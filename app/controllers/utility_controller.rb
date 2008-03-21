class UtilityController < ApplicationController

  layout nil

  # query the shell to get the hostname for this computer
  def hostname
    begin
      hostname = `hostname`
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
    
  end
  
  # stop a project
  def stop_project
    
  end

end
