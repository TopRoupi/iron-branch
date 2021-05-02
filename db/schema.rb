# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_27_171636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.integer "constitution"
    t.string "email"
    t.string "telephone"
    t.string "cep"
    t.float "capital"
    t.date "last_capital_modification"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "investor_id", null: false
    t.bigint "invested_id", null: false
    t.float "value"
    t.integer "funds"
    t.date "investment_date"
    t.boolean "anomalous"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invested_id"], name: "index_investments_on_invested_id"
    t.index ["investor_id"], name: "index_investments_on_investor_id"
  end

  add_foreign_key "investments", "companies", column: "invested_id"
  add_foreign_key "investments", "companies", column: "investor_id"
end
