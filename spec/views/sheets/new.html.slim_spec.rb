require 'rails_helper'

RSpec.describe "sheets/new", type: :view do
  before(:each) do
    assign(:sheet, Sheet.new(
      thickness: 1,
      width: 1,
      length: 1,
      description: "MyText",
      name: "MyString"
    ))
  end

  it "renders new sheet form" do
    render

    assert_select "form[action=?][method=?]", sheets_path, "post" do

      assert_select "input[name=?]", "sheet[thickness]"

      assert_select "input[name=?]", "sheet[width]"

      assert_select "input[name=?]", "sheet[length]"

      assert_select "textarea[name=?]", "sheet[description]"

      assert_select "input[name=?]", "sheet[name]"
    end
  end
end
