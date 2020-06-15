FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { Faker::Company.brazilian_company_number }
    constitution { 'ltda' }
    email { Faker::Internet.email }
    telephone { '99999999999' }
    cep { Faker::Address.zip_code }
    capital { rand(100000) }
    last_capital_modification { Time.now.strftime("%d/%m/%Y") }
    status { 'active' }
  end
end