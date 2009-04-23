class AddDefaultRailsRootToSystem < ActiveRecord::Migration
  def self.up
    add_column :systems, 'default_rails_root', :string
  end

  def self.down
    remove_column :systems, 'default_rails_root'
  end
end
