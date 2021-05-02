# frozen_string_literal: true

require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = create :company
  end

  test "#have_anomalies? should return false if dont have any investments with anomalous true" do
    create :investment, investor: @company

    refute(@company.have_anomalies?)
  end

  test "#have_anomalies? should return true if do have any investments with anomalous true" do
    invested = create :company

    create :investment, investor: invested, invested: @company
    create :investment, investor: @company, invested: invested, anomalous: true

    assert(@company.have_anomalies?)
  end

  test "#invested_companies should return the list with the investors companies" do
    invested_a = create :company
    invested_b = create :company

    create :investment, investor: @company, invested: invested_a
    create :investment, investor: @company, invested: invested_b

    assert_includes(@company.invested_companies, invested_a, invested_b)
  end

  test "#investors_companies should return the list with the investors companies" do
    investor_a = create :company
    investor_b = create :company

    create :investment, investor: investor_a, invested: @company
    create :investment, investor: investor_b, invested: @company

    assert_includes(@company.investors_companies, investor_a, investor_b)
  end

  test "#unique_invested_companies_investments should return a list with the investments per company invested" do
    invested_a = create :company
    invested_b = create :company

    create :investment, investor: @company, invested: invested_a
    create :investment, investor: @company, invested: invested_a

    create :investment, investor: @company, invested: invested_b
    create :investment, investor: @company, invested: invested_b

    assert_includes(@company.unique_invested_companies_investments,
      @company.investments.where(invested: invested_a),
      @company.investments.where(invested: invested_b))
  end

  test "#unique_investor_companies_investments should return a list with the investments per investor company" do
    investor_a = create :company
    investor_b = create :company

    create :investment, investor: investor_a, invested: @company
    create :investment, investor: investor_a, invested: @company

    create :investment, investor: investor_b, invested: @company
    create :investment, investor: investor_b, invested: @company

    assert_includes(@company.unique_investor_companies_investments,
      @company.investors.where(investor: investor_a),
      @company.investors.where(investor: investor_b))
  end

  test "#total_capital should return the capital plus the sum of investors investments on the company" do
    @company.capital = 100

    create :investment, invested: @company, value: 50
    create :investment, invested: @company, value: 50

    assert_equal(@company.total_capital, 200)
  end

  test "#participation_percentage_on should return the percentage of the participation on the invested company" do
    invested = create :company, capital: 500

    create :investment, investor: @company, invested: invested, value: 500

    # 500 / (500 + 500) * 100

    assert_equal(@company.participation_percentage_on(invested), 50.0)
  end

  test "#participation_value_on should return the sum of the investments value on the invested company" do
    invested = create :company

    create :investment, investor: @company, invested: invested, value: 500
    create :investment, investor: @company, invested: invested, value: 500

    assert_equal(@company.participation_value_on(invested), 1000)
  end

  test "#sufixed_name should return name plus the constitution" do
    assert_equal(@company.sufixed_name, "#{@company.name} #{@company.constitution}")
  end

  test "#search should search agaist every string column" do
    columns = Company.columns.filter { |column| column.type == :string }

    columns.each do |column|
      column = @company.send(column.name)

      assert_includes(Company.search(column), @company)
    end
  end

  test "#all_investors should return all investors companies direct and indirect" do
    investor_a = create :company
    investor_b = create :company
    not_an_investor = create :company

    create :investment, investor: investor_a, invested: investor_b
    create :investment, investor: investor_b, invested: @company
    create :investment, investor: @company, invested: not_an_investor

    assert_includes(@company.all_investors, investor_a, investor_b)
    refute_includes(@company.all_investors, not_an_investor)
  end

  test "#investments_matrix should return the company's investments tree matrix" do
    invested_a = create :company
    invested_b = create :company
    indirect_invested = create :company

    investment_a = create :investment, investor: @company, invested: invested_a
    investment_b = create :investment, investor: @company, invested: invested_b
    indirect_investment = create :investment, investor: invested_a, invested: indirect_invested

    expected_out = [
      [@company],
      [investment_a, investment_b],
      [invested_a, invested_b],
      [indirect_investment],
      [indirect_invested]
    ]

    # ivestment tree
    #
    #      c
    #      |
    #    -----
    #    |   |
    #    a   b
    #    |
    #    |
    #    d

    assert_equal @company.investments_matrix, expected_out
  end
end
