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

ActiveRecord::Schema.define(version: 20170331054428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "task_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_audits_on_task_id", using: :btree
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "product_name"
    t.string   "price"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "money_bags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "available_credit"
    t.integer  "expenses"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_money_bags_on_user_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "item_total", limit: 10
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total"
    t.integer  "order_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "ancestry"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image_url",    limit: 30
    t.string   "redirect_url", limit: 30
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_category_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "image_url",           limit: 30
    t.string   "price",               limit: 30
    t.decimal  "weight_in_kgs",                  precision: 7, scale: 4
    t.decimal  "cholestrol_per_gm",              precision: 7, scale: 4
    t.integer  "quantity"
    t.index ["product_category_id"], name: "index_products_on_product_category_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "rule"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                         default: "", null: false
    t.string   "encrypted_password",            default: "", null: false
    t.string   "username",                      default: "", null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "gender",             limit: 8
    t.string   "city",               limit: 20
    t.string   "state",              limit: 20
    t.string   "nationality",        limit: 20
    t.index ["email"], name: "unique_email", unique: true, using: :btree
  end

  add_foreign_key "audits", "tasks"
  add_foreign_key "money_bags", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "product_categories"
end
