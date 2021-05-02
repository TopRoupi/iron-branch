# frozen_string_literal: true

class ChangeDataTypeForCompanyCapital < ActiveRecord::Migration[6.0]
  def change
    change_column(:companies, :capital, :float8)
  end
end
