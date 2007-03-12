require File.join(File.dirname(__FILE__), '../../../test_helper')
require 'streamlined/controller/render_methods'

class Streamlined::Controller::RenderMethodsTest < Test::Unit::TestCase
  include Streamlined::Controller::RenderMethods
  include FlexMock::TestCase
  
  # begin stub methods
  def controller_name
    "people"
  end
  
  def managed_views_include?(action)
    true
  end

  def managed_partials_include?(action)
    true
  end
  # end stub methods
  
  def pretend_template_exists(exists)
    flexstub(self) do |stub|
      stub.should_receive(:specific_template_exists?).and_return(exists)
    end
  end
  
  def test_convert_action_options_for_generic
    pretend_template_exists(false)
    options = {:action=>"new", :id=>"1"}
    convert_action_options(options)
    assert_equal({:template=>"../../../templates/generic_views/new", :id=>"1"}, options)
  end

  def test_convert_action_options_for_specific
    pretend_template_exists(true)
    options = {:action=>"new", :id=>"1"}
    convert_action_options(options)
    assert_equal({:action=>"new", :id=>"1"}, options)
  end

  def test_convert_partial_options_for_generic
    pretend_template_exists(false)
    options = {:partial=>"_list", :other=>"1"}
    convert_partial_options(options)
    assert_equal({:layout=>false, :template=>"../../../templates/generic_views/_list", :other=>"1"}, options)
  end

  def test_convert_partial_options_and_layout_for_generic
    pretend_template_exists(false)
    options = {:partial=>"_list", :other=>"1", :layout=>true}
    convert_partial_options(options)
    assert_equal({:layout=>true, :template=>"../../../templates/generic_views/_list", :other=>"1"}, options)
  end

  def test_convert_partial_options_for_specific
    pretend_template_exists(true)
    options = {:partial=>"_list", :other=>"1"}
    convert_partial_options(options)
    assert_equal({:partial=>"_list", :other=>"1"}, options)
  end
end