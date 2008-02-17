class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.string :local_hostname
      t.string :remote_hostname

      t.timestamps
    end
  end

  def self.down
    drop_table :systems
  end
end
