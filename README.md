Name: BankCE
Description: BankCE is CLI built to be able to create users, have a balance and send money from
that balance to other users.

Relationships:
User >—— Transaction ——< Account
name user_id account_id
user_id account_id balance
amount
datetime

User Stories:

- User has one account
- User have many transactions through account
- Account can have many transactions
- Account belongs to a user
- Transaction belongs to one user
- Transaction belongs to one account

CRUD Functionality:

CREATE:
User can create a new user with a new account
User can create a new transaction (deposit/withdraw)

READ:
User can get his balance
User can check transactions based on day
User can check transactions based on amount

DELETE:
User can cancel a transaction

Made by: Claud Sarb, Emilio Quintana
