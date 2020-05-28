class Transfer < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  def deposit
    new_balance = account.balance + self.amount
    account.update(:balance => new_balance)
  end

  def withdraw
    # CALCULATES POSSIBLE NEW BALANCE TO CHECK FOR
    # NEGATIVES
    new_balance = account.balance - self.amount
    # IF THE POSSIBLE BALANCE IS LESS THAN ZERO
    # THEN RAISE AN ERROR
    if new_balance < 0
      puts "Error! You can't withdraw more than your current balance."
    else
      # WITHDRAWS MONEY FROM THE USER'S BALANCE
      account.update(:balance => new_balance)
    end
  end

  def reverse_transfer

    # GET THE RECIEVER'S ACCOUNT
    reciever_account = Account.find(self.account_id)

    # GET THE SENDER'S ACCOUNT
    user_account = self.user.account

    # START REVERSAL
    puts "Reversing Transaction..."

    # WITHDRAW FROM RECIEVER'S BALANCE
    recievers_new_balance = reciever_account.balance - self.amount
    reciever_account.update(:balance => recievers_new_balance)
    
    # DEPOSIT INTO SENDER'S BALANCE
    senders_new_balance = user_account.balance + self.amount
    user_account.update(:balance => senders_new_balance)
    
    # DELETE TRANSACTION FROM TABLE
    self.delete
  end

end