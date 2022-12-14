# frozen_string_literal: true

module Booleans
  module Attachment
    extend ActiveSupport::Concern

    included do
      def changed_for_autosave?
        super || !attachment_changes.empty?
      end
    end

    def correct_file_type?
      file.attached? && file.content_type.in?(
        %w[
          text/csv application/pdf application/vnd.ms-excel
          application/msword application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
          application/vnd.openxmlformats-officedocument.wordprocessingml.document text/plain
          application/vnd.openxmlformats-officedocument.presentationml.presentation
        ]
      )
    end
  end
end
