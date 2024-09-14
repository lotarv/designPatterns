require './student.rb'

student1 = Student.new(
  {id:1,
  name: "Сергей",
  surname: "Лотарев",
  middle_name: "Юрьевич",
  phone: '88005553535',
  telegram: 'lotarv',
  email: 'lotarev.serge@yandex.ru',
  git: 'lotarv'}
  )

student2 = Student.new(id:2,name: "Amal",surname: "Blyagoz",middle_name: "Hazretovich",phone: '89003335555',telegram: 'lamafout',email: 'amalblyagoz@yandex.ru',git: 'lamafout');
student3 = Student.new(id:3,name: "Filipp",surname: "Matyuha",middle_name: "Andreevich",phone: '8325854233',telegram:'serenity_flaim',email:'serenity_flaim@yandex.ru',git:"sfka");
student4 = Student.new(
  {id: 123,
  name: "Иван",
  surname: "Петров",
  middle_name: "Иванович",
  phone: "+7 (999) 123-45-67",
  telegram: "@ivanpeterov",
  email: "ivan.petrov@example.com",
  git: "github.com/ivanpeterov"}
  )


student2.showInfo()


