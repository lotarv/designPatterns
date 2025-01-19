require_relative '../../models/student_list/student_list.rb'
require_relative '../../models/student_list/strategies/format_strategy.rb'
class Student_list_controller
    def initialize(view)
        @view = view
        begin
            @student_list = Student_list.new(JSON_strategy.new())
            @student_list.read('../resources/students.json')
        end
    end

    def check()
        puts @student_list.get_k_n_student_short_list(30,1).get_data()
    end
end
