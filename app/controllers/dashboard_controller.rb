class DashboardController < ApplicationController
  
  before_filter :get_projects

  def index
    extended
    render :action => 'extended'
  end

  def extended

  end
  
  def compact

  end
  
  private
  def get_projects
    @projects = Project.find(:all)
  end
  
end
