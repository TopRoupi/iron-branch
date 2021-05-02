# frozen_string_literal: true

json.array! @investments, partial: "investments/investment", as: :investment
