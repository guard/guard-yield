require 'guard/compat/test/helper'
require 'guard/yield'

RSpec.describe Guard::Yield do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  subject { described_class.new(options) }

  let(:options) { {} }
  let(:block) { instance_double(Proc) }

  describe "#initialize" do
    context "with no object given" do
      let(:options) { { start: block } }
      it "passes self" do
        expect(block).to receive(:call).with(subject, :start)
        subject.start
      end
    end

    context "with a user object" do
      let(:object) { double("some object") }
      let(:options) { { object: object, start: block } }
      it "passes the object" do
        expect(block).to receive(:call).with(object, :start)
        subject.start
      end
    end

    context "with an unknown option" do
      let(:options) { { foo: :bar } }
      it "fails" do
        expect { subject }.to raise_error(ArgumentError, "Unknown option: :foo")
      end
    end

    context "with a Guard::Plugin watchers option" do
      let(:options) { { watchers: [] } }
      it "fails" do
        expect { subject }.to_not raise_error
      end
    end

    context "with a Guard::Plugin group option" do
      let(:options) { { group: [] } }
      it "fails" do
        expect { subject }.to_not raise_error
      end
    end

    context "with a Guard::Plugin callbacks option" do
      let(:options) { { callbacks: [] } }
      it "fails" do
        expect { subject }.to_not raise_error
      end
    end
  end

  describe "#start" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.start(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { start: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :start, :foo, :bar)
        subject.start(:foo, :bar)
      end
    end
  end

  describe "#stop" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.stop(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { stop: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :stop, :foo, :bar)
        subject.stop(:foo, :bar)
      end
    end
  end

  describe "#run_all" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.run_all(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { run_all: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :run_all, :foo, :bar)
        subject.run_all(:foo, :bar)
      end
    end
  end

  describe "#reload" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.reload(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { reload: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :reload, :foo, :bar)
        subject.reload(:foo, :bar)
      end
    end
  end

  describe "#run_on_additions" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.run_on_additions(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { run_on_additions: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :run_on_additions, :foo, :bar)
        subject.run_on_additions(:foo, :bar)
      end
    end
  end

  describe "#run_on_modifications" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.run_on_modifications(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { run_on_modifications: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :run_on_modifications, :foo, :bar)
        subject.run_on_modifications(:foo, :bar)
      end
    end
  end

  describe "#run_on_removals" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.run_on_removals(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { run_on_removals: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :run_on_removals, :foo, :bar)
        subject.run_on_removals(:foo, :bar)
      end
    end
  end

  describe "#run_on_changes" do
    context "with no block" do
      it "does nothing" do
        expect(block).to_not receive(:call)
        subject.run_on_changes(:foo, :bar)
      end
    end

    context "with a block" do
      let(:options) { { run_on_changes: block } }
      it "calls the block" do
        expect(block).to receive(:call).with(subject, :run_on_changes, :foo, :bar)
        subject.run_on_changes(:foo, :bar)
      end
    end
  end
end
