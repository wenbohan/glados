require 'test_helper'

class ProductCategoryPolicyTest < ActiveSupport::TestCase
  let(:product_category) { product_categories(:arterial) }
  let(:user) { users(:generic_user) }

  describe "for authorized user" do
    [:admin, :product_category_manager].each do |role|
      before do
        user.add_role role
      end

      it "permits index" do
        :product_category.must_permit user, :index
      end

      it "permits show" do
        product_category.must_permit user, :show
      end

      it "permits new" do
        product_category.must_permit user, :new
      end

      it "permits create" do
        product_category.must_permit user, :create
      end

      it "permits edit" do
        product_category.must_permit user, :edit
      end

      it "permits update" do
        product_category.must_permit user, :update
      end

      it "permits destroy" do
        product_category.must_permit user, :destroy
      end
    end
  end

  describe "for unauthorized user" do
    it "prohibits index" do
      :product_category.wont_permit user, :index
    end

    it "prohibits show" do
      product_category.wont_permit user, :show
    end

    it "prohibits new" do
      product_category.wont_permit user, :new
    end

    it "prohibits create" do
      product_category.wont_permit user, :create
    end

    it "prohibits edit" do
      product_category.wont_permit user, :edit
    end

    it "prohibits update" do
      product_category.wont_permit user, :update
    end

    it "prohibits destroy" do
      product_category.wont_permit user, :destroy
    end
  end

  describe "for guest" do
    it "prohibits index" do
      :product_category.wont_permit nil, :index
    end

    it "prohibits show" do
      product_category.wont_permit nil, :show
    end

    it "prohibits new" do
      product_category.wont_permit nil, :new
    end

    it "prohibits create" do
      product_category.wont_permit nil, :create
    end

    it "prohibits edit" do
      product_category.wont_permit nil, :edit
    end

    it "prohibits update" do
      product_category.wont_permit nil, :update
    end

    it "prohibits destroy" do
      product_category.wont_permit nil, :destroy
    end
  end
end
