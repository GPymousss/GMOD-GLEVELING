util.AddNetworkString("gLevelingSync")

local playersData = {}

local function gServerCalculateExpForLevel(level)
	return math.floor(100 * level * 1.5)
end

local function gServerResetAllLevels()
	for steamID in pairs(playersData) do
		playersData[steamID].level = 1
		playersData[steamID].exp = 0
	end
end

local function gServerGetPlayerCount()
	return table.Count(playersData)
end

local function gServerFindHighestLevelPlayer()
	local highestLevel = 0
	local topPlayer = nil

	for steamID, data in pairs(playersData) do
		if data.level > highestLevel then
			highestLevel = data.level
			topPlayer = steamID
		end
	end

	return topPlayer, highestLevel
end

local function gServerSyncPlayerData(ply)
	local steamID = ply:SteamID64()
	if not playersData[steamID] then return end

	gNetSendToClient("gLevelingSync", {
		level = playersData[steamID].level,
		exp = playersData[steamID].exp
	}, ply)
end

local ply = FindMetaTable("Player")

function ply:gServerSetLevel(level)
	if not IsValid(self) then
		MsgC(Color(150, 0, 0), "Joueur invalide...")
		return
	end

	local gSteamID = self:SteamID64()

	if not playersData[gSteamID] then
		playersData[gSteamID] = {}
	end

	playersData[gSteamID].level = level

	gServerSyncPlayerData(self)
end

function ply:gServerGetLevel()
	local gSteamID = self:SteamID64()

	if not playersData[gSteamID] then
		playersData[gSteamID] = {level = 1, exp = 0}
	end

	return playersData[gSteamID].level or 1
end

function ply:gServerSetExp(exp)
	if not IsValid(self) then
		MsgC(Color(150, 0, 0), "Joueur invalide...")
		return
	end

	local gSteamID = self:SteamID64()

	if not playersData[gSteamID] then
		playersData[gSteamID] = {level = 1, exp = 0}
	end

	playersData[gSteamID].exp = exp

	gServerSyncPlayerData(self)
end

function ply:gServerGetExp()
	local gSteamID = self:SteamID64()

	if not playersData[gSteamID] then
		playersData[gSteamID] = {level = 1, exp = 0}
	end

	return playersData[gSteamID].exp or 0
end

function ply:gServerAddExp(amount)
	self:gServerSetExp(self:gServerGetExp() + amount)

	local currentExp = self:gServerGetExp()
	local levelsGained = 0

	while true do
		local nextLevelExp = gServerCalculateExpForLevel(self:gServerGetLevel())

		if currentExp >= nextLevelExp then
			currentExp = currentExp - nextLevelExp
			levelsGained = levelsGained + 1
			self:gServerSetLevel(self:gServerGetLevel() + 1)
		else
			break
		end
	end

	self:gServerSetExp(currentExp)

	if levelsGained > 0 then
		if levelsGained == 1 then
			self:ChatPrint("Félicitations ! Vous êtes passé au niveau " .. self:gServerGetLevel())
		else
			self:ChatPrint("Félicitations ! Vous avez gagné " .. levelsGained .. " niveaux ! Vous êtes maintenant niveau " .. self:gServerGetLevel())
		end
	end
end