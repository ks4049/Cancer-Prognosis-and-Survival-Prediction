require 'test_helper'

class MoneyBagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @money_bag = money_bags(:one)
  end

  test "should get index" do
    get money_bags_url, as: :json
    assert_response :success
  end

  test "should create money_bag" do
    assert_difference('MoneyBag.count') do
      post money_bags_url, params: { money_bag: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show money_bag" do
    get money_bag_url(@money_bag), as: :json
    assert_response :success
  end

  test "should update money_bag" do
    patch money_bag_url(@money_bag), params: { money_bag: {  } }, as: :json
    assert_response 200
  end

  test "should destroy money_bag" do
    assert_difference('MoneyBag.count', -1) do
      delete money_bag_url(@money_bag), as: :json
    end

    assert_response 204
  end
end
