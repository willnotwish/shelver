require 'rails_helper'

RSpec.describe "units/index", type: :view do
  before(:each) do
    assign(:units, [
      Unit.create!(
        sheet: nil,
        code: "Code",
        width: 2,
        height: 3,
        offset_top: 4,
        offset_bottom: 5,
        shelf_count: 6
      ),
      Unit.create!(
        sheet: nil,
        code: "Code",
        width: 2,
        height: 3,
        offset_top: 4,
        offset_bottom: 5,
        shelf_count: 6
      )
    ])
  end

  it "renders a list of units" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(6.to_s), count: 2
  end
end
