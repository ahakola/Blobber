--This announces kill priority only in 10m and 25m heroic modes. Velcro-mode (LFR) and normal modes not supported
--Bad coder does bad code, but at least the dogs bark and the caravan keeps on going...

--PRIORITIES SETUP:
--Purple, Green, Blue, Black -> Green / Alternatively Black !Spread! (More DPS to the boss)
local blob1 = "BLACK - Spread!"

--Green, Red, Black, Blue -> Green
local blob2 = "GREEN"

--Green, Yellow, Red; Black -> Green (Hardest one to heal)
local blob3 = "GREEN"

--Blue, Purple, Yellow; Green -> Yellow !Spread!
local blob4 = "YELLOW - Spread!"

--Blue, Black, Yellow; Purple -> Yellow / Alternatively Black (More DPS to the boss)
local blob5 = "YELLOW"

--Purple, Red, Black; Yellow -> Purple / Alternatively Yellow (This needs less raid CD:s)
local blob6 = "YELLOW"

--local blobdebug = "Divine Light" --

local A = LibStub("AceAddon-3.0"):NewAddon("Blobber", "AceConsole-3.0", "AceEvent-3.0")

function A:OnInitialize()
	DEFAULT_CHAT_FRAME:AddMessage("Blobber: |cFF00FF00Loaded|r")
-- 1.2
	A:RegisterChatCommand("blobber", "SlashCMD")
	A:RegisterChatCommand("blob", "SlashCMD")
	if not BlobberBool and strlen(tostring(BlobberBool)) == 3 then -- running first time (BlobberBool == nil), setting to true
		BlobberBool = true
		A:Print("Running first time, announcing is set to: |cFF00FF00"..tostring(BlobberBool).."|r");
	end
end

-- 1.2
function A:SlashCMD(arg)
	arg = arg:trim()
	if not arg or arg == "" then
		A:Print("Announcing is set to: |cFFFFFF00"..tostring(BlobberBool).."|r");
	elseif arg == "enable" or arg == "toggle" or arg == "true" or arg == "default" then
		BlobberBool = true
		A:Print("Announcing changed to: |cFF00FF00"..tostring(BlobberBool).."|r");
	elseif arg == "disable" or arg == "false" then
		BlobberBool = false
		A:Print("Announcing changed to: |cFFFF0000"..tostring(BlobberBool).."|r");
	else
		A:Print("Unknown command, try '/blobber', '/blobber enable' or '/blobber disable'");
	end
end

function A:OnEnable()
	A:RegisterEvent("ZONE_CHANGED_NEW_AREA", "CheckDS")
	A:RegisterEvent("ZONE_CHANGED", "CheckDS")
	A:RegisterEvent("PLAYER_ENTERING_WORLD", "CheckDS")
end

function A:CheckDS()
--	A:Print("|cFF8888FF"..GetRealZoneText().."|r") --
--	if (GetRealZoneText() == "Stormwind City") then --
	if (GetRealZoneText() == "Dragon Soul") then
		A:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--		A:Print("|cFF00FF00Registered|r") --
	else
		A:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--		A:Print("|cFFFF0000Unregistered|r") --
	end
end

function A:UNIT_SPELLCAST_SUCCEEDED(event, unitID, spell, rank, lineID, spellID)
	-- 1.2
	if not BlobberBool  then
		return
	end

	local diff =  GetInstanceDifficulty()
	if (diff > 2) then -- Heroic only
		if (spellID == 105420) then --Purple, Green, Blue, Black
			SendChatMessage(blob1, "YELL")
			SendChatMessage(blob1, "RAID")
		elseif (spellID == 105435) then --Green, Red, Black, Blue
			SendChatMessage(blob2, "YELL")
			SendChatMessage(blob2, "RAID")
		elseif (spellID == 105436) then --Green, Yellow, Red; Black
			SendChatMessage(blob3, "YELL")
			SendChatMessage(blob3, "RAID")
		elseif (spellID == 105437) then --Blue, Purple, Yellow; Green
			SendChatMessage(blob4, "YELL")
			SendChatMessage(blob4, "RAID")
		elseif (spellID == 105439) then --Blue, Black, Yellow; Purple
			SendChatMessage(blob5, "YELL")
			SendChatMessage(blob5, "RAID")
		elseif (spellID == 105440) then --Purple, Red, Black; Yellow
			SendChatMessage(blob6, "YELL")
			SendChatMessage(blob6, "RAID")
		else
			--Wut?
		end
--	else -- Debug stuff ----
--		if spellID == 105420 then --Purple, Green, Blue
--			A:Print("|cFF8888FF"..blob1.."|r")
--		elseif spellID == 105435 then --Green, Red, Black
--			A:Print("|cFF8888FF"..blob2.."|r")
--		elseif spellID == 105436 then --Green, Yellow, Red
--			A:Print("|cFF8888FF"..blob3.."|r")
--		elseif spellID == 105437 then --Blue, Purple, Yellow
--			A:Print("|cFF8888FF"..blob4.."|r")
--		elseif spellID == 105439 then --Blue, Black, Yellow
--			A:Print("|cFF8888FF"..blob5.."|r")
--		elseif spellID == 105440 then --Purple, Red, Black
--			A:Print("|cFF8888FF"..blob6.."|r")
--		elseif spellID == 82326 then --Debug
--			A:Print("|cFF8888FF"..blobdebug.."|r "..diff)
--			SendChatMessage(blobdebug, "YELL")
--		else
--			--Wut?
--		end ----
	end
end