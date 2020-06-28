FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { Faker::Company.brazilian_company_number }
    constitution { 'ltda' }
    email { Faker::Internet.email }
    telephone { rand(100_000_000..999_999_999).to_s }
    cep { Faker::Address.zip_code }
    capital { rand(100000) }
    last_capital_modification { Time.now.strftime("%d/%m/%Y") }
    status { rand(2) }
  end
end