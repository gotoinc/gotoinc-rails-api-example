class Api::V1::ConversationsController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Conversations', %w[index create show destroy])
  end

  def create_message
    run_interaction Api::V1::Conversations::CreateMessage
  end
end