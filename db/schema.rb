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

ActiveRecord::Schema.define(version: 20170726080621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.boolean  "is_correct",      default: false
    t.text     "answer_markdown"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.integer  "points"
    t.boolean  "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.boolean  "is_passed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "time_at"
    t.index ["question_id"], name: "index_cards_on_question_id", using: :btree
    t.index ["user_id"], name: "index_cards_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comment_markdown"
    t.boolean  "is_hidden"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "question_id"
    t.index ["question_id"], name: "index_comments_on_question_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "flags", force: :cascade do |t|
    t.text     "reason"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_flags_on_question_id", using: :btree
    t.index ["user_id"], name: "index_flags_on_user_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "owner_id"
    t.string   "message"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "state",       default: false
    t.string   "category"
    t.string   "source"
    t.index ["owner_id"], name: "index_notifications_on_owner_id", using: :btree
    t.index ["question_id"], name: "index_notifications_on_question_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "privacies", force: :cascade do |t|
    t.text     "body"
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "category"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description_markdown"
    t.text     "explanation_markdown"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "choice"
    t.integer  "session_id"
    t.integer  "count_flags",          default: 0
    t.boolean  "suspended",            default: false
    t.string   "state"
    t.index ["session_id"], name: "index_questions_on_session_id", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "reasons", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "rs_evaluations", force: :cascade do |t|
    t.string   "reputation_name"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.float    "value",           default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.index ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true, using: :btree
    t.index ["reputation_name"], name: "index_rs_evaluations_on_reputation_name", using: :btree
    t.index ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type", using: :btree
    t.index ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type", using: :btree
  end

  create_table "rs_reputation_messages", force: :cascade do |t|
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.float    "weight",      default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true, using: :btree
    t.index ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type", using: :btree
  end

  create_table "rs_reputations", force: :cascade do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.string   "target_type"
    t.integer  "target_id"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.index ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
    t.index ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
    t.index ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree
  end

  create_table "session_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "session_id"
    t.boolean  "is_passed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_session_cards_on_question_id", using: :btree
    t.index ["session_id"], name: "index_session_cards_on_session_id", using: :btree
    t.index ["user_id"], name: "index_session_cards_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "title"
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tag"
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "stats_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "session_id"
    t.float    "percentage"
    t.boolean  "is_passed"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "time_at"
    t.integer  "number_cards_correct", default: 0
    t.index ["session_id"], name: "index_stats_sessions_on_session_id", using: :btree
    t.index ["user_id"], name: "index_stats_sessions_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "takes", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_takes_on_question_id", using: :btree
    t.index ["session_id"], name: "index_takes_on_session_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "points"
    t.integer  "streak",                            default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                   default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token",   limit: 30
    t.datetime "deleted_at"
    t.string   "username",                          default: ""
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "vote_reasons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "vote_reason_id"
    t.index ["question_id", "user_id"], name: "index_vote_reasons_on_question_id_and_user_id", unique: true, using: :btree
  end

  add_foreign_key "vote_reasons", "questions"
  add_foreign_key "vote_reasons", "users"
end
