class SalesRegionPolicy < ApplicationPolicy
  def index?
    user && user.has_any_role?(:admin, :sales_region_manager)
  end

  def show?
    user && user.has_any_role?(:admin, :sales_region_manager)
  end

  def create?
    user && user.has_any_role?(:admin, :sales_region_manager)
  end

  def update?
    user && user.has_any_role?(:admin, :sales_region_manager)
  end

  def destroy?
    user && user.has_any_role?(:admin, :sales_region_manager)
  end
end
