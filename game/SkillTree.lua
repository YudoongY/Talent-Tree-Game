newSkillTreeType{
    type = "race",
    name = "Race Tree",
    points_per_level = 3,
    -- Define base properties
}

newSkill{
    id = "example_skill",
    name = "Example Skill",
    type = "skill",
    require = {
        stat = { mag=10 },
        skill = { ["base_magic"]=2 },  -- Prerequisites
    },
    level_range = {1, 5},
    points = 5,
    mode = "passive",
    -- Skill effects
    modifiers = {
        -- Base modifiers
    },
    -- For meta-skills
    onModifySkill = function(self, target_skill, level)
        -- Modify target skill
    end,
}