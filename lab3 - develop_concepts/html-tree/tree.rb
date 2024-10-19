require "./tag.rb"
def parse_html(html)
    parent_element = nil
    current_element = {
        name:"",
        content:"",
        attributes:{},
        children:[],
    }

    html.scan(/<[^>]+>|[^<]+/) do |token|
        token.strip!
        if token.start_with?("<")
            unless token.start_with?("</")
                proceed_tag_opening(current_element, token)
            else
                proceed_tag_closing(current_element, token)
            end
        elsif !token.empty?
            proceed_text(current_element, token)
        end
        
    end
end

def proceed_tag_opening(current_element, token)
    puts "Message from proceed_tag_opening:"
    puts token
    tag_contains = token[1...-1].split(" ")  #Достаю все, что внутри <>
    tag_name = tag_contains[0]  #Достает имя тега
    tag_attributes_array = tag_contains[1..]  #Достает атрибуты тега в виде массива

    tag_attributes = {}
    tag_attributes_array.each do |element| 
        key, value = element.split("=")
        tag_attributes[key] = value
    end

    current_element[:name] = tag_name
    current_element[:attributes] = tag_attributes
    
end

def proceed_tag_closing(current_element, token)
    puts "Message from proceed_tag_closing:"
    tag_name = token[2...-1]
    puts tag_name
end

def proceed_text(current_element, token)
    puts "Message from proceed_text:"
    
    current_element[:content] = token;
end


# test_tag = Tag.new(name: "h1", attributes: {height: "20px", width: "50px"}, content: "welcome")


html = "<div class='a' id='lol'> Block A </div>"

html2 = "
<h1> Welcome </h1>
<div> 
    <p> Paragraph </p>
</div>
"

parse_html(html)

