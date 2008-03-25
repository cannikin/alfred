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

ActiveRecord::Schema.define(:version => 5) do

  create_table "environments", :force => true do |t|
    t.string "name",        :default => "NULL"
    t.string "short_name",  :default => "NULL"
    t.string "description", :default => "NULL"
    t.string "command",     :default => "NULL"
    t.string "log",         :default => "NULL"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",            :default => "NULL"
    t.string   "description",     :default => "NULL"
    t.string   "local_url",       :default => "NULL"
    t.string   "remote_url",      :default => "NULL"
    t.string   "rails_root",      :default => "NULL"
    t.integer  "port",            :default => 0
    t.integer  "pid",             :default => 0
    t.integer  "server_id",       :default => 0
    t.integer  "state_id",        :default => 0
    t.integer  "environment_id",  :default => 0
    t.text     "notes",           :default => "NULL"
    t.datetime "last_started_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string "name",    :default => "NULL"
    t.string "command", :default => "NULL"
  end

  create_table "states", :force => true do |t|
    t.string "name",        :default => "NULL"
    t.string "description", :default => "NULL"
    t.string "color_1",     :default => "NULL"
    t.string "color_2",     :default => "NULL"
  end

  create_table "systems", :force => true do |t|
    t.string   "local_hostname",  :default => "NULL"
    t.string   "remote_hostname", :default => "NULL"
    t.integer  "port",            :default => 0
    t.integer  "poll_interval",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
