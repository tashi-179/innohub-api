# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id            :bigint           not null, primary key
#  clipable_type :string           not null
#  default       :boolean          default(FALSE)
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  clipable_id   :bigint           not null
#
# Indexes
#
#  index_videos_on_clipable_type_and_clipable_id  (clipable_type,clipable_id)
#

class VideoSerializer < ApplicationSerializer
  attributes(
    :id,
    :filename,
    :byte_size,
    :default
  )

  attribute :clip_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.clip) if object.clip.attached?
  end
end
