# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '6c6c680c98f511d759c8e616ed56f6d4'

  before_filter :get_system

  def get_system
    @system = System.find(:first)
  end

  # query the state of an app
  private
  def project_running?(project)
    output = `ps aux | grep ruby.*#{project.port.to_s}`.split(/\n/)

    !output.reject do |process|       # find every process for which 'grep' is not found -- is that array empty?
      process.match(/grep/)
    end.empty?
  end

  # query the state of an app
  private
  def update_status(project)
    project_running = project_running?(project)

    # update the project's status in the database
    if project_running
      state = State.find_by_name('Running')
    else
      state = State.find_by_name('Stopped')
    end
    
    project.state = state
    project.save

    # only render the running-ness if this is an ajax request
    #if request.xhr? || request.get?
    #  render :text => project_running.to_s
    #else
    #  render :nothing => true
    #end
  end


end
