source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"


using_windows = !!((RUBY_PLATFORM =~ /(win|w)(32|64)$/) || (RUBY_PLATFORM=~ /mswin|mingw/))

gem "win32-process", "~> 0.6.5" if using_windows

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "shoulda", ">= 0"
  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.6.2"
  gem "rcov", ">= 0"
end
