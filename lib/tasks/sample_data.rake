namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Andrew",
    			 last_name:  "Voshage",
    			 profile_name: "sdogood",
                 email: "andrew.voshage@gmail.com",
                 password: "password",
                 password_confirmation: "password")
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      profile_name = "profile-#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(first_name: first_name,
      				last_name: last_name,
                   email: email,
                   profile_name: profile_name,
                   password: password,
                   password_confirmation: password)
    end
  end
end