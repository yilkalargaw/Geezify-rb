#!/usr/bin/ruby
# coding: utf-8

# This class contains the processing tools to convert  Geeze numbers to arabic.
class Arabify
  def initialize(str)
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
    split_by_100_and_padd(split_by_10000s(rollback(str)))
  end

  def convert_2digit(str)
    str.split('').sum { |x| numhash[x] }
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
    arr.map { |y| convert_2digit(y) }
  end

  def rollback(str)
    separate_10000(
      str
        .gsub('፼፻', '፼፩፻')
        .gsub(/^፻/, '፩፻')
        .gsub(/^፼/, '፩፼')
    )
  end

  def separate_10000(str)
    str.include?('፼፼') && str.gsub!('፼፼', '፼ ፼') while str.include?('፼፼')
    str
  end

  def numhash
    Hash['፩' => 1, '፪' => 2, '፫' => 3, '፬' => 4,
         '፭' => 5, '፮' => 6, '፯' => 7, '፰' => 8,
         '፱' => 9, '፲' => 10, '፳' => 20, '፴' => 30,
         '፵' => 40, '፶' => 50, '፷' => 60, '፸' => 70,
         '፹' => 80, '፺' => 90, ' ' => 0]
  end
end
