def menu
    puts "Выберите задачу для решения:"
    puts "1. Задача 1 - Найти элементы, расположенные перед последним минимальным"
    puts "2. Задача 2 - Найти элементы, расположенные после первого максимального"
    puts "3. Задача 2 - Найти элементы, расположенные после первого максимального"
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

    yield(result) if block_given? 
end

def find_elements_after_first_max(arr) #Задача 1.21
    puts "Исходный массив: #{arr}" 
    max_value = arr.max
    max_index = arr.index(max_value)
    print max_index
    result = arr.slice(max_index + 1, arr.length)

    yield(result) if block_given?
end

def find_elements_after_first_max(arr) #Задача 1.21
    puts "Исходный массив: #{arr}" 
    max_value = arr.max
    max_index = arr.index(max_value)
    print max_index
    result = arr.slice(max_index + 1, arr.length)

    yield(result) if block_given?
end

arr = [9,5,3,7,1,4,1,9]
loop do
    menu
    choice = gets.chomp.to_i
    case choice
    when 1
        find_elements_before_last_min(arr) {|result| puts "Результат: #{result}"} # Пример блока для задачи 1
    when 2
    f   ind_elements_after_first_max(arr) {|result| puts "Результат: #{result}"}  # Пример блока для задачи 2
    when 3
        data = read_from_keyboard
    puts "Вы ввели: #{data}"
    when 4
        data = read_from_file
        puts "Содержимое файла: #{data}" if data
    when 6
        puts "Выход из программы"
        break
    else
        puts "Неверный выбор, попробуйте снова"
    end
end

  