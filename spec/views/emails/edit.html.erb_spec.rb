require 'rails_helper'

RSpec.describe "emails/edit", type: :view do
  let(:email) {
    Email.create!()
  }

  before(:each) do
    assign(:email, email)
  end

  it "renders the edit email form" do
    render

    assert_select "form[action=?][method=?]", email_path(email), "post" do
    end
  end
end
