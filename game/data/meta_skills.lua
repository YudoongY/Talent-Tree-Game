-- Define base meta-skill type
newSkillType{
    type = "meta",
    name = "Meta",
    description = "Skills that modify other skills",
}

-- Meta-skill framework
local MetaSkill = {
    -- Base meta-skill functions
    modifySkill = function(self, target, params)
        if not target then return end
        
        -- Store original values for restoration
        target._original = target._original or table.clone(target)
        
        -- Apply modifications
        self:applyEffect(target, params)
    end,
    
    restoreSkill = function(self, target)
        if target._original then
            table.merge(target, target._original)
            target._original = nil
        end
    end,
}

-- Example meta-skills
newSkill{
    id = "skill_amplifier",
    type = "meta",
    name = "Skill Amplifier",
    require = {
        stat = { mag=14 },
    },
    info = function(self, t)
        return ("Increases damage of target skill by %d%%"):format(self:getEffect(t))
    end,
    getEffect = function(self, t)
        return self:combatTalentScale(t, 10, 50)
    end,
    onModifySkill = function(self, t, target)
        if target.damage then
            target.damage = target.damage * (1 + self:getEffect(t)/100)
        end
    end,
}

newSkill{
    id = "skill_splitter",
    type = "meta",
    name = "Skill Splitter",
    require = {
        stat = { cun=16 },
    },
    info = function(self, t)
        return "Splits target skill into multiple weaker versions"
    end,
    onModifySkill = function(self, t, target)
        if target.damage then
            target.damage = target.damage * 0.6
            target.multiTarget = true
            target.maxTargets = self:combatTalentScale(t, 2, 4)
        end
    end,
}