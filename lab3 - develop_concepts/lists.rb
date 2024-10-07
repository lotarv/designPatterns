def menu
    puts "Выберите задачу для решения:"
    puts "1. Задача 1 - Найти элементы, расположенные перед последним минимальным"
    puts "2. Задача 2 - Найти элементы, расположенные после первого максимального"
    puts "3. Задача 3 - Проверить, чередуются ли в массиве положительные и отрицательные числа"
    puts "4. Задача 2 - Найти элементы, расположенные после первого максимального"
    puts "5. Задача 2 - Найти элементы, расположенные после первого максимального"
    puts "6. Выход"
  end
  
def read_from_keyboard
    puts "Введите данные с клавиатуры:"
    gets.chomp
end

def find_elements_before_last_min(arr) # Задача 1.9
    puts "Исходный массив: #{arr}"

    min_value = arr.min
    min_index = arr.rindex(min_value)
    result = arr.slice(0, min_index)

    puts "Результат: #{result}"
end

def find_elements_after_first_max(arr) #Задача 1.21
    puts "Исходный массив: #{arr}" 
    max_value = arr.max
    max_index = arr.index(max_value)
    print max_index
    result = arr.slice(max_index + 1, arr.length)

    puts "Результат: #{result}"
end

def check_rotation(arr) #Задача 1.33
    
    result = arr.each_cons(2).all? {|a,b| (a.positive? && b.negative?) || (a.negative? && b.positive?)}

    if result
        puts "Числа чередуются"
    else
        puts "Числа не чередуются"
    end
end

def sum_on_interval(arr, range)
    puts "Исходный массив: #{arr}"
    puts "Интервал: #{range}"

    result = arr.select {|x| range.include?(x)}.sum #Отбираем элементы из диапозона и суммируем их

    puts "Результат: #{result}"
end

arr = [9,5,3,7,1,4,1,9]
# arr = [1,-1,2,-2,3,-3]
loop do
    menu
    choice = gets.chomp.to_i
    case choice
    when 1
        find_elements_before_last_min(arr)
    when 2
        find_elements_after_first_max(arr)  
    when 3
        check_rotation(arr)
    when 4
        sum_on_interval(arr, 1..5)
    when 6
        puts "Выход из программы"
        break
    else
        puts "Неверный выбор, попробуйте снова"
    end
end

  