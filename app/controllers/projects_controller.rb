class ProjectsController < ApplicationController
  
  def index
    
  end

  def new
    @project = Project.new
    @project.local_url = @system.local_hostname
    @project.remote_url = @system.remote_hostname
    if Project.maximum(:port)
      @project.port = Project.maximum(:port) + 1
    else
      @project.port = @system.port == 3000 ? 3001 : 3000
    end
    @project.state = State.find(State::STATES[:stopped][:id])

    @servers = Server.find(:all).map {|s| [s.name, s.id]}
    @environments = Environment.find(:all).map {|e| [e.name, e.id]}
    @system = System.find(:first)
  end

  def edit
    @project = Project.find(params[:id])
    @servers = Server.find(:all).map {|s| [s.name, s.id]}
    @environments = Environment.find(:all).map {|e| [e.name, e.id]}
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      #`rails #{@project.rails_root}` if params[:build_app]   FIXME: Building the Rails app on the fly doesn't work, alfred never finishes the request and needs to be restarted. App is created as mode 777, is that a hint?
      redirect_to :controller => 'dashboard', :action => 'extended'
    else
      render :action => 'new'
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to :controller => 'dashboard', :action => 'extended'
    else
      render :action => 'edit'
    end
  end
  
end
