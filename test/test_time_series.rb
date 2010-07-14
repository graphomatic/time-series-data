require "test/unit"
require "lib/time_series"

class TestTimeSeries < Test::Unit::TestCase

  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @data = Hash.new()
    
    # Create TimeSeries collections for each
    # resolution.
    TimeSeries::UNITS.each do | unit |
      @data[ unit ] = TimeSeries.new( unit )
    end
    
    # Setup a bunch of datapoints in two different months
    @start_june = Time.parse("12:00 12th June 2010")
    @datapoints_june = (1..1).collect do |i|
      TimeSeries::DataPoint.new( @start_june + i, i)
    end
    
    @start_july = Time.parse("12:00 12th July 2010")
    @datapoints_july = (1..1).collect do |i|
      TimeSeries::DataPoint.new( @start_july + i, i)
    end
    
    
  end

  def test_initialize
    TimeSeries::UNITS.each do | unit |
      assert_instance_of( TimeSeries, @data[ unit ], "Unit is #{unit.to_s}" )
    end
  end

  # Test that the unit setter
  def test_initialize_exception_throw
    assert_raise ArgumentError, "Failed to raise ArgumentError when initializing with bad unit" do
      test_obj = TimeSeries.new( :notaunit )
    end
  end
  
  def test_contants
    assert_raise TypeError, "Failed to raise TypeError when tyring to change constant" do
      TimeSeries::UNITS << :notaunit
    end
  end
  
  def test_push_retrieve_datapoints
    # Push the june and july data points into the
    # TimeSeries object with :month resolution.
    @datapoints_june.each { |dp| @data[ :month] << dp }
    @datapoints_july.each { |dp| @data[ :month] << dp }
    
    assert_equal( @datapoints_june, @data[ :month][ "June 2010" ].collect )
    assert_equal( @datapoints_july, @data[ :month][ "July 2010" ].collect )
  end

end
