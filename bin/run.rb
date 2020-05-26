require_relative '../config/environment'

def menu(user)

    puts "What would you like to do?"
    puts "1. Deposit"
    puts "2. Withdraw"
    puts "3. Get Balance"
    puts "0. Quit"
    print ">>> "
    action = gets.chomp.to_i
  
    while(action != 0) do
  
      case action
        when 1 # Deposit
          puts "How much would you like to deposit?"
          print ">>> "
          amount = gets.chomp.to_f
  
          puts "Creating Transaction..."
          tr = Transaction.create(user_id: user.id, account_id:  user.account.id, amount: amount, status: "pending")
          tr.deposit
          
        when 2 # Withdraw
          puts "How much would you like to withdraw?"
          print ">>> "
          amount = gets.chomp.to_f
  
          puts "Creating Transaction..."
          tr = Transaction.create(user_id: user.id, account_id:  user.account.id, amount: amount, status: "pending")
          tr.withdraw
        when 3 # Check Balance
          balance = user.account.balance
          # Update
          puts "Your current balance is $#{balance}"
        else
          puts "Incorrect input! Please try again."
      end
  
      puts "What would you like to do?"
      puts "1. Deposit"
      puts "2. Withdraw"
      puts "3. Get Balance"
      puts "0. Quit"
      print ">>> "
      action = gets.chomp.to_i
    end
end

puts "Welcome to BankCE"
puts "*" * 25

# Gets user's username
puts "Please enter your name:"
print ">>> "
name = gets.chomp
 
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


