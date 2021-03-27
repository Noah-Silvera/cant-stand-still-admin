# frozen_string_literal: true

class NavLinkComponent < ViewComponent::Base
  def initialize(link:, text:, classStr: "")
    @link = link
    @text = text
    @classStr = classStr
  end

  def before_render
    if request.path == @link
      @is_active = true
    end
  end
end
