require "test/unit"
require "lib/time_series"
require "date"

class TestTimeSeriesPeriod < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @test_start_point = "Fri Jan 01 00:45:30 +0000 2010"
    @data = TimeSeries::Period.new( @test_start_point, :month)
  end

  def test_initialize
    assert_instance_of( TimeSeries::Period, @data, "Object it a TimeSeries::Period object" )
  end
  
  def test_accessors
    assert_equal( @test_start_point, @data.start.to_s )
    assert_equal( :month, @data.duration )
  end
  
  def test_stop_calculation
    assert_equal( "Mon Feb 01 00:45:29 +0000 2010", @data.stop.to_s )
  end
  
  def test_invalid_time
    assert_raise ArgumentError, "Raises ArgumentError when the time is not valid" do
      TimeSeries::Period.new( "101st Foo 2010 25:45:30am", :month)
    end
  end
  
  def test_invalid_time_class
    assert_raise ArgumentError, "Raises ArgumentError when the time is not a string or Date/DateTime" do
      TimeSeries::Period.new( Array.new, :month)
    end
  end
  
  def test_invalid_period_type
    assert_raise ArgumentError, "Raises ArgumentError when the period is not a member of TimeSeries::UNITS" do
      TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :notaunit)
    end
  end
  
  def test_comparisons
    @a = TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :second)
    @b = TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :month)
    assert_instance_of( TimeSeries::Period, @a, "Object it a TimeSeries::Period object" )
    assert_instance_of( TimeSeries::Period, @b, "Object it a TimeSeries::Period object" )
    assert( @a < @b, "< operator comparison" )
    
    @a = TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :year)
    assert( @a > @b, "> operator comparison" )

    @b = TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :year)
    assert( @a == @b, "== operator comparison" )
    
    @a = TimeSeries::Period.new( "1st Jan 2010 12:45:30am", :year)
    @b = TimeSeries::Period.new( "2st Jan 2010 12:45:30am", :month)  
    assert( @a < @b, "< operator comparison" ) 
  end
  
  def test_case_equality_positive
    # The case equality operator tests whether the right hand argument
    # is either a period or moment that is contained by the period.
    assert( @data === "Fri Jan 01 00:45:30 +0000 2010",
            "=== failed where RHS (String) is the period start point" )
    assert( @data === DateTime.parse("Fri Jan 01 00:45:30 +0000 2010"),
            "=== failed where RHS (DateTime) is the period start point" )
    assert( @data === "Fri Jan 01 00:46:30 +0000 2010",
            "=== failed where RHS (string) is contained by the period" )
    assert( @data === DateTime.parse("Fri Jan 01 00:46:30 +0000 2010"),
            "=== failed where RHS (string) is contained by the period" )
  end
            
  def test_case_equality_negative_string
    assert( ! ( @data === "2010-05-02T00:45:30+00:00" ),
            "=== failed where RHS (String) is not contained by the period" )
  end

  def test_case_equality_negative_datetime
    assert( ! ( @data === Time.parse("2010-02-02T00:45:30+00:00") ),
            "=== failed where RHS (Time) is not contained by the period" )    
  end
  
  def test_case_equality_negative_time
    assert( ! ( @data === Time.parse("2010-02-02T00:45:30+00:00") ),
            "=== failed where RHS (Time) is not contained by the period" )    
  end
  
end