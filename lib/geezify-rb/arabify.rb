#!/usr/bin/ruby
# coding: utf-8


module GeezifyRb

  # This class contains the processing tools to convert  Geeze numbers to arabic.
  class Arabify

    ERROR_MSG_CONSTRUCTOR = 'invalid input the string is not a geez number'.freeze
    ERROR_MSG1 = 'invalid input to method convert_2digit'.freeze
    NUMHASH = Hash['፩' => 1,  '፪' => 2,  '፫' => 3,  '፬' => 4,
                   '፭' => 5,  '፮' => 6,  '፯' => 7,  '፰' => 8,
                   '፱' => 9,  '፲' => 10, '፳' => 20, '፴' => 30,
                   '፵' => 40, '፶' => 50, '፷' => 60, '፸' => 70,
                   '፹' => 80, '፺' => 90, ' ' => 0]

    def initialize(str)
      raise ArgumentError, ERROR_MSG_CONSTRUCTOR unless validinput?(str)

      @geezstr = str
    end

    def self.arabify(str)
      new(str).arabify
    end

    def arabify
      preprocessed = rollback(@geezstr.gsub('፼', '፼ ')).split('፼')

      preprocessed
        .each_with_index
        .reduce(0) do |sum, (v, i)|
        sum + convert_upto10000(v.strip) * (10_000**(preprocessed.length - 1 - i))
      end
    end

    private

    def rollback(str)
      raise ArgumentError, ERROR_MSG3 unless validinput?(str)

      str.gsub('፼፻', '፼፩፻').gsub(/^፻/, '፩፻').gsub(/^፼/, '፩፼')
    end

    def convert_2digit(string)
      str = string || ''
      raise ArgumentError, ERROR_MSG1 unless valid_for_2digit?(str)

      str.split('').sum { |x| x == '' ? 0 : NUMHASH[x] }
    end

    def convert_upto10000(str)
      return unless valid_for_convupto10000?(str)

      pos100 = str.index('፻')

      return convert_2digit(str) if pos100.nil?

      return 100 + convert_2digit(str[1..-1]) if pos100.zero?

      convert_2digit(str[0..(pos100 - 1)]) * 100 +
        convert_2digit(str[(pos100 + 1)..-1])
    end

    def validinput?(str)
      str.split('')
        .map { |x| NUMHASH.key?(x) || x == '፼' || x == '፻' }
        .reduce(true) { |result, n| result && n }
    end

    def valid_for_2digit?(str)
      str.length <= 2 && str.split('')
                           .map { |x| NUMHASH.key?(x) }
                           .reduce(true) { |res, n| res && n }
    end

    def valid_for_convupto10000?(str)
      str.is_a?(String) && str.length <= 5 && str.match('፼').nil?
    end
  end
end
