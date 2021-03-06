require 'test_helper'

describe WebsitePrivacyPolicyDocumentsController, :locale do
  it "gets index" do
    get website_privacy_policy_documents_path
    must_respond_with :success
  end

  it "gets show" do
    get website_privacy_policy_document_path(website_privacy_policy_documents(:current_website_privacy_policy_document))
    must_respond_with :success
  end
end
