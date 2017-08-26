module BitmapCommandValidator
  def validate_i_command_inputs(line_args)
    m_value = line_args[1].to_i
    n_value = line_args[2].to_i

    # The bitmap column value and row value should fall with 1 and 250
    if m_value < 0 || m_value > 255
      raise FeedbackError.new 'M value should be between 1 and 250'
    end

    if n_value < 0 || n_value > 255
      raise FeedbackError.new 'N value should be between 1 and 250'
    end

    # Return the validated values.
    [m_value, n_value]
  end
end
