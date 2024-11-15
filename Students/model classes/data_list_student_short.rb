require_relative "data_list.rb"
require_relative "../student_short.rb"
require_relative "../student.rb"
require_relative "data_table.rb"
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


student_short1 = Student_short.new_from_string(1, "Лотарев С. Ю., https://github.com/lotarv, telegram: @lotarv")
student_short2 = Student_short.new_from_string(2, "Иванов И. И., https://github.com/ivanov, telegram: @ivanov")
student_short3 = Student_short.new_from_string(3, "Петров П. П., https://github.com/petrov, telegram: @petrov")
student_short4 = Student_short.new_from_string(4, "Марков М. С., https://github.com/markov, telegram: @markov")
student_short5 = Student_short.new_from_string(5, "Антонов А. В., https://github.com/antonov, telegram: @antonov")


student_short6 = Student_short.new_from_string(6, "Смирнов С. А., https://github.com/smirnov, telegram: @smirnov")
student_short7 = Student_short.new_from_string(7, "Кузнецов К. П., https://github.com/kuznetsov, telegram: @kuznetsov")
student_short8 = Student_short.new_from_string(8, "Лебедев Л. В., https://github.com/lebedev, telegram: @lebedev")
student_short9 = Student_short.new_from_string(9, "Григорьев Г. О., https://github.com/grigoryev, telegram: @grigoryev")
student_short10 = Student_short.new_from_string(10, "Федоров Ф. И., https://github.com/fedorov, telegram: @fedorov")



data_list_short = Data_list_student_short.new([student_short1, student_short2, student_short3, student_short4, student_short5])
print data_list_short.get_data

data_list_short.set_content([student_short6,student_short7, student_short8])
print data_list_short.get_data




