require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  def test_homepage
    get '/'
    assert_response :success
  end
end
