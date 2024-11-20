require_relative "student_list.rb"
require_relative "format_strategy.rb"

student_list_json = Student_list.new(YAML_strategy.new)
student_list_yaml = Student_list.new(JSON_strategy.new)

student_list_json.read("students.yaml")
student_list_yaml.read("students.json")
student_list_yaml.sort()
student_list_json.sort()
print student_list_json.get_k_n_student_short_list(20,1).get_data()
print student_list_yaml.get_k_n_student_short_list(20,2).get_data()
