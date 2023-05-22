module Completude
  def self.get_completude(json)
    json.values.any? { |value| !value.empty? }
  end
end