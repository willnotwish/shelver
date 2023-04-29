FactoryBot.define do
  factory :panel do
    x { 100 }
    y { 200 }
    sheet
    label { 'Test panel' }
  end
end
