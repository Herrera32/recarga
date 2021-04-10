class CreateRecargaSaldos < ActiveRecord::Migration[6.0]
  def change
    create_table :recarga_saldos do |t|
      t.date :fecha
      t.references :usuario
      t.references :catalogo_recarga
      t.decimal :saldo_inicial
      t.decimal :saldo_final      
      t.string :telefono
    end
  end
end
