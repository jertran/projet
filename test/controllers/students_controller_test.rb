require 'rspec'
require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get resource name" do
    assert_equal(Student, @controller.resource_name)
  end
  
  test "should get resource params" do
    post :create, student: { birthdate: @student.birthdate, lastname: @student.lastname, name: @student.name }
    assert_equal({"name"=>"MyString", "lastname"=>"MyString", "birthdate"=>"2018-03-10"}, @controller.resource_params)
  end
  
  test "should raise error if name is missing" do
    record = Student.new
    record.name = '' # invalid state
    record.valid? # run validations
    assert_equal(record.errors[:name], ["can't be blank"]) # check for presence of error
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { birthdate: @student.birthdate, lastname: @student.lastname, name: @student.name }
    assert_redirected_to student_path(assigns(:student))
  end
  
  test "shouldn't update student if informations are invalid" do
    record = Student.new
    record.name = @student.name
    patch :update, id: @student, student: { birthdate: @student.birthdate, lastname: @student.lastname, name: '' }
    assert_equal(record.name, @student.name)
  end
  
  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
