class User < ActiveRecord::Base
  has_one :account
  has_many :transfers
  has_many :owned_transfers, through: :account, source: :transfers
end