class AddFkTablasRelacionBanco < ActiveRecord::Migration[6.0]
  def change
    add_reference :usuarios, :rols, index: true, foreign_key: true
  end
end
