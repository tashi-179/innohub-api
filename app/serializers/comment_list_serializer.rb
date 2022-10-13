# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  parent_id  :integer
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_book_id  (book_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

class CommentListSerializer < ApplicationSerializer
  attributes(
    :body,
    :parent_id,
    :commentable_id,
    :user_id,
    :commented_at
  )

  attribute :user do |object|
    UserListSerializer.new(object.user)
  end

  attribute :children do |object, params|
    ChildrenListSerializer.new(object.children, params:)
  end
end
