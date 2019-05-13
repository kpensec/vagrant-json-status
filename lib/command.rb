require 'optparse'
require 'json'
require 'vagrant'

module VagrantPlugins
  class Command < Vagrant.plugin("2", :command)
    def self.synopsis
      "outputs status Vagrant environments for this user"
    end

    def execute
      options = {}

      opts = OptionParser.new do |o|
        o.banner = "Usage: vagrant json-status"
        o.separator ""
        o.on("--prune", "Prune invalid entries.") do |p|
          options[:prune] = true
        end
      end

      # Parse the options
      argv = parse_options(opts)
      return if !argv

      entries = []
      prune   = []
      @env.machine_index.each do |entry|
        # If we're pruning and this entry is invalid, skip it
        # and prune it later.
        if options[:prune] && !entry.valid?(@env.home_path)
          prune << entry
          next
        end

        entries << entry
      end

      # Prune all the entries to prune
      prune.each do |entry|
        deletable = @env.machine_index.get(entry.id)
        @env.machine_index.delete(deletable) if deletable
      end

      @env.ui.info "{\"machines\": #{entries.map {|e| e.to_json_struct()}.to_json()}}"


      # Success, exit status 0
      0
    end
  end
end
