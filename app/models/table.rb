require_relative 'question'

class Table
  def initialize(attributes = {})
    @range = attributes[:range]
    @count = attributes[:count]
    create_table
  end

  def pick
    @table.pop
  end

  def return(question)
    @table << question
    @table.shuffle!
  end

  def empty?
    @table.empty?
  end

  def size
    @table.size
  end

  private

  def create_table
    @table = []
    @range.each do |col|
      (1..10).each { |row| @table << Question.new(one: row, two: col) }
    end
    @table.flatten!
    @table.shuffle!
    @table = @table.first(5) unless @count == "all"
  end
end
