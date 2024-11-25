-- Module identification
long_name = "Building Porn"
short_name = "BDPorn"
version = {1,0,0}
engine = {1,7,0}  -- Is the version correct?
description = "A Skill Tree Game"
author = {"YudoongY", "H"}

-- Dependencies
dependencies = {
    {'tome', version = {1,7,0}},  -- If you're building on ToME4
}

-- Load order
loader = {
    mod = { -- Module loading rules
        class = true,
        data = true,
    },
    -- Override ToME files if needed
    override = false,
}

-- Module configuration
configuration_opts = {
    -- Your game's configuration options
}

-- Initialize when the module loads
function init()
    -- Game initialization code
end

-- Called when a new game starts
function load()
    -- Game load code
end