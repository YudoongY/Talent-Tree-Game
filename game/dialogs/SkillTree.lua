require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TreeMap = require "engine.ui.TreeMap"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, width, height)
    Dialog.init(self, title, width, height)
    
    -- Create UI elements
    self:setupUI()
end

function _M:setupUI()
    -- Setup skill tree visualization
    self.c_desc = Textzone.new{
        width = self.iw,
        height = self.ih * 0.3,
        text = "Select a skill to view details"
    }
    
    self.c_tree = TreeMap.new{
        width = self.iw,
        height = self.ih * 0.7,
        on_select = function(node) self:onNodeSelect(node) end
    }
    
    -- Layout UI elements
    self:loadUI{
        {left = 0, top = 0, ui = self.c_tree},
        {left = 0, top = self.ih * 0.7, ui = self.c_desc}
    }
end

function _M:onNodeSelect(node)
    -- Handle node selection
    self.c_desc.text = node:getDescription()
    self.c_desc:generate()
end