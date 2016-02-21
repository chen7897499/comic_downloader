# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'comic_downloader/version'

Gem::Specification.new do |spec|
  spec.name          = "comic_downloader"
  spec.version       = ComicDownloader::VERSION
  spec.authors       = ["bomb"]
  spec.email         = ["chen7897499@gmail.com"]
  spec.summary       = "自用的漫画下载器"
  spec.homepage      = "https://github.com/chen7897499/comic_downloader"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["comic_downloader"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "eventmachine"
  spec.add_runtime_dependency "mechanize"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "pry-byebug"
end
