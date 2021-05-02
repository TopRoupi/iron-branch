# frozen_string_literal: true

json.extract! company, :id, :name, :cnpj, :type, :email, :telephone, :cep, :capital, :last_capital_modification, :status, :created_at, :updated_at
json.url company_url(company, format: :json)
