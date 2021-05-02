# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  delegate :dom_id, to: :helpers
  include ApplicationHelper
end
