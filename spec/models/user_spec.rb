require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "Example User", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }

  describe "when first_name is not present" do
  	before { @user.first_name = "" }
  	it { should_not be_valid }
  end
end