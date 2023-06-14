SafehouseLog = {}

--- Get the player role and username as a string
---@param player IsoPlayer
---@return string
function SafehouseLog.getPlayerInfo(player)
    return "(" .. player:getAccessLevel() .. ") " .. player:getUsername() .. " '" .. player:getFullName() .. "'"
end

---Get the safehouse information as a string
---@param safehouse SafeHouse
---@return string
function SafehouseLog.getSafehouseInfo(safehouse)
    local text = ""
    -- local square = getCell() and getCell():getGridSquare(safehouse:getX() + safehouse:getW() / 2, safehouse:getY() + safehouse:getH() / 2, 0)
    -- local building = square and square:getBuilding()
    -- if building then
    --     text = text .. "Building ID:" .. tostring(building:getID())
    --     if building:getDef() and building:getDef():getZone() then
    --         text = text .. " Zone:" .. building:getDef():getZone():getName()
    --     end
    -- end
    return text .. "'" .. safehouse:getTitle() .. "' " ..  safehouse:getId()
end

--- Append text to the safehouse log
---@param str string
function SafehouseLog.appendToLog(str)
    local writer = getFileWriter("safehouse.log", true, true)
    if writer then
        writer:writeln(str)
        writer:close()
    end
end

--- Get a safehouse from it's ID
---@param id string
function SafehouseLog.getSafehouseFromID(id)
    local safehouses = SafeHouse.getSafehouseList()
    for i = 1, safehouses:size() do
        ---@type SafeHouse
        local safehouse = safehouses:get(i - 1)
        if safehouse and safehouse:getId() == id then
            return safehouse
        end
    end
end
