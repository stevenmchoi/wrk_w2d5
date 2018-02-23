class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max + 1) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    unless include?(num)
      self[num] << num
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

# O(1)
  def insert(num)
    unless include?(num)
      self[num] << num
      @count += 1
      resize! if count > @num_buckets
    end
  end

# O(1)
  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

# worst O(n); amortized O(1)
  def include?(num)
    self[num].include?(num)
  end

  private

# O(1)
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  # def num_buckets
  #   @store.length
  # end

# O(n)
  def resize!
    @num_buckets *= 2
    new_array = Array.new(@num_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |num|
        new_bucket = num % @num_buckets
        new_array[new_bucket] += [num]
      end
    end

    @store = new_array
  end
end
