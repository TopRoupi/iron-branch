# frozen_string_literal: true

require "test_helper"

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
    @company = build :company
    assert_difference("Company.count") do
      post companies_url, params: {company: {capital: @company.capital, cep: @company.cep, cnpj: @company.cnpj, email: @company.email, last_capital_modification: @company.last_capital_modification, name: @company.name, status: @company.status, telephone: @company.telephone, constitution: @company.constitution}}
    end

    assert_redirected_to companies_path
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should show company investments on" do
    invested = create :company

    create :investment, investor: @company, invested: invested

    get "/companies/#{@company.id}/investments-on/#{invested.id}"

    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: {company: {capital: @company.capital, cep: @company.cep, cnpj: @company.cnpj, email: @company.email, last_capital_modification: @company.last_capital_modification, name: @company.name, status: @company.status, telephone: @company.telephone, constitution: @company.constitution}}
    assert_redirected_to companies_path
  end

  test "should destroy company" do
    assert_difference("Company.count", -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end

  # search tests

  test "get index should search for companies by name" do
    other_company = create :company

    get companies_url,
      params: {
        search: @company.name
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by cnpj" do
    other_company = create :company

    get companies_url,
      params: {
        search: @company.name
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by telephone" do
    other_company = create :company

    get companies_url,
      params: {
        search: @company.telephone
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by email" do
    other_company = create :company

    get companies_url,
      params: {
        search: @company.email
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by cep" do
    other_company = create :company

    get companies_url,
      params: {
        search: @company.cep
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by capital equals" do
    other_company = create :company

    get companies_url,
      params: {
        capital_param: "=",
        capital: @company.capital
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by capital greather than" do
    other_company = create :company, capital: 100
    @company.capital = 200

    get companies_url,
      params: {
        capital_param: ">",
        capital: 150
      }

    assert_includes(assigns(:companies), @company)
    refute_includes(assigns(:companies), other_company)
  end

  test "get index should search for companies by capital less than" do
    other_company = create :company, capital: 100
    @company.capital = 200

    get companies_url,
      params: {
        capital_param: "<",
        capital: 150
      }

    assert_includes(assigns(:companies), other_company)
    refute_includes(assigns(:companies), @company)
  end
end
