require 'rails_helper'

RSpec.describe "units/edit", type: :view do
  let(:unit) {
    Unit.create!(
      sheet: nil,
      code: "MyString",
      width: 1,
      height: 1,
      offset_top: 1,
      offset_bottom: 1,
      shelf_count: 1
    )
  }

  before(:each) do
    assign(:unit, unit)
  end

  it "renders the edit unit form" do
    render

    assert_select "form[action=?][method=?]", unit_path(unit), "post" do

      assert_select "input[name=?]", "unit[sheet_id]"

      assert_select "input[name=?]", "unit[code]"

      assert_select "input[name=?]", "unit[width]"

      assert_select "input[name=?]", "unit[height]"

      assert_select "input[name=?]", "unit[offset_top]"

      assert_select "input[name=?]", "unit[offset_bottom]"

      assert_select "input[name=?]", "unit[shelf_count]"
    end
  end
end
