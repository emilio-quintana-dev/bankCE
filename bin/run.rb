require_relative '../config/environment'

# $table = TTY::Table.new ['header1','header2'], [['a1', 'a2'], ['b1', 'b2']]
$prompt = TTY::Prompt.new

puts `clear`
puts "Welcome to BankCE"
puts
name = $prompt.ask("Please enter your name:")

if User.find_by(name: name)
  user = User.find_by(name: name)
  menu(user)
else
  puts `clear`
  choices = %w(Yes No)
  answer = $prompt.select("No user found with that name, would you like to register?", choices)
  if answer == "Yes"
    user = User.create(name: name)
    acct = Account.create(balance: 0, user_id: user.id)
    menu(user)
  else
    puts "Bye bye!"
  end

end

