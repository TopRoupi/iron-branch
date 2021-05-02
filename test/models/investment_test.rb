# frozen_string_literal: true

require "test_helper"

class InvestmentTest < ActiveSupport::TestCase
  setup do
    @investment = create :investment
  end

  test "#circular? should return if a investment is circular" do
    company_a = create :company
    company_b = create :company

    create :investment, investor: company_a, invested: company_b

    @investment.investor = company_b
    @investment.invested = company_a

    assert(@investment.circular?)
  end
end
