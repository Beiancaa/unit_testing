require 'test_helper'

class TestActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_activity = test_activities(:one)
  end

  test "should get index" do
    get test_activities_url
    assert_response :success
  end

  test "should get new" do
    get new_test_activity_url
    assert_response :success
  end

  test "should create test_activity" do
    assert_difference('TestActivity.count') do
      post test_activities_url, params: { test_activity: { activity_url: @test_activity.activity_url } }
    end

    assert_redirected_to test_activity_url(TestActivity.last)
  end

  test "should show test_activity" do
    get test_activity_url(@test_activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_activity_url(@test_activity)
    assert_response :success
  end

  test "should update test_activity" do
    patch test_activity_url(@test_activity), params: { test_activity: { activity_url: @test_activity.activity_url } }
    assert_redirected_to test_activity_url(@test_activity)
  end

  test "should destroy test_activity" do
    assert_difference('TestActivity.count', -1) do
      delete test_activity_url(@test_activity)
    end

    assert_redirected_to test_activities_url
  end
end
