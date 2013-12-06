require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "Example", last_name: "User", 
  														profile_name: "user", email: "user@example.com", 
  														password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) } # these are added to the user
  it { should respond_to(:password_confirmation) } # after has_secure_password is called
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
  	before do
  		@user.save!
  		@user.toggle!(:admin)
  	end

  	it { should be_admin }
  end

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

	describe "when password is" do

		describe "too short" do
			# should be at least 6 chars
			before { @user.password = @user.password_confirmation = "a" * 5 }

			it { should be_invalid }
		end

		describe "retun value of authethod method" do
			before { @user.save }
			# let creates local varible
			let(:found_user) { User.find_by(email: @user.email ) }

			describe "with valid password" do
				# authenticate returns the found_user if true
				it { should eq found_user.authenticate(@user.password) }
			end

			describe "with invalid password" do
				let(:user_for_invalid_password) { found_user.authenticate("invalid") }
     
     		it { should_not eq user_for_invalid_password }
     		# specify is the same as it
      	specify { expect(user_for_invalid_password).to be_false }
			end

		end
	end

	describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "remember_token" do
  	before { @user.save }
  	its(:remember_token) { should_not be_blank } # it { expect(@user.remember_token).not_to be_blank }
  end
end