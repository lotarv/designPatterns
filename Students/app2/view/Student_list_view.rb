require 'fox16'
require_relative '../../database-connection/Student_list_DB.rb'
require_relative '../controller/Student_list_controller.rb'
include Fox

class Student_list_view < FXMainWindow
  attr_reader :current_page, :items_per_page
  def initialize(app)
    # Основное окно приложения
    super(app, "Students",opts: DECOR_ALL & ~DECOR_RESIZE, width: 915, height: 440)

    @controller = Student_list_controller.new(self)
    @items_per_page = 15
    @current_page = 0
    @sort_order = :asc
    @total_pages = (@controller.get_logs_count / @items_per_page).ceil + 1

    # Контейнер с горизонтальным расположением
    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)


    # Область с таблицей
    
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    markup_table(table_frame)

    @controller.refresh_data()
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def markup_table(parent_frame)
    @table = FXTable.new(parent_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.rowHeader.width = 0 # Скрываем заголовки строк
    @table.setTableSize(@items_per_page, 4)
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)

    navigation_segment = FXHorizontalFrame.new(parent_frame, opts: LAYOUT_CENTER_X | LAYOUT_FIX_WIDTH, width:100)
    @prev_button = FXButton.new(navigation_segment, "<<<", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    @page_index = FXLabel.new(navigation_segment, "#{@current_page + 1}", opts: LAYOUT_CENTER_X)
    @next_button = FXButton.new(navigation_segment, ">>>", opts: LAYOUT_RIGHT | BUTTON_NORMAL)

    @prev_button.connect(SEL_COMMAND) {change_page(-1)}
    @next_button.connect(SEL_COMMAND) {change_page(1)}

  end

  def change_page(offset)
    new_page = @current_page + offset
    return if new_page < 0 || new_page >= @total_pages
    @current_page = new_page
    @controller.refresh_data
  end

  def set_table_params(column_names, rows_count)
    column_names.each_with_index do |name, index| 
        @table.setColumnText(index, name)
    end

    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)
  end

  def set_table_data(data)
    @table_data = data
    update_table_data()
  end


  
  def update_table_data()
    (0...@items_per_page).each do |row|
      item = @table_data[row]
      if item
        @table.setItemText(row, 0, (item[0] + (@current_page * @items_per_page)).to_s)
        @table.setItemText(row, 1, item[1])
        @table.setItemText(row, 2, item[2])
        @table.setItemText(row, 3, item[3])
      else
        # Очистка строки, если данных нет
        @table.setItemText(row, 0, "")
        @table.setItemText(row, 1, "")
        @table.setItemText(row, 2, "")
        @table.setItemText(row, 3, "")
      end
    end
  
    # Обновление метки текущей страницы
    @page_index.setText("#{@current_page + 1} / #{@total_pages}")
  end


end

if __FILE__ == $0
  app = FXApp.new
  Student_list_view.new(app)
  app.create
  app.run
end