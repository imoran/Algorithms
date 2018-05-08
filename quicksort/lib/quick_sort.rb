class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.first

    first_half = array.select { |el| el < pivot }
    second_half = array.select { |el| el > pivot }

    first_half.sort1 + [pivot] + second_half.sort1
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)
    sort2!(array, start, (pivot_idx - (start)), &prc)
    sort2!(array, (pivot_idx + 1), (length - (pivot_idx + 1)), &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot_idx = start + 1
    index = start + 1

    while index < (start + length)
      if prc.call(array[index], array[start]) == -1
        array[pivot_idx], array[index] = array[index], array[pivot_idx]
        pivot_idx += 1
      end
      index += 1
    end
    pivot_idx -= 1
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
