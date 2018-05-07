class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |val, idx|
      result += val.hash * idx
    end
    result
  end
end

class String
  def hash
    result = 0
    i = 1
    self.each_byte do |byte|
      result += byte * i
      i += 1
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.to_a.each do |arr|
      result += arr.hash
    end
    result
  end
end
