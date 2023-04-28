# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_27_080859) do
  create_table "composite_units", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "orientation", default: 0
    t.integer "position", default: 100
    t.index ["composite_id"], name: "index_composite_units_on_composite_id"
    t.index ["unit_id"], name: "index_composite_units_on_unit_id"
  end

  create_table "composites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "panels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.bigint "sheet_id", null: false
    t.string "label"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sheet_id"], name: "index_panels_on_sheet_id"
  end

  create_table "sheets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "thickness"
    t.integer "width"
    t.integer "length"
    t.text "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "sheet_id", null: false
    t.string "code"
    t.integer "width"
    t.integer "height"
    t.integer "offset_top"
    t.integer "offset_bottom"
    t.integer "shelf_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "depth"
    t.string "name"
    t.text "description"
    t.integer "kind", default: 0, null: false
    t.index ["sheet_id"], name: "index_units_on_sheet_id"
  end

  add_foreign_key "composite_units", "composites"
  add_foreign_key "composite_units", "units"
  add_foreign_key "panels", "sheets"
  add_foreign_key "units", "sheets"
end
