class AddFieldsToUsuario < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :usuario, :string
    add_column :usuarios, :activo, :boolean
    add_column :usuarios, :telefono, :string
    add_column :usuarios, :saldo_recarga, :integer, default: 0
  end
end