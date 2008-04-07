class ProjectsController < ApplicationController
  
  def index
    
  end

  def new
    @project = Project.new
    @project.local_url = @system.local_hostname
    @project.remote_url = @system.remote_hostname
    @project.port = Project.maximum(:port) + 1
    @project.state = State.find(State::STATES[:stopped][:id])

    @servers = Server.find(:all).map {|s| [s.name, s.id]}
    @environments = Environment.find(:all).map {|e| [e.name, e.id]}
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to :controller => 'dashboard', :action => 'extended'
    end
  end
  
end
