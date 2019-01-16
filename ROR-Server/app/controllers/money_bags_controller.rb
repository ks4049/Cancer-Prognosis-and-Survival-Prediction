class MoneyBagsController < ApplicationController
  before_action :set_money_bag, only: [:show, :update, :destroy]

  # GET /money_bags
  def index
    @money_bags = MoneyBag.all

    render json: @money_bags
  end

  # GET /money_bags/1
  def show
    render json: @money_bag
  end

  # POST /money_bags
  def create
    @money_bag = MoneyBag.new(money_bag_params)

    if @money_bag.save
      render json: @money_bag, status: :created, location: @money_bag
    else
      render json: @money_bag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /money_bags/1
  def update
    if @money_bag.update(money_bag_params)
      render json: @money_bag
    else
      render json: @money_bag.errors, status: :unprocessable_entity
    end
  end

  def getBagId
    @bag_details=MoneyBag.where(:user_id=>params[:user_id]).first
    render json: @bag_details
  end
  # DELETE /money_bags/1
  def destroy
    @money_bag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_money_bag
      @money_bag = MoneyBag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def money_bag_params
      params.fetch(:money_bag, {})
      params.require(:money_bag).permit(:user_id, :available_credit, :expenses)
    end
end
