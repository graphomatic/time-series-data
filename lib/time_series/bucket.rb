# Author::    Paul Leader (mailto:paul@paulleader.co.uk)
# Copyright:: Paul Leader
# License::   See README.txt

# Class to hold data for an individual 
# time period held within a TimeSeries object
# This should only ever be created by a TimeSeries
# object.
require 'set'

class TimeSeries::Bucket
  include Enumerable

  attr_reader :period
  
  # Create new bucket for the given moment in time
  def initialize( period )
    if not period.is_a? TimeSeries::Period
      raise ArgumentError, "TimeSeries::Period expected as argument to TimeSeries::Bucket.new, got #{period.class}"
    end
    @period = period
    
    # Setup our basic data-structures
    @data_points = Array.new() 
  end
  
  def <<( item )
    if not item.is_a? TimeSeries::DataPoint
      raise ArgumentError, "TimeSeries::DataPoint expected as argument to TimeSeries::Bucket.<<, got #{item.class}"
    end
    
    @data_points << item
  end
  
  def each( &block )
    @data_points.each( &block )
  end
  
  # Does the bucket contain any data?
  def empty?
    @data_points.length < 1
  end
  
  def length
    @data_points.length
  end
  
  def ==(other)
    self.period.eql?(other.period) && 
      ( other.collect == @data_points )
  end
  
  alias eql? ==
  
end