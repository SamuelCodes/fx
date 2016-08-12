class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.belongs_to :quote_set
      t.string :symbol, index: true
      t.decimal :bid
      t.decimal :ask
      t.decimal :high
      t.decimal :low
      t.integer :direction
      t.datetime :last

      t.timestamps
    end
  end
end
