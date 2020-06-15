FactoryBot.define do
  factory :investment do
    association :investor, factory: :company
    association :invested, factory: :company
    value { rand(100000) }
    funds { "cotes" }
    investment_date { Time.now.strftime("%d/%m/%Y") }
    anomalous { false }
  end
end