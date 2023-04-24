require 'rails_helper'

RSpec.describe "units/show", type: :view do
  before(:each) do
    assign(:unit, Unit.create!(
      sheet: nil,
      code: "Code",
      width: 2,
      height: 3,
      offset_top: 4,
      offset_bottom: 5,
      shelf_count: 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
