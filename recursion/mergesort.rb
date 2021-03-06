# frozen_string_literal: true

# Merge Sort: Sorts the array in order from smallest to largest

# Pseudocode:
# base case: repeat until the size of the (sub)array is less than 1 (nothing left to search)
#   declare midpoint of array
#   recursively call mergesort on left half of array
#   recursively call mergesort on right half of array
# merge sorted arrays:
#   declare empty array for sorted elements (merged)
#   until either left or right arrays are empty:
#     sort first items in both arrays by order (<=>)
#     remove the compared element, and add them back into the sorted merged array
#   return the completed merged array (with remaining left and right arrays)

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.size / 2
  left = merge_sort(arr.take(mid))
  right = merge_sort(arr.drop(mid))

  merge(left, right)
end

def merge(left, right)
  sorted_merge = []
  until left.empty? || right.empty?
    larger_element = left.first < right.first ? left.shift : right.shift
    sorted_merge << larger_element
  end
  sorted_merge + left + right
end

arr = [14, -45, 49, 15, 19, 100.32, 63, 11, 39, 21]
p merge_sort(arr) # => [-45, 11, 14, 15, 19, 21, 39, 49, 63, 100.32]

# merge sort as an Array method, with optional block
class Array
  def my_mergesort(&prc)
    # default block - sorts from smallest to largest
    prc ||= proc { |a, b| a <=> b }
    return self if length <= 1

    mid = size / 2
    left = take(mid).my_mergesort(&prc)
    right = drop(mid).my_mergesort(&prc)

    my_merge(left, right, &prc)
  end

  private

  def my_merge(left, right, &prc)
    merge = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1 then merge << left.shift
      when 0 then merge << left.shift
      when 1 then merge << right.shift
      end
    end
    merge + left + right
  end
end

p arr.my_mergesort # => [-45, 11, 14, 15, 19, 21, 39, 49, 63, 100.32]
p arr.my_mergesort { |a, b| b <=> a } # => [100.32, 63, 49, 39, 21, 19, 15, 14, 11, -45] reverse sort
