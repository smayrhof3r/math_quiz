require_relative 'question'

class Table
  def initialize(attributes = {})
    @range = attributes[:range]
    @count = attributes[:count]
    binding.pry
    create_table
  end

  def pick
    @table.pop
  end

  def return(question)
    @table << question
  end

  def empty?
    @table.empty?
  end

  private

  def create_table
    @table = []
    @range.each do |col|
      (1..10).each { |row| @table << Question.new(one: row, two: col) }
    end
    @table.flatten!
    @table.shuffle!
    @count == "20" ? @table.sample(20) : @table
  end
end
