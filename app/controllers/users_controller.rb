class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    query = params[:search_query]
    if query.present?
      @users = User.where('username LIKE ?', "%#{query}%")
    else
      @users = []
    end

    if turbo_frame_request?
      render partial: "layouts/search_results", locals: { users: @users }
    end
  end

  def show

  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
