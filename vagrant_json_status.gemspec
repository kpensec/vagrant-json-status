
lib = File.expand_path("../lib", __FILE__)
$:.unshift(lib) unless $:.include?(lib)
require "vagrant_json_status/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant_json_status"
  spec.version       = VagrantJsonStatus::VERSION
  spec.authors       = ["kpensec"]
  spec.email         = ["kevin.pensec@gmail.com"]

  spec.summary       = "Plugin for vagrant to display status in json format"
  spec.homepage      = "http://kpensec.github.io/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
    #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }
  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end

  spec.files = unignored_files
  spec.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  
end
