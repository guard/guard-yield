require 'guard/compat/test/template'

RSpec.describe "Guard::Yield" do
  describe "template" do
    subject { Guard::Compat::Test::Template.new("Guard::Yield") }

    it "set an example watcher" do
      expect(subject.changed("foo.rb")).to eq(%w(bar.rb))
    end
  end
end
