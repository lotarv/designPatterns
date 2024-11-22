# main.rb

require_relative '../database-connection/student_list_DB.rb'
DB_connection.instance.connect()
# Создание объекта Student_list_DB

student_list_db = Student_list_DB.new

# Создание нового студента
student = Student.new({
  name: "Алёна",
  surname: "Пономарева",
  middle_name: "Игоревна",
  phone: '87007007070',
  email: 'ponomareva.alena@yandex.ru',
  git: 'https://github.com/alenka228'
})

# Добавление студента в базу данных и список
student_list_db.add_student(student)

# Показать всех студентов после добавления
puts "All students after adding one:"
puts student_list_db.get_k_n_student_short_list(30,1).get_data()


# Удалить студента
student_list_db.delete_student(31)

# Показать всех студентов после удаления
puts "All students after deletion:"
puts student_list_db.get_k_n_student_short_list(30, 1).get_data()

# Получение количества студентов
puts "Total number of students: #{student_list_db.count}"

DB_connection.instance.close_connection()
