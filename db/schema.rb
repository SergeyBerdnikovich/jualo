# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130626171654) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "ad_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_notes", :force => true do |t|
    t.string   "resource_id",     :null => false
    t.string   "resource_type",   :null => false
    t.integer  "admin_user_id"
    t.string   "admin_user_type"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "admin_notes", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "ads", :force => true do |t|
    t.integer  "category_id"
    t.integer  "ad_type_id"
    t.integer  "ad_condition_id"
    t.float    "price"
    t.integer  "image_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "slug"
    t.integer  "currency_id"
    t.boolean  "active"
  end

  add_index "ads", ["ad_condition_id"], :name => "index_ads_on_ad_condition_id"
  add_index "ads", ["ad_type_id"], :name => "index_ads_on_ad_type_id"
  add_index "ads", ["category_id"], :name => "index_ads_on_category_id"
  add_index "ads", ["city_id"], :name => "index_ads_on_city_id"
  add_index "ads", ["created_at"], :name => "index_ads_on_created_at"
  add_index "ads", ["price"], :name => "index_ads_on_price"
  add_index "ads", ["slug", "city_id", "state_id", "category_id"], :name => "index_ads_on_slug_and_city_id_and_state_id_and_category_id", :unique => true
  add_index "ads", ["state_id"], :name => "index_ads_on_state_id"
  add_index "ads", ["user_id"], :name => "index_ads_on_user_id"

  create_table "ads_variants", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "variant_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attach_tokens", :force => true do |t|
    t.string   "token"
    t.integer  "ad_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "categories", ["parent"], :name => "index_categories_on_parent"
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "category_options", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "cities", ["slug"], :name => "index_cities_on_slug", :unique => true

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "details", :force => true do |t|
    t.integer  "ad_id"
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.integer  "ad_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.boolean  "need_download",      :default => false
  end

  add_index "images", ["ad_id"], :name => "index_images_on_ad_id"

  create_table "olxcoid_category", :force => true do |t|
    t.string  "name"
    t.text    "des"
    t.integer "parent"
    t.integer "exported", :limit => 1
  end

  add_index "olxcoid_category", ["id"], :name => "catidinx"
  add_index "olxcoid_category", ["id"], :name => "id", :unique => true
  add_index "olxcoid_category", ["parent"], :name => "catparinx"

  create_table "olxcoid_links", :force => true do |t|
    t.integer "type"
    t.integer "type_id"
    t.string  "link",          :limit => 600
    t.string  "hash",          :limit => 32
    t.integer "last_accessed"
    t.integer "parsed",        :limit => 1
  end

  add_index "olxcoid_links", ["hash"], :name => "hash", :unique => true
  add_index "olxcoid_links", ["hash"], :name => "linkhashinx"
  add_index "olxcoid_links", ["id"], :name => "id", :unique => true
  add_index "olxcoid_links", ["id"], :name => "linkidinx"
  add_index "olxcoid_links", ["last_accessed"], :name => "linklastaccinx"
  add_index "olxcoid_links", ["parsed"], :name => "linkparsedinx"
  add_index "olxcoid_links", ["type"], :name => "linktypeinx"
  add_index "olxcoid_links", ["type_id"], :name => "linktypeidinx"

  create_table "olxcoid_products", :force => true do |t|
    t.string  "name"
    t.string  "short_des",   :limit => 500
    t.text    "des"
    t.text    "images"
    t.integer "category_id"
    t.string  "address",     :limit => 5000
    t.string  "phone"
    t.string  "price"
    t.integer "used",        :limit => 1
    t.string  "username"
    t.integer "exported",    :limit => 1
  end

  add_index "olxcoid_products", ["category_id"], :name => "prodcatidinx"
  add_index "olxcoid_products", ["exported"], :name => "prodcatidinxexported"
  add_index "olxcoid_products", ["id"], :name => "id", :unique => true
  add_index "olxcoid_products", ["id"], :name => "prodidinx"

  create_table "options", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "options_variants", :force => true do |t|
    t.integer  "category_option_id"
    t.string   "value"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "des"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "statistic"
    t.string   "ripper_status"
    t.integer  "ripper_perfomance"
    t.integer  "ripper_start_time"
    t.text     "start_links"
    t.string   "export_to"
  end

  create_table "proxies", :force => true do |t|
    t.string   "address"
    t.integer  "port"
    t.integer  "checked"
    t.integer  "badcount"
    t.boolean  "alive"
    t.string   "parser"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "states", ["slug"], :name => "index_states_on_slug", :unique => true

  create_table "static_pages", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "locale_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "blackberry_pin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "variants", :force => true do |t|
    t.integer  "option_id"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
