# frozen_string_literal: true

module Scopes
  module User
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        where(
          "CONCAT_WS(' ', email, username, phone) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_roles, ->(roles) { joins(:roles).where(roles: { id: roles }) }
      scope :filter_by_status, ->(status) { where(active: status) }
    end
  end
end
