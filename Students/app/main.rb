require './app.rb'

app = FXApp.new
MainWindow.new(app)
app.create()
app.run()