require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.full_name) }
	end

	describe "sign_up page" do
		before { visit signup_path }

		let(:submit) { 'Create my account' }

		it { should have_content("Sign Up") }

		describe "when fields are blank" do
			it "should fail" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "when fields are all valid" do
			before do
				fill_in "First Name", with: "Chris"
				fill_in 'Last Name', with: "Wolfe"
				fill_in 'Profile Name', with: "WWCWD"
				fill_in 'Email', with: "cw2@gmail.com"
				fill_in 'Password', with: "ImStuckInTheCloset"
				fill_in 'Confirmation', with: "ImStuckInTheCloset"
			end

			it "should change User db count" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end