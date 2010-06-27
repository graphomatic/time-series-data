# -*- ruby -*-

require 'rubygems'
require 'hoe'

namespace :test do
  task :unit do
    ruby 'test/test_time_series_data.rb'
    ruby 'test/test_time_series_data_bucket.rb'
    ruby 'test/test_time_period.rb'
  end
end


Hoe.spec 'time_series_data' do
  VERSION = '1.0.0'

  developer('Paul Leader', 'paul@paulleader.co.uk')

  # self.rubyforge_name = 'timeseries_datax' # if different than 'timeseries_data'
end

# vim: syntax=ruby
