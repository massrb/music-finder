require 'rails_helper'

RSpec.describe "emails/show", type: :view do
  before(:each) do
    assign(:email, Email.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
