require 'lib/fresh_find/line'

module FreshFind
  def self.call
    Line.all
  end
end
