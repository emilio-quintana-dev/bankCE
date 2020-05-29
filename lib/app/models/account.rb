class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transfers

  # DEPOSIT METHOD WHERE AMOUNT WAS POSITIVE ++
    def account_deposit
    end
  
    # WITHDRAW METHOD WHERE AMOUNT GETS TAKEN FROM ACCOUNT --  
  def account_withdraw
  end

end