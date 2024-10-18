require 'minitest/autorun'
require './arrProc.rb'

class ArrProcTest < Minitest::Test
    def setup
        @my_array = ArrProc.new([10,11,5,4,6,7,80,-3,-5,-5, 49])
        @array_for_chunk = ArrProc.new([1,3,5,7,10,12,14,16,11])
    end

    def test_filter_remove_even_numbers
        result = @my_array.filter {|num| num.odd?}
        expected = [11,5,7,-3,-5,-5,49]
        assert_equal(expected, result)
    end

    def test_filter_remove_negative_numbers
        result = @my_array.filter {|num| num > 0}
        expected = [10,11,5,4,6,7,80,49]
        assert_equal(expected, result)
    end

    def test_member_true
        result = @my_array.member?(49)
        expected = true
        assert_equal(expected, result)
    end

    def test_member_false
        result = @my_array.member?(52)
        expected = false
        assert_equal(expected, result)
    end

    def test_sum_positive
        result = @my_array.sum {|num| num > 0}
        expected = 172
        assert_equal(expected, result)
    end

    def test_sum_negative
        result = @my_array.sum {|num| num < 0}
        expected = -13
        assert_equal(expected, result)
    end

    def test_reduce_sum
        result = @my_array.reduce(0) {|acc, num| acc + num}
        expected = 159
        assert_equal(expected, result)
    end

    def test_reduce_multiple
        result = @my_array.reduce(1) {|acc, num| acc * num}
        expected = -27165600000
        assert_equal(expected, result)
    end

    def test_include_even
        result = @my_array.include? {|num| num.even?}
        expected = true
        assert_equal(result,expected)
    end

    def test_chunk
        result = @array_for_chunk.chunk{|num| num.even?}
        expected = [[false, [1, 3, 5, 7]], [true, [10, 12, 14, 16]], [false, [11]]]
        assert_equal(expected,result)
    end



end
