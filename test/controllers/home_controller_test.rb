require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "index action returns 200" do
    get :index
    assert_response :success
  end

  test "download action returns 200 with params" do
    post :download, params: {ids: [1, 2, 3]}
    assert_response :success
  end

  test "download action returns 200 when no params" do
    post :download, params: {ids: []}
    assert_response :success
  end

end
