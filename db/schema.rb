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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150517145521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "popularities", force: :cascade do |t|
    t.integer  "entrances"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "popularities", ["product_id"], name: "index_popularities_on_product_id", using: :btree
  add_index "popularities", ["user_id"], name: "index_popularities_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "page_link"
    t.string   "picture_link"
    t.string   "title"
    t.integer  "website_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "products", ["website_id"], name: "index_products_on_website_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "website_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["website_id"], name: "index_users_on_website_id", using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "num_of_products"
    t.string   "product_name_selector"
    t.string   "product_url_selector"
    t.string   "product_picture_selector"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "page_product_picture_selector"
    t.string   "page_product_name_selector"
  end

  add_foreign_key "popularities", "products"
  add_foreign_key "popularities", "users"
  add_foreign_key "products", "websites"
  add_foreign_key "users", "websites"
end
