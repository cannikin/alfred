class System < ActiveRecord::Base
  
  validates_numericality_of :port, :poll_interval
  validates_presence_of :local_hostname, :remote_hostname, :port, :poll_interval
  
end
