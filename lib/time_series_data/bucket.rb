# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to hold data for an individual 
# time period held within a TimeSeriesData object
# This should only ever be created by a TimeSeriesData
# object.
class TimeSeriesData::Bucket
  
  attr_reader :period
  
  # Create new bucket for the given moment in time
  def initialize( period )
    if not period.is_a? TimeSeriesData::Period
      raise ArgumentError, "TimeSeriesData::Period expected as argument to TimeSeriesData::Bucket.new, got #{period.class}"
    end
    @period = period
    
    # Setup our basic data-structures
    @data_points = Array.new() 
  end
  
  def <<( item )
    if not item.is_a? TimeSeriesData::DataPoint
      raise ArgumentError, "TimeSeriesData::DataPoint expected as argument to TimeSeriesData::Bucket.<<, got #{item.class}"
    end
    
    @data_points << item
  end
end