require 'csv'

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  #after_create :sum_cost


  # p-17
  def approve
    render json: params
  end

  # p-18
  def calc
    render plain: rand(100).to_s
  end

  # p-19
  def first
    @order = Order.first
    render :show
  end

  # p-31
  def sum_cost
    prices = {sas: 100, sata: 200, ssd: 300, ram:150, cpu: 1000}
    cost = 0
    (0...@order.options.length).step(2).each do |i|
      cost += prices[i] * @order.options[i+1]
    end
    @order.cost = cost
  end

  # GET /orders or /orders.json
  # p-32
  def index
    per_page = 30 
    per_page = params[:per_page].to_i if params[:per_page]
    @orders = Order.limit(per_page).offset(per_page * params[:page].to_i).order('id DESC')
  end

  # GET /orders/1 or /orders/1.json
  def show
    @orders = Order.all
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :status, :cost)
  end
end
