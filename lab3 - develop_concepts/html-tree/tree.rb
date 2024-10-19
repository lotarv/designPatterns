require "./tag.rb"
# def parse_html(html)
#     stack = []
#     parent_element = nil
#     current_element = {
#         name:"",
#         content:"",
#         attributes:{},
#         children:[],
#     }

#     html.scan(/<[^>]+>|[^<]+/) do |token|
#         token.strip!
#         if token.start_with?("<")
#             unless token.start_with?("</")
#                 proceed_tag_opening(current_element, token)
#             else
#                 proceed_tag_closing(current_element, token)
#             end
#         elsif !token.empty?
#             proceed_text(current_element, token)
#         end
        
#     end
# end

# def proceed_tag_opening(current_element, token)
#     puts "Message from proceed_tag_opening:"
#     puts token
#     tag_contains = token[1...-1].split(" ")  #Достаю все, что внутри <>
#     tag_name = tag_contains[0]  #Достает имя тега
#     tag_attributes_array = tag_contains[1..]  #Достает атрибуты тега в виде массива

#     tag_attributes = {}
#     tag_attributes_array.each do |element| 
#         key, value = element.split("=")
#         tag_attributes[key] = value
#     end

#     current_element[:name] = tag_name
#     current_element[:attributes] = tag_attributes
    
# end

# def proceed_tag_closing(current_element, token)
#     puts "Message from proceed_tag_closing:"
#     tag_name = token[2...-1]
#     puts tag_name
# end

# def proceed_text(current_element, token)
#     puts "Message from proceed_text:"
    
#     current_element[:content] = token;
# end

class Tree
    attr_accessor :root
    def initialize(html_string)
        self.root = self.parse_html(html_string)
    end

    def to_s
        return self.root
    end

    def parse_html(html)
        stack = []
        parent_element = nil
    
        html.scan(/<[^>]+>|[^<]+/) do |token|
            token.strip!
            if token.start_with?("<")
                unless token.start_with?("</")
                    parent_element = proceed_tag_opening(stack, token, parent_element)
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
end



# test_tag = Tag.new(name: "h1", attributes: {height: "20px", width: "50px"}, content: "welcome")


html = "<div class='a' id='lol'> Block A </div>"

new_tree = Tree.new(html)

print new_tree
html2 = "
<h1> Welcome </h1>
<div> 
    <p> Paragraph </p>
</div>
"

# parse_html(html)

