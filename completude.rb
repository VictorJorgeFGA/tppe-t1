module Completude
  def self.get_completude(json)
    if json.values.size == 1
      !json.values.first.empty?
    elsif json.values.size == 2
      (!json.values.first.empty?) || (!json.values[1].empty?)
    else
      (!json.values.first.empty?) || (!json.values[1].empty?) || (!json.values[2].empty?)
    end
  end
end