# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :authorize_request
end
