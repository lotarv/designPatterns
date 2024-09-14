class Student
    attr_accessor :id, :name,:surname, :middle_name,:phone,:telegram,:email,:git
    def initialize(id, name, surname, middle_name, phone = '', telegram = '', email = '', git = '')
        @id = id
        @name = name
        @surname = surname
        @middle_name = middle_name
        @phone = phone
        @telegram = telegram
        @email = email
        @git = git
    end

    def showInfo()
        puts "*** #{@name} #{@middle_name} #{@surname} ***"
        puts "id: #{@id}"
        puts "phone: #{@phone}" if @phone
        puts "telegram: #{@telegram}" if @telegram
        puts "email: #{@email}" if @email
        puts "git : #{@git}" if @github
        puts "***********************"
    end
end

student1 = Student.new(1,"Sergey", "Lotarev", "Urievich")

