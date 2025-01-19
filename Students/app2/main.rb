require_relative './view/Student_list_view.rb'

app = FXApp.new
Student_list_view.new(app)
app.create()
app.run()