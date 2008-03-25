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
      output = `#{project.rails_root}/script/server -p #{project.port} -d`   #TODO: Add environment to this call, should come from params[:environment]
      if output == ''
        # okay, the output didn't return anything, that's bad. experiment and try to figure out why
        raise NoSuchDirectory, "The directory #{project.rails_root} does not exist."    # if the output is blank then there was an error, most likely that the command wasn't found (wrong directory structure)
      end
      project.last_started_at = Time.now.to_s(:db)
    rescue => e
      project.state = State.find(State::STATES[:error][:id])
      project.notes = e.message
    end
    project.save
    get_state
  end
  
  # stop a project
  def stop_project
    
  end
  
  private
  def set_state(project,state)
    project.state
  end

end
