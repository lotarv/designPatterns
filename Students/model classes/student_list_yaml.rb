require 'yaml'
require_relative "student_list.rb"

class Student_list_YAML < Student_list
    private

    def load_data()
        @data = YAML.load_file(@filename, symbolize_names: true)
    end

    def make_string()
        yaml_string = YAML.dump(@data)
        return yaml_string
    end

end