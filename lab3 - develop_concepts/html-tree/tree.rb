require "./tag.rb"
require "./tree_iterator_dfs.rb"
require "./tree_iterator_bfs.rb"
class Tree
    attr_reader :root
    def initialize(html_string)
        self.parse_html(html_string)
    end

    def dfs_iterator()
        return Tree_iterator_dfs.new(self.root)
    end

    def bfs_iterator()
        return Tree_iterator_bfs.new(self.root)
    end

    private
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
    end
    
    def proceed_tag_opening(stack, token, parent_element)
        tag_contains = token[1...-1].split(" ")  #Достаю все, что внутри <>
        tag_name = tag_contains[0]  #Достает имя тега
        tag_attributes_array = tag_contains[1..]  #Достает атрибуты тега в виде массива
    
        tag_attributes = {}
        tag_attributes_array.each do |element| 
            key, value = element.split("=")
            tag_attributes[key] = value[1...-1]
        end

        tag = Tag.new(name: tag_name, attributes: tag_attributes)
    
        if parent_element
            parent_element.add_child(tag)
        else
            @root = tag
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

end



