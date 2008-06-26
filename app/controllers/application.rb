class ApplicationController < ActionController::Base
  helper :all

  before_filter :get_system

  def get_system
    @system = System.find(:first)
  end
  
  # determine the state of the project and update in the database
  private
  def update_state(project)
    unless project.state.id == State::STATES[:error][:id]
      if project_running?(project)
        project.state = State.find(State::STATES[:running][:id])
      else
        project.state = State.find(State::STATES[:stopped][:id])
      end
      project.notes = nil
    end
    project.save
  end

  # query the state of an app
  private
  def project_running?(project)
    !`ps wwwaux | grep ruby.*#{project.port.to_s} | grep -v grep`.split(/\n/).empty?
  end

  # get the pid of a running app
  private
  def get_pid(project)
    if project_running?(project)
      output = `ps wwwaux | grep ruby.*#{project.port.to_s} | grep -v grep`.split(/\n/)
      process.split().first.strip              # split on spaces and return the first instance, which should be the pid
    else
      nil
    end
  end


end
