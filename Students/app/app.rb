require 'fox16'

include Fox

class MainWindow < FXMainWindow
  def initialize(app)
    # Основное окно приложения
    super(app, "Три области",opts: DECOR_ALL & ~DECOR_RESIZE, width: 907, height: 400)

    # Контейнер с горизонтальным расположением
    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Область фильтрации
    filter_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 200)
    FXLabel.new(filter_frame, "Фильтрация")
    FXTextField.new(filter_frame, 20, nil, 0, TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    FXButton.new(filter_frame, "Применить фильтр", opts: BUTTON_NORMAL | LAYOUT_FILL_X)

    # Область с таблицей
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    make_and_fill_table(table_frame)

    # Область с кнопками
    button_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 150)
    FXLabel.new(button_frame, "Действия")
    FXButton.new(button_frame, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    FXButton.new(button_frame, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    FXButton.new(button_frame, "Редактировать", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def make_and_fill_table(parent_frame)
    table = FXTable.new(parent_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    table.rowHeader.width = 0 # Скрываем заголовки строк
    table.setTableSize(10, 4)
    table.setColumnText(0, "№")
    table.setColumnText(1, "Имя")
    table.setColumnText(2, "git")
    table.setColumnText(3, "Контакты")
    table.setColumnWidth(0, 30)
    table.setColumnWidth(1, 100)
    table.setColumnWidth(2, 200)
    table.setColumnWidth(3, 200)
    (0..9).each do |row|
        table.setItemText(row, 0, "#{row + 1}")
        table.setItemText(row, 1, "Элемент #{row + 1}")
        table.setItemText(row, 2, "Описание для элемента #{row + 1}")
        table.setItemText(row, 3, "Описание для элемента #{row + 1}")
    end
  end
end

if __FILE__ == $0
  app = FXApp.new
  MyApp.new(app)
  app.create
  app.run
end
