require "test_helper"

class TaxesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get taxes_index_url
    assert_response :success
  end

  test "should get show" do
    get taxes_show_url
    assert_response :success
  end

  test "should get new" do
    get taxes_new_url
    assert_response :success
  end

  test "should get create" do
    get taxes_create_url
    assert_response :success
  end

  test "should get edit" do
    get taxes_edit_url
    assert_response :success
  end

  test "should get update" do
    get taxes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get taxes_destroy_url
    assert_response :success
  end
end
