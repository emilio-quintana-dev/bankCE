class Transfer < ActiveRecord::Base
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

  def reverse_transfer

    # Get the account where the deposit was made
    account_id = self.account_id
    reciever_account = Account.find(account_id)

    # Get the account of the user that made the deposit
    user_account = self.user.account

    # Reverse Transactions
    puts "Reversing Transaction..."
    reciever_balance = reciever_account.balance - self.amount
    reciever_account.update(:balance => reciever_balance)
    
    sender_balance = user_account.balance + self.amount
    user_account.update(:balance => sender_balance)
    
    self.delete
  end

end