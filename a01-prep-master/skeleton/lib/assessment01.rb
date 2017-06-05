require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
    if accumulator
      each do |el|
        accumulator = yield(accumulator, el)
      end
      return accumulator
    else
      accumulator = self[0]
      self[1..-1].each do |el|
        accumulator = yield(accumulator, el)
      end
      accumulator
    end
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2...num).each { |n| return false if num % n == 0}
end

def primes(num)
  primes = []
  i = 2
  until primes.length == num
   primes << i if is_prime?(i)
   i += 1
  end
  primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num <= 1
  factorials = factorials_rec(num - 1)
  factorials << factorials_rec(num - 1)[-1] * (num - 1)
  factorials
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    duplicates = Hash.new {[]}
    uniq.each_with_index do |uniq_el|
      indexes = []
      each_with_index do |el, idx|
        indexes << idx if uniq_el == el
      end
      duplicates[uniq_el] = indexes if indexes.length > 1
    end
    duplicates
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    string_chars = chars
    symmetric = []
    (2..length).each do |length|
      string_chars.each_cons(length) do |cons|
        symmetric << cons.join if cons.reverse == cons
      end
    end
    symmetric
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if length <= 1
    left_half = self[0...length/2]
    right_half = self[length/2..-1]
    (left_half.merge_sort + right_half.merge_sort).merge


  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? && right.empty?
      if left.empty?
        merged << right.shift
      elsif right.empty?
        merged << left.shift
      elsif prc.call(left[0], right[0]) == -1
        merged << left.shift
      else
        merged << right.shift
      end
    end
    merged
  end
end
