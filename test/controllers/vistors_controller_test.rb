require 'test_helper'

class VistorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vistor = vistors(:one)
  end

  test "should get index" do
    get vistors_url
    assert_response :success
  end

  test "should get new" do
    get new_vistor_url
    assert_response :success
  end

  test "should create vistor" do
    assert_difference('Vistor.count') do
      post vistors_url, params: { vistor: { contact_number: @vistor.contact_number, email: @vistor.email, username: @vistor.username } }
    end

    assert_redirected_to vistor_url(Vistor.last)
  end

  test "should show vistor" do
    get vistor_url(@vistor)
    assert_response :success
  end

  test "should get edit" do
    get edit_vistor_url(@vistor)
    assert_response :success
  end

  test "should update vistor" do
    patch vistor_url(@vistor), params: { vistor: { contact_number: @vistor.contact_number, email: @vistor.email, username: @vistor.username } }
    assert_redirected_to vistor_url(@vistor)
  end

  test "should destroy vistor" do
    assert_difference('Vistor.count', -1) do
      delete vistor_url(@vistor)
    end

    assert_redirected_to vistors_url
  end
end
