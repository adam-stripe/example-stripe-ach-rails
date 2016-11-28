require 'test_helper'

class MicrodepositsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get microdeposits_new_url
    assert_response :success
  end

  test "should get create" do
    get microdeposits_create_url
    assert_response :success
  end

end
