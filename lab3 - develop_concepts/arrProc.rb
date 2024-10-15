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

    def reduce(init,&block)
        acc = init
        for i in 0...self.arr.length
            acc = yield acc, self.arr[i]
        end

        return acc
    end

    def include?(&block)
        for i in 0...self.arr.length
            if yield self.arr[i]
                return true
            end
        end
        
        return false
    end

    def chunk(&block)
        collections = []  # Массив для хранения групп
        current_group = []  # Текущая группа
        previous_value = nil  # Хранит предыдущее значение блока
    
        self.arr.each do |element|  # Итерируемся по каждому элементу
            current_value = yield(element)  # Получаем значение блока для текущего элемента
    
            # Если это первый элемент или значение изменилось, сохраняем предыдущую группу
            if previous_value.nil? || current_value != previous_value
                collections << [current_value, []]  # Начинаем новую группу
                current_group = collections.last.last  # Устанавливаем текущую группу
            end
    
            current_group << element  # Добавляем элемент в текущую группу
            previous_value = current_value  # Обновляем предыдущее значение
        end
    
        collections  # Возвращаем массив групп
    end
    
end

new_arr = [1,2,3,4,5]

arrProc = ArrProc.new(new_arr)

# puts(arrProc.filter {|num| num > 3})
# puts(arrProc.member?(3))
# puts(arrProc.member?(20))

# puts (arrProc.sum {|num| num.even?})

# puts arrProc.reduce(1) {|acc, num| acc * num}
# puts arrProc.reduce(1) {|acc, num| acc + num}

# puts arrProc.include? {|num| num > 5}

puts arrProc.chunk {|num| num.even?}.inspect