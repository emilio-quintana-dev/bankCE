class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  def deposit
    puts "Depositing..."
    new_balance = account.balance + self.amount
    account.update(:balance => new_balance)
    puts "The new balance is #{user.account.balance}"
  end

  def withdraw
    puts "Withdrawing..."
    new_balance = account.balance - self.amount

    if new_balance < 0
      puts "Error! Amount can't be greater than balance."
    else
      account.update(:balance => new_balance)
      puts "The new balance is #{user.account.balance}"
    end
  end


end