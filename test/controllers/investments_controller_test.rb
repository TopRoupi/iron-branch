require 'test_helper'

class InvestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investment = create :investment
  end

  test "should get new" do
    get new_investment_url,
      params: {
        investor_id: @investment.investor_id,
        invested_id: @investment.invested_id
      }
    assert_response :success
  end

  test "should create investment" do
    assert_difference('Investment.count') do
      post investments_url, params: { investment: { anomalous: @investment.anomalous, invested_id: @investment.invested_id, investment_date: @investment.investment_date, investor_id: @investment.investor_id, funds: @investment.funds, value: @investment.value } }
    end

    assert_redirected_to investment_url(Investment.last)
  end

  test "should show investment" do
    get investment_url(@investment)
    assert_response :success
  end

  test "should destroy investment" do
    assert_difference('Investment.count', -1) do
      delete investment_url(@investment)
    end

    assert_redirected_to root_path
  end
end
