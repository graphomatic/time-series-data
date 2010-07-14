require "test/unit"
require "lib/time_series"
require "date"

class TestTimeSeriesBucketDataPoint < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @when = Time.parse("10th January 2010")
    @what = 100
    @data = TimeSeries::DataPoint.new( @when, @what )
  end

  def test_initialize
    assert_instance_of( TimeSeries::DataPoint, @data, "Object should be a TimeSeries::DataPoint object" )
  end
  
  def test_accessors
    assert_equal( @when, @data.moment )
    assert_equal( @what, @data.value )
  end
  
end