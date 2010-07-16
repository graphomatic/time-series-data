= time_series

* http://github.com/graphomatic/time-series-data

== DESCRIPTION:

A collection of classes for manipulating time-series numerical data in Ruby.

Time series data is essentially any data keyed on date and/or time.

== FEATURES (Planned)

* Storage and manipulation of time-series data.
* Aggregate functions such as average, sum, min, max etc by date.
* Variable granularity by time unit: second, minute, hour, day etc.
* Time series functions such as weighted averages.

== SYNOPSIS:

  # Data is stored in children of the DataPoint class.
  class LighteningStrikes < TimeSeries::DataPoint
    attr_reader :where

    def initialize( when, value, where )
      super(when, value)
      @where = where
    end

  end

  # Create a series grouped by day
  # TimeSeries is a collection of TimeSeries::Bucket objects
  # indexed by the time period.
  gigawatts = TimeSeries( :day )

  clock_tower = TimeSeries::DataPoint.new( "22:04 Nov 12 1955",
                                               1.21,
                                               "the clock tower" )
  gigawatts << clock_tower
  # ...add some more data

  # Get the bucket for one day and query it.
  nov_12th = gigawatts["Nov 12 1955"]
  biggest = nov_12th.max
  puts "Biggest lightening strike of Nov 12 1955 was #{biggest.value} which struck #{biggest.where}"
  puts "The average lightening strike on Nov 12 1955 was #{nov_12th.mean}"
  # Display all the data for that one bucket.
  nov_12th.each_item { |i| puts i.to_s }


  # Add series based calculations such as rolling averages that
  # cannot be computed based on the data in a single bucket.
  # Methods are added to each of the buckets for the selected
  # computations.  There are mutating (with !) and non mutating versions

  # Add Exponentially weighted rolling average with a factor of 0.25
  gigawatts.calculate_ewra!( :factor => 0.25 )

  # Add sliding window rolling average using 3 items from the left and 2 from
  # the right of the point treating empty buckets as 0s
  gigawatts.calculate_swra!( :window_left => 3, :window_right => 3, :nil_as => 0 )

  # Output the results
  gigawatts.each do |i|
    puts i.ewra
    puts i.swra
  end

== REQUIREMENTS:

* None

== INSTALL:

* sudo gem install time-series-data

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2010 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
