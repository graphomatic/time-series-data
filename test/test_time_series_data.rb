require "test/unit"
require "lib/time_series_data"

class TestTimeSeriesData < Test::Unit::TestCase

  def setup
    @obj = TimeSeriesData.new()
  end

  def test_initialize
    
    assert_instance_of( TimeSeriesData, @obj )
  end
end
