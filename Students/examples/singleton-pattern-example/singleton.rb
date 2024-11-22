require 'pg'
class DB_connection

    @instance = nil

    private_class_method :new

    def self.instance
        return @instance ||= new
    end

    def connect()
        raise "Connection already established" if @connection
        @connection = PG.connect(
            dbname: "postgres",
            user: "postgres",
            password:"password",
            host: "localhost",
            port: 5432
        )
    end

    def execute_query(query)
        @connection.exec(query)
    end

    def close_connection()
        if @connection
            @connection.close()
            @connection = nil
        end
    end

end

db = DB_connection.instance
db2 = DB_connection.instance
db.connect()
puts db.equal?(db2) # True => Ссылаются на один и тот же экземпляр
db.close_connection()