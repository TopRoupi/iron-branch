class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.integer :constitution
      t.string :email
      t.string :telephone
      t.string :cep
      t.float :capital
      t.date :last_capital_modification
      t.integer :status

      t.timestamps
    end
  end
end
