namespace :crawler do
  namespace :rooms do
    task :crawl_from_muabannhadat, [:pages_number] => [:environment] do |t, args|
      puts "Start crawling room from 'www.muabannhadat.vn'"
      if pages_number = args[:pages_number].try(:to_i)
        CrawlRoomsFromMuabannhadatService.new(pages_number).perform
      else
        CrawlRoomsFromMuabannhadatService.new.perform
      end
      puts "Finish crawling room from 'www.muabannhadat.vn'"
    end

    task :crawl_from_nhadat24h, [:pages_number] => [:environment] do |t, args|
      puts "Start crawling room from 'nhadat24h.net'"
      if pages_number = args[:pages_number].try(:to_i)
        CrawlRoomsFromNhadat24hService.new(pages_number).perform
      else
        CrawlRoomsFromNhadat24hService.new.perform
      end
      puts "Finish crawling room from 'nhadat24h.net'"
    end
  end
end
