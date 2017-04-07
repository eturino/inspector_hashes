module InspectorHashes

  # `InspectorHashes.diff(a, b)` will return:
  # - nil (if equal)
  # - if given simple objects, a single difference object:
  #   ```
  #     { where: '', a: a, b: b }
  #   ```
  # - if a hash or an array: the array of differences.
  class Inspector
    attr_accessor :a, :b, :in_a, :in_b, :prefixes

    SEPARATOR = '.'.freeze
    NO_KEY = '<<<key not present>>>'.freeze

    def initialize(a:, b:, in_a: true, in_b: true, prefixes: [])
      self.a = a
      self.b = b
      self.in_a = in_a
      self.in_b = in_b
      self.prefixes = prefixes
    end

    def call
      return nil if a == b

      prepare_diff
    end

    private

    def prepare_diff
      return diff_array if a.is_a?(Array) && b.is_a?(Array)
      return diff_hash if a.is_a?(Hash) && b.is_a?(Hash)

      { where: prefixes.join(SEPARATOR), a: a_log_value, b: b_log_value }
    end

    def diff_array
      longest = a.length > b.length ? a : b
      diff_enumerator longest.each_index, :check_array_has_index
    end

    def diff_hash
      keys = a.keys.concat(b.keys).uniq
      diff_enumerator keys, :check_hash_has_key
    end

    def diff_enumerator(key_enumerator, check_method)
      key_enumerator.map do |key|
        inspector_for(key, check_method).call
      end.compact.flatten
    end

    def inspector_for(key, check_method)
      Inspector.new a: a[key],
                    b: b[key],
                    in_a: send(check_method, a, key),
                    in_b: send(check_method, b, key),
                    prefixes: prefixes_for(key)
    end

    def prefixes_for(key)
      prefixes.dup.tap { |l| l << key.inspect }
    end

    def b_log_value
      in_b ? b : NO_KEY
    end

    def a_log_value
      in_a ? a : NO_KEY
    end

    def check_array_has_index(list, index)
      list.length > index
    end

    def check_hash_has_key(hash, key)
      hash.key? key
    end
  end
end
