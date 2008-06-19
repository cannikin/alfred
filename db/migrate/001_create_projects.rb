require 'active_record/fixtures'

class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.string :local_url, :null => false
      t.string :remote_url, :null => false
      t.string :rails_root, :null => false
      t.integer :port, :null => false
      t.integer :pid
      t.integer :server_id, :null => false
      t.integer :state_id, :null => false
      t.integer :environment_id, :null => false
      t.text :notes
      t.datetime :last_started_at

      t.timestamps
    end

  end

  def self.down
    drop_table :projects
  end
end
