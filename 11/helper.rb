class FuelCell
  def initialize(x, y, serialno)
    @x = x
    @y = y
    @grid_sn = serialno
    @power = nil
    @block_power = Hash.new
  end
  def power
    if @power.nil?
      rack_id = @x + 10
      power = rack_id * @y
      power += @grid_sn
      power = power * rack_id
      power = power.to_s[-3].to_i
      power = 0 if power == nil
      @power = power - 5
    end
    return @power
  end
  def c
    return "#{@x},#{@y}"
  end
  def to_s
    return "(#{@x},#{@y})P=#{self.power}"
  end
  def set_block_power(size, power)
    @block_power[size] = power
  end
  def block_power(size)
    return @block_power[size]
  end
end
