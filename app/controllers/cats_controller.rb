class CatsController < ApplicationController
  # helper_method :users_cat?
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :users_cat?, only: [:edit, :update]
  
  def index
    @cats = Cat.all
  end
  
  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.rental_requests.order(:start_date)
  end
  
  def new
    @cat = Cat.new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def users_cat?
    @cat = Cat.find(params[:id])
    unless @cat && current_user.id == @cat.user_id
      redirect_to cat_url(@cat)
    end
  end
  
  private
  def cat_params
    params.require(:cat).permit(
      :age,
      :birth_date,
      :color,
      :name,
      :sex,
      :description)
  end
end
