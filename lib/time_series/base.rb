# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# This class holds data as a time series.
# It provides methods to group and aggregate
# data.
require 'set'

class TimeSeries
  include Enumerable

  attr_reader :unit
 
  # Define the understood units of time that
  # the timeseries data may be grouped into
  UNITS = [ :second, :minute, :hour, :day, :week, :month, :year ]
  UNITS.freeze
  
  # Create new TimeSeries collection with the 
  # supplied granularity.
  def initialize(unit_type)
    
    @resolution_unit = unit_type
    
    # Create our hash.
    # The default value is an empty bucket with
    # a start point and resolution.
    @buckets = Hash.new do |hash, key|
      period = create_period( key )
      @buckets[ key ] = TimeSeries::Bucket.new( period )
    end
    
    if not UNITS.member?(unit_type)
      raise ArgumentError, "#{unit_type} is not an allowed unit of time"
    end

  end

  def each( &block )
    @buckets.each( &block )
  end
 
  # Class method to normalise times from
  # String, Date, DateTime or Time objects to Time objects
  def TimeSeries.Normalise_Time( time )
    moment = case time
      when Time
        time
      when DateTime, Date
        time.to_time
      when String
        Time.parse( time )
      else
        raise ArgumentError, "Expected Time, DateTime, Date, or parseable String, got a #{time.class}"
      end
    return moment        
  end
  
  def <<( datapoint )
    startpoint = calculate_bucket( TimeSeries.Normalise_Time( datapoint.moment ) )
    @buckets[ startpoint ] << datapoint
  end
  
  # Select the single bucket based on a moment.
  # The moment is normalised to the relevant period for this collection
  # based on the resolution of the collection.
  def []( *moment )
    if moment.length > 1 then
      return self.slice( moment[0], moment[1] )
    end
    if moment[0].is_a? TimeSeries::Period then
      @buckets[ moment[0] ]
    else
      @buckets[ calculate_bucket( TimeSeries.Normalise_Time( moment[0] ) ) ]
    end
  end

  # Select all buckets from start to stop.
  # Start and stop are normalised to the period they occur in.
  def slice( start, stop )
    
    start_point = create_period( calculate_bucket( TimeSeries.Normalise_Time( start ) ) )
    stop_point = create_period( calculate_bucket( TimeSeries.Normalise_Time( stop ) ) )

    # Create a new TimeSeries object with the same resolution as
    # self, and clones of each bucket from start to stop.
    
    new_slice = TimeSeries.new( @resolution_unit )

    ( start_point .. stop_point ).each do |period|
      if not @buckets[period].empty? then
        new_slice[period] = @buckets[period].clone
      end
    end
    
    new_slice
  end
  
  def to_s
    s = <<END
\n\nTimeSeries - Resolution: #{@resolution_unit}
#{@buckets.length} buckets
END

    @buckets.each_pair do | key, bucket |
      s += "#{key} <#{key.class}> (#{key.hash}) -> #{bucket.length} datapoints\n"
    end
    
    s
  end
  
  def ==(x)
    x.buckets == @buckets && x.unit == @unit
  end
  
  alias eql? ==

  def keys
    @buckets.keys
  end

protected

  # Assign a bucket to a slot in the array directly
  # Useful for performing deep copies
  def []=( period, bucket )
    @buckets[ period ] = bucket
  end
  
  def buckets
    @buckets
  end
  
private

  def calculate_bucket( time )
    sec, min, hour, day, month, year, wday, yday, isdst, zone = time.to_a
    
    case @resolution_unit
      when :second
        nil # Do nothing
      when :minute
        sec = 0
      when :hour
        sec, min = 0
      when :day
        sec, minute, hour = 0
      when :week
        # We use a Date object to do proper date arithmetic
        # so we can get the beginning of the containing week
        date = Date.civil( year, month, day )
        date -= wday # Shift to the first day of the week
        year = date.year
        month = date.month
        day = date.day
      when :month
        sec, min, hour, day = 0
      when :year
        sec, min, hour, day, month = 0
    end
      
    create_period( Time.utc(sec, min, hour, day, month, year, wday, yday, isdst, zone) )
    
  end
  
  def create_period( startpoint )
    if startpoint.is_a? TimeSeries::Period then
      startpoint
    else
      TimeSeries::Period.new( startpoint, @resolution_unit )
    end
  end
  
end