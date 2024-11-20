require 'json'

require_relative "student_list.rb"
class Student_list_JSON < Student_list
    private 

    def load_data()
        @data = JSON.parse(File.read(@filename), symbolize_names:true)
    end

    def make_string()
        json_string = JSON.pretty_generate(@data)
        return json_string
    end
end
