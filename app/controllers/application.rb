class ApplicationController < ActionController::Base
  helper :all

  before_filter :get_system

  def get_system
    @system = System.find(:first)
  end
  
  # determine the state of the project and update in the database
  private
  def update_state(project)
    unless project.state.id == State::ERROR
      if project_running?(project)
        project.state = State.find(State::RUNNING)
      else
        project.state = State.find(State::STOPPED)
      end
    end
    project.save
  end

  # query the state of an app
  private
  def project_running?(project)
    output = `ps aux | grep ruby.*#{project.port.to_s}`.split(/\n/)

    !output.reject do |process|       # find every process for which 'grep' is not found -- is that array empty?
      process.match(/grep/)
    end.empty?
  end

end
