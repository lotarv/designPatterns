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

short = Student_short.new_from_student_obj(student1)
puts student1.get_info()
short2 = Student_short.new_from_string(5, student1.get_info())
puts short2.contact

print Student_short.parse_from_string(student1.get_info())
# student2 = Student.new(
#   id:2,
#   name: "Амаль",
#   surname: "Блягоз",
#   middle_name: "Хазретович",
#   phone: '89003335555',
#   telegram: 'lamafout',
#   email: 'amalblyagoz@yandex.ru',
#   git: 'lamafout'
# )

# student3 = Student.new(
#   id:3,
#   name: "Филипп",
#   surname: "Матюха",
#   middle_name: "Андреевич",
#   phone: '83258543233',
#   telegram:'serenity_flaim',
#   email:'serenity_flaim@yandex.ru',
#   git:"serenity_flaim"
# )

# student4 = Student.new(
#   {id: 123,
#   name: "Иван",
#   surname: "Петров",
#   middle_name: "Иванович",
#   phone: "+7 (999) 123-45-67",
#   telegram: "@ivanpeterov",
#   email: "ivan.petrov@example.com",
#   git: "github.com/ivanpeterov"}
#   )


# students = [student1, student2, student3, student4]

# for i in students
#     i.showInfo()
# end


