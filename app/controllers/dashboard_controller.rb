class DashboardController < ApplicationController
  
  def extended
    @projects = Project.find(:all)
  end
  
  def compact
    @projects = Project.find(:all)
  end
end
