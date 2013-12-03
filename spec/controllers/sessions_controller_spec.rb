require 'spec_helper'

describe SessionsController do

	describe "should get new signup page" do
		before { visit signin_path }
		subject { controller }
		it { should assigns(:user) }
	end
end

# describe TeamsController do
#   describe "GET index" do
#     it "assigns @teams" do
#       team = Team.create
#       get :index
#       expect(assigns(:teams)).to eq([team])
#     end

#     it "renders the index template" do
#       get :index
#       expect(response).to render_template("index")
#     end
#   end
# end