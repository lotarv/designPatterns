class Student
    attr_accessor :id, :name,:surname, :middle_name,:phone,:telegram,:email,:git

    #phone number validation
    def self.valid_number?(phone_number)
        phone_number.nil? || /^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/.match?(phone_number)
    end

    #email validation
    def self.valid_email?(email)
        email.nil? || /^[\w+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.match?(email)
    end

    #telegram validation
    def self.valid_telegram?(telegram) 
        telegram.nil? || /@[a-zA-Z0-9_]{5,}$/.match?(telegram)
    end

    #git validation
    def self.valid_git?(git)
        git.nil? || %r{^https?://github\.com/[a-zA-Z0-9_\-]+$}.match?(git)
    end

    #Конструктор 
    def initialize(params)
        raise "id not provided" if !params[:id]
        self.id = params[:id]

        raise "name not provided" if !params[:name]
        self.name = params[:name]

        raise "surname not provided" if !params[:surname]
        self.surname = params[:surname]

        raise "middle_name not provided" if !params[:middle_name]
        self.middle_name = params[:middle_name]

        self.phone = params[:phone]
        self.telegram = params[:telegram]
        self.email = params[:email]
        self.git = params[:git]
    end

    #Метод для вывода информации о студенте
    def showInfo()
        puts "*** #{@name} #{@middle_name} #{@surname} ***"
        puts "id: #{@id}"
        puts "phone: #{@phone}" if @phone
        puts "telegram: #{@telegram}" if @telegram
        puts "email: #{@email}" if @email
        puts "git : #{@git}" if @git
        puts "***********************"
    end

    #Метод для валидации контактов

    def validate()
        if self.git.nil?
            puts("У студента #{self.name} #{self.middle_name} #{self.surname} отсутствует git")
        else
            puts("git студента #{self.name} #{self.middle_name} #{self.surname}: #{self.git}")
        end

        if self.phone.nil? && self.email.nil?
            puts("У студента #{self.name} #{self.middle_name} #{self.surname} нет контактов для связи")
        elsif !self.phone.nil? && !self.email.nil?
            puts("Телефон студента #{self.name} #{self.middle_name} #{self.surname}: #{self.phone}")
            puts("email студента #{self.name} #{self.middle_name} #{self.surname}: #{self.email}")
        else
            puts("Телефон студента #{self.name} #{self.middle_name} #{self.surname}: #{self.phone}") if @phone
            puts("email студента #{self.name} #{self.middle_name} #{self.surname}: #{self.email}") if @email
        end


    end

    #setters
    def phone=(phone_number)
        if !self.class.valid_number?(phone_number)
            raise ArgumentError, "invalid phone number"
        end
        @phone = phone_number  
    end

    def email=(email)
        if !self.class.valid_email?(email)
            raise ArgumentError, "invalid email"
        end
        @email = email
    end

    def telegram=(telegram)
        if !self.class.valid_telegram?(telegram)
            raise ArgumentError, "invalid telegram"
        end

        @telegram = telegram
    end

    def git=(git)
        if !self.class.valid_git?(git)
            raise ArgumentError, "invalid git link"
        end

        @git = git
    end


end

  