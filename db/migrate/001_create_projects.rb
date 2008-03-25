require 'active_record/fixtures'

class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :local_url
      t.string :remote_url
      t.string :rails_root
      t.integer :port
      t.integer :pid
      t.integer :server_id
      t.integer :state_id
      t.integer :environment_id
      t.text :notes
      t.datetime :last_started_at

      t.timestamps
    end

    # load some default data
    directory = File.join(File.dirname(__FILE__), "default_data") 
    Fixtures.create_fixtures(directory, "projects")

  end

  def self.down
    drop_table :projects
  end
end
