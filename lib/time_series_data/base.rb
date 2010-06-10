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
  
  
  
  def initialize(options)
    @buckets = Hash.new
    self.unit = options[:unit]
  end
  
  attr_reader :unit
  def unit=(u)
    if not UNITS.include?(u)
      raise ArgumentError, 'Unit #{u.to_s} is not one of the allowed types'
    else
      @unit = u
    end
  end
  
end