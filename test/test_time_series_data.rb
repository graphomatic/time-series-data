require "test/unit"
require "lib/time_series_data"

class TestTimeSeriesData < Test::Unit::TestCase

  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @data = Hash.new()
    
    TimeSeriesData::UNITS.each do | unit |
      @data[ unit ] = TimeSeriesData.new( unit )
    end
  end

  def test_initialize
    TimeSeriesData::UNITS.each do | unit |
      assert_instance_of( TimeSeriesData, @data[ unit ], "Unit is #{unit.to_s}" )
    end
  end
  
  # Test that the setter works for all valid units
  def test_unit_accessor
    TimeSeriesData::UNITS.each do | unit |
      assert_equal( unit, @data[ unit ].unit, "Unit correctly reported as #{unit.to_s}" )
    end
  end
  
  # Test that the unit setter
  def test_unit_setter_exception_throw
    # Test first during creation of a new object
    # that an illegal type will raise an ArgumentError
    assert_raise ArgumentError, "Failed to raise ArgumentError when initializing with bad unit" do
      test_obj = TimeSeriesData.new( :notaunit )
    end
    
    # Create a test object with a know good unit and test
    # setting it to an invalid unit.
    test_obj = TimeSeriesData.new( TimeSeriesData::UNITS.first )
    assert_raise ArgumentError, "Failed to raise ArgumentError when setting bad unit" do
      test_obj.unit = :notaunit
    end
    
    # Now try setting it to a know good unit
    assert_nothing_raised "Failed to set a good unit" do
      test_obj.unit = TimeSeriesData::UNITS.last
    end    
    
    
  end
  
end
