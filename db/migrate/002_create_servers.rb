require 'active_record/fixtures'

class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :name
      t.string :command
    end
    
    # load some default data
    directory = File.join(File.dirname(__FILE__), "default_data") 
    Fixtures.create_fixtures(directory, "servers")
    
  end

  def self.down
    drop_table :servers
  end
end
