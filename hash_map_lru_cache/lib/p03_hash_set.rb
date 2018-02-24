require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    num = key.hash

    unless include?(key)
      self[num] << key
      @count += 1
      resize! if count > num_buckets
    end
  end

  def include?(key)
    num = key.hash

    self[num].include?(key)
  end

  def remove(key)
    num = key.hash

    if include?(key)
      self[num].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def resize!
    @num_buckets *= 2
    new_array = Array.new(num_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |key|
        new_bucket = key.hash % num_buckets
        new_array[new_bucket] += [key]
      end
    end

    @store = new_array
  end
end
