namespace :crawler do
  namespace :room do
    task crawl_from_muabannhadat: :environment do
      puts "Start crawling room from www.muabannhadat.vn"
      CrawlRoomsFromMuabannhadatService.new.perform
      puts "Finish crawling room from www.muabannhadat.vn"
    end
  end
end
