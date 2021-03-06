# keeps track of the game state
class Score
  attr_accessor :question
  attr_reader :mistakes, :status, :message, :score, :question_count

  def initialize(table)
    @table = table
    @question_index = 0
    @mistakes = 0
    @score = 0
    @question_count = table.size
    create_status
    @message = "let's do this!"
  end

  def correct?(answer)
    check = @question.correct_answer?(answer)
    check ? updates_correct : updates_wrong
    check
  end

  def next_question
    @question = @table.pick
  end

  def last_question?
    @table.empty?
  end

  private

  def updates_correct
    @message = ['Go go go!', 'You got this!', 'Keep it up!'].sample
    @score += 10
    if @question_count < 50
      @status[@question_index] = ['đ¤', 'đ', 'đ', 'đ', 'đ', 'đ¤', 'đĨŗ', 'đ¤Š'].sample unless @status[@question_index] == 'đĨ'
    else
      @status = "#{@question_index + 1} / #{@question_count}"
    end
    @question_index += 1
  end

  def updates_wrong
    @mistakes += 1
    @question_count += 1
    @table.return(@question)
    @score -= 2
    @message = ['Try again!', 'Not quite!', 'Oops...!'].sample
    update_status
  end

  def update_status
    if @question_count < 50
      @status[@question_index] = ['đĨ', 'đĨē', 'đĩ', 'đĨ´', 'âšī¸', 'đ', 'đĻ'].sample
      @status += 'đ'
    else
      @status = "#{@question_index} / #{@question_count}"
    end
  end

  def create_status
    @status = @table.size < 50 ? 'đ' * @table.size : "0 / #{@table.size}"
  end
end
