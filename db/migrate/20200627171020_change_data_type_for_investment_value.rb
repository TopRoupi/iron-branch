# frozen_string_literal: true

class ChangeDataTypeForInvestmentValue < ActiveRecord::Migration[6.0]
  def change
    change_column(:investments, :value, :float8)
  end
end
