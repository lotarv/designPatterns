require "./tag.rb"
class Tree

    attr_accessor :root
    def initialize(html_string)
        self.root = self.parse_html(html_string)
    end


    def parse_html(html)
        stack = []
        parent_element = nil
    
        html.scan(/<[^>]+>|[^<]+/) do |token|
            token.strip!
            parent_element = stack.last 
            if token.start_with?("<")
                unless token.start_with?("</")
                    
                    proceed_tag_opening(stack, token, parent_element)             
                else
                    proceed_tag_closing(stack, token)
                end
            elsif !token.empty?
                proceed_text(token,parent_element)
            end
            
        end

        return self.root
    end
    
    def proceed_tag_opening(stack, token, parent_element)
        tag_contains = token[1...-1].split(" ")  #Достаю все, что внутри <>
        tag_name = tag_contains[0]  #Достает имя тега
        tag_attributes_array = tag_contains[1..]  #Достает атрибуты тега в виде массива
    
        tag_attributes = {}
        tag_attributes_array.each do |element| 
            key, value = element.split("=")
            tag_attributes[key] = value
        end

        tag = Tag.new(name: tag_name, attributes: tag_attributes)
    
        if parent_element
            parent_element.add_child(tag)
        else
            self.root = tag
        end

        stack << tag
        return tag
            
        
    end
    
    def proceed_tag_closing(stack, token)
        
        tag_name = token[2...-1]
        if stack.last && stack.last.name == tag_name
            stack.pop
        end
    end
    
    def proceed_text(token, parent_element)
        
        parent_element.content = token
    end

    def to_html
        root ? tag_to_html(root) : ""
      end
    
      private
    
      def tag_to_html(tag)
        # Сборка атрибутов тега в строку
        attributes_str = tag.attributes.map { |key, value| "#{key}='#{value}'" }.join(" ")
    
        # Открывающий тег с атрибутами
        opening_tag = attributes_str.empty? ? "<#{tag.name}>" : "<#{tag.name} #{attributes_str}>"
    
        # Контент, включая рекурсивный вызов для дочерних тегов
        inner_content = tag.children.map { |child| tag_to_html(child) }.join + (tag.content || "")
    
        # Закрывающий тег
        closing_tag = "</#{tag.name}>"
    
         # Полный HTML для текущего тега
        "#{opening_tag}#{inner_content}#{closing_tag}"
      end

end



# test_tag = Tag.new(name: "h1", attributes: {height: "20px", width: "50px"}, content: "welcome")


html = "<div class='a' id='lol'>
    <h1>Title Document</h1>
    <p>Some text</p>
</div>"

new_tree = Tree.new(html)

print(new_tree.root)
print(new_tree.to_html)

