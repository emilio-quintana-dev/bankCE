User.destroy_all
Transfer.destroy_all
Account.destroy_all

joe = User.create(name: "Joe Lake")
apple = User.create(name: "Adele Apple")
gabe = User.create(name: "Gaben First")


acct_1 = Account.create(balance: 0, user_id: joe.id)
acct_2 = Account.create(balance: 0, user_id: apple.id)
acct_3 = Account.create(balance: 0, user_id: gabe.id)

# TRANSACTIONS WITHIN JOE'S ACCOUNT
trans_acc_1 = Transfer.create(user_id: joe.id, account_id: acct_1.id, amount: 1000)
trans_acc_1.deposit
trans_acc_2 = Transfer.create(user_id: joe.id, account_id: acct_1.id, amount: 1000)
trans_acc_2.deposit
trans_acc_3 = Transfer.create(user_id: joe.id, account_id: acct_1.id, amount: 1000)
trans_acc_3.deposit

# TRANSACTIONS OUTSIDE JOE'S ACCOUNT
trans_acc_4 = Transfer.create(user_id: joe.id, account_id: acct_2.id, amount: 1000)
trans_acc_4.deposit
trans_acc_5 = Transfer.create(user_id: joe.id, account_id: acct_2.id, amount: 1000)
trans_acc_5.deposit
trans_acc_6 = Transfer.create(user_id: joe.id, account_id: acct_3.id, amount: 1000)
trans_acc_6.deposit



