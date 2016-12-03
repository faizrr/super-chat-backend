class UsersController < ApplicationController
  before_action :authenticate_user

  def profile
    render json: current_user, except: %w(id auth0_id created_at updated_at)
  end
end
