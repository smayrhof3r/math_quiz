class Question
  attr_reader :one, :two, :answer

  def initialize(attributes = {})
    @one = attributes[:one]
    @two = attributes[:two]
    @answer = @one * @two
  end

  def correct_answer? (user_response)
    @answer == user_response
  end
end
