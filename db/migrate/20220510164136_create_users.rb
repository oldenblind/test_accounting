class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, unque: true, null: false
      t.string :password_digest, null: false
      t.string :api_token

      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
