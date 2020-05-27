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

  def cancel_transaction
    puts "Hello #{user.name}, are you sure you want to cancel the last transaction? Yes or No?"
    user_input = gets.chomp
    if user_input == "Yes"
      puts "Canceling #{Transaction.last}"
      binding.pry
    end
  
    #deletes the last transaction performed by the user
    #Transaction.last, last transaction made by user
  end

end