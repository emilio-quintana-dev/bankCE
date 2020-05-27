require 'tty-prompt'

def display_stats(user)
  user.account.reload
  puts "🧍‍♂️  #{user.name}  |  💰  #{user.account.balance}  \n\n"
end

def menu(user)
  puts `clear`
  display_stats(user)
  # $table.render(:basic)
  choices = %w(Deposit Withdraw History Cancel Balance Quit)
  action = $prompt.select("What would you like to do?", choices)
    
    while(action != "Quit") do
  
      case action
        when "Deposit"
          puts `clear`
          display_stats(user)
          deposit(user)
        
        when "Withdraw"
          puts `clear`
          display_stats(user)
          puts "How much would you like to withdraw?"
          print ">>> "
          amount = gets.chomp.to_f
  
          tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
          tr.withdraw

        when "History"
          puts `clear`
          display_stats(user)

          choices = %w(All\ Transactions My\ Transactions)
          user_input = $prompt.select("Which transactions would you like to view?", choices)

          if user_input == "All Transactions"
            user.transfers.map do |transfer|
              puts "Transaction ID #{transfer.id} - Amount:  $ #{transfer.amount}"
            end
          elsif user_input == "My Transactions"
            user.owned_transfers.map do |transfer|
              puts "Transaction ID #{transfer.id} - Amount:  $ #{transfer.amount}"
            end
          end
        when "Cancel"
          puts `clear`
          display_stats(user)
        
          choices = user.transfers.map do |transaction|
            account = Account.find(transaction.account_id)
            reciever = User.find(account.user_id)
            "#{reciever.name} - $ #{transaction.amount} - #{transaction.id}"
          end

          user_input = $prompt.select("Which transactions would you like to cancel?", choices)
          transaction_id = user_input.split()[-1].to_i
          transfer = Transfer.find(transaction_id)
          transfer.reverse_transfer
          user.transfers.reload
          puts "Transaction Deleted and Reversed Successfully."
        when "Balance"
          puts `clear`
          display_stats(user)
          user.account.reload
          balance = user.account.balance
          puts "Your current balance is $#{balance}"
        else
          puts "Incorrect input! Please try again."
      end

      action = $prompt.select("What would you like to do?", %w(Deposit Withdraw History Cancel Balance Quit))
      
    end
end

def deposit(user)
  choices = %w(My\ Account Different\ Account) 
  choice = $prompt.select("Where would you like to deposit?", choices)
    if choice == "My Account"
      puts `clear`
      display_stats(user)
      puts "How much would you like to deposit?"
      print ">>> "
      amount = gets.chomp.to_f 
      tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
      tr.deposit
    elsif choice == "Different Account"
      puts `clear`
      display_stats(user)
      choices = Account.all.map do |account|
        "#{account.user.name}  - #{account.id}"
      end

      chosen_account = $prompt.select("Which account would you like to deposit to?", choices)
      account_id = chosen_account.split()[-1].to_i
      receiver = User.find(account_id)

      puts `clear`
      display_stats(user)
      puts "How much would you like to deposit?"
      print ">>> "
      amount = gets.chomp.to_f
      if user.account.balance < amount 
        puts "Insufficient funds!"
      else 
        puts "Creating Transaction..."
        tr = Transfer.create(user_id: receiver.id, account_id:  receiver.account.id, amount: amount)
        tr.deposit
      end
    end
end


