require "test/unit"
require "lib/time_series_data"

class TestTimeSeriesDataBucket < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @data = TimeSeriesData::Bucket.new( 1, :month)
  end

  def test_initialize
    assert_instance_of( TimeSeriesData::Bucket, @data, "Object it a TimeSeriesData::Bucket object" )
  end

  def test_append
    assert_nothing_raised do
      @data << 10
    end
    
    assert_raise ArgumentError do
      @data << "Not a number"
    end
  end
  
end