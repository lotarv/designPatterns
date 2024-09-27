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
        self.git = params[:git]

        #Установка контактов
        self.set_contacts({
            phone:params[:phone],
            telegram:params[:telegram],
            email:params[:email]
         })
    end

    #Метод для вывода информации о студенте
    def show_info()
        puts "***********************"
        attributes_to_show = {
            "Полное имя" => self.get_full_name(),
            "id" => @id,
            "git" => @git,
            "Номер телефона" => @phone, 
            "telegram" => @telegram,
            "email" => @email
        }

        attributes_to_show.each do |key, value| 
            puts "#{key}: #{value}" if value
        end


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
        self.phone = contacts[:phone] if contacts[:phone]
        self.email = contacts[:email] if contacts[:email]
        self.telegram = contacts[:telegram] if contacts[:telegram]
    end

    def get_info()
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

    def get_full_name()
        "#{self.surname} #{self.name[0].upcase()}. #{self.middle_name[0].upcase()}. "
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

  