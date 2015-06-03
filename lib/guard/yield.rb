require "guard/compat/plugin"

module Guard
  class Yield < Plugin
    PLUGIN_METHODS = %i(start stop run_all reload run_on_additions
    run_on_modifications run_on_removals run_on_changes)

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
