class Tag
    attr_accessor :name, :attributes, :children, :content
    
    def initialize(name:, attributes: {}, children: [], content: "")
      self.name = name
      self.attributes = attributes
      self.children = children
      self.content = content
    end
  
    def opening_tag
      attrs = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ") unless attributes.empty?

      return "<#{name} #{attrs}>#{content}</#{name}>"
    end

    def closing_tag
        if self.closing?
            attrs = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ") unless attributes.empty?
            return "</#{name} #{attrs}>"
        end
    end

    def closing?
        return ["img", "input"].member?(name)
    end

    def children_count
        children.length
    end

    def closing?
        ["img", "input"].include?(self.name)
    end

    def add_child(child)
        self.children << child
    end

    def self.parse_attributes(attributes_str)
        attributes = {}
        attributes_str.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value|
            attributes[key] = value
        end
        attributes
    end


  end
 