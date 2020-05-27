User.destroy_all
Transaction.destroy_all
Account.destroy_all

joe = User.create(name: "Joe Lake")
apple = User.create(name: "Adele Apple")
gabe = User.create(name: "Gaben First")


acct_1 = Account.create(balance: 0, user_id: joe.id)
acct_2 = Account.create(balance: 0, user_id: apple.id)
acct_3 = Account.create(balance: 0, user_id: gabe.id)

trans_acc_1 = Transaction.create(user_id: joe.id, account_id: acct_1.id, amount: 100)

