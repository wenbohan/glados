module Admin
  class WebsiteTermsOfUseDocumentsController < BaseController
    before_action :set_website_terms_of_use_document, only: [:show, :edit, :update, :destroy]

    def index
      @website_terms_of_use_documents = WebsiteTermsOfUseDocument.all
      authorize @website_terms_of_use_documents
    end

    def show
      @legal_policy_document = @website_terms_of_use_document
    end

    def new
      @website_terms_of_use_document = WebsiteTermsOfUseDocument.new
      authorize @website_terms_of_use_document
    end

    def edit
    end

    def create
      @website_terms_of_use_document = WebsiteTermsOfUseDocument.new(website_terms_of_use_document_params)
      authorize @website_terms_of_use_document

      if @website_terms_of_use_document.save
        redirect_to [:admin, @website_terms_of_use_document], notice: %(Saved "#{@website_terms_of_use_document.title}" successfully.)
      else
        render :new
      end
    end

    def update
      if @website_terms_of_use_document.update(website_terms_of_use_document_params)
        redirect_to [:admin, @website_terms_of_use_document], notice: %(Updated "#{@website_terms_of_use_document.title}" successfully.)
      end
    end

    def destroy
      @website_terms_of_use_document.destroy
      redirect_to admin_website_terms_of_use_documents_path, notice: %(Deleted "#{@website_terms_of_use_document.title}" successfully.)
    end

    private

    def set_website_terms_of_use_document
      @website_terms_of_use_document = WebsiteTermsOfUseDocument.find(params[:id])
      authorize @website_terms_of_use_document
    end

    def website_terms_of_use_document_params
      params.require(:website_terms_of_use_document).permit(:title, :body, :effective_on)
    end
  end
end
