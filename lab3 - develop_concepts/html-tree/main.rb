require "./tag.rb"
require "./tree.rb"

html = "
<div class=\"welcome-section\">
    <h1>Добро пожаловать на наш сайт!</h1>
    <p id='greeting-text'>Мы рады видеть вас здесь. Ознакомьтесь с нашими услугами и не стесняйтесь задавать вопросы.</p>

    <div class=\"card\">
        <h2>Наши Услуги</h2>
        <p>Мы предлагаем широкий спектр услуг, включая веб-разработку, дизайн и SEO-оптимизацию.</p>
        <button>Узнать больше</button>
    </div>
</div>
"
html_tree = Tree.new(html)

# Создаем итератор для обхода в глубину
iterator = Tree_iterator_bfs.new(html_tree.root)

# Выводим элементы дерева
iterator.each do |node|
  puts "Tag: #{node.name}, Attributes: #{node.attributes} Content: #{node.content}"
end