# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to hold data for an individual 
# data point for use with a 
class TimeSeries::DataPoint
  
  attr_reader :moment, :value
  
  def initialize( moment, value )
    # Type checks
    @moment = TimeSeries::Normalise_Time( moment )
    
    if ( not value.is_a? Numeric ) then
      raise ArgumentError, "Numeric expected for second argument, got a #{moment.class}"
    end
    @value = value

  end

  # Compare based on the time of the data point.
  def <=>( rhs )
    self.moment <=> rhs.moment
  end
  
  def ==(rhs)
    @moment == rhs.moment &&
      @value == rhs.value
  end
  
  alias eql? ==
    
end