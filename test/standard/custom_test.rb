require "test_helper"
require "rubocop"

class Standard::CustomTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Standard::Custom::VERSION
  end

  BASE_CONFIG = "config/base.yml"
  INHERITED_OPTIONS = %w[
    Description
    Reference
    Safe
    SafeAutoCorrect
    StyleGuide
    VersionAdded
    VersionChanged
  ].freeze
  def test_configures_all_custom_cops
    Dir[Pathname.new(__dir__).join("../../lib/standard/cop/*")].sort.each { |file| require file }
    expected = RuboCop::Cop::Standard.constants.map { |name| "Standard/#{name}" }
    actual = YAML.load_file(BASE_CONFIG).keys

    missing = expected - actual
    extra = actual - expected

    assert_equal missing, [], "Configure these cops as either Enabled: true or Enabled: false in #{BASE_CONFIG}"
    assert_equal extra, [], "These cops do not exist and should not be configured in #{BASE_CONFIG}"
  end

  def test_alphabetized_config
    actual = YAML.load_file(BASE_CONFIG).keys - ["require"]
    expected = actual.sort

    assert_equal actual, expected, "Cop names should be alphabetized! (See this script to do it for you: https://github.com/testdouble/standard/pull/222#issue-744335213 )"
  end
end
