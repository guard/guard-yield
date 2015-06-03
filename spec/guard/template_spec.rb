require 'guard/compat/test/template'

RSpec.describe "Guard::Yield" do
  describe "template" do
    subject { Guard::Compat::Test::Template.new("Guard::Yield") }

    # Just validate enough to avoid syntax errors
    it "set an example watcher" do
      expect(subject.changed("foo.css")).to eq(%w(foo.css))
    end
  end
end
