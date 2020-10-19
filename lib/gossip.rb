require 'csv'
require 'pry'
class Gossip

  attr_reader :author, :content 

  def initialize(author,content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
    
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
    all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end

    return all_gossips
  end

  def self.find(id)
    ligne = []
    CSV.read("./db/gossip.csv").each_with_index do |csv,i|
      ligne = csv if i==(id-1)
    end
    
    return ligne
  end

  def self.update(id,info)
    
     arr = []
     CSV.read("./db/gossip.csv").each do |csv_line|
      arr << csv_line
     end
     CSV.open("./db/gossip.csv","wb") do |csv|
      
      arr.each_with_index do |line,i|
        if (id-1) == i
          csv << info
        else
          csv << line
        end
        
      end
    end
    
  end
end
