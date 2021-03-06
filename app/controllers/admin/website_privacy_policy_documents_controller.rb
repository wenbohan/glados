module Admin
  class WebsitePrivacyPolicyDocumentsController < BaseController
    before_action :set_website_privacy_policy_document, only: [:show, :edit, :update, :destroy]

    def index
      @website_privacy_policy_documents = WebsitePrivacyPolicyDocument.all
      authorize @website_privacy_policy_documents
    end

    def show
      @legal_policy_document = @website_privacy_policy_document
    end

    def new
      @website_privacy_policy_document = WebsitePrivacyPolicyDocument.new
      authorize @website_privacy_policy_document
    end

    def edit
    end

    def create
      @website_privacy_policy_document = WebsitePrivacyPolicyDocument.new(website_privacy_policy_document_params)
      authorize @website_privacy_policy_document

      if @website_privacy_policy_document.save
        redirect_to [:admin, @website_privacy_policy_document], notice: %(Saved "#{@website_privacy_policy_document.title}" successfully.)
      else
        render :new
      end
    end

    def update
      if @website_privacy_policy_document.update(website_privacy_policy_document_params)
        redirect_to [:admin, @website_privacy_policy_document], notice: %(Updated "#{@website_privacy_policy_document.title}" successfully.)
      end
    end

    def destroy
      @website_privacy_policy_document.destroy
      redirect_to admin_website_privacy_policy_documents_path, notice: %(Deleted "#{@website_privacy_policy_document.title}" successfully.)
    end

    private

    def set_website_privacy_policy_document
      @website_privacy_policy_document = WebsitePrivacyPolicyDocument.find(params[:id])
      authorize @website_privacy_policy_document
    end

    def website_privacy_policy_document_params
      params.require(:website_privacy_policy_document).permit(:title, :body, :effective_on)
    end
  end
end
