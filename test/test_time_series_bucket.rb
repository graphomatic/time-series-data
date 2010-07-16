require "test/unit"
require "lib/time_series"
require 'set'

class TestTimeSeriesBucket < Test::Unit::TestCase
  
  # Create a series of test objects,
  # one for each allowed grouping period.
  def setup
    @test_start_point = "2010-01-01T00:45:30+00:00"
    @start_time = Time.parse( @test_start_point )
    @period = TimeSeries::Period.new( @test_start_point, :month)
    @data = TimeSeries::Bucket.new( @period )
    
    # Setup a bunch of datapoints in the correct period
    @good_datapoints = (1..10).collect do |i|
      TimeSeries::DataPoint.new( @start_time + i, i)
    end
    
    @bad_datapoints = (1..10).collect do |i|
      TimeSeries::DataPoint.new( @start_time + i, i)
    end
    
  end

  def test_initialize
    assert_instance_of( TimeSeries::Bucket, @data, "Object it a TimeSeries::Bucket object" )
  end
  
  def test_raise_from_initialize
    assert_raise ArgumentError, "Didn't raise ArgumentError when a TimeSeries::Period was not passed" do
      @x = TimeSeries::Bucket.new( "Not a period" )
    end
  end

  def test_append
    assert_nothing_raised "Raised exception when valid DataPoint appended to the bucket" do
      @data_point = TimeSeries::DataPoint.new( DateTime.parse("2010-01-02T00:45:30+00:00"), 1000 )
      @data << @data_point
    end
    
    assert_raise ArgumentError do
      @data << "Not a DataPoint"
    end
  end
  
  def test_enumerable
    # Add the data to the bucket.
    @good_datapoints.each do |dp|
      @data << dp
    end
    
    # Use Sets rather than Arrays as there is
    # no guarentee that the items in the Bucket will be returned in order 
    
    # Set up a set to compare against.
    @test_values = Set.new( (1..10).collect { |i| i } )
    
    # Now extract the values of each
    @values = Set.new( @data.collect { |i| i.value } )
    assert_equal( @test_values, @values, "Collect failed to return the correct items")
    
  end
  
  # Test that the sort method works, relies on
  # DataPoint.<=> working correctly
  def test_sortability
    # Push the same set of data in twice.
    # so contains [1, .., 10, 1, .., 10]
    # which is not sorted.
    @good_datapoints.each do |dp|
      @data << dp
    end
    @good_datapoints.each do |dp|
      @data << dp
    end
    
    # Now extract the values of each
    @test_values = (1..10).collect { |i| [i, i] }.flatten
    
    @values = @data.sort.collect { |i| i.value }
    
    assert_equal( @test_values, @values, "Sort failed to sort the items correctly")
  end
  
  
  def test_is_empty
    assert( @data.empty? )
    
    @good_datapoints.each do |dp|
      @data << dp
    end
    assert( @data.empty? == false)
  end
  
  def test_length
    @good_datapoints.each do |dp|
      @data << dp
    end
    assert_equal( 10, @data.length )
  end
  
  def test_eql
    @a = TimeSeries::Bucket.new( @period )
    @b = TimeSeries::Bucket.new( @period )
    
    @good_datapoints.each do |dp|
      @a << dp
      @b << dp
    end
    
    assert( @a.eql?( @b ), "Two identical buckets not eql?")
  end
  
  def test_sum
    @a = TimeSeries::Bucket.new( @period )
    total = 0
    
    @good_datapoints.each do |dp|
      @a << dp
      total += dp.value
    end
    
    assert_equal( total, @a.sum, "Failed to sum up items in a bucket corrrectly")
  end
  
end