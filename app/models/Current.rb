#This pattern allows us to use the power of a model for the object needs instead of the user object itself so that it can be independently accessed.

class Current < ActiveSupport::CurrentAttributes
  attribute :user
end