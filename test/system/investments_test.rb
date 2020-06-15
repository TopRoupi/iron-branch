require "application_system_test_case"

class InvestmentsTest < ApplicationSystemTestCase
  setup do
    @investment = investments(:one)
  end

  test "visiting the index" do
    visit investments_url
    assert_selector "h1", text: "Investments"
  end

  test "creating a Investment" do
    visit investments_url
    click_on "New Investment"

    check "Anomalous" if @investment.anomalous
    fill_in "Invested company", with: @investment.invested_company_id
    fill_in "Investment date", with: @investment.investment_date
    fill_in "Investor company", with: @investment.investor_company_id
    fill_in "Type", with: @investment.type
    fill_in "Value", with: @investment.value
    click_on "Create Investment"

    assert_text "Investment was successfully created"
    click_on "Back"
  end

  test "updating a Investment" do
    visit investments_url
    click_on "Edit", match: :first

    check "Anomalous" if @investment.anomalous
    fill_in "Invested company", with: @investment.invested_company_id
    fill_in "Investment date", with: @investment.investment_date
    fill_in "Investor company", with: @investment.investor_company_id
    fill_in "Type", with: @investment.type
    fill_in "Value", with: @investment.value
    click_on "Update Investment"

    assert_text "Investment was successfully updated"
    click_on "Back"
  end

  test "destroying a Investment" do
    visit investments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Investment was successfully destroyed"
  end
end
