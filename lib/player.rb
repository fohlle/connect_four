
class Player

  attr_accessor :icon
  attr_reader :name

  def initialize(name,icon = nil)
    @name = name
    @icon = icon
  end

end