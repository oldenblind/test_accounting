class CreateBalanceTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :balance_transactions do |t|
      t.string :target, null: false
      t.integer :delta, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
