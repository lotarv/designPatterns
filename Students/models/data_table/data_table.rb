class Data_table
    def initialize(data)
        @data = data
    end

    def to_s()
        result_string = ""
        for i in 0...self.rows
            result_string += "\n"
            for j in 0...self.cols
                result_string += "#{@data[i][j]} "
            end
        end

        return result_string
    end

    def rows()
        return @data.length
    end

    def cols()
        return @data[0].length unless @data[0].nil?
        return 0
    end

    def get(row, col)
        if row >= self.rows || row < 0
            raise ArgumentError, "There is no such row"
        elsif col >= self.cols || col < 0
            raise ArgumentError, "There is no such row"
        end
        
        return @data[row][col]

    end
end