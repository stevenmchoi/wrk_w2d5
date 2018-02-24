class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0.hash

    each_with_index do |num, idx|
      result ^=  num.hash * idx.hash
    end

    result
  end
end

class String
  def hash
    str_arr = []

    chars do |chr|
      str_arr << chr.ord
    end

    str_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0.hash

    each do |key, val|
      result ^= key.to_s.hash * val.hash
    end

    result
  end
end
