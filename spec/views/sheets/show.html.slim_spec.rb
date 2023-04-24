require 'rails_helper'

RSpec.describe "sheets/show", type: :view do
  before(:each) do
    assign(:sheet, Sheet.create!(
      thickness: 2,
      width: 3,
      length: 4,
      description: "MyText",
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
  end
end
