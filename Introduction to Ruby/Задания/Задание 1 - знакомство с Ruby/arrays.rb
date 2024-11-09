def min(array)
    return nil if array.length == 0
    minimum = array[0]
    for i in 1...array.length
       minimum = array[i] if (array[i] < minimum)
    end

    return minimum
end

def index_of(array, value)
    index = -1
    i = 0
    while i < array.length
        if value == array[i]
            index =  i
            break
        end
        i += 1
    end
    index
end

def first_positive_of(array)
    for i in 0...array.length
        return array[i] if array[i] > 0
    end
    -1
end

method = ARGV[0].to_i
file_name = ARGV[1]

begin
    array_from_file = File.read(file_name).split(',').map {|value| value.to_i}  #Считали и преобразовали в инты
rescue Exception => e
    puts "Произошла ошибка: #{e.message}"
    exit
end


case method
when 0
    puts "Minimal element of an array: #{min(array_from_file)}" 
when 1
    puts "Enter the value whose index you need: "
    value = $stdin.gets.chomp.to_i
    if (index_of(array_from_file, value) == -1)
        puts "There is no such value in the array"
    else
        puts "The index of #{value} is #{index_of(array_from_file, value)}"
    end
when 2
    if (first_positive_of(array_from_file) == -1)
        puts "There is no positive elements in the array"
    else
        puts "First positive element in the array: #{first_positive_of(array_from_file)}"
    end
else
    puts "There is no such method"
end


