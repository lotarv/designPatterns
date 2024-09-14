def is_prime (number)
    return false if (number == 1)
    for i in 2...number
        if number % i == 0
            return false
        end
    end
    return true
end

def max_prime_divisor(number)  #Метод 1 - Найти максимальный простой делитель числа
    max_divisor = 0
    for i in 2..number
        if (number % i == 0 and is_prime(i))
            max_divisor = i
        end
    end
    return max_divisor
end

def mult_of_digits_not_divide_by_5(number) #Метод 2 - Найти произведение цифр числа, не делящихся на 5
    result = 1
    numberCpy = number
    while numberCpy > 0
        digit = numberCpy % 10
        result *= digit if (digit % 5 != 0)
        numberCpy /= 10
    end 
    result
end

def gdc_special(number)  #Метод 3 - Найти НОД максимального нечетного непростого делителя числа и произведения цифр данного числа
    #Вычисляем максимальный нечетный непростой делитель
    max_odd_nonprime_divisor = 1
    for i in 2..number
        next if i % 2 == 0  # исключаем четные
        next if (number % i != 0)  #исключаем не делители
        next if (is_prime(i))  #исключаем простые числа
        max_odd_nonprime_divisor = i
    end
    
    
    #Вычисляем произведение чисел данного числа
    multiple_of_digits = 1

    while number > 0
        multiple_of_digits *= number % 10
        number /= 10
    end

    #Вычисляем НОД - наибольший общий делитель
    a = max_odd_nonprime_divisor
    b = multiple_of_digits

    while b != 0
        a,b = b, a % b
    end

    return a
end


arr = [1,2,3]

puts arr
arr[5] = 'sergey'
print arr

