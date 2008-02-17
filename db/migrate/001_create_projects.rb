class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :local_url
      t.string :remote_url
      t.string :rails_root
      t.string :port
      t.integer :server_id
      t.integer :state_id
      t.integer :environment_id
      t.datetime :last_started_at

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
