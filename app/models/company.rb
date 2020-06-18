class Company < ApplicationRecord
  enum constitution: [:ltda, :sa]
  enum status: [:active, :inative]
  has_many :investments, foreign_key: 'investor_id'
  has_many :investors, class_name: 'Investment', foreign_key: 'invested_id'

  def have_anomalies?
    investments.exists?(anomalous: true)
  end

  def invested_companies
    investments.pluck(:invested_id).uniq.map do |id|
      Company.find(id)
    end
  end

  def unique_companies_investments
    investments.pluck(:invested_id).uniq.map do |id|
      investments.where(invested_id: id)
    end
  end

  def total_capital
    capital + investors.sum{ |investment| investment.value }
  end

  def participation_percentage_on(invested)
    participation_value_on(invested) / invested.total_capital * 100
  end

  def participation_value_on(invested)
    investments.where(invested: invested).sum { |investment| investment.value }
  end
end