class Student
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

    #getter & setter for @id
    def id
        @id
    end

    def id=(value)
        @id = value
    end

    #getter & setter for @name
    def name
        @name
    end

    def name=(value)
        @name = value
    end

    #getter & setter for @surname
    def surname
        @surname
    end

    def surname=(value)
        @surname = value
    end

    #getter & setter for @middle_name
    def middle_name
        @middle_name
    end

    def middle_name=(value)
        @middle_name = value
    end

    #getter & setter for @phone
    def phone
        @phone
    end

    def phone=(value)
        @phone = value
    end

     #getter & setter for @telegram
    def telegram
        @telegram
    end

    def telegram=(value)
        @telegram = value
    end

     #getter & setter for @email
    def email
        @email
    end

    def email=(value)
        @email = value
    end

     #getter & setter for @git
    def git
        @git
    end

    def git=(value)
        @git = value
    end
end

student1 = Student.new(1,"Sergey", "Lotarev", "Urievich")

