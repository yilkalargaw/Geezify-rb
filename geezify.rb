#!/usr/bin/ruby
# coding: utf-8

# This class contains the processing tools to convert arabic numbers to Geeze.
class Geezify
  ERROR_MSG_CONSTRUCTOR = 'invalid input the input is not a number'.freeze
  ERROR_MSG1 = 'invalid input to method geezify_2digit'.freeze
  ERROR_MSG2 = 'invalid input to geezify_4digit'.freeze

  # constructor
  def initialize(num)
    raise ArgumentError, ERROR_MSG_CONSTRUCTOR unless num.integer?

    @num = num
  end

  def geezify
    clean_up_uncessary_1s geezify_with_1s(@num)
  end

  private

  def geezify_2digit(num)
    oneth_array = Array['', '፩', '፪', '፫', '፬', '፭', '፮', '፯', '፰', '፱']
    tenth_array = Array['', '፲', '፳', '፴', '፵', '፶', '፷', '፸', '፹', '፺']
    raise ArgumentError, ERROR_MSG1 unless num.integer? && num >= 0 && num < 100

    tenth_array[(num / 10)] + oneth_array[num % 10]
  end

  def geezify_4digit(num)
    raise ArgumentError, ERROR_MSG unless num.integer? && num < 10_000

    num.digits(100).reverse.map { |x| geezify_2digit(x) }.join('፻')
  end

  def geezify_with_1s(num)
    num.digits(10_000).reverse.map { |x| geezify_4digit(x) }.join('፼')
  end

  def clean_up_uncessary_1s(num)
    num.gsub('፼፩፻', '፼፻').gsub(/^፩፼/, '፼').gsub(/^(፩፻)/, '፻') || num
  end
end
