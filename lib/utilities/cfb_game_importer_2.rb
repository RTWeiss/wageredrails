require 'csv'
require 'nokogiri'
require 'date'
require 'open-uri'

# require in rails console, call on schedule url's. Manually input League

def find_or_create_by_name(team)
  if Team.exists?(name: team)
    Team.where(name: team).first.id
  else
    team = Team.new(name: team)
    team.save!
    team.id
  end
end

def import(url)
  pg = Nokogiri::HTML(open(url))
  table = pg.css('table#schedule.sortable.stats_table').max_by { |t| t.xpath('.//tr').length }
  games = table.search('tr')[4..-1].map {|i| i.search('td//text()').collect {|t| CGI.unescapeHTML(t.to_s) } }

  games.each do |game|
    g = game.delete_if { |i| i =~ /\(/ }
    # parsed_team_name = g[4]
    parsed_team_id = find_or_create_by_name(g[4])
    date_arr = g[1].split(' ')
    month = Date::ABBR_MONTHNAMES.index(date_arr[0])
    day = date_arr[1].to_i
    date = Date.new(2015, month, day)

    if game[5] =~ /@/
      home = find_or_create_by_name(g[6])
      Game.where(date: date, home_team_id: home, away_team_id: parsed_team_id).first_or_create
    else
      away = find_or_create_by_name(g[5])
      Game.where(date: date, home_team_id: parsed_team_id, away_team_id: away).first_or_create
    end
  end
end
