class CreateAccounts < ActiveRecord::Migration[4.2]

  def change
    create_table :accounts do |t|
      t.float :balance
      t.integer :user_id
    end
  end


end