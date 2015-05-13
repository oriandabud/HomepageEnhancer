require 'test_helper'

class PopularitiesControllerTest < ActionController::TestCase
  setup do
    @popularity = popularities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:popularities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create popularity" do
    assert_difference('Popularity.count') do
      post :create, popularity: { entrances: @popularity.entrances, product_id: @popularity.product_id, user_id: @popularity.user_id }
    end

    assert_redirected_to popularity_path(assigns(:popularity))
  end

  test "should show popularity" do
    get :show, id: @popularity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @popularity
    assert_response :success
  end

  test "should update popularity" do
    patch :update, id: @popularity, popularity: { entrances: @popularity.entrances, product_id: @popularity.product_id, user_id: @popularity.user_id }
    assert_redirected_to popularity_path(assigns(:popularity))
  end

  test "should destroy popularity" do
    assert_difference('Popularity.count', -1) do
      delete :destroy, id: @popularity
    end

    assert_redirected_to popularities_path
  end
end
