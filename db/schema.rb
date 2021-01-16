ActiveRecord::Schema.define(version: 2021_01_16_030632) do
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline", null: false
    t.string "status", default: "未着手", null: false
    t.integer "priority", default: 0, null: false
    t.bigint "user_id"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
  end

  add_foreign_key "tasks", "users"
end
