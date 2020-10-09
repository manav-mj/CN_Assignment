class Event < ApplicationRecord
  enum type: [:accepted, :escalated, :resolved]
end
