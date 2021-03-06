module Admin
  class KnowledgeBaseArticlesController < BaseController
    before_action :set_knowledge_base_article, only: [:show, :edit, :update, :destroy]
    before_action :set_product_types, only: [:new, :edit]
    before_action :set_taggable_items, only: [:new, :edit]

    def index
      @knowledge_base_articles = KnowledgeBaseArticle.order(:title)
      authorize @knowledge_base_articles
    end

    def show
      @article = @knowledge_base_article
      render 'knowledge_base_articles/show'
    end

    def new
      @knowledge_base_article = KnowledgeBaseArticle.new
      authorize @knowledge_base_article
    end

    def edit
    end

    def create
      @knowledge_base_article = KnowledgeBaseArticle.new(knowledge_base_article_params)
      authorize @knowledge_base_article

      if @knowledge_base_article.save
        redirect_to [:admin,@knowledge_base_article], notice: %(Saved "#{@knowledge_base_article.title}" successfully.)
      else
        set_product_types
        render :new
      end
    end

    def update
      if @knowledge_base_article.update(knowledge_base_article_params)
        redirect_to [:admin,@knowledge_base_article], notice: %(Updated "#{@knowledge_base_article.title}" successfully.)
      else
        set_product_types
        render :edit
      end
    end

    def destroy
      @knowledge_base_article.destroy
      redirect_to admin_knowledge_base_articles_path, notice: %(Deleted "#{@knowledge_base_article.title}" successfully.)
    end

    private

    def set_knowledge_base_article
      @knowledge_base_article = KnowledgeBaseArticle.find(params[:id])
      authorize @knowledge_base_article
    end

    def knowledge_base_article_params
      params.require(:knowledge_base_article).permit(:title, :subtitle, :body, :posted_on, :tag_list, product_ids: [])
    end

    def set_product_types
      @product_types = ProductType.includes(:products).reorder(:position).order('products.name')
    end

    def set_taggable_items
      @taggable_items = Tag.pluck(:name)
    end

  end
end
