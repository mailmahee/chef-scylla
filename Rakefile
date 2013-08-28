#!/usr/bin/env rake

require 'rake'
require 'rake/tasklib'
require 'rake/testtask'
require 'rspec/core/rake_task'

# BEGIN CHEF-4338: TODO: remove this when CHEF-4338 is merged upstream
require 'chef/cookbook/metadata'
require 'chef/cookbook/syntax_check'

class Chef
  module Tasks
    class CookbookSyntaxCheckTask < ::Rake::TaskLib
      attr_accessor :name, :cookbook_path, :cache_path

      def initialize(name = :cookbook_syntax_check)
        @name = name
        @cookbook_path = Dir.pwd
        @cache_path = File.join(ENV['HOME'], '.chef', 'checksums')
        yield self if block_given?
        define
      end

      def define
        desc "Check Syntax of Chef cookbook"
        task(name) do
          syntax_checker = Chef::Cookbook::SyntaxCheck.new(cookbook_path)
          syntax_checker.validated_files.instance_variable_set('@cache_path', cache_path) # TODO: fix upstream

          fail "invalid ruby files" unless syntax_checker.validate_ruby_files
          fail "invalid templates" unless syntax_checker.validate_templates
        end
      end

    end
  end
end
# END CHEF-4338

Chef::Tasks::CookbookSyntaxCheckTask.new

require 'foodcritic'
require 'foodcritic/rake_task'
FoodCritic::Rake::LintTask.new do
  options = { fail_tags: ['any'] }
end

def cookbook_metadata
  metadata = Chef::Cookbook::Metadata.new
  metadata.from_file 'metadata.rb'
  metadata
end

def cookbook_name
  name = cookbook_metadata.name
  if name.nil? || name.empty?
    File.basename(File.dirname(__FILE__))
  else
    name
  end
end

COOKBOOK_NAME = ENV['COOKBOOK_NAME'] || cookbook_name
COOKBOOKS_PATH = ENV['COOKBOOKS_PATH'] || 'tmp/cookbooks'

task :setup_cookbooks do
  rm_rf COOKBOOKS_PATH
  sh 'berks', 'install', '--path', COOKBOOKS_PATH
end

desc 'Run ChefSpec examples'
task :chefspec => :setup_cookbooks do
  sh 'rspec', '--color', '--format', 'documentation',
     File.join(COOKBOOKS_PATH, COOKBOOK_NAME, 'spec')
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> test-kitchen gem not loaded, omitting tasks" unless ENV['CI']
rescue Kitchen::UserError => e
  puts "#{e.message}: kitchen error, ommitting tasks"
end

# aliases
task :test => :chefspec
task :spec => :chefspec

task :lint => [:cookbook_syntax_check, :foodcritic]
task :default => [:lint, :test]
task :all => [:lint, :test, 'kitchen:all']
