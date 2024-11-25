-- combat.lua
class.new("CustomCombatTurn", class.makeAI, {
    -- Custom turn handler for automated combat
    _M:init = function(self, actor)
        self.actor = actor
        self.skill_queue = {}
    end,

    -- Pre-plan combat actions
    setupActions = function(self, actions)
        self.skill_queue = table.clone(actions)
    end,

    -- Execute pre-planned actions
    performNext = function(self)
        local next_action = table.remove(self.skill_queue, 1)
        if next_action then
            self:executeAction(next_action)
        end
    end,
})