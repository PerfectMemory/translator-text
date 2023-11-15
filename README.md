# TranslatorText

[![Gem](https://img.shields.io/gem/v/translator-text.svg)](https://rubygems.org/gems/translator-text/) [![Code Climate](https://codeclimate.com/github/PerfectMemory/translator-text.png)](https://codeclimate.com/github/PerfectMemory/translator-text)

API Wrapper for the [Microsoft Translator Text API 3.0](https://docs.microsoft.com/en-us/azure/cognitive-services/translator/reference/v3-0-reference) (Cognitive Services).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'translator-text'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install translator-text
    
## Cognitive Services API Key

* To be able to use the Cognitive Services, you must have an API key and for that you need an Azure account.
* If you don't have an Azure account, you can create one for free on [this page](https://azure.microsoft.com/en-us/free/). 
* Once logged on your [Azure portal](https://portal.azure.com/), subscribe to the Translator Text API in Microsoft Cognitive Service.
* You will find two subscription keys available in 'RESOURCE MANAGEMENT > Keys' ('KEY 1' and 'KEY 2').

## Usage

### Client

You can instanciate your own client by passing the [Azure authentication](https://learn.microsoft.com/en-us/azure/ai-services/translator/reference/v3-0-reference#authentication) parameters.

```ruby
require 'translator-text'

client = TranslatorText::Client.new(api_key, api_region)
```

Or use the built-in that uses the following environment variables:

* `COGNITIVE_SUBSCRIPTION_KEY`: The value is the Azure secret key for your subscription to Translator.
* `COGNITIVE_SUBSCRIPTION_REGION`: The value is the region of the multi-service or regional translator resource. This value is optional when using a global translator resource.

```ruby
require 'translator-text'

client = TranslatorText.client
```


### Translation

```ruby
require 'translator-text'

results = TranslatorText.client.translate(
	['something to translate', 'another something to translate'],
	to: [:fr, :es]
)

# Returns
# [
#   #<TranslationResult detectedLanguage={"language"=>"en", "score"=>1.0} translations=[
#     #<Translation text="Première phrase" to="fr">,
#     #<Translation text="Primera oración" to="es">]>,
#   #<TranslationResult detectedLanguage={"language"=>"en", "score"=>1.0} translations=[
#     #<Translation text="Deuxième phrase" to="fr">, 
#     #<Translation text="Segunda oración" to="es">]>
# ]
```

### Detection

```ruby
require 'translator-text'

results = TranslatorText.client.detect(['some unknown language', 'quelque chose à détecter'])

# Returns
# [
#   #<DetectionResult language=:en score=1.0 isTranslationSupported=true isTransliterationSupported=false alternatives=[
#     #<Alternative language=:de score=1.0 isTranslationSupported=true isTransliterationSupported=false>,
#     #<Alternative language=:"fil-PH" score=1.0 isTranslationSupported=true isTransliterationSupported=false>]>,
#   #<DetectionResult language=:fr score=1.0 isTranslationSupported=true isTransliterationSupported=false alternatives=[
#     #<Alternative language=:nl score=0.75 isTranslationSupported=true isTransliterationSupported=false>,
#     #<Alternative language=:vi score=0.75 isTranslationSupported=true isTransliterationSupported=false>]>
# ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PerfectMemory/translator-text. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TranslatorText project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/PerfectMemory/translator-text/blob/master/CODE_OF_CONDUCT.md).
