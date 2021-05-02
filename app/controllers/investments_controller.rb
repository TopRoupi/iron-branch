# frozen_string_literal: true

class InvestmentsController < ApplicationController
  before_action :set_investment, only: [:show, :edit, :update, :destroy]

  # GET /investments
  # GET /investments.json
  def index
    @investments = Investment.all
  end

  # GET /investments/1
  # GET /investments/1.json
  def show
  end

  # GET /investments/new
  def new
    @investment = Investment.new

    @investment.investor_id = params[:investor_id]
    @investment.invested_id = params[:invested_id]

    session[:return_to] = request.referer
  end

  # POST /investments
  # POST /investments.json
  def create
    @investment = Investment.new(investment_params)

    respond_to do |format|
      if @investment.save
        session[:return_to] ||= @investment
        format.html { redirect_to session.delete(:return_to), notice: "Investment was successfully created." }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1
  # DELETE /investments/1.json
  def destroy
    @investment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Investment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_investment
    @investment = Investment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def investment_params
    params.require(:investment).permit(:investor_id, :invested_id, :value, :funds, :investment_date, :anomalous)
  end
end
