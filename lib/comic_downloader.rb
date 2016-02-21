Dir["#{File.expand_path(File.dirname(__FILE__))}/comic_downloader/*.rb"].each { |file| require file }
require 'nokogiri'
require 'mechanize'
require 'eventmachine'

module ComicDownloader

  class Scraper

    def initialize(hash = {})
      @url = hash[:url]
      @range = Range.new(*hash[:range].split("..").map(&:to_i)) unless hash[:range].nil?
      @proxy_ip = hash[:proxy_ip]
      handle(@url, @range, @proxy_ip)
    end

    def handle(url, range = nil, proxy_ip = nil)
      warning "不合法的url" unless url =~ /((^http:\/\/8yyls.com\/(\d)+\/$)|(^http:\/\/g.e-hentai.org))/
      case url
      when /8yyls.com/
        EM.run do
          ComicDownloader::Eightyyls.new(url, range, proxy_ip).download
          EM.stop
        end
      when /g.e-hentai.org/
        ComicDownloader::Ehentai.new(url, range, proxy_ip).download
      end
    end

    def warning(notice)
      puts notice
      return
    end

  end
end
