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
    def initialize(arr)
        @arr = arr
    end

    def to_s
       return @arr.join(' ')
    end

    def filter(&block)
        result = []
        @arr.each do |element|
            if block.call(element)
                result << element
            end
        end
        return result
    end

    def member?(value)
        @arr.each do |element|
            if element == value
                return true
            end
        end
        return false
    end

    def sum(&block)  # Сумммирует только те элементы, которые подходят под условие
        sum = 0
        @arr.each do |element|
            if block.call(element)
                sum += element
            end
        end
        return sum
    end

    def reduce(init = @arr[0],&block)
        acc = init
        @arr.each do |element|
            acc = block.call(acc, element)
        end

        return acc
    end

    def include?(&block)  #true если хотя бы один элемент подходит под условие, иначе false
        @arr.each do |element|
            if block.call(element)
                return true
            end
        end
        
        return false
    end


    def chunk(&block)
        collections = []  # Массив для хранения групп
        current_group = []  # Текущая группа
        previous_value = nil  # Хранит предыдущее значение блока
    
        @arr.each do |element|  # Итерируемся по каждому элементу
            current_value = block.call(element)  # Получаем значение блока для текущего элемента
    
            # Если это первый элемент или значение изменилось, сохраняем предыдущую группу
            if previous_value.nil? || current_value != previous_value
                collections << [current_value, []]  # Начинаем новую группу
                current_group = collections.last.last  # Устанавливаем текущую группу
            end
    
            current_group << element  # Добавляем элемент в текущую группу
            previous_value = current_value  # Обновляем предыдущее значение
        end
    
        return collections  # Возвращаем массив групп
    end

    
    
end
