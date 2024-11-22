require_relative "data_list.rb"
require_relative "../student_short.rb"
require_relative "../student.rb"
require_relative "../data_table/data_table.rb"
class Data_list_student_short < Data_list
    def get_names()
        return ["№","full_name", "git", "contact"]
    end

    private def prepare_data(data)
        cur_row = []
        cur_number = 1
        @arr.each do |student_short|
            cur_row.append(cur_number)
            cur_row.append(student_short.full_name)
            cur_row.append(student_short.git)
            cur_row.append(student_short.get_contact)
            cur_number += 1
            data.append(cur_row)
            cur_row = []
        end
    end

end




