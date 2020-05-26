class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, through: :user
  
end