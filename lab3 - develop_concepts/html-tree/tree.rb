require "./tag.rb"
def parse_html(html)
    current_element = {
        name:"",
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



    print tag_name, tag_attributes
end

def proceed_tag_closing(current_element, token)
    puts "Message from proceed_tag_closing:"
    tag_name = token[2...-1]
    puts tag_name
end

def proceed_text(current_element, token)
    puts "Message from proceed_text:"
    
    puts token
end



html = "<div class='a' id='lol'> Block A </div>"

html2 = "
<h1> Welcome </h1>
<div> 
    <p> Paragraph </p>
</div>
"

parse_html(html)
