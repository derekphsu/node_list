require 'uri'
require 'net/http'
require 'httparty'
require 'JSON'

def node_challenge

  node_array = ['089ef556-dfff-4ff2-9733-654645be56fe']
  node_count = {}
  node_visited = {}
  pointer = 0
  result = get_node('089ef556-dfff-4ff2-9733-654645be56fe')


  while pointer < node_array.length
    node = node_array[pointer]
    unless node_visited[node]
      node_visited[node] = true
      response = get_node(node).first
      response["child_node_ids"].each do |id|
        node_count[id] ? node_count[id] += 1 : node_count[id] = 1
      end

      node_array += response["child_node_ids"]
    end

    pointer += 1
  end

  max = 0
  max_node = ""
  node_count.each do |k,v|
    if v > max
      max = v
      max_node = k
    end
  end
  puts node_count.size
  puts max_node
  puts max
end


def get_node(node)
  res = HTTParty.get("https://nodes-on-nodes-challenge.herokuapp.com/nodes/" + node)
  body = res.body
  return JSON.parse(body)
end


def populate_array_and_list(node, array, list)

end
node_challenge