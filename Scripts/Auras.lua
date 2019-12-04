local _, addon = ...
local module = addon:NewModule("AceEvent-3.0", "AceHook-3.0")

local masque = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
if not masque then return end

local L = addon:GetLocale()

local BUFF_FRAMES = {
	["enchant"] = "TempEnchant",
	["player"] = "BuffButton"
}

local playerBuffGroup

local function ApplySkin(maxAuras, group, frameName, callback)
	for i = 1, maxAuras do
		local name = frameName .. i
		local frame = _G[name]
		if frame then
			group:AddButton(frame)
		else
			break
		end
		local border = _G[name .. "Border"]
		if frame and border and callback then
			callback(border)
		end
	end
end

function module:OnInitialize()
	local uiName = addon:GetUIName()

    playerBuffGroup = masque:Group(uiName, L["Player Buffs"])
end

module:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
	ApplySkin(NUM_TEMP_ENCHANT_FRAMES, playerBuffGroup, BUFF_FRAMES["enchant"], function(border)
		border:SetVertexColor(.75, 0, 1)
	end)
end)

module:SecureHook("AuraButton_Update", function()
    ApplySkin(BUFF_MAX_DISPLAY, playerBuffGroup, BUFF_FRAMES["player"])
end)