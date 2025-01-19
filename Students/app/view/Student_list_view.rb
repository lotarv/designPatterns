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

    # Область фильтрации
    filter_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 200)
    markup_filtration(filter_frame)

    # Область с таблицей
    
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    markup_table(table_frame)

    @controller.refresh_data()

    # Область с кнопками
    button_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 150)
    
    markup_buttons(button_frame)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def markup_filtration(filter_frame)
    FXLabel.new(filter_frame, "Фамилия и инициалы:")
    FXTextField.new(filter_frame, 20, nil, 0, TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    # Поле фильтрации по git
    add_filter_section(filter_frame, "Git")

    # Поле фильтрации по почте
    add_filter_section(filter_frame, "Почта")

    # Поле фильтрации по телефону
    add_filter_section(filter_frame, "Телефон")

    # Поле фильтрации по Telegram
    add_filter_section(filter_frame, "Telegram")

    #Кнопка для сброса фильтров
    FXButton.new(filter_frame, "Сбросить", opts: BUTTON_NORMAL)

  end

  def add_filter_section(parent, label_text)
    section_frame = FXVerticalFrame.new(parent, LAYOUT_FILL_X | LAYOUT_FIX_HEIGHT | FRAME_THICK, height: 80)
    FXLabel.new(section_frame, label_text)
  
    # Выпадающий список (ComboBox)
    combo_box = FXComboBox.new(section_frame, 3, nil, 0, COMBOBOX_STATIC | LAYOUT_FILL_X)
    combo_box.numVisible = 3
    combo_box.appendItem("Не важно")
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.setCurrentItem(0) # По умолчанию выбрано "Не важно"
  
    # Поле ввода
    input_field = FXTextField.new(section_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    input_field.hide

    # Обработчик изменения выбора в ComboBox
    combo_box.connect(SEL_COMMAND) do
      case combo_box.currentItem
      when 1 # "Да"
        input_field.show
      else # "Нет" или "Не важно"
        input_field.hide
      end
      section_frame.recalc
    end

  end

  def markup_table(parent_frame)
    @table = FXTable.new(parent_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.rowHeader.width = 0 # Скрываем заголовки строк
    @table.setTableSize(@items_per_page, 4)
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)

    # Обработчик нажатия на заголовок первого столбца
    @table.columnHeader.connect(SEL_COMMAND) do |sender, sel, event|
    if event.to_i == 1  # 0 — это индекс первого столбца
        @controller.sort_by_column(1)  # Сортировка по первому столбцу
        @controller.refresh_data  # Обновление данных
    end
  end

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

  def markup_buttons(button_frame)
    FXLabel.new(button_frame, "Действия")
  
    # Кнопка Добавить
    FXButton.new(button_frame, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
  
    # Кнопка Изменить
    @edit_button = FXButton.new(button_frame, "Изменить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @edit_button.enabled = false # По умолчанию отключена
  
    # Кнопка Удалить
    @delete_button = FXButton.new(button_frame, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @delete_button.enabled = false # По умолчанию отключена
  
    # Кнопка Обновить
    @update_button = FXButton.new(button_frame, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @update_button.connect(SEL_COMMAND) do
      @controller.read_data()
      @controller.refresh_data()
    end
    # Подключаем обработчик выбора строк в таблице
    @table.connect(SEL_CHANGED) do
      selected_rows = []
      (@table.selStartRow..@table.selEndRow).each do |row|
        selected_rows << row if row >= 0 && row < @table.numRows && @table.rowSelected?(row)
      end
  
      if selected_rows.size == 1 # Если выделена одна строка
        @edit_button.enabled = true
        @delete_button.enabled = true
      elsif selected_rows.size > 1 # Если выделено больше одной строки
        @edit_button.enabled = false
        @delete_button.enabled = true
      else # Если ничего не выделено
        @edit_button.enabled = false
        @delete_button.enabled = false
      end
    end
  end


end

if __FILE__ == $0
  app = FXApp.new
  Student_list_view.new(app)
  app.create
  app.run
end