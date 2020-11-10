# frozen_string_literal: true

class ApiController < ApplicationController
  class_attribute :resource_class
  before_action :authorize_request

  def create
    resource = resource_class.create!(create_params)
    render_created(resource)
  end

  def destroy
    resource = resource_class.find_by!(search_params)

    authorize resource, :owner?

    resource.destroy!

    render_destroyed
  end

  def index
    render_ok(resource_class.where(user: current_user))
  end

  def show
    resource = resource_class.find_by!(search_params)

    authorize resource, :owner?

    render_ok(resource)
  end

  def update
    resource = resource_class.find_by!(search_params)

    authorize resource, :owner?

    resource.update!(update_params)

    render_ok(resource)
  end
end
