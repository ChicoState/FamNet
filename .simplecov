require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::formatter
SimpleCov.start do
    add_filter 'lib/widgets/polls/form.dart'
    add_filter 'lib/widgets/polls/poll_content.dart'
end