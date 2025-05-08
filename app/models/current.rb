# frozen_string_literal: true

# -----------------------------------------------------------------------------
#  A tiny wrapper that lets us keep per–request global values (e.g. Current.user)
#  without resorting to thread-locals or class variables.
# -----------------------------------------------------------------------------
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end

