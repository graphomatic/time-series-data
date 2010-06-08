require "test/unit"
require "lib/time_series_data"

class TestTimeSeriesData < Test::Unit::TestCase

  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @data = Hash.new()
    
    TimeSeriesData::UNITS.each do | unit |
      @data[ unit ] = TimeSeriesData.new( :unit => unit )
    end
  end

  def test_initialize
    TimeSeriesData::UNITS.each do | unit |
      assert_instance_of( TimeSeriesData, @data[ unit ], "Unit is #{unit.to_s}" )
    end
  end
  
  def test_unit_accessor
    TimeSeriesData::UNITS.each do | unit |
      assert_equal( unit, @data[ unit ].unit, "Unit correctly reported as #{unit.to_s}" )
    end
  end
  
end
