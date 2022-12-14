# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        before_action :configure_account_update_params, only: :update
        before_action :configure_account_create_params, only: :create

        protected

        def configure_account_update_params
          devise_parameter_sanitizer.permit(:account_update, keys: user_attributes)
        end

        def configure_account_create_params
          devise_parameter_sanitizer.permit(:sign_up, keys: user_attributes)
        end

        def respond_with(resource, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: UserSerializer.new(resource, include: %i[roles])
          end
        end
      end
    end
  end
end
