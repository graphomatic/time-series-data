# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# This class holds data as a time series.
# It provides methods to group and aggregate
# data.
class TimeSeriesData
  
  def initialize()
    # Initalize our internal data structures.
    @buckets = Hash.new
  end
  
end