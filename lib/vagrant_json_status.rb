require "vagrant"

module VagrantPlugins
  class Plugin < Vagrant.plugin("2")
    name "json-status command"
    description <<-DESC
      The `json-status` command shows what the running state (running/saved/..)
      is of all the Vagrant environments known to the system in json format.
    DESC

    command('json-status') do
      require_relative 'command'
      Command
    end
  end
end
