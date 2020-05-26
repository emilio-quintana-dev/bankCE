class Transaction < ActiveRecord::Base
  belongs_to :user
  
  def deposit
    puts "Depositing..."
    user = User.find(self.user_id)
    new_balance = user.account.balance + self.amount
    user.account.update(:balance => new_balance)
    puts "The new balance is #{user.account.balance}"
  end

  def withdraw
    puts "Withdrawing..."
    user = User.find(self.user_id)
    new_balance = user.account.balance - self.amount

    if new_balance < 0
      puts "Error! Amount can't be greater than balance."
    else
      user.account.update(:balance => new_balance)
      puts "The new balance is #{user.account.balance}"
    end
  end

end