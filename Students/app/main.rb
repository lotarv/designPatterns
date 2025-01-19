require_relative './view/Student_list_view.rb'

app = FXApp.new
MainWindow.new(app)
app.create()
app.run()