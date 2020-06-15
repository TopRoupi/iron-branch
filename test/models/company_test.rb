require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  context '#down_tree with no circular investments' do
    setup do
      @company_a = create :company

      @company_b = create :company

      create :investment, investor: @company_a, invested: @company_b
    end

    should 'return a tree of #invested_companies_hash' do
      expected_tree = @company_a.invested_companies_hash
      expected_tree[:investments] = [{
        tree: @company_b.invested_companies_hash,
        investment: @company_a.invested_companies_hash[:investments][0]
      }]

      assert_equal(expected_tree, @company_a.down_tree)
    end
  end

  context '#down_tree with circular investments' do
    setup do
      @company_a = create :company

      @company_b = create :company

      create :investment, investor: @company_a, invested: @company_b
      create :investment, investor: @company_b, invested: @company_a, anomalous: true
    end

    should 'return a tree of #invested_companies_hash' do
      expected_tree = @company_a.invested_companies_hash
      expected_tree[:investments] = [{
        tree: @company_b.invested_companies_hash,
        investment: @company_a.invested_companies_hash[:investments][0]
      }]
      expected_tree[:investments][0][:tree][:investments] = [{
        tree: {
          company: @company_a.invested_companies_hash[:company],
          investments: []
        },
        investment: @company_b.invested_companies_hash[:investments][0]
      }]

      assert_equal(expected_tree, @company_a.down_tree)
    end
  end
end
