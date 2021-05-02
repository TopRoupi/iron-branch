# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :show_investments_on, :new_investment]
  autocomplete :company, :name, full: true
  autocomplete :company, :cnpj, full: false, extra_data: [:name, :cep, :telephone, :email, :cnpj]

  # GET /companies
  # GET /companies.json
  def index
    @companies = if params[:search].blank?
      Company.all
    else
      Company.search params[:search]
    end

    @companies.where!(constitution: params[:constitution]) unless params[:constitution].blank?
    @companies.where!(status: params[:status]) unless params[:status].blank?

    unless params[:capital_param].blank? || params[:capital].blank?
      @companies.where!("capital #{params[:capital_param]} #{params[:capital]}")
    end

    unless params[:order_param].blank? || params[:order_by].blank?
      @companies.order!("#{params[:order_by]} #{"DESC" if params[:order_param] == "desc"}")
    end

    @companies = @companies.paginate(page: params[:page], per_page: 10)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/1/investments-on/2
  def show_investments_on
    @invested = Company.find(params[:invested_id])
    @investments = @company.investments.where(invested: @invested)
    @investments = @investments.paginate(page: params[:page], per_page: 10)
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to companies_url, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :cnpj, :constitution, :email, :telephone, :cep, :capital, :last_capital_modification, :status)
  end
end
