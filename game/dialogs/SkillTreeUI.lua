require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Separator = require "engine.ui.Separator"
local ListColumns = require "engine.ui.ListColumns"
local TextzoneList = require "engine.ui.TextzoneList"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Skill Tree", game.w * 0.8, game.h * 0.8)
    
    self.font = core.display.newFont("/data/font/DroidSansMono.ttf", 14)
    self:setupUI()
end

function _M:setupUI()
    -- Left panel: Tree visualization
    self.c_tree = TreeMap.new{
        width = self.iw * 0.7,
        height = self.ih,
        scrollbar = true,
        nodes = {},
        connections = {},
        nodeSize = {width = 100, height = 50},
        onNodeClick = function(node) self:onNodeSelect(node) end,
        displayNode = function(node)
            -- Custom node rendering
            return {
                text = node.name,
                color = node.available and {0,255,0} or {128,128,128}
            }
        end
    }

    -- Right panel: Details and controls
    self.c_desc = TextzoneList.new{
        width = self.iw * 0.3,
        height = self.ih * 0.7,
        scrollbar = true,
    }

    self.c_invest = Button.new{
        text = "Invest Point",
        width = self.iw * 0.3,
        height = 30,
        callback = function() self:investPoint() end
    }

    -- Layout elements
    self:loadUI{
        {left = 0, top = 0, ui = self.c_tree},
        {right = 0, top = 0, ui = self.c_desc},
        {right = 0, bottom = 0, ui = self.c_invest},
    }
    self:setFocus(self.c_tree)
    self:setupTooltips()
end

function _M:setupTooltips()
    -- Initialize tooltip system
    self.mouse = Mouse.new()
    self.tooltip = Tooltip.new()
end

function _M:onNodeSelect(node)
    if not node then return end
    
    -- Update description
    self.c_desc:setText({
        {text = node.name, color = colors.GOLD},
        {text = "\n\nLevel: "..node.level.."/"..node.max_level},
        {text = "\n\n"..node:getDescription()},
        {text = "\n\nPrerequisites:", color = colors.LIGHT_BLUE},
        -- List prerequisites
    })
    
    -- Update invest button state
    self.c_invest.enabled = self:canInvestPoint(node)
end

function _M:investPoint(node)
    -- Handle point investment
    if self:canInvestPoint(node) then
        game.player:investSkillPoint(node)
        self:updateDisplay()
    end
end