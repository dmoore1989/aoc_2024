# frozen_string_literal: true

MOVEMENTS = [
  [0, 1],
  [1, 0],
  [-1, 0],
  [0, -1],
  [1, -1],
  [-1, -1],
  [1, 1],
  [-1, 1]
].freeze

def outside_of_array?(index, length)
  index.negative? || index >= length
end

def map_array_counts(array)
  hash = {}
  array.each do |element|
    hash[element] ||= 0
    hash[element] += 1
  end
  hash
end
