require "engine.class"
require "engine.Entity"

module(..., package.seeall, class.inherit(engine.Entity))

-- Skill tree class
function _M:init(t, no_default)
    engine.Entity.init(self, t, no_default)
    
    self.nodes = {}
    self.connections = {}
    self.available_points = 0
end

function _M:addNode(node)
    self.nodes[node.id] = node
end

function _M:connectNodes(node1, node2)
    table.insert(self.connections, {from = node1, to = node2})
end

function _M:canAllocatePoint(node)
    -- Check if point can be allocated
    return self:hasPrerequisites(node) and self.available_points > 0
end