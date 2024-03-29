# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { Faker::Company.brazilian_company_number }
    constitution { "ltda" }
    email { Faker::Internet.email }
    telephone { rand(11000_000_000..11999_999_999).to_s }
    cep { rand(10000000..99999999).to_s }
    capital { rand(100000) }
    last_capital_modification { Time.now.strftime("%d/%m/%Y") }
    status { rand(2) }
  end
end
