class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name
      t.string :description
      t.string :color_1
      t.string :color_2

      t.timestamps
    end
    
    # load some default data
    directory = File.join(File.dirname(__FILE__), "default_data") 
    Fixtures.create_fixtures(directory, "states")
    
  end

  def self.down
    drop_table :states
  end
end
