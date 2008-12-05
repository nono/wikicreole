#!/usr/bin/env ruby

require 'test/unit'
require 'Creole'

class TC_Creole < Test::Unit::TestCase

  def test_strip_leading_and_trailing_eq_and_whitespace
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("==head")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace(" == head")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("head ==")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("head == ")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("head  ")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("  head")
    assert_equal "head", Creole.strip_leading_and_trailing_eq_and_whitespace("  head  ")
  end
  
  def test_strip_list
    assert_equal "`head", Creole.strip_list(" *head")
    assert_equal "\n`head", Creole.strip_list("\n *head")
  end
  
  def test_chunk_filter_lambdas
    assert_equal "a string with a  in it", Creole.filter_string_x_with_chunk_filter_y("a string with a : in it", :ip)
    assert_equal "a string with a newline", Creole.filter_string_x_with_chunk_filter_y("a string with a newline\n", :p)
    assert_equal "", Creole.filter_string_x_with_chunk_filter_y("a non-blank string", :blank)
    
    #special... uses strip_list function inside the lamda function
    assert_equal "`head", Creole.filter_string_x_with_chunk_filter_y(" *head", :ul)
    assert_equal "head", Creole.filter_string_x_with_chunk_filter_y("head == ", :h5)
  end
  
  def test_init
    Creole.init
    assert_equal 1, 1
  end
  
  def test_strong
    s = Creole.creole_parse("**Hello**")
    assert_equal "<p><strong>Hello</strong></p>\n\n", s
  end
  
  def test_italic
    s = Creole.creole_parse("//Hello//")
    assert_equal "<p><em>Hello</em></p>\n\n", s
  end
  
#  def test_italic_with_spaces
#    s = Creole.creole_parse("//Hello// **Hello**")
#    assert_equal "<p><em>Hello</em> <strong>Hello</strong></p>\n\n", s
#  end
  
end