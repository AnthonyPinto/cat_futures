class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new()
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  def create
    @cat_rental_requests = CatRentalRequest.new(cat_rental_requests_params)
    if @cat_rental_requests.save
      redirect_to cat_url(@cat_rental_requests.cat_id)
    else
      render :new
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
