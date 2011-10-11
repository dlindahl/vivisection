require 'helper'

class TestVivisection < Test::Unit::TestCase

  should "have a default destination" do
    assert Vivisection.destination
  end

  should "default source files" do
    assert Vivisection.source_files.is_a? Array
  end

  should "define a custom Rocco template" do
    assert Vivisection.rocco_options[:template_file]
  end

  should "have a index URL property" do
    assert_nil Vivisection.index_url
  end

  should "provide the ability to ignore files" do
    assert Vivisection.ignore.is_a? Array
  end

end
