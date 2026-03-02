-- A fallback option to completely disable treesitter-context if it's causing problems
-- Rename this file to treesitter-context.lua to use it (temporarily disabling the plugin)

local M = {
    enable = false,
    setup = function(opts)
        -- Do nothing, effectively disabling the plugin
        print("nvim-treesitter-context is disabled by the fallback file")
    end,
    update_context = function()
        -- No-op, preventing errors
    end
}

-- Return a dummy module that prevents errors
return M
