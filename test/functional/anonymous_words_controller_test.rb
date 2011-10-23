require 'test_helper'

class AnonymousWordsControllerTest < ActionController::TestCase
  tests WordsController
  setup do
    @word = words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:words)
  end

  test "should show word" do
    get :show, :id => @word.to_param
    assert_response :success
  end
end
