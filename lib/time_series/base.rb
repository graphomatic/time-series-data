# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# This class holds data as a time series.
# It provides methods to group and aggregate
# data.

class TimeSeries

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
      period = TimeSeries::Period.new( key, @resolution_unit )
      @buckets[ key ] = TimeSeries::Bucket.new( period )
    end
    
    if not UNITS.member?(unit_type)
      raise ArgumentError, "#{unit_type} is not an allowed unit of time"
    end

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
  
  def []( moment )
    startpoint = calculate_bucket( TimeSeries.Normalise_Time( moment ) )
    @buckets[ startpoint ]
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
      
    Time.utc(sec, min, hour, day, month, year, wday, yday, isdst, zone)
    
  end
  
end