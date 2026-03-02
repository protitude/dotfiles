-- Monkey patch for nvim-treesitter-context to prevent 'range' nil value errors
local M = {}

-- Apply the patch when this file is loaded
local function apply_patch()
    -- Suppress the deprecation warning
    local old_notify = vim.notify
    local notify_filter = function(msg, level, opts)
        if msg and (msg:match("vim.tbl_add_reverse_lookup is deprecated") or
                    msg:match("treesitter-context")) then
            return -- Don't show this message
        end
        return old_notify(msg, level, opts)
    end

    -- Start silent mode
    vim.notify = notify_filter

    -- Get the path to the plugin's context.lua file
    local plugin_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-treesitter-context/lua/treesitter-context/context.lua'
    local plugin_loaded = vim.fn.filereadable(plugin_path) == 1

    if not plugin_loaded then
        vim.notify = old_notify
        return
    end

    -- Try to get the original function that's causing the error
    local status_ok, ts_context = pcall(require, 'treesitter-context.context')
    if not status_ok then
        vim.notify = old_notify
        return
    end

    -- Add safety wrapper around functions that might be causing the error
    local original_get_context = ts_context.get_context
    if original_get_context then
        ts_context.get_context = function(...)
            local status, result = pcall(original_get_context, ...)
            if not status then
                -- If error occurs, return empty context instead of crashing
                return { contexts = {}, prev = {} }
            end
            return result
        end
    end

    -- Patch the implementation of context.range function if it's accessible
    local cache = package.loaded['treesitter-context.cache']
    if cache and cache.context_range then
        local original_context_range = cache.context_range
        cache.context_range = function(ctx, ...)
            if not ctx then return nil end
            
            local status, result = pcall(original_context_range, ctx, ...)
            if not status then
                -- Return nil instead of erroring
                return nil
            end
            return result
        end
    end

    -- Try to directly patch the error location
    local context_module = package.loaded['treesitter-context.context']
    if context_module then
        -- Hook into the problematic function
        for k, v in pairs(context_module) do
            if type(v) == 'function' then
                context_module[k] = function(...)
                    local status, result = pcall(v, ...)
                    if not status then
                        -- Silently fail instead of erroring
                        return nil
                    end
                    return result
                end
            end
        end
    end

    -- Restore original notify function
    vim.notify = old_notify
    
    -- Use a less intrusive notification
    vim.schedule(function()
        vim.api.nvim_echo({{"Treesitter context patched", "Comment"}}, false, {})
    end)
end

-- Apply the patch immediately
apply_patch()

return M
