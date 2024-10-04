require './person.rb'
class Student < Person
    attr_accessor :name, :surname, :middle_name, :phone,:telegram,:email

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
    
    #Конструктор 
    def initialize(params = {name:, surname:, middle_name:, id:nil, git:nil, phone:nil, telegram:nil, email:nil})

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
    def to_s()
        result_string = "***********************\n"

        attributes_to_show = {
            "Полное имя" => self.get_full_name(),
            "id" => @id,
            "git" => @git,
            "Номер телефона" => @phone, 
            "telegram" => @telegram,
            "email" => @email
        }

        attributes_to_show.each do |key, value| 
            result_string += "#{key}: #{value}\n" if value
        end


        result_string += "***********************\n"

        result_string
    end

    #Метод для валидации контактов

    def validate?()
        self.validate_git?() && self.validate_contact?()

    end

    def validate_contact?()
        !self.telegram.nil? || !self.phone.nil? || !self.email.nil?
    end

    def set_contacts(contacts = {phone:nil, email:nil, telegram:nil})    
        self.phone = contacts[:phone] if contacts[:phone]
        self.email = contacts[:email] if contacts[:email]
        self.telegram = contacts[:telegram] if contacts[:telegram]
    end

    def get_info()
        self.get_full_name + ", " + self.git + ", " + self.get_contact
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
    
    private def name=(name_value)
        @name = name_value
    end

    private def surname=(surname_value)
        @surname = surname_value
    end

    private def middle_name=(middle_name_value)
        @middle_name = middle_name_value
    end

end

