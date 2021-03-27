# frozen_string_literal: true

class NavLinkComponent < ViewComponent::Base
  def initialize(link:, text:, classStr: "")
    @link = link
    @text = text
    @classStr = classStr
  end
end
