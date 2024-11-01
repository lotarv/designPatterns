require "./student.rb"
class TreeNode
    attr_accessor :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end

class BinarySearchTree

    include Enumerable

    def initialize
        @root = nil
    end

    def insert(value)
        if @root.nil?
            @root = TreeNode.new(value)
        else
            insert_rec(@root, value)
        end
    end

    def insert_rec(node, value)
        if value > node.value
            if node.right == nil
                node.right = TreeNode.new(value)
            else
                insert_rec(node.right, value)
            end
        else 
            if node.left == nil
                node.left = TreeNode.new(value)
            else
                insert_rec(node.left, value)
            end
        end
    end

    def print_tree(node = @root)
        return if node.nil?
        print_tree(node.left)
        puts node.value
        print_tree(node.right)
    end

    # Реализация метода each для модуля Enumerable
    def each(&block)
        traverse_in_order(@root, &block)
    end

    def traverse_in_order(node, &block)
        return if node.nil?
        traverse_in_order(node.left, &block)
        block.call(node.value)
        traverse_in_order(node.right, &block)
    end
end
