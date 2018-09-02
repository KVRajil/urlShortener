module Api::V1
  class UrlsController < ApplicationController
  before_action :check_api_valid
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  def index
    @urls = current_user.urls.active
    respond_to do |format|
      format.json { render json:@urls }
    end
  end

  def show
  end

  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.json { render json: @url }
      else
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @url.update(url_params)
        format.json { render json: @url }
      else
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @url.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  def set_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end

  def check_api_valid
    if params[:key].present?
      @api = UserApi.find_by_key(params[:key])
      @user = @api.user
    end
    if @api.nil? || @user.nil?
      render nothing: true, status: 401
    end
  end

  end
end