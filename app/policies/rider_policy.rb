class RiderPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  # TODO - how the heck does scope work
end
