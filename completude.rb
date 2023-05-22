module Completude
  def self.get_completude(json)
    if json.values.size == 1
      !json.values.first.empty?
    else
      (!json.values.first.empty?) || (!json.values[1].empty?)
    end
  end
end