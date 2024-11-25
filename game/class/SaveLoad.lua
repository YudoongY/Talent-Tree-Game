require "engine.class"
require "engine.SaveGame"

module(..., package.seeall, class.inherit(engine.SaveGame))

-- Custom save data handler
function _M:saveGame()
    -- Save base game data
    self:savePrimary()
    
    -- Save custom data
    self:saveData("skill_trees", game.player.skill_trees)
    self:saveData("meta_effects", game.player.meta_effects)
    self:saveData("planned_actions", game.player.planned_actions)
end

function _M:loadGame()
    -- Load base game data
    self:loadPrimary()
    
    -- Load custom data with error handling
    local ok, skill_trees = self:loadData("skill_trees")
    if ok then 
        game.player.skill_trees = skill_trees
    else
        -- Handle corrupted data
        game.player:initializeSkillTrees()
    end
    
    -- Load meta effects
    local ok, meta_effects = self:loadData("meta_effects")
    if ok then
        game.player.meta_effects = meta_effects
    end
    
    -- Load planned actions
    local ok, planned_actions = self:loadData("planned_actions")
    if ok then
        game.player.planned_actions = planned_actions
    end
end

-- Data verification
function _M:verifyData()
    -- Verify skill tree integrity
    for tree_id, tree in pairs(game.player.skill_trees) do
        if not self:verifySkillTree(tree) then
            game.log("Warning: Corrupted skill tree detected: "..tree_id)
            game.player:resetSkillTree(tree_id)
        end
    end
end

function _M:verifySkillTree(tree)
    -- Check tree structure
    if not tree.nodes or not tree.connections then
        return false
    end
    
    -- Verify node connections
    for _, conn in ipairs(tree.connections) do
        if not tree.nodes[conn.from] or not tree.nodes[conn.to] then
            return false
        end
    end
    
    return true
end

-- Hook integration
class:bindHook("ToME:save", function(self)
    game:saveGame()
end)

class:bindHook("ToME:load", function(self)
    game:loadGame()
    game:verifyData()
end)