require 'yaml'
require_relative "../student.rb"
require_relative "data_list_student_short.rb"

class Student_list_YAML
    def initialize()
        @data = nil
    end

    def read(filename)
        @filename = filename
        @data = YAML.load_file(filename, symbolize_names: true)
    end

    def write(filename = @filename)
        yaml_string = YAML.dump(@data)
        File.write(filename, yaml_string)
    end

    def get_by_id(id)
        @data.each do |element|
            if element[:id] == id
                return Student.new(element)
            end
        end

        raise ArgumentError, "id doesn't exist"
    end

    def get_k_n_student_short_list(k, n)
        start_from = k * (n - 1)
        finish = start_from + k
        slice = @data.slice(start_from..finish)

        forming_data = []

        slice.each do |student_str|
            forming_data.push(Student_short.new_from_student_obj(Student.new(student_str)))
        end

        return Data_list_student_short.new(forming_data)
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
        @data.reject! { |data_obj| data_obj[:id] == id }
    end

    def print_content()
        @data.each do |element|
            puts element
        end
    end

    def get_student_short_count()
        return @data.count
    end

    private

    def get_data_from_student_obj(student_obj)
        {
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
        max_id_element = @data.max_by { |data_obj| data_obj[:id] }
        return max_id_element[:id]
    end
end
