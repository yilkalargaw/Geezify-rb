# coding: utf-8
require 'minitest/autorun'
require_relative '../lib/geezify-rb.rb'
require_relative 'test_case'

class GeezifyTest < Minitest::Test
  include GeezifyRb
  def test_geezify_for_all_test_cases
    TESTDATA
      .map { |x| assert_equal x[1], GeezifyRb::Geezify.geezify(x[0]) }
  end
end
