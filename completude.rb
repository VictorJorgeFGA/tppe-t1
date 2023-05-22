module Completude
  def self.get_completude(json, method = :or)
    is_present = -> (a) do
      !a.empty?
    end

    if method == :or
      json.values.any?(&is_present)
    else
      json.values.map(&is_present).reduce(false) { |a,b| a ^ b }
    end
  end
end