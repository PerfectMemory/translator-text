lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'translator_text/version'

Gem::Specification.new do |spec|
  spec.name          = 'translator-text'
  spec.version       = TranslatorText::VERSION
  spec.authors       = ['Aymeric Brisse']
  spec.email         = ['aymeric.brisse@perfect-memory.com']

  spec.summary       = 'API Wrapper for the Microsoft Translator Text API'
  spec.description   = 'API Wrapper for the Microsoft Translator Text API (Cognitive Services)'
  spec.homepage      = 'https://github.com/PerfectMemory/translator-text'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'dry-struct', '~> 1'
  spec.add_dependency 'httparty', '~> 0.21'
end
