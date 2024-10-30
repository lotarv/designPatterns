class TreeNode
    attr_accessor :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end

class BinarySearchTree
    attr_accessor :root
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

        puts node.value
        print_tree(node.right)
        print_tree(node.left)
    end
end

bst = BinarySearchTree.new();

bst.insert(6)
bst.insert(8)
bst.insert(9)
bst.insert(4)

print bst.print_tree