module DeviseTokenAuth::Concerns::ActiveRecordSupport
  extend ActiveSupport::Concern

  included do
    serialize :tokens, TokensSerialization
  end

  class_methods do
    # It's abstract replacement .find_by
    def dta_find_by(attrs = {})
      find_by(attrs)
    end
  end
end

class TokensSerialization
  # Serialization hash to json
  def self.dump(object)
    object.each_value(&:compact!) unless object.nil?
    JSON.generate(object)
  end

  # Deserialization json to hash
  def self.load(json)
    case json
    when String
      JSON.parse(json)
    when NilClass
      {}
    else
      json
    end
  end
end