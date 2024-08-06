require 'test_helper'

class BusinessStaffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_staff = business_staffs(:one)
  end

  test "should get index" do
    get business_staffs_url
    assert_response :success
  end

  test "should get new" do
    get new_business_staff_url
    assert_response :success
  end

  test "should create business_staff" do
    assert_difference('BusinessStaff.count') do
      post business_staffs_url, params: { business_staff: { business_unit_id: @business_staff.business_unit_id, post_id: @business_staff.post_id, user_id: @business_staff.user_id } }
    end

    assert_redirected_to business_staff_url(BusinessStaff.last)
  end

  test "should show business_staff" do
    get business_staff_url(@business_staff)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_staff_url(@business_staff)
    assert_response :success
  end

  test "should update business_staff" do
    patch business_staff_url(@business_staff), params: { business_staff: { business_unit_id: @business_staff.business_unit_id, post_id: @business_staff.post_id, user_id: @business_staff.user_id } }
    assert_redirected_to business_staff_url(@business_staff)
  end

  test "should destroy business_staff" do
    assert_difference('BusinessStaff.count', -1) do
      delete business_staff_url(@business_staff)
    end

    assert_redirected_to business_staffs_url
  end
end
