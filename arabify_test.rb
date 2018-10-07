# coding: utf-8
require 'minitest/autorun'
require_relative 'arabify'
require_relative 'test_case'

class ArabifyTest < Minitest::Test
  def test_geezify_for_all_test_cases
    TESTDATA
      .map { |x| assert_equal x[0], Arabify.new(x[1]).arabify }
  end
end
