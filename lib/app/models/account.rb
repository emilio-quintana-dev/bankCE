class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transfers

  # DEPOSIT METHOD WHERE AMOUNT WAS POSITIVE
  
end