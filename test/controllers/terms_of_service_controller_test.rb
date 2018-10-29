require 'test_helper'

class TermsOfServiceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get terms_of_service_index_url
    assert_response :success
  end

end
