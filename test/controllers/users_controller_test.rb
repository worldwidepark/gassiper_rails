require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_create_url
    assert_response :success
  end

  test "should get login" do
    get users_login_url
    assert_response :success
  end

  test "should get logout" do
    get users_logout_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end
end
