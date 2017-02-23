class MaxIntSet
  def initialize(max)
    @store = Array.new(max){|i| false}
  end

  def insert(num)
    if !is_valid?(num)
      raise ArgumentError, "Out of bounds"
    else
      @store[num] = true
    end
  end

  def remove(num)
    if !is_valid?(num)
      raise ArgumentError, "Out of bounds"
    else
      @store[num] = false
    end
  end

  def include?(num)
    if !is_valid?(num)
      raise ArgumentError, "Out of bounds"
    else
      @store[num]
    end
  end

  private

  def is_valid?(num)
    num < @store.length && num >= 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless bckt(num).include?(num)
        bckt(num) << num
    end
  end

  def remove(num)
    bckt(num).delete(num)
  end

  def include?(num)
    bckt(num).include?(num)
  end

  private

  def bckt(num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless bckt(num).include?(num)
      @count += 1

      resize! if @count >= num_buckets

      bckt(num) << num
    end
  end

  def remove(num)
    bckt(num).delete(num)
  end

  def include?(num)
    bckt(num).include?(num)
  end

  private

  def bckt(num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets){Array.new}

    @store.each do |bucket|
      bucket.each do |ele|
        new_adress = ele % new_num_buckets
        new_store[new_adress] << ele
      end
    end

    @store = new_store

  end
end
