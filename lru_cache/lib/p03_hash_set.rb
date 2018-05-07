require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    @store[key.hash % num_buckets].push(key)
    @count += 1
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |el|
        temp[el.hash % (num_buckets * 2)].push(el)
      end
    end
    @store = temp
  end
end
