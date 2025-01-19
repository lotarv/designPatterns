require 'fox16'
require_relative '../database-connection/Student_list_DB.rb'
include Fox

class MainWindow < FXMainWindow
  def initialize(app)
    # Основное окно приложения
    super(app, "Students",opts: DECOR_ALL & ~DECOR_RESIZE, width: 915, height: 440)

    # Контейнер с горизонтальным расположением
    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Область фильтрации
    filter_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 200)
    make_and_fill_filtration(filter_frame)

    # Область с таблицей
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    make_and_fill_table(table_frame)

    # Область с кнопками
    button_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 150)
    
    make_buttons(button_frame)

    
    
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def make_and_fill_table(parent_frame)
    #Подключение к БД

    DB_connection.instance.connect()
    student_list = Student_list_DB.new()

    puts student_list.get_k_n_student_short_list(30, 1).get_data()
    @table_data = student_list.get_k_n_student_short_list(30, 1).get_data()
    @items_per_page = 15
    @current_page = 0
    @total_pages = (@table_data.length.to_f / @items_per_page).ceil
    @sort_order = :asc # По умолчанию сортировка по возрастанию

    table_frame = FXVerticalFrame.new(parent_frame, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    @table = FXTable.new(table_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.rowHeader.width = 0 # Скрываем заголовки строк
    @table.setTableSize(@items_per_page, 4)
    @table.setColumnText(0, "№")
    @table.setColumnText(1, "Имя")
    @table.setColumnText(2, "git")
    @table.setColumnText(3, "Контакты")
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)

    # Добавляем обработчик сортировки по колонке "Имя"
    @table.columnHeader.connect(SEL_COMMAND) do |sender, sel, event|
        if event.to_i == 1 # Если кликнули по заголовку колонки "Имя"
            sort_table_data_by_name
            update_table_data
        end
    end
    

    # Пагинация
    pagination_frame = FXHorizontalFrame.new(table_frame, LAYOUT_FILL_X | LAYOUT_CENTER_X)
    prev_button = FXButton.new(pagination_frame, "< Предыдущая", opts: BUTTON_NORMAL | LAYOUT_SIDE_LEFT)
    @page_label = FXLabel.new(pagination_frame, "Страница: 1 / #{@total_pages}", opts: JUSTIFY_CENTER_X | LAYOUT_FILL_X)
    next_button = FXButton.new(pagination_frame, "Следующая >", opts: BUTTON_NORMAL | LAYOUT_SIDE_RIGHT)

    prev_button.connect(SEL_COMMAND) do
      @current_page -= 1 if @current_page > 0
      update_table_data
    end

    next_button.connect(SEL_COMMAND) do
      @current_page += 1 if (@current_page + 1) * @items_per_page < @table_data.size
      update_table_data
    end

    update_table_data # Обновляем таблицу сразу после создания
end

  
  def update_table_data
    start_index = @current_page * @items_per_page
    end_index = [start_index + @items_per_page, @table_data.size].min
  
    (0...@items_per_page).each do |row|
      if start_index + row < end_index
        item = @table_data[start_index + row]
        @table.setItemText(row, 0, item[0].to_s)
        @table.setItemText(row, 1, item[1])
        @table.setItemText(row, 2, item[2])
        @table.setItemText(row, 3, item[3])
      else
        @table.setItemText(row, 0, "")
        @table.setItemText(row, 1, "")
        @table.setItemText(row, 2, "")
        @table.setItemText(row, 3, "")
      end
    end
  
    # Обновление метки текущей страницы
    @page_label.text = "Страница: #{@current_page + 1} / #{@total_pages}" if @page_label
  
    # Обновление метки текущей страницы
    @page_label.setText("Страница: #{@current_page + 1} / #{@total_pages}")
  end

  # Метод для сортировки данных по колонке "Имя"
def sort_table_data_by_name
    if @sort_order == :asc
        @table_data.sort_by! { |row| row[1] }
        @sort_order = :desc
    else
        @table_data.sort_by! { |row| row[1] }.reverse!
        @sort_order = :asc
    end
end

  def make_and_fill_filtration(filter_frame)
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

  def make_buttons(button_frame)
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
    FXButton.new(button_frame, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      update_table_data # Обновляет таблицу согласно установленным фильтрам
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
  MainWindow.new(app)
  app.create
  app.run
end