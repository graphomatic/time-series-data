# File to monkeypatch the Time and DateTime classes to make them convertable.
# Both are useful for time calculations at differnt resolution.
# FIX: Naive stringify/parse approach for the moment, replace with something smarter

require 'date'
require 'time'

class Time
  def to_datetime
    DateTime.parse( self.to_s )
  end
end


class DateTime

  def to_time
    Time.parse( self.to_s )
  end

end

class Date

  def to_time
    Time.parse( self.to_s )
  end

end