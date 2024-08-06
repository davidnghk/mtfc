require 'test_helper'

class GuardiansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guardian = guardians(:one)
  end

  test "should get index" do
    get guardians_url
    assert_response :success
  end

  test "should get new" do
    get new_guardian_url
    assert_response :success
  end

  test "should create guardian" do
    assert_difference('Guardian.count') do
      post guardians_url, params: { guardian: { email: @guardian.email, guardian_user_id: @guardian.guardian_user_id, name: @guardian.name, phone: @guardian.phone, user_id: @guardian.user_id } }
    end

    assert_redirected_to guardian_url(Guardian.last)
  end

  test "should show guardian" do
    get guardian_url(@guardian)
    assert_response :success
  end

  test "should get edit" do
    get edit_guardian_url(@guardian)
    assert_response :success
  end

  test "should update guardian" do
    patch guardian_url(@guardian), params: { guardian: { email: @guardian.email, guardian_user_id: @guardian.guardian_user_id, name: @guardian.name, phone: @guardian.phone, user_id: @guardian.user_id } }
    assert_redirected_to guardian_url(@guardian)
  end

  test "should destroy guardian" do
    assert_difference('Guardian.count', -1) do
      delete guardian_url(@guardian)
    end

    assert_redirected_to guardians_url
  end
end
