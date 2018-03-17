require 'test_helper'

class TownTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Town validation does geocoding" do
    belfort = Town.new
    belfort.name = 'belfort'
    assert belfort.valid?
    assert_equal(belfort.latitude, 47.6379599)
    assert_equal(belfort.longitude, 6.8628942)
  end
  
  test "Town not existing is not valid" do
    unknown = Town.new
    unknown.name = 'MyString'
    assert !unknown.valid?
  end
  
  
end
