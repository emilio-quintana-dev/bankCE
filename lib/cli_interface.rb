require 'tty-prompt'


def menu(user)
  puts `clear`
  puts "Welcome #{user.name}"
  # $table.render(:basic)
  choices = %w(Deposit Withdraw History Cancel Balance Quit)
  action = $prompt.select("What would you like to do?", choices)
    
    while(action != "Quit") do
  
      case action
        when "Deposit"
          deposit(user)
        
        when "Withdraw"
          puts "How much would you like to withdraw?"
          print ">>> "
          amount = gets.chomp.to_f
  
          puts "Creating Transaction..."
          tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
          tr.withdraw

        when "History"
          puts "Which transactions would you like to view? All or Self"
          user_input = gets.chomp
          if user_input == "All"
            user.transfers.map do |transfer|
              puts "Transaction ID #{transfer.id}"
              puts "Transaction Amount #{transfer.amount}"
            end
          elsif user_input == "Self"
            user.owned_transfers.map do |transfer|
              puts "Transaction ID #{transfer.id}"
              puts "Transaction Amount #{transfer.amount}"
            end
          end
        when "Cancel"
          puts "Displaying Transactions..."
          user.transfers.map do |transaction|
            account = Account.find(transaction.account_id)
            user = User.find(account.user_id)
            puts "Name: #{user.name}"
            puts "Transaction ID: #{transaction.id}"
            puts "Amount: #{transaction.amount}"
          end

          puts "Please enter the ID of the transaction you would like to cancel:"
          transaction_id = gets.chomp.to_i

          transfer = Transfer.find(transaction_id)
          puts "Reversing Transaction...."
          transfer.reverse_transfer
        
          puts "Transaction Deleted and Reversed Successfully."
        when "Balance"
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
  puts `clear`
  choices = %w(MyAccount DifferentAccount) 
  choice = $prompt.select("Where would you like to deposit?", choices)
    if choice == "MyAccount"
      puts "How much would you like to deposit?"
      print ">>> "
      amount = gets.chomp.to_f 
      puts "Creating Transaction..."
      tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
      tr.deposit
    elsif choice == "DifferentAccount"

      choices = Account.all.map do |account|
        "#{account.user.name}  - #{account.id}"
      end

      chosen_account = $prompt.select("Which account would you like to deposit to?", choices)
      account_id = chosen_account[-1].to_i
      receiver = User.find(account_id)
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


