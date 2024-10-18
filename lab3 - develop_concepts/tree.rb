require "./tag.rb"
def parse_html(html)
    current_element = {
        name:,
        attributes:{},
        children:[],
    }
    html.scan(/<[^>]+>|[^<]+/) do |token|
        
    end
end


html = "
<h1> Welcome </h1>
<div> 
    <p> Paragraph </p>
</div>
"

parse_html(html)
