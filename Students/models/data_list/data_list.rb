require_relative "../data_table/data_table.rb"
class Data_list
    def initialize(arr)
        @arr = arr.sort()
        @observers = []
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
        names = self.get_names
        data = []
        prepare_data(data)
        return Data_table.new(data)
    end

    def set_content(new_content)
        @arr.clear()
        @arr = new_content
    end

    def count()
        return @arr.size
    end
    

    def prepare_data(data)
        raise NotImplementedError
    end

    def add_observer(observer)
        @observers << observer
    end

    def notify()
        @observers.each do |observer|
            observer.set_table_params(get_names(), self.count)
            observer.set_table_data(get_data())
        end
    end
end