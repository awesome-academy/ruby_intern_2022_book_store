class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :init_order, only: :create
  before_action :load_user_id, only: :index

  def index
    @pagy, @orders = pagy Order.all.where("user_id = #{@user_id}").order_newest
  end

  def index; end

  def new
    @order = Order.new
  end

  def create
    @cart = session[:cart]
    @cart.each do |line_item|
      @order.order_details.build(
        quantity: line_item["quantity"],
        book_detail_id: line_item["book_id"]
      )
    end
    @order.save!
    session[:cart] = []
    flash[:success] = t "success"
    redirect_to root_url
  rescue ActiveRecord::RecordNotSaved => e
    handle_exception e
  end

  private
  def init_order
    @order = current_user.orders.new order_params
  end

  def order_params
    params.require(:order).permit :name, :receiver,
                                  :phone, :address_id, :discount_id
  end

  def handle_exception exception
    log exception
    flash.now[:danger] = t "error"
    redirect_to root_url
  end

  def load_user_id
    @user_id = current_user.id
  end
end
