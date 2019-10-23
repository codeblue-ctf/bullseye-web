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

ActiveRecord::Schema.define(version: 2019_10_23_064618) do

  create_table "admins", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login_name"
    t.index ["login_name"], name: "index_admins_on_login_name", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.string "image_digest"
    t.integer "team_id"
    t.integer "problem_id"
    t.datetime "uploaded_at"
    t.text "event_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.text "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "timeout"
    t.integer "ntrials"
    t.text "docker_compose"
    t.string "exploit_container_name"
    t.string "problem_container_name"
    t.text "calc_formula"
    t.boolean "hidden"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "label"
    t.datetime "start_at"
    t.boolean "disabled"
  end

  create_table "runner_workers", force: :cascade do |t|
    t.string "host"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score"
    t.integer "image_digest"
    t.integer "succeeded"
    t.integer "failed"
    t.datetime "runner_started_at"
    t.datetime "runner_finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "log"
    t.integer "runner_result_id"
    t.index ["runner_result_id"], name: "index_scores_on_runner_result_id", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "login_name"
    t.string "default_runner"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.index ["email"], name: "index_teams_on_email", unique: true
    t.index ["login_name"], name: "index_teams_on_login_name", unique: true
    t.index ["reset_password_token"], name: "index_teams_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_teams_on_uid_and_provider", unique: true
  end

end
