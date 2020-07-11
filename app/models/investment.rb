class Investment < ApplicationRecord
  belongs_to :investor, class_name: "Company"
  belongs_to :invested, class_name: "Company"
  enum funds: [:actions, :cotes]
  
  before_create :set_anomalous
  before_create :set_funds

  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :investment_date, presence: true
  validates :invested_id, presence: true
  validates :investor_id, presence: true

  def circular? 
    return true if investor == invested
    investor.all_investors.include? invested
  end

  private

  def set_anomalous
    self.anomalous = circular?
  end
  
  def set_funds
    self.funds = if (invested.constitution == 'ltda')
      'cotes'
    else
      'actions'
    end
  end
end
