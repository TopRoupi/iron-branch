# frozen_string_literal: true

class Companies::Tree::Component < ApplicationComponent
  def initialize(company)
    @matrix = company.investments_matrix
  end
end
