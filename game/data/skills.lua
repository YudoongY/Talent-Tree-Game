-- Define skills
newSkill{
    id = "base_magic",
    name = "Basic Magic",
    type = "spell",
    points = 1,
    cooldown = 3,
    mana = 10,
    action = function(self, t)
        -- Skill implementation
    end,
    info = function(self, t)
        return "Deals magical damage"
    end
}