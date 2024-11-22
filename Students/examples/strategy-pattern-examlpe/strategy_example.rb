#Интерфейс стратегии

class TaxStrategy
    def calculate_tax(amount)
        raise NotImplementedError
    end
end

#Конкретные стратегии
class RegularTax < TaxStrategy
    def calculate_tax(amount)
        return amount * 0.13
    end
end

class ReducedTax < TaxStrategy
    def calculate_tax(amount)
        return amount * 0.06
    end
end

class NoTax < TaxStrategy
    def calculate_tax(amount)
        return 0
    end
end

class ShoppingCart
    def initialize(tax_strategy)
        @tax_strategy = tax_strategy
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def total
        return @items.sum
    end

    def calculate_tax()
        @tax_strategy.calculate_tax(total)
    end
end

cart = ShoppingCart.new(RegularTax.new)

cart.add_item(100)
cart.add_item(200)

puts cart.calculate_tax()