require './student.rb'

student1 = Student.new(1, "Sergey", "Lotarev", "Urievich", '88005553535', 'lotarv', 'lotarev.serge@yandex.ru', 'lotarv');
student2 = Student.new(2, "Amal", "Blyagoz", "Hazretovich", '89003335555', 'lamafout', 'amalblyagoz@yandex.ru', 'lamafout');
student3 = Student.new(3, "Filipp", "Matyuha", "Andreevich", '8325854233', 'serenity_flaim', 'serenity_flaim@yandex.ru', 'serenity_flaim');

student1.showInfo()
student2.showInfo()
student3.showInfo()