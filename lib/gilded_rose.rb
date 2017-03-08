class GildedRose

  def initialize(items)
    @items = items
    @unique_items = %i{backstage sulfuras brie}
  end

  def update_quality
    @items.each do |item|
      name = item.name.downcase
      match = @unique_items.select{ |x| name.match(x.to_s) }.join.to_sym
      next if match == :sulfuras
      match.empty? ? normal(item) : send(match, item)
    end
  end

  def backstage(item)
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in <= 0
    return if item.quality == 50
    item.sell_in <= 10 ? item.quality += 2 : item.quality += 1
    item.quality += 1 if item.sell_in <= 5
  end

  def brie(item)
    item.sell_in -= 1
    return if item.quality == 50
    item.sell_in <= 0 ? item.quality += 2 : item.quality += 1
  end

  def normal(item)
    item.sell_in -= 1
    item.sell_in <= 0 ? item.quality -= 2 : item.quality -= 1
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
