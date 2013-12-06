require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "index" do
		before do
			sign_in FactoryGirl.create(:user)
			FactoryGirl.create(:user, first_name: "Bob", profile_name: "Bob", email: "bob@gmail.com")
			FactoryGirl.create(:user, first_name: "Bob", profile_name: "Sue", email: "sue@gmail.com")
			visit users_path
		end

    	it { should have_content('All users') }

    	it "should list each user" do
    		User.all.each do |user|
    			expect(page).to have_selector('td', text: user.full_name)
    		end
    	end
	end


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
				fill_in 'Password', with: "Password"
				fill_in 'Confirmation', with: "Password"
			end

			it "should change User db count" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
			describe "after saving user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'cw2@gmail.com') }

				it { should have_link("Sign Out") }
				it { should have_content(user.full_name) }
				it { should have_selector('div.alert.alert-notice', text: 'Welcome') }
			end
		end
	end

	describe "edit page" do
		let(:user) {FactoryGirl.create(:user)}
		let(:updateButton) { 'Update Info' }
		before do 
			sign_in user
			visit edit_user_path(user)
		end

		it { should have_content("Edit Your Info") }

		describe "invalid info entered" do
			before do
				fill_in "Email", with: ""
				fill_in "Password", with: user.password
				fill_in "Confirmation", with: user.password
				click_button updateButton
			end

			it { should have_selector('div.alert.alert-error'), text: "Invalid" }
		end

		describe "with valid information" do
			let(:new_email) { "newemail@gmail.com" }
			before do
				fill_in "Email", with: new_email
				fill_in "Password", with: user.password
				fill_in "Confirmation", with: user.password
				click_button updateButton
			end
			it { should have_selector('div.alert.alert-success') }
			specify { expect(user.reload.email).to eq new_email }
		end

	end
end