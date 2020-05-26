class User < ActiveRecord::Base
  has_one :account
  has_many :transactions, through: :account

end