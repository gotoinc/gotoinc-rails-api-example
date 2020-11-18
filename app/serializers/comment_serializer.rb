class CommentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :content, :event_id, :user_id
end