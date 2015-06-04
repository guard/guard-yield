# Guard::Yield

[![Build Status](https://travis-ci.org/guard/guard-yield.png?branch=master)](https://travis-ci.org/guard/guard-yield)
[![Gem Version](https://badge.fury.io/rb/guard-yield.svg)](http://badge.fury.io/rb/guard-yield)

A Guard pseudo-plugin to conveniently run *any* Ruby code - straight from your
Guardfile (without writing your own plugin).

## Installation

in your Gemfile:

```ruby
group :development do
  gem 'guard-yield'
end
```

Install with:

    $ bundle install

Or install it yourself as:

    $ gem install guard-yield


## Usage

Add snippets to your `Guardfile` with:

    $ bundle exec guard init yield

Then, edit/remove them and run:

    $ bundle exec guard

## Useful example

Automatically building Docker images from a Dockerfile in Guard:

```ruby
run_docker = proc do
  image = "my_image"
  system("docker build -t #{image} .") || throw(:task_has_failed)
end

guard :yield, { :run_on_modifications => run_docker } do
  watch(/^Dockerfile$/)
end
```

(You could use the Docker API, `require 'docker'`, etc. but this is less work and nice output, and the task doesn't get fired if it fails).


## Another example

Show a list of md5sums whenever these files change

```ruby
  md5_summer = proc { |_, _, files| puts `md5sum #{files * ' '}` }
  guard :yield, run_on_modifications: md5_summer do
    watch('foo.rb')
    watch('bar.rb')
    watch('baz.rb')
  end
```

Yes, you don't need to resort to hax with the `watch()` block or creating
inline Guard plugins in your Guardfile. Especially for local one-shot pieces of
code like this.

## Tips

Aside from supporting all the methods for Guard::Plugin:

```
:start
:stop
:run_all
:reload
:run_on_additions
:run_on_modifications
:run_on_removals
:run_on_changes
```

there's a special `:object` option, that allows you to pass any object you like
to *all* the methods.

(Just check the logger example in the Guardfile).

This means you can conveniently use any Ruby library inside your Guardfile -
without writing a Guard plugin as a wrapper for it.

Also, remember to use Guard's `throw(:task_has_failed)` to flag an error
(otherwise Guard will disable your guard), e.g. :

```ruby
  my_syntax_checker = proc do |_, _, changes|
    changes.each do |file|
      system("ruby -c #{file}") || throw(:task_has_failed) # IMPORTANT!
    end
  end

  guard :yield, run_on_modifications: &my_syntax_checker do
    watch('foo.rb')
    watch('bar.rb')
  end
```


## FAQ

> "Why not use the watch() block for running code?"

1. That's not what it's for (you need the `return nil` hack at least)
2. You don't have access to the guard object (even if it's your own)
3. You can't pass data to the block (you just have the file)
4. The dsl has it's own namespace - guard-yield side-steps that
5. This cleanly separates rules (which can get complex) from behavior
6. It really is just for substituting one change for another (not for code)

Here's an example anyway (NOT RECOMMENDED!):

```ruby
# nil to prevent plugin for doing anything itself
watch("foo.*") { |m| `cp #{m} #{m}.backup`; nil }
```

> "Why not use an inline Guard plugin inside the Guardfile?"

Usually it's the Object-Oriented way to do things, and it's likely easier to
extract into a gem.

But if you don't want to create a full-blown gem, or you want the logic to be
local, verbose and concise ... guard-yield will help.

And as above - guard-yield allows you to prototype an interface to any Ruby
library and use that directly in your Guardfile - and often with less code,
classes and methods to get the job done.

> "Why not just create a gem/lib for every task like that?"

One reason is - you may quickly end up with too many gems to maintain (for no
reason), while those gems will just be a thin, minimal front-end to a complex
Ruby library.

Basically it all boils down to how many options you want your guard plugin to
handle - and how complex handling them is.

Not every use case can be extracted into a nice generic gem useful for many
people - that's why I created this gem.

Have fun!


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/guard-yield.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

