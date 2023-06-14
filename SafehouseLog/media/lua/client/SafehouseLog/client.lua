--- Log safehouse invitation accepted
_ISSafehouseUI_onAnswerSafehouseInvite = _ISSafehouseUI_onAnswerSafehouseInvite or ISSafehouseUI.onAnswerSafehouseInvite
function ISSafehouseUI:onAnswerSafehouseInvite(button, ...)
    if button.internal == "YES" then
        ---@type SafeHouse
        local safehouse = button.parent.safehouse

        local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " joined [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
        sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
    end
    
    return _ISSafehouseUI_onAnswerSafehouseInvite(self, button, ...)
end

--- Log safehouse invitation sent
--- Log safehouse ownership transfer
_ISSafehouseAddPlayerUI_onClick = _ISSafehouseAddPlayerUI_onClick or ISSafehouseAddPlayerUI.onClick
function ISSafehouseAddPlayerUI:onClick(button, ...)
    if button.internal == "ADDPLAYER" then
        ---@type SafeHouse
        local safehouse = self.safehouse

        if not self.changeOwnership then
            local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " invited " .. self.selectedPlayer .. " to [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
            sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
        else
            local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " transferred [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "] ownership to " .. self.selectedPlayer
            sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
        end
    end

    return _ISSafehouseAddPlayerUI_onClick(self, button, ...)
end

--- Log safehouse released
--- Log safehouse admin removed
_ISSafehouseUI_onReleaseSafehouse = _ISSafehouseUI_onReleaseSafehouse or ISSafehouseUI.onReleaseSafehouse
function ISSafehouseUI:onReleaseSafehouse(button, player, ...)
    if button.internal == "YES" then
        ---@type SafeHouse
        local safehouse = button.parent.ui.safehouse

        if button.parent.ui:isOwner() then
            local text = SafehouseLog.getPlayerInfo(getPlayerFromUsername(button.parent.ui.safehouse:getOwner())) .. " released [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
            sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
        elseif button.parent.ui:hasPrivilegedAccessLevel() then
            local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " admin removed [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
            sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
        end
    end

    return _ISSafehouseUI_onReleaseSafehouse(self, button, player, ...)
end

--- Log member who's kicked from safehouse
_ISSafehouseUI_onRemovePlayerFromSafehouse = _ISSafehouseUI_onRemovePlayerFromSafehouse or ISSafehouseUI.onRemovePlayerFromSafehouse
function ISSafehouseUI:onRemovePlayerFromSafehouse(button, player, ...)
    if button.internal == "YES" then
        ---@type SafeHouse
        local safehouse = button.parent.ui.safehouse

        local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " removed player " .. button.parent.ui.selectedPlayer .. " from [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
        sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
    end

    return _ISSafehouseUI_onRemovePlayerFromSafehouse(self, button ,player, ...)
end

--- Log member who quitted safehouse
_ISSafehouseUI_onQuitSafehouse = _ISSafehouseUI_onQuitSafehouse or ISSafehouseUI.onQuitSafehouse
function ISSafehouseUI:onQuitSafehouse(button, ...)
    if button.internal == "YES" then
        ---@type SafeHouse
        local safehouse = button.parent.ui.safehouse

        local text = SafehouseLog.getPlayerInfo(button.parent.ui.player) .. " quitted [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
        sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
    end

    return _ISSafehouseUI_onQuitSafehouse(self, button, ...)
end

--- Log safehouse title change
_ISSafehouseUI_onChangeTitle = _ISSafehouseUI_onChangeTitle or ISSafehouseUI.onChangeTitle
function ISSafehouseUI:onChangeTitle(button, ...)
    if button.internal == "OK" then
        ---@type SafeHouse
        local safehouse = button.parent.safehouse
        local newTitle = button.parent.entry:getText()

        local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " changed [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "] title to '" .. newTitle .. "'"
        sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
    end

    return _ISSafehouseUI_onChangeTitle(self, button, ...)
end

--- Log claiming safehouse
_ISWorldObjectContextMenu_onTakeSafeHouse = _ISWorldObjectContextMenu_onTakeSafeHouse or ISWorldObjectContextMenu.onTakeSafeHouse
ISWorldObjectContextMenu.onTakeSafeHouse = function(worldobjects, square, player, ...)
    _ISWorldObjectContextMenu_onTakeSafeHouse(worldobjects, square, player, ...)

    local safehouse = SafeHouse.getSafeHouse(square)
    if safehouse then
        local text = SafehouseLog.getPlayerInfo(getSpecificPlayer(player)) .. " claimed [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
        sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
    end
end

--- Log admin defined safehouse creation
_ISAddSafeZoneUI_onClick = _ISAddSafeZoneUI_onClick or ISAddSafeZoneUI.onClick
function ISAddSafeZoneUI:onClick(button, ...)
    _ISAddSafeZoneUI_onClick(self, button, ...)
    
    if button.internal == "OK" then
        local x = math.floor(math.min(self.X1, self.X2));
		local y = math.floor(math.min(self.Y1, self.Y2));
		local w = math.floor(math.abs(self.X1 - self.X2) + 1);
		local h = math.floor(math.abs(self.Y1 - self.Y2) + 1);
        
        local safehouse = SafeHouse.getSafeHouse(x, y, w, h)
        if safehouse then
            local text = SafehouseLog.getPlayerInfo(getPlayer()) .. " created [" .. SafehouseLog.getSafehouseInfo(safehouse) .. "]"
            sendClientCommand("SafehouseLog", "writeSafehouseEvent", { getTimeInMillis() .. " -> " .. text })
        end
    end
end
