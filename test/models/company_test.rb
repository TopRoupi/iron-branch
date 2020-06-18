require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = create :company
  end
    
  test '#have_anomalies? should return false if dont have any investments with anomalous true' do
    create :investment, investor: @company

    refute(@company.have_anomalies?)
  end

  test '#have_anomalies? should return true if do have any investments with anomalous true' do
    create :investment, investor: @company, anomalous: true

    assert(@company.have_anomalies?)
  end

  test '#invested_companies should return the list with the investors companies' do
    invested_a = create :company
    invested_b = create :company

    create :investment, investor: @company, invested: invested_a
    create :investment, investor: @company, invested: invested_b

    assert_includes(@company.invested_companies, invested_a, invested_b)
  end

  test '#unique_companies_investments should return a list with the investments per company invested' do
    invested_a = create :company
    invested_b = create :company

    create :investment, investor: @company, invested: invested_a
    create :investment, investor: @company, invested: invested_a

    create :investment, investor: @company, invested: invested_b
    create :investment, investor: @company, invested: invested_b

    assert_includes(@company.unique_companies_investments,
                    @company.investments.where(invested: invested_a),
                    @company.investments.where(invested: invested_b),)
  end

  test '#total_capital should return the capital plus the sum of investors investments on the company' do
    @company.capital = 100

    create :investment, invested: @company, value: 50
    create :investment, invested: @company, value: 50

    assert_equal(@company.total_capital, 200)
  end

  test '#participation_percentage_on should return the percentage of the participation on the invested company' do
    invested =  create :company, capital: 500

    create :investment, investor: @company, invested: invested, value: 500

    # 500 / (500 + 500) * 100

    assert_equal(@company.participation_percentage_on(invested), 50.0)
  end

  test '#participation_value_on should return the sum of the investments value on the invested company' do
    invested =  create :company

    create :investment, investor: @company, invested: invested, value: 500
    create :investment, investor: @company, invested: invested, value: 500

    assert_equal(@company.participation_value_on(invested), 1000)
  end
end