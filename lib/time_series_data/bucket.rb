# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to hold data for an individual 
# time period held within a TimeSeriesData object
# This should only ever be created by a TimeSeriesData
# object.
class TimeSeriesData::Bucket
  
  # Create new bucket for the given moment in time
  # and the granularity.
  def initialize( moment, unit )
    @moment = moment
    @unit   = unit
    @items  = Array.new()
  end
  
  # Add an item to the bucket.
  def <<(item)
    if item.is_a? Numeric
      @items << item
    else
      raise ArgumentError, "TimeSeriesData items must be numeric"
    end
  end
  
end