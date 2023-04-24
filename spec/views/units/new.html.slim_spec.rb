require 'rails_helper'

RSpec.describe "units/new", type: :view do
  before(:each) do
    assign(:unit, Unit.new(
      sheet: nil,
      code: "MyString",
      width: 1,
      height: 1,
      offset_top: 1,
      offset_bottom: 1,
      shelf_count: 1
    ))
  end

  it "renders new unit form" do
    render

    assert_select "form[action=?][method=?]", units_path, "post" do

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
