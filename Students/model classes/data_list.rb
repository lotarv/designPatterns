class Data_list
    def initialize(arr)
        @arr = arr.sort()
    end

    def select(number)
        raise ArumentError , "number must be a positive integer" if !number.is_a?(Integer)
        raise ArgumentError, "There is no #{number} element in the data_list obj with #{@arr.length} elements" if number >= @arr.length

        return @arr[number]
    end

    def get_selected(a,b)
        return @arr[a...b]
    end

    def to_s()
        return "#{@arr}"
    end

    def get_names()
        raise NotImplementedError
    end

    def get_data()
        raise NotImplementedError
    end
end