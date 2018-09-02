class UserApisController < ApplicationController
  before_action :authenticate_user!

  def create
    @api = current_user.user_apis.first_or_create

    respond_to do |format|
      format.js
    end
  end

end