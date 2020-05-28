def display_stats(user)
  user.account.reload
  puts "🧍‍♂️  #{user.name}  |  💰  #{user.account.balance}  \n\n"
end

def clear_and_reload(user)
  puts `clear`
  user.account.reload
  user.transfers.reload
end

def menu(user)
  clear_and_reload(user)
  display_stats(user)

  choices = %w(Deposit Withdraw Cancel Balance Quit) # History is temporarily removed
  action = $prompt.select("What would you like to do?", choices)
    
    while(action != "Quit") do
      case action
        # DEPOSIT
        # USER CAN DEPOSIT MONEY INTO HIS/HER ACCOUNT
        # OR INTO ANOTHER ACCOUNT
        when "Deposit"
          clear_and_reload(user)
          display_stats(user)
          deposit(user)
        # WITHDRAW
        # USER CAN WITHDRAW MONEY FROM HIS/HER ACCOUNT
        when "Withdraw"
          clear_and_reload(user)
          display_stats(user)
          amount = $prompt.ask("How much would you like to withdraw?")
          # USER.ID => USER SENDING THE MONEY
          # ACCOUNT.ID => ACCOUNT OF USER RECIEVING THE MONEY
          tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
          tr.withdraw

        # when "History"
        #   puts `clear`
        #   display_stats(user)
        #   reload(user)

        #   choices = %w(All\ Transactions My\ Transactions)
        #   user_input = $prompt.select("Which transactions would you like to view?", choices)

        #   if user_input == "All Transactions"
        #     user.transfers.map do |transfer|
        #       puts "Transaction ID #{transfer.id} - Amount:  $ #{transfer.amount} - #{transfer.account.user.name}"
        #     end
        #   elsif user_input == "My Transactions"
        #     user.owned_transfers.map do |transfer|
        #       puts "Transaction ID #{transfer.id} - Amount:  $ #{transfer.amount}"
        #     end
        #   end

        # CANCEL
        # USER CAN SELECT A TRANSACTION HE
        # WOULD LIKE TO REVERSE/CANCEL
        when "Cancel"
          clear_and_reload(user)
          display_stats(user)
          
          # LOOP THROUGH ALL TRANSACTIONS THAT
          # INCLUDE THIS USER'S ID
          choices = user.transfers.map do |transaction|
            # SAVE THE RECIEVER'S ACCOUNT INSTANCE
            reciever_account = Account.find(transaction.account_id)
            # SAVE THE RECIEVER'S USER INSTANCE
            reciever = User.find(reciever_account.user_id)
            # PRINT OUT ALL TRANSACTIONS
            "#{reciever.name} - $ #{transaction.amount} - #{transaction.id}"
          end

          # USER SELECTS WHICH TRANSACTION HE WANTS TO CANCEL
          user_input = $prompt.select("Which transactions would you like to cancel?", choices)
          # GET THAT TRANSACTION'S ID
          transaction_id = user_input.split()[-1].to_i
          # FIND THAT TRANSACTION
          transfer = Transfer.find(transaction_id)
          # REVERSE IT
          transfer.reverse_transfer
          # CLEAR AND RELOAD
          clear_and_reload(user)
          display_stats(user)
          puts "Transaction Deleted and Reversed Successfully."

        when "Balance"
          clear_and_reload(user)
          display_stats(user)
          puts "Your current balance is $#{user.account.balance}"
        else
          puts "Incorrect input! Please try again."
      end

      action = $prompt.select("What would you like to do?", %w(Deposit Withdraw Cancel Balance Quit)) # # History is temporarily removed
      
    end
end


def deposit(user)
  # DEPOSIT WILL INCREASE THE BALANCE OF THE USER'S ACCOUNT
  # OR ANY OTHER REGISTERED ACCOUNT
  clear_and_reload(user)
  display_stats(user)
  choices = %w(My\ Account Different\ Account) 
  choice = $prompt.select("Where would you like to deposit?", choices)
    
  if choice == "My Account"
      clear_and_reload(user)
      display_stats(user)
      amount = $prompt.ask("How much would you like to deposit?")
      tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
      tr.deposit
      clear_and_reload(user)
      display_stats(user)
  elsif choice == "Different Account"
      clear_and_reload(user)
      display_stats(user)

      # LIST ALL REGISTERED ACCOUNTS
      choices = Account.all.map do |account|
        "NAME: #{account.user.name}  - ACCOUNT ID: #{account.id}"
      end
      # POSSIBLE PROBLEM HERE!!!
      
      # USER SELECTS ONE ACCOUNT
      chosen_account = $prompt.select("Which account would you like to deposit to?", choices)
      # WE GET THE ID OF THAT ACCOUNT
      account_id = chosen_account.split()[-1].to_i
      # WE GET THE RECIEVER'S ACCOUNT INSTANCE
      receiver_account = Account.find(account_id)
      # WE GET THE RECIEVERS RECIEVER'S USER INSTANCE
      receiver = User.find(receiver_account.user.id)
      # CLEAR AND RELOAD
      clear_and_reload(user)
      display_stats(user)
      # GET THE AMOUNT THE USER WANTS TO SEND
      amount = $prompt.ask("How much would you like to deposit?").to_f
      # CHECK FOR NEGATIVE BALANCE
      if user.account.balance < amount 
        puts "Insufficient funds!"
      else 
        # DEPOSIT MONEY INTO RECIEVER'S BALANCE
        tr = Transfer.create(user_id: user.id, account_id:  receiver.account.id, amount: amount)
        tr.deposit
        # CLEAR AND RELOAD
        clear_and_reload(user)
        display_stats(user)
        # WITHDRAW MONEY FROM THE SENDER'S BALANCE
        tr2 = Transfer.create(user_id: receiver.id, account_id: user.account.id, amount: amount)
        tr2.withdraw
        # CLEAR AND RELOAD
        clear_and_reload(user)
        display_stats(user)
        
        puts "Deposit completed!"
      end
    end
end

