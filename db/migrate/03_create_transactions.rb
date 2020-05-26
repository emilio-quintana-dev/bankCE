class CreateTransactions < ActiveRecord::Migration[4.2]

  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :account_id
      t.float :amount
      t.string :status
      t.timestamps
    end
  end
end