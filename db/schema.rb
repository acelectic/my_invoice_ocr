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

ActiveRecord::Schema.define(version: 2019_12_02_044222) do

  create_table "customer_stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_store_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "assign_branch_name", limit: 100
    t.integer "customer_id", null: false
    t.string "customer_store_name"
    t.string "customer_store_type", limit: 1
    t.index ["customer_store_code"], name: "index_customer_stores_unique", unique: true
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_code", limit: 10, null: false
    t.string "customer_short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_code"], name: "index_customers_unique", unique: true
  end

  create_table "dc_routes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "distribution_center_id", null: false
    t.string "dc_route_code", limit: 10, null: false
    t.string "dc_route_name", limit: 80, null: false
    t.boolean "is_factory"
    t.string "operation_type", limit: 50
    t.integer "plant_id"
    t.string "customer_branch_code", limit: 5
    t.string "building_code", limit: 10
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dc_route_code"], name: "index_dc_routes_on_dc_route_code", unique: true
    t.index ["distribution_center_id"], name: "index_dc_routes_on_distribution_center_id"
  end

  create_table "distribution_centers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "distribution_center_code", limit: 6, null: false
    t.string "distribution_center_name", limit: 50, null: false
    t.integer "sale_zone_id"
    t.integer "sub_sale_zone_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["distribution_center_code"], name: "index_departments_on_code", unique: true
  end

  create_table "event_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "event_type", limit: 30, null: false
    t.string "from_table", limit: 100
    t.string "to_table", limit: 100
    t.integer "from_count"
    t.integer "to_count"
    t.text "query"
    t.string "distribution_center_code", limit: 6
    t.string "dc_route_code", limit: 10
    t.datetime "event_start_date"
    t.datetime "event_end_date"
    t.string "result", limit: 500
    t.string "job_duration", limit: 50
    t.string "job_id", limit: 75
    t.string "job_name", limit: 70
    t.integer "creator_id"
    t.string "remarks", limit: 300
    t.integer "progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_category_code", limit: 10, null: false
    t.string "item_category_name", limit: 50, null: false
    t.boolean "is_active", default: true, null: false
    t.string "alternate_name", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_category_code"], name: "index_item_categories_on_item_cat_code", unique: true
  end

  create_table "item_sub_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "item_category_id", null: false
    t.string "item_sub_category_code", limit: 10, null: false
    t.string "item_sub_category_name", limit: 50, null: false
    t.boolean "is_active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_category_id", "item_sub_category_code"], name: "idx_item_cat_on_item_cat_id_and_item_sub_cat_code", unique: true
    t.index ["item_sub_category_code"], name: "index_item_sub_categories_on_item_sub_category_code"
  end

  create_table "item_unit_of_measures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_um_code", limit: 4, null: false
    t.string "item_um_name", null: false
    t.string "status", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_um_code"], name: "index_item_unit_of_measures_on_item_um_code", unique: true
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_code", limit: 40, null: false
    t.string "short_name", limit: 100
    t.string "item_thai_name", limit: 100, null: false
    t.string "item_eng_name", limit: 100
    t.string "description", limit: 200
    t.string "item_type", limit: 1, null: false
    t.boolean "is_active", default: true, null: false
    t.string "remain_code", limit: 40
    t.boolean "is_boi", default: true, null: false
    t.integer "item_sub_category_id"
    t.integer "unit_of_measure_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_code"], name: "index_items_on_item_code", unique: true
  end

  create_table "ms_invoice_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ms_invoice_id"
    t.bigint "invoice_id"
    t.integer "seq_no"
    t.integer "item_id"
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ms_invoice_id", "item_id"], name: "index_ms_invoice_items_unique", unique: true
  end

  create_table "ms_invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "invoice_id", null: false
    t.string "vat_invoice_number", limit: 22, null: false
    t.decimal "total_cost", precision: 16, scale: 2, default: "0.0"
    t.string "dc_route_id", limit: 10
    t.string "branch_seq", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_store_id", null: false
    t.integer "distribution_center_id", null: false
    t.date "invoice_date"
    t.index ["vat_invoice_number"], name: "index_ms_invoice_on_vat_invoice_number", unique: true
    t.index ["vat_invoice_number"], name: "index_ms_invoices_vat_invoice_number"
  end

  create_table "ocr_invoice_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ocr_invoice_id"
    t.string "image_name", null: false
    t.string "full_name", null: false
    t.integer "page", null: false
    t.date "ocr_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ocr_invoice_id", "ocr_date", "image_name", "page"], name: "index_ocr_invoice_images_unique", unique: true
  end

  create_table "ocr_invoice_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ocr_invoice_id"
    t.string "invoice_sequence"
    t.float "price"
    t.float "page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "item_id", null: false
    t.index ["ocr_invoice_id", "item_id"], name: "index_ocr_invoice_items_unique", unique: true
  end

  create_table "ocr_invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "vat_no"
    t.integer "sequence"
    t.string "status"
    t.float "total_page"
    t.float "net_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "ocr_date", null: false
    t.boolean "is_compared", default: false, null: false
    t.integer "customer_store_id", null: false
    t.index ["ocr_date", "customer_store_id", "vat_no"], name: "index_ocr_invoices_unique", unique: true
    t.index ["ocr_date"], name: "index_ocr_invoices_ocr_date"
  end

  create_table "tr_invoice_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ms_invoice_item_id", null: false
    t.integer "ocr_invoice_item_id"
    t.integer "invoice_sequence", null: false
    t.boolean "ocr_item_result", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tr_invoice_id", null: false
    t.index ["invoice_sequence", "ms_invoice_item_id", "tr_invoice_id"], name: "index_tr_invoice_items_unique", unique: true
  end

  create_table "tr_invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ms_invoice_id", null: false
    t.integer "ocr_invoice_id", null: false
    t.boolean "ocr_result", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_compared", default: false, null: false
    t.date "ocr_date", null: false
    t.integer "validate_reason_id"
    t.index ["ocr_date", "ms_invoice_id", "ocr_invoice_id"], name: "index_customers_unique", unique: true
    t.index ["ocr_date", "ocr_result"], name: "index_tr_invoices_ocr_date_and_ocr_result"
    t.index ["ocr_date"], name: "index_tr_invoices_ocr_date"
  end

  create_table "validate_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "reason_code", limit: 4, null: false
    t.string "desc", null: false
    t.boolean "is_active", default: true, null: false
    t.string "creator", limit: 6, null: false
    t.string "updator", limit: 6, null: false
    t.boolean "reason_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["desc"], name: "index_desc_validate_reasons_unique", unique: true
    t.index ["reason_code", "reason_type"], name: "index_reason_code_and_type_validate_reasons_unique", unique: true
  end

end
