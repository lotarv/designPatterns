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


print student1.to_s()

