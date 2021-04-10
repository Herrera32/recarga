class CreateCatalogoRecargas < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogo_recargas do |t|
      t.string :nombre
      t.decimal :monto
    end
  end
end