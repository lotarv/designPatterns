'''
Вариант9.
Методы:
9 filter,
21 member?, ???????????????????????
33 sum,
28 reduce,
16 include?,
4 chunk,
'''

class ArrProc
    private attr_accessor :arr

    def initialize(arr)
        self.arr = arr
    end

    def to_s
        self.arr.join(' ')
    end

    def filter(&block)
        new_arr = []
        for i in 0...self.arr.length
            if yield self.arr[i]
                new_arr.append(self.arr[i])
            end
        end
        return new_arr

    end

    def member?(element)
        for i in 0...self.arr.length
            if self.arr[i] == element
                return true
            end
        end
        return false
    end

    def sum(&block)  # Summing elements that suitable for confition
        sum = 0
        for i in 0...self.arr.length
            if yield self.arr[i]
                sum += self.arr[i]
            end
        end
        return sum
    end

    def reduce
    end

    def include?
    end

    def chunk
    end




end

new_arr = [1,2,3,4,5]

arrProc = ArrProc.new(new_arr)

puts(arrProc.filter {|num| num > 3})
puts(arrProc.member?(3))
puts(arrProc.member?(20))

puts (arrProc.sum {|num| num.even?})