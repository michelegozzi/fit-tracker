#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

FitTracker::Application.load_tasks

RDoc::Task.new :rdoc do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "rdoc"
  rdoc.rdoc_files.include("README.rdoc", "doc/*", "app/**/*.rb", "lib/*.rb", "config/**/*.rb")
  #change above to fit needs

  rdoc.title = "Fit-Tracker Documentation"
  rdoc.options << "--all" 
end
