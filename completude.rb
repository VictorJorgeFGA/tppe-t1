module Completude
  def self.is_empty?(h)
    if h.is_a?(Hash)
      ans = true
      h.keys.each do |k|
        ans = ans && is_empty?(h[k])
      end
      ans
    else
      h.empty?
    end
  end

  def self.get_completude(json, method = :or)
    is_present = -> (a) do
      !is_empty?(a)
    end

    if method == :or
      json.values.any?(&is_present)
    else
      json.values.map(&is_present).reduce(false) { |a,b| a ^ b }
    end
  end
end