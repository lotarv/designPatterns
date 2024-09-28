require './student.rb'
require './student_short.rb'
student1 = Student.new(
  {id:5,
  name: "Сергей",
  surname: "Лотарев",
  middle_name: "Юрьевич",
  phone: '88005553535',
  # telegram: '@lotarv',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv'
}
  )


# puts student1.to_s()

student2 = Student_short.new_from_student_obj(student1)


puts student1.get_full_name()
puts student2.get_full_name()

puts student1.get_contact()
puts student2.get_contact()

