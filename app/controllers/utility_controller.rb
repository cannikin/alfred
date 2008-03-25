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
                :button => State::STATES[@project.state.name.downcase.to_sym][:button],
                :notes => @project.notes }
    render :text => output.to_json
  end
  
  # start a project
  def start_project
    project = Project.find(params[:id])
    begin
      output = `mongrel_rails start -c #{project.rails_root} -p #{project.port} -e #{project.environment.command} -d`
      # project.pid = File.open("#{project.rails_root}/tmp/pids/mongrel.pid").read.chomp.to_i             # command should have created a mongrel.pid file, read that in and store the pid
      # raise NoSuchDirectory, "The directory #{project.rails_root} does not exist."                    # if the output is blank then there was an error, most likely that the command wasn't found (wrong directory structure)
      project.last_started_at = Time.now.to_s(:db)                                                      # timestap the last started time as right now
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
  
  private
  def set_state(project,new_state)
    project.state = State.find(State::STATES[new_state][:id])
    project.save
  end

end
