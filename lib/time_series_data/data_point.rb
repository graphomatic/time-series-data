# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to hold data for an individual 
# data point for use with a 
class TimeSeriesData::DataPoint
  
  attr_reader :moment, :value
  
  def initialize( moment, value )
    # Type checks
    if ( not moment.is_a? DateTime ) then
      raise ArgumentError, "DateTime expected for first argument, got a #{moment.class}"
    end
    if ( not value.is_a? Numeric ) then
      raise ArgumentError, "Numeric expected for second argument, got a #{moment.class}"
    end

    @moment = moment
    @value = value
  end
    
end