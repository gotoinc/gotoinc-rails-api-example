class BaseInteraction < ActiveInteraction::Base
  include InteractionErrors

  class << self
    def serialize_with(serializer)
      @serializer = serializer
    end

    def get_serializer
      @serializer || (superclass.get_serializer if superclass.respond_to? :get_serializer)
    end
  end

  delegate :get_serializer, to: 'self.class'

  def run
    raise InteractionArgumentError.new errors unless valid?
    self.result = begin
      res = execute
      errors.any? ? errors : serialize_result(res)
    rescue Interrupt => e
      merge_errors_onto_base(e.outcome.errors)
    end
  end

  def serialize_result(res)
    if res.is_a?(InteractionResult)
      if get_serializer
        options = res.meta ? {meta: res.meta} : nil
                
        get_serializer.new(res.data, options).serializable_hash
      else
        res.data
      end
    else
      res
    end
  end
end
