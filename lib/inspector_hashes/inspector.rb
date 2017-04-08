module InspectorHashes

  # `InspectorHashes.diff(a, b)` will return:
  # - nil (if equal)
  # - if given simple objects, a single difference object:
  #   ```
  #     { where: '', a: a, b: b }
  #   ```
  # - if a hash or an array: the array of differences.
  class Inspector
    attr_accessor :a, :b, :a_exists, :b_exists, :prefixes

    SEPARATOR = ' > '.freeze
    NO_KEY = '<<<key not present>>>'.freeze

    def initialize(a:, b:, a_exists: true, b_exists: true, prefixes: [])
      self.a = a
      self.b = b
      self.a_exists = a_exists
      self.b_exists = b_exists
      self.prefixes = prefixes
    end

    def call
      return nil if a_exists && b_exists && a == b

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
      diff_enumerable longest.each_index, :check_array_has_index
    end

    def diff_hash
      keys = (a.keys + b.keys).uniq.sort_by(&:to_s)
      diff_enumerable keys.uniq, :check_hash_has_key
    end

    def diff_enumerable(key_enumerable, check_method)
      key_enumerable.map do |key|
        inspector_for(key, check_method).call
      end.compact.flatten
    end

    def inspector_for(key, check_method)
      Inspector.new a: a[key],
                    b: b[key],
                    a_exists: send(check_method, a, key),
                    b_exists: send(check_method, b, key),
                    prefixes: prefixes_for(key)
    end

    def prefixes_for(key)
      new_prefix = key.is_a?(String) ? key : key.inspect
      prefixes.dup.tap { |l| l << new_prefix }
    end

    def b_log_value
      b_exists ? b : NO_KEY
    end

    def a_log_value
      a_exists ? a : NO_KEY
    end

    def check_array_has_index(list, index)
      list.length > index
    end

    def check_hash_has_key(hash, key)
      hash.key? key
    end
  end
end
