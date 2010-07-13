require "test/unit"
require "lib/time_series_data"

class TestTimeSeriesDataBucket < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @test_start_point = "2010-01-01T00:45:30+00:00"
    @period = TimeSeriesData::Period.new( @test_start_point, :month)
    @data = TimeSeriesData::Bucket.new( @period )
  end

  def test_initialize
    assert_instance_of( TimeSeriesData::Bucket, @data, "Object it a TimeSeriesData::Bucket object" )
  end
  
  def test_raise_from_initialize
    assert_raise ArgumentError, "Didn't raise ArgumentError when a TimeSeriesData::Period was not passed" do
      @x = TimeSeriesData::Bucket.new( "Not a period" )
    end
  end

  def test_append
    assert_nothing_raised "Raised exception when valid DataPoint appended to the bucket" do
      @data_point = TimeSeriesData::DataPoint.new( DateTime.parse("2010-01-02T00:45:30+00:00"), 1000 )
      @data << @data_point
    end
    
    assert_raise ArgumentError do
      @data << "Not a DataPoint"
    end
  end
  
end