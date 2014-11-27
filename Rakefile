require File.expand_path('../config/application', __FILE__)
require 'rubocop/rake_task'

task default: [:spec, :rubocop]

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  # only show the files with failures
  task.formatters = ['simple']
  # don't abort rake on failure
  task.fail_on_error = false
end

Rails.application.load_tasks
