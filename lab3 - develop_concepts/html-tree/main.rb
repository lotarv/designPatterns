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

def proceed_dfs(tree)
  # Создаем итератор для обхода в глубину
  iterator = tree.dfs_iterator

  # Выводим элементы дерева
  iterator.each do |node|
    puts "Tag: #{node.name}, Attributes: #{node.attributes} Content: #{node.content}"
  end
end


def proceed_bfs(tree)
  # Создаем итератор для обхода в ширину
  iterator = tree.bfs_iterator

  # Выводим элементы дерева
  iterator.each do |node|
    puts "Tag: #{node.name}, Attributes: #{node.attributes} Content: #{node.content}"
  end
end

proceed_dfs(html_tree)

print "**********"

proceed_bfs(html_tree)