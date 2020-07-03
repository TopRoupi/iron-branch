class Company < ApplicationRecord
  enum constitution: [:ltda, :sa]
  enum status: [:active, :inative]
  has_many :investments, foreign_key: 'investor_id'
  has_many :investors, class_name: 'Investment', foreign_key: 'invested_id'

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  validates :name,
            length: { maximum: 60 },
            presence: true,
            uniqueness: true

  validates :constitution,
            presence: true

  validates :status,
            presence: true

  validates :cnpj,
            cnpj: true,
            presence: true,
            uniqueness: true

  validates :cep,
            format: {
              with: /[0-9]{5}-[0-9]{3}/
            },
            presence: true

  validates :capital,
            presence: true,
            numericality: { greater_than: 0 }

  validates :last_capital_modification,
            presence: true
            
  validates :telephone, 
            format: {
              with: /(^|\()?\s*(\d{2})\s*(\s|\))*(9?\d{4})(\s|-)?(\d{4})($|\n)/
            },
            presence: true,
            uniqueness: true

  def self.generate_tree(branches, levels, size_factor = 5)
    company = FactoryBot.create :company

    return company if levels < 0

    rand(branches).times do
      invested = generate_tree(branches , levels - 1)
      level /= size_factor
      branches = branches.min-1..branches.max
      FactoryBot.create :investment, investor: company, invested: invested 
    end

    company
  end

  def have_anomalies?
    investments.exists?(anomalous: true)
  end

  def invested_companies
    investments.pluck(:invested_id).uniq.map do |id|
      Company.find(id)
    end
  end

  def investors_companies
    investors.pluck(:investor_id).uniq.map do |id|
      Company.find(id)
    end
  end

  def unique_invested_companies_investments
    investments.pluck(:invested_id).uniq.map do |id|
      investments.where(invested_id: id)
    end
  end

  def unique_investor_companies_investments
    investors.pluck(:investor_id).uniq.map do |id|
      investors.where(investor_id: id)
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

  def sufixed_name
    "#{name} #{constitution}"
  end

  def self.search(term)
    Company.fuzzy_search(term)
  end

  def all_investors
    result = unique_investor_companies_investments

    result.filter! do |investments|
      investments[0].anomalous != true
    end

    result.map! do |investments|
      investor = investments[0].investor
      
      [investor.all_investors, investor]
    end
    
    result.flatten
  end
end
