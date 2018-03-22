require 'rspec'
require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  setup do
    @town = towns(:one)
  end

  test "should create student" do
    # save the current controller
    old_controller = @controller
    # use the student controller
    @controller = StudentsController.new
    assert_difference('Student.count') do
      post :create, student: { birthdate: @student.birthdate, lastname: @student.lastname, name: @student.name }
    end
    # not asserting on the redirect
    @controller = old_controller
  end

  test "shouldn't save student if blank in record" do
    # save the current controller
    old_controller = @controller
    # use the student controller
    @controller = StudentsController.new
    assert_raises(Exception) do
      post :create, student: { birthdate: '', lastname: nil, name: '' }
    end
    @controller = old_controller
  end

  test "should create town" do
    # save the current controller
    old_controller = @controller
    # use the student controller
    @controller = TownsController.new
    assert_difference('Town.count') do
      post :create, town: { latitude: @town.latitude, longitude: @town.longitude, name: @town.name, postalcode: @town.postalcode }
    end
    # not asserting on the redirect
    @controller = old_controller
  end

  test "shouldn't save town if blank in record" do
    # save the current controller
    old_controller = @controller
    # use the student controller
    @controller = TownsController.new
    assert_raises(Exception) do
      post :create, town: { name: nil, latitude: nil, longitude: nil }
    end
    @controller = old_controller
  end

  test "should render new on error in form" do
    # invalidating town record
    record = Student.new
    record.name = '' # invalid state
    # save the current controller
    old_controller = @controller
    # use the student controller
    @controller = StudentsController.new
    post :create, student: {id: @student.id, name: record.name, lastname: record.lastname, birthdate: record.birthdate}, :format => "json"
    # asserting on :unprocessable_entity response status code
    assert_response 422
    # run validations
    record.valid? # run validations
    assert_equal record.errors[:name], ["can't be blank"]
    @controller = old_controller
  end
end