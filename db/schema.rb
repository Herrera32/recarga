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

ActiveRecord::Schema.define(version: 2021_04_10_182407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accions", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogo_recargas", force: :cascade do |t|
    t.string "nombre"
    t.decimal "monto"
  end

  create_table "recarga_saldos", force: :cascade do |t|
    t.date "fecha"
    t.bigint "usuario_id"
    t.bigint "catalogo_recarga_id"
    t.decimal "saldo_inicial"
    t.decimal "saldo_final"
    t.string "telefono"
    t.index ["catalogo_recarga_id"], name: "index_recarga_saldos_on_catalogo_recarga_id"
    t.index ["usuario_id"], name: "index_recarga_saldos_on_usuario_id"
  end

  create_table "recursos", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.bigint "tipo_recurso_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tipo_recurso_id"], name: "index_recursos_on_tipo_recurso_id"
  end

  create_table "rol_accions", force: :cascade do |t|
    t.bigint "rol_id"
    t.bigint "recurso_id"
    t.bigint "accion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accion_id"], name: "index_rol_accions_on_accion_id"
    t.index ["recurso_id"], name: "index_rol_accions_on_recurso_id"
    t.index ["rol_id"], name: "index_rol_accions_on_rol_id"
  end

  create_table "rols", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tipo_recursos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "usuario"
    t.boolean "activo"
    t.string "telefono"
    t.integer "saldo_recarga", default: 0
    t.bigint "rols_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["rols_id"], name: "index_usuarios_on_rols_id"
  end

  add_foreign_key "recursos", "tipo_recursos"
  add_foreign_key "rol_accions", "accions"
  add_foreign_key "rol_accions", "recursos"
  add_foreign_key "rol_accions", "rols"
  add_foreign_key "usuarios", "rols", column: "rols_id"
end
