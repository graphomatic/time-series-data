= time_series_data

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

  gigawatts = TimeSeriesData( :day )

  gigawatts["22:04 Nov 12 1955"].store(1.21)

  # ...add some more data

  puts "Biggest lightening strike of Nov 12 1955" + gigawatts["Nov 12 1955"].max.to_s

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
