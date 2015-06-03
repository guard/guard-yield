require "guard/compat/plugin"

module Guard
  class Yield < Plugin
    PLUGIN_METHODS = %i(start stop run_all reload run_on_additions
    run_on_modifications run_on_removals run_on_changes)

    VALID_GUARD_OPTIONS = %i(watchers group callbacks)

    VALID_OPTIONS = %i(object)

    def initialize(options={})
      valid_options = PLUGIN_METHODS + VALID_OPTIONS + VALID_GUARD_OPTIONS
      options.keys.each do |key|
        unless valid_options.include?(key)
          raise ArgumentError, "Unknown option: #{key.inspect}"
        end
      end

      super
    end

    PLUGIN_METHODS.each do |name|
      define_method(name) do |*args|
        block = self.options.fetch(name, nil)
        next unless block
        object = self.options.fetch(:object, self)
        block.call object, name, *args
      end
    end
  end
end
