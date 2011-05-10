require File.dirname(__FILE__) + '/../test_helper'
require 'home_controller'

class HomeControllerTest < ActionController::TestCase
  
  scenario :basic
  
  def setup
    @controller = HomeController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  should route(:get, "/").to(:controller=>'home', :action => 'show')

  context "get show" do
    setup {get :show}
    should respond_with(:success)
    should assign_to(:body_class)
    should render_template 'show'
  end
  
  context "show with empty user table" do
    setup do
      HomeController.class_eval do
        class_variable_set '@@verified_installation', nil
      end
      User.destroy_all
      get :show
    end
    should respond_with(:redirect)
  end
  
end
