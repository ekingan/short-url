class LinkController < ApplicationController
  before_action :set_link, only: [:create, :custom]

  def index
    @link = Link.find_by(slug: params[:slug])
    render json: {
      created_at: @link.created_at, 
      total_visits: @link.total_visits,
      visits_per_day: @link.visits_per_day
    }
  end

  def create; end
 
  def show
    if @link = Link.find_by(slug: params[:slug])
      Visit.create(link_id: @link.id)
      redirect_to @link.body
    else
      render json: { success: false, message: @link.errors.full_messages}
    end
  end

  def custom; end

  private

  def set_link
    @slug = params[:slug] || SecureRandom.urlsafe_base64(6)
    @link = Link.where(body: params[:body], slug: @slug, base_url: request.base_url).first_or_create
    @link.save ? success_response : error_response
  end

  def success_response
    render json: 
      { 
        success: true,
        original_link: @link.body, 
        slug: @link.slug, 
        full_link: @link.full_link
      }
  end

  def error_response
    render json: { success: false, message: @link.errors.full_messages}
  end
end
