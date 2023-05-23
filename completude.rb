module Completude
  def self.get_completude(json, method = :or)
    set_attrs_presence(json)

    if method == :or
      apply_operator(json) { |a,b|  (a || b) }
    else
      apply_operator(json) { |a,b| (a ^ b) }
    end
  end

  private

  def self.set_attrs_presence(data)
    if data.is_a?(Array)
      data.each_with_index do |value, index|
        if value.is_a?(Array) || value.is_a?(Hash)
          set_attrs_presence(value)
        else
          data[index] = !value.empty?
        end
      end
    elsif data.is_a?(Hash)
      data.each do |key, value|
        if value.is_a?(Array) || value.is_a?(Hash)
          set_attrs_presence(value)
        else
          data[key] = !value.empty?
        end
      end
    else
      !data.empty?
    end
  end

  def self.apply_operator(data, &block)
    ans = false
    (data.is_a?(Hash) ? data.values : data).each do |value|
      if value.is_a?(Hash) || value.is_a?(Array)
        ans = yield(ans, apply_operator(value, &block))
      else
        ans = yield(ans, value)
      end
    end

    ans
  end
end