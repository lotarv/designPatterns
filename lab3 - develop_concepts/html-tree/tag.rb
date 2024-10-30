class Tag
    attr_accessor :name, :attributes, :children, :content
    
    def initialize(name:, attributes: {}, children: [], content: "")
      self.name = name
      self.attributes = attributes
      self.children = children
      self.content = content
    end

  
    def opening_tag
      attrs = attributes.map { |key, value| "#{key}=#{value}" }.join(" ") unless attributes.empty?

      return "<#{name} #{attrs}>#{content}</#{name}>"
    end

    def closing_tag
        if self.closing?
            attrs = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ") unless attributes.empty?
            return "</#{name} #{attrs}>"
        end
    end


    def children_count
        children.length
    end

    def add_child(child)
        self.children << child
    end

    def to_s
        return "name: #{self.name}, content: #{self.content}, children: #{self.children}, attributes: #{self.attributes}"
    end

  end
 