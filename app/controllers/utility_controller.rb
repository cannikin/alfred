class UtilityController < ApplicationController

  layout nil

  # query the shell to get the hostname for this computer
  def hostname
    begin
      hostname = `hostname`.chomp
      render :text => hostname
    rescue
      render :text => 'unknown'
    end
  end

  # get the status of a project and update in the database
  def get_status
    @project = Project.find(params[:id])
    update_status(@project)
  end
  
  # start a project
  def start_project
    project = Project.find(params[:id])
    begin
      output = `#{project.rails_root}/script/server -p #{project.port} -d`   #TODO: Add environment to this call, should come from params[:environment]
    rescue
      set_status(project,State::ERROR)
    end
    get_status
    render :action => 'get_status'
  end
  
  # stop a project
  def stop_project
    
  end

end
