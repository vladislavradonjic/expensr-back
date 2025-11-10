class CreateCurrencies < ActiveRecord::Migration[8.1]
  def change
    create_table :currencies do |t|
      t.string :code, null: false
      t.boolean :is_default, null: false, default: false

      t.timestamps
    end

    add_index :currencies, :code,  unique: true
  end
end
