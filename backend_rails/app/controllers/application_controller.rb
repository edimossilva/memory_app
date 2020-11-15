# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Auth::JsonWebTokenHelper
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  def render_created(entity)
    render json: { data: serialize_data(entity) }, status: :created
  end

  def render_destroyed
    render json: {}, status: :no_content
  end

  def render_not_found(exception)
    render json: { error_message: exception.message }, status: :not_found
  end

  def render_ok(entity)
    render json: { data: serialize_data(entity) }, status: :ok
  end

  def render_list_ok(entity)
    render json: { data: serialize_data(entity) }, status: :ok
  end

  def render_unauthorized(message = 'Unauthorized')
    render json: { error_message: message }, status: :unauthorized
  end

  def render_unprocessable_entity(exception)
    render json: { error_message: exception.message }, status: :unprocessable_entity
  end

  def search_params
    params.permit(:id)
  end

  private

  def serialize_data(entity)
    if entity.instance_of?(Array) || entity.instance_of?(ActiveRecord::Relation)
      entity.map(&:serialize)
    else
      entity.serialize
    end
  end
end
