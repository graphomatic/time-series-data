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

  # Test that the unit setter
  def test_initialize_exception_throw
    assert_raise ArgumentError, "Failed to raise ArgumentError when initializing with bad unit" do
      test_obj = TimeSeriesData.new( :notaunit )
    end
  end
  
  def test_contants
    assert_raise TypeError, "Failed to raise TypeError when tyring to change constant" do
      TimeSeriesData::UNITS << :notaunit
    end
  end

end
