module Admin
  class DealersController < BaseController
  	before_action :set_dealer, only: [:edit, :show, :update, :destroy]

    def index
      @dealers = Dealer.all
      authorize @dealers
    end

    def show
    end

    def new
      @dealer = Dealer.new
      authorize @dealer
    end

    def edit
    end

    def create
      @dealer = Dealer.new(dealer_params)
      authorize @dealer

      if @dealer.save
        redirect_to admin_dealers_path, notice: %(Saved "#{@dealer.name}" successfully.)
      else
        render :new
      end
    end

    def update
      if @dealer.update(dealer_params)
        redirect_to admin_dealer_path(@dealer), notice: %(Updated "#{@dealer.name}" successfully.)
      else
        render :edit
      end
    end

    def destroy
      @dealer.destroy
      redirect_to admin_dealers_path, notice: %(Deleted "#{@dealer.name}" successfully.)
    end

    private

    def set_dealer
      @dealer = Dealer.find(params[:id])
      authorize @dealer
    end

    def dealer_params
      params.require(:dealer).permit(:name, :address, :locality, :region, :postal_code, :country_id, :phone, :email, :website)
    end
  end
end
