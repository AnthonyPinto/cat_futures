class CatRentalRequestsController < ApplicationController
  before_action :require_login
  before_action :users_cat?, only: [:approve, :deny]
  
  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new()
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id]).includes(:user)
  end

  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_requests_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      redirect_to new_cat_rental_request_url
    end
  end
  
  def approve
    puts "APPROVE" + "*" * 500
    cat_rental_request = CatRentalRequest.find(params[:id])
    cat_rental_request.approve!
    redirect_to cat_url(cat_rental_request.cat_id)
  end
  
  def deny
    puts "DENY" + "*" * 500
    cat_rental_request = CatRentalRequest.find(params[:id])
    cat_rental_request.deny!
    redirect_to cat_url(cat_rental_request.cat_id)
  end
  
  def users_cat?
     @cat_rental_request = CatRentalRequest.find(params[:id])
     cat = @cat_rental_request.cat
    unless cat && cat.user_id == current_user.id
      redirect_to cat_url(cat)
    end
  end
  
  private
  def cat_rental_requests_params
    params.require(:cat_rental_request).permit(
      :cat_id,
      :start_date,
      :end_date,
      :status
    )
  end
end
