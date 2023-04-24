require 'rails_helper'

RSpec.describe "sheets/index", type: :view do
  before(:each) do
    assign(:sheets, [
      Sheet.create!(
        thickness: 2,
        width: 3,
        length: 4,
        description: "MyText",
        name: "Name"
      ),
      Sheet.create!(
        thickness: 2,
        width: 3,
        length: 4,
        description: "MyText",
        name: "Name"
      )
    ])
  end

  it "renders a list of sheets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
