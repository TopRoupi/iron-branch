FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { Faker::Company.brazilian_company_number }
    constitution { 'ltda' }
    email { Faker::Internet.email }
    telephone { rand(11000_000_000..11999_999_999).to_s }
    cep { '02470060' }
    capital { rand(100000) }
    last_capital_modification { Time.now.strftime("%d/%m/%Y") }
    status { rand(2) }
  end
end