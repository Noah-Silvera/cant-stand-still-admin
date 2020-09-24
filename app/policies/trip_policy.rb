class TripPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
    # TODO - logged in
  end

  # TODO - how the heck does scope work
end
