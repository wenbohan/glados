module Admin
  class ProductCategoriesController < BaseController
    before_action :set_product_category, only: [:edit, :update, :destroy]

    def index
      @product_categories = ProductCategory.includes(:product_type)
      authorize @product_categories
    end

    def show
      @product_category = ProductCategory.includes(:products).find(params[:id])
      authorize @product_category
    end

    def new
      @product_category = ProductCategory.new
      authorize @product_category
    end

    def edit
    end

    def create
      @product_category = ProductCategory.new(product_category_params)
      authorize @product_category

      if @product_category.save
        redirect_to admin_product_categories_path, notice: %(Saved "#{@product_category.name}" successfully.)
      else
        render :new
      end
    end

    def update
      if @product_category.update(product_category_params)
        redirect_to admin_product_categories_path, notice: %(Updated "#{@product_category.name} successfully.")
      else
        render :edit
      end
    end

    def destroy
      @product_category.destroy
      redirect_to admin_product_categories_path, notice: %(Deleted #{@product_category.name} successfully.)
    end

    def sort
      params[:product_category].each_with_index do |id, index|
        ProductCategory.where(id: id).update_all({position: index + 1})
      end
      head :no_content
    end

    private

    def set_product_category
      @product_category = ProductCategory.find(params[:id])
      authorize @product_category
    end

    def product_category_params
      params.require(:product_category).permit(:name, :description, :hero_image, :icon_image, :product_type_id)
    end
  end
end
