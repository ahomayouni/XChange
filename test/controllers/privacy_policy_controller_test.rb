require 'test_helper'

class PrivacyPolicyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get privacy_policy_index_url
    assert_response :success
  end

end
