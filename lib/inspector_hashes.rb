require 'inspector_hashes/version'
require 'inspector_hashes/inspector'

# `InspectorHashes.diff(a, b)` will return the array of differences.
module InspectorHashes
  def self.diff(a, b)
    inspector_for(a, b).call
  end

  def self.inspector_for(a, b)
    Inspector.new a: a, b: b
  end
end
