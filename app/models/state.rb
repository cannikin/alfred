class State < ActiveRecord::Base

  has_many :projects
  
  STOPPED = State.find_by_name('Stopped').id
  RUNNING = State.find_by_name('Running').id
  ERROR = State.find_by_name('Error').id
  STARTING = State.find_by_name('Starting').id

end
