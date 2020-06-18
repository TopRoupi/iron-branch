require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = create :company
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post companies_url, params: { company: { capital: @company.capital, cep: @company.cep, cnpj: @company.cnpj, email: @company.email, last_capital_modification: @company.last_capital_modification, name: @company.name, status: @company.status, telephone: @company.telephone, constitution: @company.constitution } }
    end

    assert_redirected_to company_url(Company.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { capital: @company.capital, cep: @company.cep, cnpj: @company.cnpj, email: @company.email, last_capital_modification: @company.last_capital_modification, name: @company.name, status: @company.status, telephone: @company.telephone, constitution: @company.constitution } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end
end