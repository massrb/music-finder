require 'rails_helper'

RSpec.describe "emails/index", type: :view do
  before(:each) do
    assign(:emails, [
      Email.create!(),
      Email.create!()
    ])
  end

  it "renders a list of emails" do
    render
    cell_selector = 'div>p'
  end
end
