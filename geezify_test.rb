# coding: utf-8
require 'minitest/autorun'
require_relative 'geezify'
require_relative 'test_case'

class GeezifyTest < Minitest::Test
  def test_geezify_for_all_test_cases
    TESTDATA
      .map { |x| assert_equal x[1], Geezify.new(x[0]).geezify }
  end
end
