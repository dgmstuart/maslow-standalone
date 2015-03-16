# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150316212524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "need_revisions", force: :cascade do |t|
    t.integer  "need_id",     null: false
    t.integer  "author_id",   null: false
    t.string   "action_type", null: false
    t.json     "snapshot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "need_statuses", force: :cascade do |t|
    t.integer "need_id",                            null: false
    t.text    "description"
    t.text    "reasons",               default: [],              array: true
    t.text    "additional_comments"
    t.text    "validation_conditions"
  end

  create_table "needs", force: :cascade do |t|
    t.string  "role",                              null: false
    t.string  "goal",                              null: false
    t.string  "benefit",                           null: false
    t.text    "met_when",             default: [],              array: true
    t.string  "other_evidence"
    t.string  "legislation"
    t.integer "duplicate_of"
    t.integer "yearly_user_contacts"
    t.integer "yearly_site_views"
    t.integer "yearly_need_views"
    t.integer "yearly_searches"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "need_id",     null: false
    t.integer  "author_id",   null: false
    t.integer  "revision_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name",         null: false
    t.string "abbreviation"
  end

  create_table "tag_types", force: :cascade do |t|
    t.string   "identifier", null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",     null: false
    t.integer  "need_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "tag_type_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text   "permissions", default: [], array: true
    t.text   "bookmarks",   default: [], array: true
  end

end
