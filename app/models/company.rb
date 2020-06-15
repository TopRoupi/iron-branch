class Company < ApplicationRecord
  enum constitution: [:ltda, :sa]
  enum status: [:active, :inative]
  has_many :investments, foreign_key: 'investor_id'
  has_many :investors, class_name: 'Investment', foreign_key: 'invested_id'


  def down_tree
    company_hash = invested_companies_hash
    return company_hash if company_hash[:investments].empty?

    company_hash[:investments].map! do |investment|
      company = Company.find(investment[0]['invested_id'])

      tree = if investment[0]['anomalous']
        company = company.invested_companies_hash
        company[:investments].clear
        company
      else
        company.down_tree
      end

      {
        tree: tree,
        investment: investment
      }
    end

    company_hash
  end

  def have_anomalies?
    investments.exists?(anomalous: true)
  end

  def invested_companies_hash
    unique_investments = investments.pluck(:invested_id).uniq

    unique_investments.map! do |id|
      investments.where(invested_id: id).map { |i| i.serializable_hash }
    end

    {
      company: serializable_hash,
      investments: unique_investments
    }
  end
end