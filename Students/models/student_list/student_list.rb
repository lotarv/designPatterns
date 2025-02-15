require_relative "../student.rb"
require_relative "../student_short.rb"
require_relative "../data_list/data_list.rb"
require_relative "../data_list/data_list_student_short.rb"
class Student_list
    def initialize(data_format)
        @format = data_format
        @data = nil
    end

    def read(filename)
        @data = @format.read(filename)
    end

    def write(filename = @filename)
        @format.write(filename, @data)
    end

    def get_by_id(id)
        @data.each do |element|
            if element[:id] == id
                return Student.new(element)
            end
        end

        raise ArgumentError, "id doesn't exist"
    end

    def get_k_n_student_short_list(k,n, data_list = nil)
        start_from = k * (n-1)
        finish = [start_from + k - 1, @data.size - 1].min
        
        slice = @data.slice(start_from..finish)

        slice = @data.slice(start_from..finish) || []  # Если slice nil, возвращаем пустой массив

        forming_data = slice.map do |student_str|
        Student_short.new_from_student_obj(Student.new(student_str))

        end

        if (data_list)
            data_list.set_content(forming_data)
            return
        else Data_list_student_short.new(forming_data)
        end        
    end

    def sort()
        @data.sort_by! { |data_obj| Student.new(data_obj).get_full_name }
    end

    def add_student(student_obj)
        data_obj = get_data_from_student_obj(student_obj)
        data_obj[:id] = self.get_max_id + 1
        @data.push(data_obj)
    end

    def replace_student(id, student_obj)
        new_data_obj = get_data_from_student_obj(student_obj)
        new_data_obj[:id] = id

        @data.each_with_index do |data_obj, i|
            if data_obj[:id] == id
                @data[i] = new_data_obj
            end
        end
        
    end

    def delete_student(id)
        raise ArgumentError, "id is out of bounds" if id < 0 || id > self.get_max_id
        @data.reject! {|data_obj| data_obj[:id] == id}
    end

    def get_student_short_count()
        return @data.count
    end


    private

    def get_data_from_student_obj(student_obj)
        data_obj = {
            id: student_obj.id,
            name: student_obj.name,
            surname: student_obj.surname,
            middle_name: student_obj.middle_name,
            phone: student_obj.phone,
            telegram: student_obj.telegram,
            email: student_obj.email,
            git: student_obj.git
        }
    end
    def get_max_id()
        max_id_element = @data.max_by {|data_obj| data_obj[:id]}
        return max_id_element[:id]
    end
end