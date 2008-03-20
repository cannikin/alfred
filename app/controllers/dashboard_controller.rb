class DashboardController < ApplicationController

  def index
    
  end
  
  def extended
    @projects = Project.find(:all)
  end
  
  def compact
    @projects = Project.find(:all)
  end
end
