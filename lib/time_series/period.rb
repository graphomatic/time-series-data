# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to describe time periods based on their
# start time and duration.
# Time periods are immutable

require 'date'
require 'time'

class TimeSeries::Period
  
  include Comparable
  
  attr_reader :start, :duration
  
  # Create a new TimeSeries::Period
  # with the specified start point and duration
  # The start point can be specified as a string representing
  # a date/time or a Ruby Date or DateTime object
  def initialize( time, duration )
    @start = case time
      when String
        Time.parse( time )
      when DateTime
        time.to_time
      when Time
        time
      else
        raise ArgumentError, "Date/DateTime object or string required."
      end
      
    if @start.nil?
      raise ArgumentError, "#{start} was not a valid point in time"
    end
    
    unless TimeSeries::UNITS.member?( duration )
      raise ArgumentError, "Duration must be a member of TimeSeries::UNITS"
    end
    
    @duration = duration
      
  end
  
  def succ
    # Get the start point of the next period.
    successor = case @duration
      when :minute
        @start + 60
      when :hour
        @start + 60 * 60
      when :day
        @start + ( 60 * 60 * 24 )
      when :week
        @start + ( 60 * 60 * 24 * 7 )
      when :month
        dt = @start.to_datetime
        dt = dt >> 1
        dt.to_time
      when :year
        dt = @start.to_datetime
        dt = dt >> 12
        dt.to_time
      end
    
    TimeSeries::Period.new( successor, @duration )
  end
  
  def -(rhs)
    if self == rhs
      0
    elsif self < rhs
      0 - ( ( self ... rhs ).to_a.length )
    else
      ( rhs ... self ).to_a.length
    end
  end
  
  
  def stop
    # If the duration is :second then the start and stop are the same
    if @duration == :second
      return @start
    end
    
    # Otherwise the stop is the second before the beginning of the next period.
    self.succ.start - 1
  end
  
  # Define the <=> operator so that the Comparable mixin works
  def <=>( obj )
    if @start > obj.start
      1
    elsif @start < obj.start
      -1
    else
      TimeSeries::UNITS.index( @duration ) <=> TimeSeries::UNITS.index( obj.duration )
    end
  end
  
  def ===( comp )
    if comp.is_a? String then
      comp = Time.parse( comp )
    elsif comp.is_a? DateTime then
      comp = comp.to_time
    elsif comp.is_a? Time then
      nil # That's fine...
    else
      raise ArgumentError, "Right hand side of TimeSeries::Period.=== must be either a parseable string or a DateTime"
    end

    if ( comp >= @start ) and
       comp <= self.stop
      true
    else
      false
    end
  end
  
  def to_s
    "Period: from #{@start} for 1 #{@duration}"
  end
  
  def ==(x)
    ( @start == x.start ) && 
      ( @duration == x.duration )
  end
  
  alias eql? ==
  
  def hash
    code = 17
    code = 37 * code + @start.to_i.hash
    code = 37 * code + @duration.hash
    
    code
  end
  
end