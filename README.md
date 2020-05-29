# Name: BankCE

Description: BankCE is CLI built to be able to create users, have a balance and send money from
that balance to other users. <br/>

## Relationships:

User >—— Transaction ——< Account <br/>

## User Stories:

- User has one account <br/>
- User have many transactions through account <br/>
- Account can have many transactions <br/>
- Account belongs to a user <br/>
- Transaction belongs to one user <br/>
- Transaction belongs to one account <br/>

## CRUD Functionality:

### CREATE:

- User can create a new user with a new account
- User can create a new transaction (deposit/withdraw)
- User can send money to other users/accounts

### READ:

- User can get his balance
- User can view all transactions
- User can view own transactions

### DELETE:

- User can cancel/delete a transaction

## Made by: Claud Sarb, Emilio Quintana
