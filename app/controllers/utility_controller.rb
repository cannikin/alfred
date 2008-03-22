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

  # get the state of a project and update in the database
  def get_state
    @project = Project.find(params[:id])
    update_state(@project)
    render :text => @project.state.name.downcase
  end
  
  # start a project
  def start_project
    project = Project.find(params[:id])
    begin
      output = `#{project.rails_root}/script/server -p #{project.port} -d`   #TODO: Add environment to this call, should come from params[:environment]
      if output == ''
        raise 'InvalidCommand'
      end
      project.last_started_at = Time.now.to_s(:db)
    rescue
      project.state = State.find(State::ERROR)
    end
    project.save
    get_state
    #render :text => '<xmp>' + output.inspect + '</xmp>'
  end
  
  # stop a project
  def stop_project
    
  end
  
  private
  def set_state(project,state)
    project.state
  end

end
