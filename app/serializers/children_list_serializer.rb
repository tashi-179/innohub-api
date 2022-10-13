# frozen_string_literal: true

class ChildrenListSerializer < ApplicationSerializer
  attributes(
    :text,
    :parent_id,
    :commentable_id,
    :user_id,
    :commented_at
  )

  attribute :user do |object|
    UserListSerializer.new(object.user)
  end
end
