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

