require "test/unit"
require "lib/time_series_data"
require "date"

class TestTimeSeriesDataBucketDataPoint < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @when = Time.parse("10th January 2010")
    @what = 100
    @data = TimeSeriesData::DataPoint.new( @when, @what )
  end

  def test_initialize
    assert_instance_of( TimeSeriesData::DataPoint, @data, "Object should be a TimeSeriesData::DataPoint object" )
  end
  
  def test_accessors
    assert_equal( @when, @data.moment )
    assert_equal( @what, @data.value )
  end
  
end