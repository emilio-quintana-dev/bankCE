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

### READ:

- User can get his balance
- User can check transactions based on day
- User can check transactions based on amount

### DELETE:

- User can cancel a transaction

## Made by: Claud Sarb, Emilio Quintana
