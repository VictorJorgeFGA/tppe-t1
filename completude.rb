module Completude
  def self.get_completude(json)
    !json.values.first.empty?
  end
end