require "test/unit"
require "lib/time_series_data"
require "date"

class TestTimeSeriesDataPeriod < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @test_start_point = "2010-01-01T00:45:30+00:00"
    @data = TimeSeriesData::Period.new( @test_start_point, :month)
  end

  def test_initialize
    assert_instance_of( TimeSeriesData::Period, @data, "Object it a TimeSeriesData::Period object" )
  end
  
  def test_accessors
    assert_equal( @test_start_point, @data.start.to_s )
    assert_equal( :month, @data.duration )
  end
  
  def test_invalid_time
    assert_raise ArgumentError, "Raises ArgumentError when the time is not valid" do
      TimeSeriesData::Period.new( "101st Foo 2010 25:45:30am", :month)
    end
  end
  
  def test_invalid_time_class
    assert_raise ArgumentError, "Raises ArgumentError when the time is not a string or Date/DateTime" do
      TimeSeriesData::Period.new( Array.new, :month)
    end
  end
  
  def test_invalid_period_type
    assert_raise ArgumentError, "Raises ArgumentError when the period is not a member of TimeSeriesData::UNITS" do
      TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :notaunit)
    end
  end
  
  def test_comparisons
    @a = TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :second)
    @b = TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :month)
    assert_instance_of( TimeSeriesData::Period, @a, "Object it a TimeSeriesData::Period object" )
    assert_instance_of( TimeSeriesData::Period, @b, "Object it a TimeSeriesData::Period object" )
    assert( @a < @b, "< operator comparison" )
    
    @a = TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :year)
    assert( @a > @b, "> operator comparison" )

    @b = TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :year)
    assert( @a == @b, "== operator comparison" )
    
    @a = TimeSeriesData::Period.new( "1st Jan 2010 12:45:30am", :year)
    @b = TimeSeriesData::Period.new( "2st Jan 2010 12:45:30am", :month)  
    assert( @a < @b, "< operator comparison" ) 
  end
  
end