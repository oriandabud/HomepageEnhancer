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

ActiveRecord::Schema.define(version: 20150531123412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "page_link"
    t.integer  "website_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["website_id"], name: "index_categories_on_website_id", using: :btree

  create_table "category_pages", force: :cascade do |t|
    t.integer  "website_id"
    t.string   "products_selector"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "validator_selector"
  end

  create_table "entrances", force: :cascade do |t|
    t.integer  "popularity_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "entrances", ["popularity_id"], name: "index_entrances_on_popularity_id", using: :btree

  create_table "home_pages", force: :cascade do |t|
    t.integer  "website_id"
    t.string   "product_name_selector"
    t.string   "product_url_selector"
    t.string   "product_price_selector"
    t.string   "product_picture_selector"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "product_old_price_selector"
    t.string   "product_container_selector"
    t.string   "img_max_width"
    t.string   "img_max_height"
  end

  create_table "popularities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "entrances_count", default: 0
  end

  add_index "popularities", ["product_id"], name: "index_popularities_on_product_id", using: :btree
  add_index "popularities", ["user_id"], name: "index_popularities_on_user_id", using: :btree

  create_table "product_pages", force: :cascade do |t|
    t.integer  "website_id"
    t.string   "name_selector"
    t.string   "picture_selector"
    t.string   "price_selector"
    t.string   "validator_selector"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "old_price_selector"
    t.string   "regular_price_selector"
  end

  create_table "products", force: :cascade do |t|
    t.string   "page_link"
    t.string   "picture_link"
    t.string   "title"
    t.integer  "website_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "price"
    t.integer  "old_price"
    t.integer  "regular_price"
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "categories", "websites"
  add_foreign_key "entrances", "popularities"
  add_foreign_key "popularities", "products"
  add_foreign_key "popularities", "users"
  add_foreign_key "products", "websites"
  add_foreign_key "products", "websites"
  add_foreign_key "users", "websites"
  add_foreign_key "users", "websites"
end
