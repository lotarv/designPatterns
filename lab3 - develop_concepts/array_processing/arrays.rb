def menu
    puts "Выберите задачу для решения:"
    puts "1. Задача 1 - Найти элементы, расположенные перед последним минимальным"
    puts "2. Задача 2 - Найти элементы, расположенные после первого максимального"
    puts "3. Задача 3 - Проверить, чередуются ли в массиве положительные и отрицательные числа"
    puts "4. Задача 4 - Найти сумму элементов, значение которых попадет в интервал"
    puts "5. Задача 5 - Найти количество элементов, которые больше, чем сумма всех предыдущих"
    puts "6. Выход"
  end
  
def read_from_keyboard
    puts "Введите ваш выбор:"
    return gets.chomp
end

def find_elements_before_last_min(arr) # Задача 1.9
    min_value = arr.min
    min_index = arr.rindex(min_value)
    result = arr.select.with_index {|_, index| index < min_index}

    return result
end

def find_elements_after_first_max(arr) #Задача 1.21
    max_value = arr.max
    max_index = arr.index(max_value)
    result = arr.select.with_index {|_, index| index > max_index}

    return result
end

def check_rotation(arr) #Задача 1.33
    
    result = arr.each_cons(2).all? {|a,b| (a.positive? && b.negative?) || (a.negative? && b.positive?)}

    return result
end

def sum_on_interval(arr, range)
    result = arr.select {|x| range.include?(x)}.sum #Отбираем элементы из диапозона и суммируем их

    return result
end

def count_elems_more_than_sum_prev(arr)

    #Cоздание массива сумм предыдущих элементов
    previous_sums = arr.map.with_index {|_, index| arr.take(index).sum}

    #Находим количество элементов, которые больше соответствующих сумм

    count = arr.zip(previous_sums).count {|elem, sum| elem > sum}

    return count

end


# arr = [9,14,3,7,1,4,1,9]
arr = [1,-1,3,2,-2,-3,3,-3]
loop do
    menu
    choice = gets.chomp.to_i
    puts "Исходный массив: #{arr}" if choice <= 6
    result = ""
    case choice
    when 1
        result = find_elements_before_last_min(arr)
    when 2
        result = find_elements_after_first_max(arr)  
    when 3
        rotation = check_rotation(arr)
        if rotation
            result = "Числа чередуются"
        else
            result = "Числа не чередуются"
        end

    when 4
        puts "Интервал: #{1..5}"
        result = sum_on_interval(arr, 1..5)
    when 5
        result = count_elems_more_than_sum_prev(arr)
    when 6
        puts "Выход из программы"
        break
    else
        puts "Неверный выбор, попробуйте снова"
    end

    puts "Результат: #{result}" if result != ""
end

  