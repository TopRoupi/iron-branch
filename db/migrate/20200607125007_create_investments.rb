# frozen_string_literal: true

class CreateInvestments < ActiveRecord::Migration[6.0]
  def change
    create_table :investments do |t|
      t.references :investor, null: false, foreign_key: {to_table: "companies"}
      t.references :invested, null: false, foreign_key: {to_table: "companies"}
      t.float :value
      t.integer :funds
      t.date :investment_date
      t.boolean :anomalous

      t.timestamps
    end
  end
end
