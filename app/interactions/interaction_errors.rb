module InteractionErrors
  class InteractionArgumentError < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def first_error
      {
        message: errors.full_messages.join(', ')
      }
    end
  end
end
