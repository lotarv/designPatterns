require_relative '../../models/student_list/student_list.rb'
require_relative '../../models/student_list/strategies/format_strategy.rb'
require_relative '../../models/data_list/data_list.rb'
class Student_list_controller
    def initialize(view)
        @view = view
        @student_list = Student_list.new(JSON_strategy.new())
        @student_list.read('../resources/students.json')
        @data_list = Data_list_student_short.new([])
        @data_list.add_observer(@view)
    end

    def refresh_data()
        @student_list.get_k_n_student_short_list(@view.items_per_page,@view.current_page + 1, @data_list)
        @data_list.notify()
    end

    def get_logs_count()
        return @student_list.get_student_short_count()
    end

    def sort_by_column(column_index)
        @student_list.sort()
    end
    
    def read_data()
        @student_list.read('../resources/students.json')
    end

end
