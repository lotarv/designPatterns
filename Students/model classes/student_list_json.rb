require 'json'
require_relative "../student.rb"
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


    def print_content()
        print @data
    end
end

json_list = Student_list_JSON.new()
json_list.read("students.json")
print json_list.get_k_n_student_short_list(2,2)