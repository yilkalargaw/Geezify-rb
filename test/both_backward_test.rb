# coding: utf-8
require 'minitest/autorun'
require_relative '../lib/geezify-rb.rb'
require_relative 'test_case'

class GeezifyArabifyBackwardTest < Minitest::Test
  include GeezifyRb

  def test_geezify_then_arabify
    TESTDATA.map do |x|
      assert_equal x[0],
        GeezifyRb::Arabify.arabify(GeezifyRb::Geezify.geezify(x[0]))
    end
  end

  def test_arabify_then_geezify
    TESTDATA.map do |x|
      assert_equal x[1],
        GeezifyRb::Geezify.geezify(GeezifyRb::Arabify.arabify(x[1]))
    end
  end
end
