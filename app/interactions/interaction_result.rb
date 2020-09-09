class InteractionResult
  attr_reader :data, :meta

  def initialize(data, meta = {})
    @data = data
    @meta = meta
  end
end
