require "./student.rb"
require "./binarySearchTree.rb"
bst = BinarySearchTree.new();

student1 = Student.new({
  id:1,
  name: "Сергей",
  surname: "Лотарев",
  middle_name: "Юрьевич",
  phone: '88005553535',
  telegram: '@lotarv',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv',
  birthdate: "26-10-2004"
})

student2 = Student.new({
  id:2,
  name: "Алена",
  surname: "Пономарева",
  middle_name: "Игоревна",
  phone: '89009009090',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv',
  birthdate: "26-10-2005"
})

student3 = Student.new({
  id:3,
  name: "Амаль",
  surname: "Блягоз",
  middle_name: "Хазретович",
  phone: '87007007070',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv',
  birthdate: "26-10-2006",
})

student4 = Student.new({
  id:3,
  name: "Никита",
  surname: "Смирнов",
  middle_name: "Олегович",
  phone: '86006006060',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv',
  birthdate: "26-10-2001",
})

student5 = Student.new({
  id:3,
  name: "Филипп",
  surname: "Матюха",
  middle_name: "Андреевич",
  phone: '85005005050',
  email: 'lotarev.serge@yandex.ru',
  git: 'https://github.com/lotarv',
})




bst.insert(student1)
bst.insert(student2)
bst.insert(student3)
bst.insert(student4)
bst.insert(student5)

print bst.map {| student | student.get_info}
