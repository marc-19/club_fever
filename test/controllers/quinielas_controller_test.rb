require "test_helper"

class QuinielasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get quinielas_show_url
    assert_response :success
  end
end
