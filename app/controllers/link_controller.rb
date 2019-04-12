class LinkController < ApplicationController

  before_action :set_link, only: [:create, :custom]

  def index
  end

  def create
  end
 
  def show
    if @link = Link.find_by(slug: params[:slug])
      @link.visits += 1
      redirect_to @link.body
    else
      render json: { success: false, message: @link.errors.full_messages}
    end
  end

  def custom
  end

  def set_link
    @slug = params[:slug] || SecureRandom.urlsafe_base64(6)
    @link = Link.where(body: params[:body], slug: @slug, base_url: request.base_url).first_or_create
    if @link.save!
      render json: { success: true, original_link: @link.body, slug: @link.slug, full_link: @link.full_link}
    else
      render json: { success: false, message: @link.errors.full_messages}
    end
  end
end
