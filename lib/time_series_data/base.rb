# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# This class holds data as a time series.
# It provides methods to group and aggregate
# data.

class TimeSeriesData

  attr_reader :unit
 
  # Define the understood units of time that
  # the timeseries data may be grouped into
  UNITS = [ :second, :minute, :hour, :day, :week, :month, :year ]
  UNITS.freeze
  
  # Create new TimeSeriesData collection with the 
  # supplied granularity.
  def initialize(unit_type)
    @buckets = Hash.new
    
    if not UNITS.member?(unit_type)
      raise ArgumentError, "#{unit_type} is not an allowed unit of time"
    end

  end
  
end