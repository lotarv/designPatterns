require 'json'
require_relative "../student.rb"
require_relative "data_list_student_short.rb"
class Student_list_JSON

    def initialize()
        @data = nil
    end

    def read(filename)
        @filename = filename
        @data = JSON.parse(File.read(filename), symbolize_names:true)
    end

    def write(filename = @filename)
        json_string = JSON.pretty_generate(@data)
        File.write(filename, json_string)
    end

    def get_by_id(id)
        @data.each do |element|
            if element[:id] == id
                return Student.new(element)
            end
        end

        raise ArgumentError, "id doesn't exist"
    end

    def get_k_n_student_short_list(k,n)
        start_from = k * (n-1)
        finish = start_from + k
        slice = @data.slice(start_from...finish)

        forming_data = []

        slice.each do |student_str|
            forming_data.push(Student_short.new_from_student_obj(Student.new(student_str)))
        end

        return Data_list_student_short.new(forming_data)
        
    end

    def sort()
        @data.sort_by! {|data_obj| Student.new(data_obj).get_full_name}
    end

    def print_content()
        @data.each do |element|
            puts element
        end
    end
end

json_list = Student_list_JSON.new()
json_list.read("students.json")
# data_list = json_list.get_k_n_student_short_list(20,2)

json_list.sort()

json_list.print_content()

puts json_list.get_as_students_obj()