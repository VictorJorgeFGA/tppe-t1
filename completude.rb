module Completude
  def self.presence(h)
    h.keys.each do |k|
      if h[k].is_a?(Hash)
        presence(h[k])
      else
        h[k] = !h[k].empty?
      end
    end
  end

  def self.func(h, &block)
    ans = false
    h.values.each do |v|
      if v.is_a?(Hash)
        ans = yield(ans, func(v, &block))
      else
        ans = yield(ans, v)
      end
    end
    ans
  end

  def self.get_completude(json, method = :or)
    presence(json)

    if method == :or
      func(json) do |a,b|
        (a || b)
      end
    else
      func(json) do |a,b|
        (a ^ b)
      end
    end
  end
end