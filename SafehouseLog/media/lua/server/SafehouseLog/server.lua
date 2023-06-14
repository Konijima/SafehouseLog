local commands = {}

-- function commands.writeSafehouseEvent(player, eventName, safehouseId, targetPlayer, text)
--     local safehouse = SafehouseLog.getSafehouseFromID(safehouseId)
--     SafehouseLog.appendToLog(SafehouseLog.getPlayerInfo(targetPlayer or player) .. " : " .. eventName .. " safehouse '" .. safehouse:getTitle() .. "' " .. (text or ""))
-- end

function commands.writeSafehouseEvent(player, text)
    SafehouseLog.appendToLog(text)
end

---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
local function onClientCommand(module, command, player, args)
    if module ~= "SafehouseLog" or not commands[command] or type(commands[command]) ~= "function" or type(args) ~= "table" then return end
    commands[command](player, unpack(args))
end
Events.OnClientCommand.Add(onClientCommand)
