module ComicDownloader
  class Eightyyls
    def initialize(url, range, proxy_ip)
      @url = url
      @range = range
      @proxy_ip = proxy_ip
      @agent = Mechanize.new
    end

    def process_range
      if @range.nil?
        count = Nokogiri::HTML(@agent.get(@url).body).css('td > a').count
        @range = (1..count)
      elsif @range.class == Range
        @range
      end
    end

    def download
      self.process_range
      @range.each do |r|
        first_page = Nokogiri::HTML(@agent.get(@url).body).css('td > a')[r-1]["href"]
        count = Nokogiri::HTML(@agent.get(@url).body).css('td > font')[r-1].text.match(/(\d)+/).to_s
        second_page = Nokogiri::HTML(@agent.get(first_page).body).css('#caonima').first["src"]
        @agent.pluggable_parser["image"] = Mechanize::DirectorySaver.save_to(r.to_s)
        em_download(second_page, count)
      end
    end

    def em_download(page, count)
      page =~ /(.*\/)(\d)+.jpg$/
      (1..count.to_i).each do |n|
        @agent.get("#{$1}#{"%03d" % n}.jpg")
      end
    end
  end
end
