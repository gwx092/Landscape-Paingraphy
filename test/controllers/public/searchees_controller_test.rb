require "test_helper"

class Public::SearcheesControllerTest < ActionDispatch::IntegrationTest
  test "should get post_result" do
    get public_searchees_post_result_url
    assert_response :success
  end

  test "should get user_result" do
    get public_searchees_user_result_url
    assert_response :success
  end

  test "should get tag_result" do
    get public_searchees_tag_result_url
    assert_response :success
  end
end
