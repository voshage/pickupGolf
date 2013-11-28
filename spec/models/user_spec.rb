require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "Example", last_name: "User", profile_name: "user", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  describe "first_name is not present" do
  	before { @user.first_name = "" }
  	it { should_not be_valid }
  end

  describe "last_name is not present" do
  	before { @user.last_name = "" }
  	it { should_not be_valid }
  end



  describe "when profile_name" do

	  describe "when is not present" do
	  	before { @user.profile_name = "" }
	  	it { should_not be_valid }
	  end

	  describe "is not present" do
	  	before do
	  		@newUser = User.new
	  		@newUser.profile_name = ""
	  		@newUser.save
	  	end

	  	subject { @newUser.errors[:profile_name] }

	  	it { should_not be_empty }
	  end

	  describe "is not unquie" do
	  	before do 
	  		@user = User.create(first_name: "Example", last_name: "User", profile_name: "user", 
	  			email: "user@example.com")
	  		@user2 = User.new(first_name: "Example", last_name: "User2", profile_name: "user", 
	  			email: "user@example.com")
	  	end

 		  subject { @user2 } 

	  	it { should_not be_valid }
	  end

	  describe "is not formated correctly" do
	  	before { @user.profile_name = "Pop 34 X" }

 		  subject { @user } 

	  	it { should_not be_valid }
	  	it { should be_new_record }
	  end
	end
end