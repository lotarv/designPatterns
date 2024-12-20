require 'fox16'
include Fox

class MainWindow < FXMainWindow
    def initialize(app)
        super(app, "FXRuby Application", width:800, height: 600)
    end

    def create
        super
        show(PLACEMENT_SCREEN)
    end
end

