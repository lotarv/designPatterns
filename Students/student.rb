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
        required_keys = [:name, :surname, :middle_name]
        required_keys.each do |key|
            raise "#{key} not provided" if !params.key?(key)
        end

        self.name = params[:name] 
        self.surname = params[:surname] 
        self.middle_name = params[:middle_name]

        #необязательные параметры
        self.id = params[:id]
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

    def validate?()
        self.validate_git?() && self.validate_contact?()

    end

    def validate_git?()
        !self.git.nil?
    end

    def validate_contact?()
        !self.telegram.nil? || !self.phone.nil? || !self.email.nil?
    end

    def set_contacts(contacts)
        if contacts[:phone]
            if self.class.valid_number?(contacts[:phone])
                @phone = contacts[:phone]
            else
                raise ArgumentError, "invalid phone number"
            end
        end

        if contacts[:email]
            if self.class.valid_email?(contacts[:email])
                @email = contacts[:email]
            else
                raise ArgumentError, "invalid email"
            end
        end

        if contacts[:telegram]
            if self.class.valid_telegram?(contacts[:telegram])
                @telegram = contacts[:telegram]
            else
                raise ArgumentError, "invalid telegram"
            end
        end
    end

    def getInfo()
        result = "#{self.surname} #{self.name[0].upcase()}. #{self.middle_name[0].upcase()}. "
        if @git
            result += "git: #{self.git} "
        end

        if @phone
            result += "телефон: #{self.phone}"
            return result
        elsif @email
            result += "email: #{self.email}"
            return result
        elsif @telegram
            result += "telegram: #{self.telegram}"
            return result
        end
        result
    end

    def getFullName()
        "#{self.surname} #{self.name[0].upcase()}. #{self.middle_name[0].upcase()}. "
    end

    def getGit()
        if @git
            return "git: #{self.git}"
        else
            return "git is unknown"
        end
    end
    
    #setters
    private def phone=(phone_number)
        if !self.class.valid_number?(phone_number)
            raise ArgumentError, "invalid phone number"
        end
        @phone = phone_number  
    end

    private def email=(email)
        if !self.class.valid_email?(email)
            raise ArgumentError, "invalid email"
        end
        @email = email
    end

    private def telegram=(telegram)
        if !self.class.valid_telegram?(telegram)
            raise ArgumentError, "invalid telegram"
        end

        @telegram = telegram
    end

    private def git=(git)
        if !self.class.valid_git?(git)
            raise ArgumentError, "invalid git link"
        end

        @git = git
    end


end

  