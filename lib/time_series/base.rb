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
    @buckets = Hash.new
    
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
  
end