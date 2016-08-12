class CreateQuoteSets < ActiveRecord::Migration[5.0]
  def change
    create_table :quote_sets do |t|

      t.timestamps
    end
  end
end
