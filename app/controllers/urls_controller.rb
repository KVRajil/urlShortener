class UrlsController < ApplicationController
  before_action :authenticate_user!, except: [:goto_url]
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  def index
    @urls = current_user.urls.active
    @api = current_user.user_apis.first
  end

  def goto_url
    url = Url.where(shortened_url:params[:shortened_url]).first
    if url
      redirect_to url.original_url
    else
      redirect_to '/'
    end
  end

  def show
  end

  def new
    @url = Url.new
  end

  def edit
  end

  def create
    @url = Url.new(url_params)
    @url.user_id = current_user.id

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Url was successfully created.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
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
end
