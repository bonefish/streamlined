require File.join(File.dirname(__FILE__), '../../../test_functional_helper')
require 'streamlined/helpers/link_helper'

class Streamlined::Helpers::LinkHelperTest < Test::Unit::TestCase
  
  def setup
    @controller = PeopleController.new
    @controller.logger = RAILS_DEFAULT_LOGGER
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @view = ActionView::Base.new
    @view.extend Streamlined::Helpers::LinkHelper
    @view.controller = @controller
    get :action=>'index'
  end
  
  def test_link_to_new_model
    assert_equal "<a href=\"#\" onclick=\"Streamlined.Windows.open_local_window_from_url('New', '/people/new'); return false;\"><img alt=\"New \" border=\"0\" src=\"/images/add_16.png\" title=\"New \" /></a>", @view.link_to_new_model
  end
end