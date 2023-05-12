# frozen_string_literal: true

# Active model - not database backed for now
class ScalingFactor
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON # needs to be stored in http session

  attr_reader :value

  def attributes
    { 'value' => value }
  end

  def value=(val)
    @value = val.to_f if val.to_i != 0
  end

  class << self
    def from_session(session)
      session[:scaling_factor] ||= new.to_json
      new(JSON.parse(session[:scaling_factor]))
    end
  end

  def save_in_session(session)
    session[:scaling_factor] = to_json
  end
end
