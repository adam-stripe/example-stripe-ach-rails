require 'test_helper'

class PlaidControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get plaid_create_url
    assert_response :success
  end

end
