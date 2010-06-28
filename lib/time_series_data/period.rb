# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to describe time periods based on their
# start time and duration.
# Time periods are immutable

class TimeSeriesData::Period
  
  include Comparable
  
  attr_reader :start, :duration
  
  # Create a new TimeSeriesData::Period
  # with the specified start point and duration
  # The start point can be specified as a string representing
  # a date/time or a Ruby Date or DateTime object
  def initialize( time, duration )
    @start = case time
      when String
        DateTime.parse( time )
      when DateTime, Date
        time
      else
        raise ArgumentError, "Date/DateTime object or string required."
      end
      
    if @start.nil?
      raise ArgumentError, "#{start} was not a valid point in time"
    end
    
    unless TimeSeriesData::UNITS.member?( duration )
      raise ArgumentError, "Duration must be a member of TimeSeriesData::UNITS"
    end
    
    @duration = duration
      
  end
  
  # Define the <=> operator so that the Comparable mixin works
  def <=>( obj )
    if @start > obj.start
      1
    elsif @start < obj.start
      -1
    else
      TimeSeriesData::UNITS.index( @duration ) <=> TimeSeriesData::UNITS.index( obj.duration )
    end
  end
  
end