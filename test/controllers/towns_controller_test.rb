require 'test_helper'

class TownsControllerTest < ActionController::TestCase
  setup do
    @town = towns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:towns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should raise error if name is missing" do
    record = Town.new
    record.name = '' # invalid state
    record.valid? # run validations
    assert_equal(record.errors[:name], ["can't be blank"]) # check for presence of error
  end

  test "should show town" do
    get :show, id: @town
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @town
    assert_response :success
  end

  test "should update town" do
    patch :update, id: @town, town: { latitude: @town.latitude, longitude: @town.longitude, name: @town.name, postalcode: @town.postalcode }
    assert_redirected_to town_path(assigns(:town))
  end
  
  test "shouldn't update town if informations are invalid" do
    record = Town.new
    record.name = @town.name
    patch :update, id: @town, town: { name: '', latitude: @town.latitude, longitude: @town.longitude }
    assert_equal(record.name, @town.name)
  end

  test "should destroy town" do
    assert_difference('Town.count', -1) do
      delete :destroy, id: @town
    end

    assert_redirected_to towns_path
  end
end
