module Admin
  class FeaturesController < BaseController
    before_action :set_feature, only: [:show, :edit, :update, :destroy]
    before_action :set_product_types, only: [:new, :edit]

    def index
      @features = Feature.all
      authorize @features
    end

    def show
    end

    def new
      @feature = Feature.new
      authorize @feature
    end

    def edit
    end

    def create
      @feature = Feature.new(feature_params)
      authorize @feature

      if @feature.save
        redirect_to [:admin, @feature], notice: %(Saved "#{@feature.title}" successfully.)
      else
        set_product_types
        render :new
      end
    end

    def update
      if @feature.update(feature_params)
        redirect_to [:admin, @feature], notice: %(Updated "#{@feature.title}" successfully.)
      else
        set_product_types
        render :edit
      end
    end

    def destroy
      @feature.destroy
      redirect_to admin_features_path, notice: %(Deleted "#{@feature.title}" successfully.)
    end

    private

    def set_feature
      @feature = Feature.find(params[:id])
      authorize @feature
    end

    def feature_params
      params.require(:feature).permit(:title, :description, :youtube_video_id, :hero_image, :remove_hero_image, :body, :tag_list, product_ids: [])
    end

    def set_product_types
      @product_types = ProductType.includes(:products).reorder(:position).order('products.name')
    end
  end
end
