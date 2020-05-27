require_relative '../config/environment'
require 'tty-prompt'
require 'tty-table'

# $table = TTY::Table.new ['header1','header2'], [['a1', 'a2'], ['b1', 'b2']]
$prompt = TTY::Prompt.new

def menu(user)
  puts `clear`
  # $table.render(:basic)
  choices = %w(Deposit Withdraw History Cancel Balance Quit)
  action = $prompt.select("What would you like to do?", choices)
    
  
    while(action != 6) do
  
      case action
        when "Deposit"
          deposit(user)
        #   puts "Would you like to deposit into your account? Yes or No?"
        #   user_input = gets.chomp
        #   if user_input == "yes, YES, y, Yes"
        #       puts "How much would you like to deposit?"
        #     print ">>> "
        #     amount = gets.chomp.to_f 
        #       puts "Creating Transaction..."
        #       tr = Transfer.create(user_id: user.id, account_id:  user.account.id, amount: amount)
        #       tr.deposit
        #   else
        #   puts "If you will like to deposit into another account, please enter account ID."
        #     Account.all.map do |account|
        #   puts "#{account.user.name}  - #{account.id}"
        #     end
        #     account_id = gets.chomp.to_i
        #     receiver = User.find(account_id)
        #     puts "How much would you like to deposit?"
        #     print ">>> "
        #     amount = gets.chomp.to_f
        #     if user.account.balance < amount 
        #       puts "Insufficient funds!"
        #     else 
        #     puts "Creating Transaction..."
        #     tr = Transfer.create(user_id: receiver.id, account_id:  receiver.account.id, amount: amount)
        #     tr.deposit
        #     end
        # end
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
      action = prompt.select("What would you like to do?", %w(Deposit Withdraw History Cancel Balance Quit))
      
    end
end

puts "Welcome to BankCE"
puts "*" * 25

# Gets user's username
# puts "Please enter your name:"
# print ">>> "
name = $prompt.ask("Please enter your name:")


 
# If the user exists then launch the menu
# based on that user's instance
if User.find_by(name: name)
  user = User.find_by(name: name)
  puts "User #{name} found!"
  puts "Launching menu..."
  menu(user)
# If the user does not exists then ask
# if the user would like to create an account
else
  puts "No user found with that name, would you like to register?"
  print ">>> "
  answer = gets.chomp
  if answer == "Yes"
    puts "Creating user..."
    user = User.create(name: name)
    puts "Creating account..."
    acct = Account.create(balance: 0, user_id: user.id)
    puts "User and account created!"
    puts "Launching menu..."
    menu(user)
  else
    puts "Bye bye!"
  end

end

# prompt = TTY::Prompt.new
