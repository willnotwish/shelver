require 'rails_helper'

RSpec.describe "sheets/edit", type: :view do
  let(:sheet) {
    Sheet.create!(
      thickness: 1,
      width: 1,
      length: 1,
      description: "MyText",
      name: "MyString"
    )
  }

  before(:each) do
    assign(:sheet, sheet)
  end

  it "renders the edit sheet form" do
    render

    assert_select "form[action=?][method=?]", sheet_path(sheet), "post" do

      assert_select "input[name=?]", "sheet[thickness]"

      assert_select "input[name=?]", "sheet[width]"

      assert_select "input[name=?]", "sheet[length]"

      assert_select "textarea[name=?]", "sheet[description]"

      assert_select "input[name=?]", "sheet[name]"
    end
  end
end
