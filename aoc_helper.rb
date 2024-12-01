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
