class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end


  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.next.prev = self.prev
    self.prev.next = self.next
    self
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(:head, nil)
    @tail = Node.new(:tail, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find_node(key)
    if node == nil
      return nil
    else
      return node.val
    end
  end

  def include?(key)
    !!find_node(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last
    last.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    node = find_node(key)
    return nil if node == nil
    node.val = val
  end

  def remove(key)
    node = find_node(key)
    return nil if node == nil
    node.remove
  end

  def find_node(key)
    node = first
    while (node.next != nil)
      if (node.key == key)
        return node
      end
      node = node.next
    end
    nil
  end

  def each
    node = first
    while (node.next != nil)
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
