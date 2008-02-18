require 'active_record/fixtures'

class CreateEnvironments < ActiveRecord::Migration
  def self.up
    create_table :environments do |t|
      t.string :name
      t.string :description
      t.string :command
      t.string :log
    end
    
    # load some default data
    directory = File.join(File.dirname(__FILE__), "default_data") 
    Fixtures.create_fixtures(directory, "environments")
    
  end

  def self.down
    drop_table :environments
  end
end
