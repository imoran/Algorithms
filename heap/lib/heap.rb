class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count

  end

  def extract
    @store[0], @store[@store.length - 1] = @store[@store.length - 1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &prc)
    extracted
  end

  def peek

  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length, &prc)
  end

  public

  def self.child_indices(len, parent_index)
    result = []
    if (parent_index * 2) < len
      result << (parent_index * 2) + 1
    else
      return result
    end
    if result[0] + 1 < len
      result << (result[0] + 1)
    end
    return result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    until (parent_idx >= len)
      child = self.child_indices(len, parent_idx)
      return array if child.length == 0
      if child.length == 2
        youngest = prc.call(array[child[0]], array[child[1]]) == -1 ? child[0] : child[1]
      elsif child.length == 1
        youngest = child[0]
      end
      if youngest && (prc.call(array[parent_idx], array[youngest]) == 1)
        array[parent_idx], array[youngest] = array[youngest], array[parent_idx]
      end
      parent_idx = youngest
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    return array if child_idx == 0
    parent = self.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent]) == -1
      array[child_idx], array[parent] = array[parent], array[child_idx]
      self.heapify_up(array, parent, len, &prc)
    else
      return array
    end
  end
end
