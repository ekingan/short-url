class LinkController < ApplicationController

  def index
  end

  def create
    @link = Link.where(body: params[:body], base_url: request.base_url).first_or_create
    if @link.save!
      render json: { success: true, original_link: @link.body, slug: @link.slug, full_link: @link.full_link}
    else
      render json: { success: false, message: @link.errors.full_messages}
    end
  end
 
  def show
    if @link = Link.find_by(slug: params[:slug])
      redirect_to @link.body
    else
      render json: { success: false, message: @link.errors.full_messages}
    end
  end

  def custom
  end
end
