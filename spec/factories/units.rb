FactoryBot.define do
  factory :unit do
    sheet
    height { 2000 }
    width { 500 }
    depth { 300 }
    name { 'Test unit' }
    sequence :code do |n|
      "code-#{n}"
    end
  end
end
