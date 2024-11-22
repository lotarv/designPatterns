require 'pg'
require_relative '../models/student.rb'
require_relative '../models/student_short.rb'
require_relative '../models/data_list/data_list_student_short.rb'
require_relative 'db_connection.rb'
class Student_list_DB
    def initialize()
        @data = get_data_from_db()
    end

    def get_k_n_student_short_list(k,n)
        start_from = k * (n-1)
        finish = start_from + k
        slice = @data.slice(start_from..finish)

        forming_data = []

        slice.each do |student_str|
            forming_data.push(Student_short.new_from_student_obj(Student.new(student_str)))
        end

        return Data_list_student_short.new(forming_data)
        
    end

    def add_student(student_obj)
        data_obj = get_data_from_student_obj(student_obj)
        data_obj[:id] = self.get_max_id + 1
        @data.push(data_obj)
        add_student_to_db(data_obj)
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
        @data.reject! {|data_obj| data_obj[:id] == id}
        delete_student_from_db(id)
    end

    def count()
        return @data.count
    end

    private 
    def get_data_from_db()
        query_result = DB_connection.instance.execute_query("SELECT * FROM student")
        data = []
        query_result.each do |row|
            row["id"] = row["id"].to_i #Преобразую типы, т.к из бд integer приходит как строка
            student_data = row.transform_keys(&:to_sym)
            data.push(student_data)
        end

        return data
    end

    def get_data_from_student_obj(student_obj)
        data_obj = {
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
        max_id_element = @data.max_by {|data_obj| data_obj[:id]}
        return max_id_element[:id]
    end

    def add_student_to_db(data_obj)
        query = "INSERT INTO student(id,name,surname,middle_name, phone,telegram,email,git) 
        VALUES (#{data_obj[:id]}, '#{data_obj[:name]}', '#{data_obj[:surname]}','#{data_obj[:middle_name]}', '#{data_obj[:phone]}','#{data_obj[:telegram]}', '#{data_obj[:email]}', '#{data_obj[:git]}')"
        DB_connection.instance.execute_query(query)
    end

    def delete_student_from_db(id)
        query = "DELETE FROM student WHERE id=#{id}"
        DB_connection.instance.execute_query(query)
    end
end


