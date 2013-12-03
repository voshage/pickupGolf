require 'spec_helper'

describe SessionsController do

	describe "should get new signup page" do
		before { visit signin_path }
		subject { controller }
		it { should assigns(:user) }
	end
end
