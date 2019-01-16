require 'test_helper'

class AuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audit = audits(:one)
  end

  test "should get index" do
    get audits_url, as: :json
    assert_response :success
  end

  test "should create audit" do
    assert_difference('Audit.count') do
      post audits_url, params: { audit: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show audit" do
    get audit_url(@audit), as: :json
    assert_response :success
  end

  test "should update audit" do
    patch audit_url(@audit), params: { audit: {  } }, as: :json
    assert_response 200
  end

  test "should destroy audit" do
    assert_difference('Audit.count', -1) do
      delete audit_url(@audit), as: :json
    end

    assert_response 204
  end
end
