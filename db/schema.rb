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

ActiveRecord::Schema.define(version: 2019_04_10_180654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index %w[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "english", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "activity_type", null: false
    t.integer "status", default: 0, null: false
    t.string "notes"
    t.integer "score", default: 0
    t.text "description"
    t.text "pitch_audience"
    t.text "abstract_outline"
    t.string "activity_file"
    t.boolean "english_approve"
    t.string "slug"
    t.index ["slug"], name: "index_activities_on_slug", unique: true
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activity_statuses", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "user_id", null: false
    t.boolean "approve", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_statuses_on_activity_id"
    t.index ["user_id"], name: "index_activity_statuses_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "comment"
    t.integer "activity_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_feedbacks_on_activity_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index %w[slug sluggable_type scope], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index %w[slug sluggable_type], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index %w[sluggable_type sluggable_id], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.bigint "activity_id", null: false
    t.index ["activity_id"], name: "index_locations_on_activity_id"
  end

  create_table "match_products", force: :cascade do |t|
    t.integer "deliverable_id"
    t.string "deliverable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "match_id"
    t.index ["match_id"], name: "index_match_products_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "match_type"
    t.integer "version"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polls", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "activities_from", null: false
    t.date "activities_to", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "repositories"
    t.text "features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_teams_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.bigint "team_id"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index %w[invited_by_type invited_by_id], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "user_id", null: false
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value", null: false
    t.index ["activity_id"], name: "index_votes_on_activity_id"
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "locations", "activities"
  add_foreign_key "match_products", "matches"
  add_foreign_key "users", "teams"
end
