# frozen_string_literal: true

require 'climate_control'

module EnvironmentSupport
  def with_modified_env(options = {}, &)
    ::ClimateControl.modify(options, &)
  end
end
