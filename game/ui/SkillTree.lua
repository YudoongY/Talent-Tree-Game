-- ui/skilltree.lua
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"

newDialog("SkillTreeDialog", function(self)
    Dialog.init(self, "Skill Tree", game.w * 0.8, game.h * 0.8)
    
    -- Create skill tree visualization
    self.c_tree = TreeMap.new{
        width = self.iw,
        height = self.ih,
        scrollbar = true,
        -- Add node rendering logic
    }
    
    -- Add modification handlers
    self.c_tree.onNodeClick = function(node)
        -- Handle node selection/activation
    end
end)