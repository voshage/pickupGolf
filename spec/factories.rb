
FactoryGirl.define do 
	factory :user do
		first_name "Andrew"
		last_name "Voss"
		profile_name "sdogood"
		email "andrew.voshage@gmail.com"
		password "123456"
		password_confirmation "123456"
	end
end