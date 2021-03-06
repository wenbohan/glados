module Admin
  class SalesTermsAndConditionsDocumentsController < BaseController
    before_action :set_sales_terms_and_conditions_document, only: [:show, :edit, :update, :destroy]

    def index
      @sales_terms_and_conditions_documents = SalesTermsAndConditionsDocument.all
      authorize @sales_terms_and_conditions_documents
    end

    def show
      @legal_policy_document = @sales_terms_and_conditions_document
    end

    def new
      @sales_terms_and_conditions_document = SalesTermsAndConditionsDocument.new
      authorize @sales_terms_and_conditions_document
    end

    def edit
    end

    def create
      @sales_terms_and_conditions_document = SalesTermsAndConditionsDocument.new(sales_terms_and_conditions_document_params)
      authorize @sales_terms_and_conditions_document

      if @sales_terms_and_conditions_document.save
        redirect_to [:admin, @sales_terms_and_conditions_document], notice: %(Saved "#{@sales_terms_and_conditions_document.title}" successfully.)
      else
        render :new
      end
    end

    def update
      if @sales_terms_and_conditions_document.update(sales_terms_and_conditions_document_params)
        redirect_to [:admin, @sales_terms_and_conditions_document], notice: %(Updated "#{@sales_terms_and_conditions_document.title}" successfully.)
      end
    end

    def destroy
      @sales_terms_and_conditions_document.destroy
      redirect_to admin_sales_terms_and_conditions_documents_path, notice: %(Deleted "#{@sales_terms_and_conditions_document.title}" successfully.)
    end

    private

    def set_sales_terms_and_conditions_document
      @sales_terms_and_conditions_document = SalesTermsAndConditionsDocument.find(params[:id])
      authorize @sales_terms_and_conditions_document
    end

    def sales_terms_and_conditions_document_params
      params.require(:sales_terms_and_conditions_document).permit(:title, :body, :effective_on, :file)
    end
  end
end
