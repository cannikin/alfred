class UtilityController < ApplicationController

  layout nil

  # query the shell to get the hostname for this computer
  def hostname
    begin
      render :text => `hostname`.chomp
    rescue
      render :text => 'unknown'
    end
  end

  # get the state of a project, update in the database, return state to browser
  def get_state
    @project = Project.find(params[:id])
    update_state(@project)
    output = {  :class => @project.state.name.downcase,
                :buttons => [State::STATES[@project.state.name.downcase.to_sym][:button]],
                :notes => @project.notes }
    # if we're running, also show a restart button
    if @project.state.id == State::STATES[:running][:id]
      output[:buttons] << State::STATES[:restart][:button]
    end
    render :text => output.to_json
  end
  
  # start a project
  def start_project
    project = Project.find(params[:id])
    started = false
    begin
      while !started
        output = `mongrel_rails start -c #{project.rails_root} -p #{project.port} -e #{project.environment.command} -d 2>&1`
        if output.include? 'PID file log/mongrel.pid already exists'
          `rm #{project.rails_root}/log/mongrel.pid`
        else
          project.last_started_at = Time.now.to_s(:db)
          started = true
        end
      end
    rescue => e
      set_state(project, :error)
      project.notes = e.message
    end
    project.save
    get_state
  end
  
  # stop a project
  def stop_project
    project = Project.find(params[:id])
    begin
      #output = `kill #{get_pid(project)}`
      `mongrel_rails stop -c #{project.rails_root}`
    rescue => e
      set_state(project, :error)
      project.notes = e.message
    end
    project.save
    get_state
  end

  # clear an error
  def clear_project
    project = Project.find(params[:id])
    set_state(project, :stopped)
    get_state
  end
  
  def is_project_running
    project = Project.find(params[:id])
    output = 'project_running? returns ' + project_running?(project).to_s + '<br /><br />'
    output += '`ps aux | grep ruby.*#{project.port.to_s} | grep -v grep` returns ' + '<pre>'
    output += `ps aux | grep ruby.*#{project.port.to_s} | grep -v grep` + '</pre>'
    render :text => output
  end
  
  private
  def set_state(project,new_state)
    project.state = State.find(State::STATES[new_state][:id])
    project.save
  end

end
