require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get reload_catalog" do
    get admin_reload_catalog_url
    assert_response :success
  end
end
