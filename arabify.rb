#!/usr/bin/ruby
# coding: utf-8

# This class contains the processing tools to convert  Geeze numbers to arabic.
class Arabify

  ERROR_MSG_CONSTRUCTOR = 'invalid input the string is not a geez number'.freeze
  ERROR_MSG1 = 'invalid input to method convert_2digit'.freeze
  ERROR_MSG2 = 'invalid input to method preprocess'.freeze
  ERROR_MSG3 = 'invalid input to method rollback'.freeze
  ERROR_MSG3 = 'invalid input to method convert_each_2_digit'.freeze
  NUMHASH = Hash['፩' => 1,  '፪' => 2,  '፫' => 3,  '፬' => 4,
                 '፭' => 5,  '፮' => 6,  '፯' => 7,  '፰' => 8,
                 '፱' => 9,  '፲' => 10, '፳' => 20, '፴' => 30,
                 '፵' => 40, '፶' => 50, '፷' => 60, '፸' => 70,
                 '፹' => 80, '፺' => 90, ' ' => 0]

  def initialize(str)
    raise ArgumentError, ERROR_MSG_CONSTRUCTOR unless validinput?(str)

    @geezstrstr = str
  end

  def arabify
    preprocess(@geezstrstr)
      .map { |x| x[0] * 100 + x[1] }
      .reverse
      .each_with_index
      .map { |x, i| x * (10_000**i) }
      .sum
  end

  private

  def preprocess(str)
    raise ArgumentError, ERROR_MSG2 unless validinput?(str)

    split_by_100_and_padd(split_by_10000s(rollback(str)))
  end

  def convert_2digit(str)
    raise ArgumentError, ERROR_MSG1 unless valid_for_2digit?(str)

    str.split('').sum { |x| NUMHASH[x] }
  end

  def split_by_10000s(str)
    str.gsub(/፼$/, '፼ ').split('፼')
  end

  def split_by_100_and_padd(str)
    str.map { |x| x[-1] == '፻' ? x << ' ' : x }
       .map { |x| convert_each_2_digit(x.split('፻')) }
       .each { |x| x.length == 1 && x.prepend(0) }
  end

  def convert_each_2_digit(arr)
    raise ArgumentError, ERROR_MSG3 unless valid_array_for_each_2digit?(arr)

    arr.map { |y| convert_2digit(y) }
  end

  def rollback(str)
    raise ArgumentError, ERROR_MSG3 unless validinput?(str)

    separate_10000(
      str
        .gsub('፼፻', '፼፩፻')
        .gsub(/^፻/, '፩፻')
        .gsub(/^፼/, '፩፼')
    )
  end

  def separate_10000(str)
    str.gsub!('፼፼', '፼ ፼') while str.include?('፼፼')
    str
  end

  def validinput?(str)
    str.split('')
       .map { |x| NUMHASH.key?(x) || x == '፼' || x == '፻' }
       .reduce(true) { |result, n| result && n }
  end

  def valid_for_2digit?(str)
    !str.empty? &&
      str.length <= 2 &&
      str.split('')
         .map { |x| NUMHASH.key?(x) }
         .reduce(true) { |res, n| res && n }
  end

  def valid_array_for_each_2digit?(arr)
    arr.map { |x| valid_for_2digit?(x) }
       .reduce(true) { |res, n| res && n }
  end
end
