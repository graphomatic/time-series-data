# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# This class holds data as a time series.
# It provides methods to group and aggregate
# data.
class TimeSeriesData
  
  # Define the understood units of time that
  # the timeseries data may be grouped into
  UNITS = Array[ :none, :minute, :hour, :day, :week, :month ]
  
  # Create new TimeSeriesData collection with the 
  # supplied granularity.
  def initialize(unit_type)
    @buckets = Hash.new
    self.unit = unit_type
  end
  
  attr_reader :unit
  def unit=(u)
    if not UNITS.include?(u)
      raise ArgumentError, "Unit #{u} is not one of the allowed types"
    else
      @unit = u
    end
  end
  
end