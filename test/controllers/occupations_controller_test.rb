require 'test_helper'

class OccupationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @occupation = occupations(:one)
  end

  test "should get index" do
    get occupations_url
    assert_response :success
  end

  test "should get new" do
    get new_occupation_url
    assert_response :success
  end

  test "should create occupation" do
    assert_difference('Occupation.count') do
      post occupations_url, params: { occupation: { checkin_datetime: @occupation.checkin_datetime, checkout_datetime: @occupation.checkout_datetime, customer: @occupation.customer, due_date: @occupation.due_date, location_id: @occupation.location_id, passport: @occupation.passport, price: @occupation.price, status: @occupation.status, total: @occupation.total } }
    end

    assert_redirected_to occupation_url(Occupation.last)
  end

  test "should show occupation" do
    get occupation_url(@occupation)
    assert_response :success
  end

  test "should get edit" do
    get edit_occupation_url(@occupation)
    assert_response :success
  end

  test "should update occupation" do
    patch occupation_url(@occupation), params: { occupation: { checkin_datetime: @occupation.checkin_datetime, checkout_datetime: @occupation.checkout_datetime, customer: @occupation.customer, due_date: @occupation.due_date, location_id: @occupation.location_id, passport: @occupation.passport, price: @occupation.price, status: @occupation.status, total: @occupation.total } }
    assert_redirected_to occupation_url(@occupation)
  end

  test "should destroy occupation" do
    assert_difference('Occupation.count', -1) do
      delete occupation_url(@occupation)
    end

    assert_redirected_to occupations_url
  end
end
