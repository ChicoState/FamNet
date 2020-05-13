require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::formatter
SimpleCov.start do
    add_filter 'lib/widgets/polls'
end