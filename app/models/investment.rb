class Investment < ApplicationRecord
  belongs_to :investor, class_name: "Company"
  belongs_to :invested, class_name: "Company"
  enum funds: [:actions, :cotes]
  before_create :set_anomalous

  def circular? 
    return true if investor == invested
    investor.all_investors.include? invested
  end

  def set_anomalous
    self.anomalous = circular?
  end
end
