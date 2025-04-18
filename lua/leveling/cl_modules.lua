local playerLocalData = {
	level = 1,
	exp = 0
}

local function gClientCalculateExpForLevel(level)
	return math.floor(100 * level * 1.5)
end

gNetReceive("gLevelingSync", function(data)
	playerLocalData.level = data.level
	playerLocalData.exp = data.exp
end)

local ply = FindMetaTable("Player")

function ply:gClientGetLevel()
	if self ~= LocalPlayer() then return 0 end
	return playerLocalData.level
end

function ply:gClientGetExp()
	if self ~= LocalPlayer() then return 0 end
	return playerLocalData.exp
end

function ply:gClientGetNextLevelExp()
	if self ~= LocalPlayer() then return 0 end
	return gClientCalculateExpForLevel(playerLocalData.level)
end

function ply:gClientGetExpProgress()
	if self ~= LocalPlayer() then return 0 end
	local nextLevelExp = gClientCalculateExpForLevel(playerLocalData.level)
	return (playerLocalData.exp / nextLevelExp) * 100
end