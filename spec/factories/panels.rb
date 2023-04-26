FactoryBot.define do
  factory :panel do
    x { 1 }
    y { 1 }
    sheet { nil }
    label { "MyString" }
    description { "MyText" }
  end
end
