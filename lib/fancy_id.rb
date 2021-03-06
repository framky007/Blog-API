require "date"

class FancyID
  PUSH_CHARS = "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvw"\
    "xyz".freeze

  def initialize
    @prev_ts = 0
    @rand_chars = Array.new(12)
  end

  def assert(condition, message = "")
    raise "Error: #{message}" unless condition
  end

  def next_id(ts = seed)
    is_duplicate = (ts == @prev_ts)
    @prev_ts = ts
    ts_chars = Array.new(8)

    7.step(0, -1) do |i|
      ts_chars[i] = PUSH_CHARS[ts % 64]
      ts = (ts / 64).floor
    end

    assert(ts.zero?)

    id = ts_chars.join ""

    if is_duplicate
      11.step(0, -1) do |i|
        unless @rand_chars[i] == 63
          @rand_chars[i] += 1

          break
        end

        @rand_chars[i] = 0
      end
    else
      12.times { |i| @rand_chars[i] = (rand * 64).floor }
    end

    12.times { |i| id << PUSH_CHARS[@rand_chars[i]] }

    assert(id.length == 20, "next_id: Length should be 20.")

    id
  end

  def seed
    Time.now.strftime("%s%j%y").to_i
  end
end

def generate_id
  fancyid = FancyID.new
  time_stamp = fancyid.seed
  fancyid.next_id(time_stamp)
end
