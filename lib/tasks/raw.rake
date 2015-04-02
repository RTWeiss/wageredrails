# Within the RouteInspector class the format method takes formatter as an argument.
# In the routes:raw rake task, the format method is called on inspector with CommentRoutesFormatter as its argument.

class CommentRoutesFormatter
  def initialize
    @buffer = []
  end

  def result
    @buffer.join("\n")
  end

  def section_title(title)
    @buffer << "\n#{title}:"
  end

  def format_time(time)
    time.strftime('#  rake routes:raw at %B %e, %Y %l:%M %p')
  end

  def section(routes)
    @buffer << draw_section(routes)
    @routes_copy = routes
    @paths = @routes_copy.collect! { |r| ['#  ' + r[:verb] + " '", r[:path] + "' => '", r[:reqs] + "'$"] }
    @paths = @paths.join.downcase
    @paths = @paths.split('$')
    @paths = @paths.each do |r|
      r.gsub!('(.:format)', '')
    end
    @paths.unshift(format_time(Time.now))
    @paths.join
  end

  def header(routes)
    @buffer << draw_header(routes)
  end

  def no_routes
    @buffer << <<-MESSAGE.strip_heredoc
      You don't have any routes defined!
      Please add some routes in config/routes.rb.
      For more information about routes, see the Rails guide: http://guides.rubyonrails.org/routing.html.
      MESSAGE
  end

  def draw_header(routes)
    name_width, verb_width, path_width = widths(routes)
    "#{'Prefix'.rjust(name_width)} #{'Verb'.ljust(verb_width)} #{'URI Pattern'.ljust(path_width)} Controller#Action"
  end

  def widths(routes)
    [routes.map { |r| r[:name].length }.max || 0,
     routes.map { |r| r[:verb].length }.max || 0,
     routes.map { |r| r[:path].length }.max || 0]
  end

  def draw_section(routes)
    header_lengths = ['Prefix', 'Verb', 'URI Pattern'].map(&:length)
    name_width, verb_width, path_width = widths(routes).zip(header_lengths).map(&:max)

    routes.map do |r|
      "#{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
    end
  end
end

namespace :routes do
  desc 'print route urls'
  task raw: :environment do
    all_routes = Rails.application.routes.routes
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    result_string = inspector.format(CommentRoutesFormatter.new)
    result_array = result_string.split("1")
    routes_only = result_array.drop(5)
    p routes_only[0]
  end
end