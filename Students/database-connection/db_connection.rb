require 'pg'
class DB_connection

    @instance = nil

    private_class_method :new

    def self.instance
        return @instance ||= new
    end

    def connect(dbname = "postgres", username = "postgres", password = "password", host = "localhost", port = 5432)
        raise "Connection already established" if @connection
        
        begin
            @connection = PG.connect(
            dbname: dbname,
            user: username,
            password:password,
            host: host,
            port: port
        )
        rescue PG::Error => e
            raise "Connection failed: #{e.message}"
        end
    end

    def connected?()
        return !@connection.nil?
    end

    def execute_query(query)
        raise "Establish the connection first" unless connected?
        
        begin
            @connection.exec(query)
        rescue PG::Error => e
            raise "Query execution failed: #{e.message}"
        end
    end

    def close_connection()
        return if !connected?
        begin
            @connection.close()
            @connection = nil
        rescue PG::Error => e
            raise "Failed to close connection: #{e.message}"
        end
    end

end