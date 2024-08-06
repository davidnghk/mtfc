require 'test_helper'

class DefectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @defect = defects(:one)
  end

  test "should get index" do
    get defects_url
    assert_response :success
  end

  test "should get new" do
    get new_defect_url
    assert_response :success
  end

  test "should create defect" do
    assert_difference('Defect.count') do
      post defects_url, params: { defect: { assignment_id: @defect.assignment_id, defect_id: @defect.defect_id, rating: @defect.rating, remarks: @defect.remarks } }
    end

    assert_redirected_to defect_url(Defect.last)
  end

  test "should show defect" do
    get defect_url(@defect)
    assert_response :success
  end

  test "should get edit" do
    get edit_defect_url(@defect)
    assert_response :success
  end

  test "should update defect" do
    patch defect_url(@defect), params: { defect: { assignment_id: @defect.assignment_id, defect_id: @defect.defect_id, rating: @defect.rating, remarks: @defect.remarks } }
    assert_redirected_to defect_url(@defect)
  end

  test "should destroy defect" do
    assert_difference('Defect.count', -1) do
      delete defect_url(@defect)
    end

    assert_redirected_to defects_url
  end
end
