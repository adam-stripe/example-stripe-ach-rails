require 'test_helper'

class BankControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bank_new_url
    assert_response :success
  end

  test "should get create" do
    get bank_create_url
    assert_response :success
  end

end
