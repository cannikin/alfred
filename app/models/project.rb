class Project < ActiveRecord::Base

  belongs_to :server
  belongs_to :state
  belongs_to :environment

end
