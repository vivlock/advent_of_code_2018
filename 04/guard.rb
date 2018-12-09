class Guard
  def initialize(id)
    @id = id
    @time_asleep = 0
    @sleep_mins = Array.new(60, 0)
  end

  def time_asleep
    return @time_asleep
  end
  def sleep(sleep_time)
    @sleep_time = sleep_time
  end

  def wake(wake_time)
    #calculate sleep values
    sleep_hour = @sleep_time.hour.dup
    sleep_min = @sleep_time.min.dup
    wake_hour = wake_time.hour
    wake_min = wake_time.min

    while(sleep_hour <= wake_hour && sleep_min < wake_min)
      @time_asleep += 1
      @sleep_mins[sleep_min] += 1
      sleep_min += 1
      if sleep_min == 60
        sleep_min = 0
        sleep_hour += 1
        if(sleep_hour == 24)
          sleep_hour = 0
        end
      end
    end
  end

  def sleepiest_minute
    return @sleep_mins.each_with_index.max[1]
  end

  def sleepiest_minute_minutes
    return @sleep_mins[sleepiest_minute]
  end
end
