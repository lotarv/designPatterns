require './student.rb'
require './student_short.rb'

student1 = Student.new({
  id:5,
  name: "Сергей",
  surname: "Лотарев",
  middle_name: "Юрьевич",
  phone: '88005553535',
  # telegram: '@lotarv',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv'
})


# puts student1.to_s()

puts student1.to_s()
student2 = Student_short.new_from_student_obj(student1)

student3 = Student_short.new_from_string(10, student1.get_info())


puts student3.get_full_name