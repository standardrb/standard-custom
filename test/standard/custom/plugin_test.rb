require "test_helper"

module Standard::Custom
  class PluginTest < Minitest::Test
    def setup
      @subject = Plugin.new({})
    end
  end
end
