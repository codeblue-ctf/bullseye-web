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

ActiveRecord::Schema.define(version: 2018_10_31_190121) do

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
  end

  create_table "schedule_results", force: :cascade do |t|
    t.integer "succeeded"
    t.text "error"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "runner_started_at"
    t.datetime "runner_finished_at"
    t.string "schedule_uuid", default: "", null: false
    t.integer "schedule_id"
    t.integer "score"
    t.integer "failed"
    t.integer "round"
    t.index ["schedule_id"], name: "index_schedule_results_on_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "team_id"
    t.integer "problem_id"
    t.datetime "start_at", null: false
    t.datetime "finish_at", null: false
    t.integer "interval", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "runner_host"
    t.integer "current_round", default: 0
    t.index ["problem_id"], name: "index_schedules_on_problem_id"
    t.index ["team_id"], name: "index_schedules_on_team_id"
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
    t.index ["email"], name: "index_teams_on_email", unique: true
    t.index ["login_name"], name: "index_teams_on_login_name", unique: true
    t.index ["reset_password_token"], name: "index_teams_on_reset_password_token", unique: true
  end

end
