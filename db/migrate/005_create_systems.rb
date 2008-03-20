require 'active_record/fixtures'

class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.string :local_hostname
      t.string :remote_hostname
      t.integer :port

      t.timestamps
    end

    # load some default data
    directory = File.join(File.dirname(__FILE__), "default_data") 
    Fixtures.create_fixtures(directory, "systems")

  end

  def self.down
    drop_table :systems
  end
end
