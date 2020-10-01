# frozen_string_literal: true

# This thread is to ignore Documentation offense
module Valid
  def valid?
    validate!
  rescue StandardError
    false
  end
end
