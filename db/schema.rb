# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 6) do

  create_table "environments", :force => true do |t|
    t.string "name"
    t.string "short_name"
    t.string "description"
    t.string "command"
    t.string "log"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "description",     :null => false
    t.string   "local_url",       :null => false
    t.string   "remote_url",      :null => false
    t.string   "rails_root",      :null => false
    t.integer  "port",            :null => false
    t.integer  "pid"
    t.integer  "server_id",       :null => false
    t.integer  "state_id",        :null => false
    t.integer  "environment_id",  :null => false
    t.text     "notes"
    t.datetime "last_started_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string "name"
    t.string "command"
  end

  create_table "states", :force => true do |t|
    t.string "name"
    t.string "description"
    t.string "color_1"
    t.string "color_2"
  end

  create_table "systems", :force => true do |t|
    t.string   "local_hostname"
    t.string   "remote_hostname"
    t.integer  "port"
    t.integer  "poll_interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_rails_root"
  end

end
