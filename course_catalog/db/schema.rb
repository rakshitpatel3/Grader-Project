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

ActiveRecord::Schema[7.2].define(version: 2024_11_23_215222) do
  create_table "courses", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lab_assistant_required"
    t.string "catalog_number"
    t.string "term"
    t.text "description"
  end

  create_table "grader_applications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "availability"
    t.text "course_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course_number"
    t.integer "section_id"
    t.index ["user_id"], name: "index_grader_applications_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.string "recommendation_type"
    t.text "comments"
    t.integer "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_recommendations_on_course_id"
    t.index ["instructor_id"], name: "index_recommendations_on_instructor_id"
    t.index ["section_id"], name: "index_recommendations_on_section_id"
    t.index ["student_id"], name: "index_recommendations_on_student_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "instructor"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "section_identifier"
    t.integer "graders_required", default: 1
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.boolean "approved"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "grader_applications", "users"
  add_foreign_key "recommendations", "courses"
  add_foreign_key "recommendations", "sections"
  add_foreign_key "recommendations", "users", column: "instructor_id"
  add_foreign_key "recommendations", "users", column: "student_id"
  add_foreign_key "sections", "courses"
end
