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

  def get_status
    @project = Project.find(params[:id])
    update_status(@project)
  end

end
