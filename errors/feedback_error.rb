# Custom error class for friendly errors
class FeedbackError < StandardError
  attr_accessor :message

  def initialize(message)
    @message = message
  end
end
