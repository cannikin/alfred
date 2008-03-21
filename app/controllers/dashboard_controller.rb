class DashboardController < ApplicationController
  
  def extended
    @projects = Project.find(:all)
    
    # get statuses for each project
    @projects.each do |project|
      update_status(project)
    end

  end
  
  def compact
    @projects = Project.find(:all)
  end
end
