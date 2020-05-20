class Graph
  attr_reader :graph, :nodes, :previous, :distance
  INFINITY = 1 << 64

  def initialize
    @graph = {}
    @nodes = Array.new
    @distance = {}
    @previous = {}
    @path = ''
  end

  def connect_graph(source, target, weight)
    if (!graph.has_key?(source))
      graph[source] = {target => weight}
    else
      graph[source][target] = weight
    end
    if (!nodes.include?(source))
      nodes << source
    end
  end

  def add_edge(source, target, weight)
    connect_graph(source, target, weight)
    connect_graph(target, source, weight)
  end


  def dijkstra(source)
    @graph.map do |a, b|
      @distance[a] = -1
    end
    @distance[source] = 0
    @previous[source] = -1
    ready = Array.new
    not_completed = true
    current = source

    while not_completed do
      @graph[current].each do |node_index, node_val|
        if (!ready.include? node_index)
          distance = @distance[current] + node_val
          if(@distance[node_index] == -1 || @distance[node_index]>distance)
            @distance[node_index] = distance
            @previous[node_index] = current
          end
        end
      end
      ready << current
      current = @graph[current].sort_by { |key, val| val }.first[0]
      not_completed = @distance.has_value?(-1)
    end
  end

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end

  def shortest_paths(source)
    dijkstra source
    res = ''
    @distance.each do |node_index, node_distance|
      path = find_path node_index
      @path = ''
      formatted = ''
      path.each_char {|a|
        formatted << a
        if a != node_index
        formatted << '-->'
        end
      }
      res << "Target(#{node_index})  #{formatted} : #{node_distance} \n"

    end

    return  res
  end

end

if __FILE__ == $0
  gr = Graph.new
  gr.add_edge("a", "c", 7)
  gr.add_edge("a", "e", 14)
  gr.add_edge("a", "f", 9)
  gr.add_edge("c", "d", 15)
  gr.add_edge("c", "f", 10)
  gr.add_edge("d", "f", 11)
  gr.add_edge("d", "b", 6)
  gr.add_edge("f", "e", 2)
  gr.add_edge("e", "b", 9)
  gr.shortest_paths("a")
  gr.print_result

end


