class Subject
    def initialize()
        @observers = []
    end

    def add_observer(observer)
        @observers << observer
    end

    def delete_observer(observer)
        @observer.delete(observer)
    end

    def notify_observers(data)
        @observers.each do |observer| 
            observer.update(data)
        end
    end
end

class Observer
    def update(data)
        raise NotImplementedError
    end
end


class WeatherStation < Subject
    @temp = nil
    def set_temp(temp)
        @temp = temp
        notify_observers(@temp)
    end
end

class Phone < Observer
    def update(data)
        puts "(phone) Update: now temp is #{data}°C"
    end
end

class Laptop < Observer
    def update(data)
        puts "(laptop) Update: now temp is #{data}°C"
    end
end

weather_station = WeatherStation.new()
phone = Phone.new()
laptop = Laptop.new()

weather_station.add_observer(phone)
weather_station.add_observer(laptop)

weather_station.set_temp(25)
