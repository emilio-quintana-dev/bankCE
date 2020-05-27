require 'tty-prompt'



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
            # binding.pry
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


