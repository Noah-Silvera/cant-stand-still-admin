# frozen_string_literal: true

class BlueButtonComponent < ViewComponent::Base
  def initialize(link: nil, text: nil)
    @text = text
    @link = link
  end
end
