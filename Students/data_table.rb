class Data_table
    def initialize(rows,cols,arr)
        @table = Array.new(rows) {Array.new(cols)}
        arr_index = 0
        @table.each_with_index do |row, i|
            row.each_index do |j|
                @table[i][j] = arr[arr_index]
                arr_index += 1
            end
        end
    end

    def print_table
        @table.each_with_index do |row, i|
            puts "\n"
            row.each_index do |j|
                print @table[i][j] , " "
            end
        end
    end
end

data_table1 = Data_table.new(3,3,["lol"]*9)

data_table1.print_table()

