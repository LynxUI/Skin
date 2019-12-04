local _, addon = ...
local module = addon:NewModule("AceEvent-3.0")

local Backdrop = addon:Import("Widgets:Backdrop")
local BackdropColor = addon:Import("Widgets:BackdropColor")
local BackdropBorderColor = addon:Import("Widgets:BackdropBorderColor") 

TOOLTIP_DEFAULT_BACKGROUND_COLOR.r = BackdropColor[1]
TOOLTIP_DEFAULT_BACKGROUND_COLOR.g = BackdropColor[2]
TOOLTIP_DEFAULT_BACKGROUND_COLOR.b = BackdropColor[3]
TOOLTIP_DEFAULT_BACKGROUND_COLOR.a = BackdropColor[4]

TOOLTIP_DEFAULT_COLOR.r = BackdropBorderColor[1]
TOOLTIP_DEFAULT_COLOR.g = BackdropBorderColor[2]
TOOLTIP_DEFAULT_COLOR.b = BackdropBorderColor[3]
TOOLTIP_DEFAULT_COLOR.a = BackdropBorderColor[4]

local TOOLTIPS = {
    GameTooltip,
    ItemRefTooltip,
    WorldMapTooltip,
    WorldMapCompareTooltip1,
    WorldMapCompareTooltip2,
    ShoppingTooltip1,
    ShoppingTooltip2,
    ItemRefShoppingTooltip1,
    ItemRefShoppingTooltip2,
    FriendsTooltip,
    PartyMemberBuffTooltip,
    BoCTooltip
}

local TOOLTIP_BORDERED_FRAMES = {
    QueueStatusFrame,
    
    BattlePetTooltip,
    FloatingBattlePetTooltip,
    FloatingPetBattleAbilityTooltip,
    PetBattlePrimaryUnitTooltip,
    PetBattlePrimaryAbilityTooltip,
    
    GarrisonFollowerTooltip,
    GarrisonFollowerAbilityTooltip,
    BuildingLevelTooltip,
    FloatingGarrisonFollowerTooltip
}

local TOOLTIP_BORDERED_FRAMES_TEXTURES = {
    "BorderTopLeft",
    "BorderTopRight",
    "BorderBottomRight",
    "BorderBottomLeft",
    "BorderTop",
    "BorderRight",
    "BorderBottom",
    "BorderLeft",
    "Background"
}

local function UpdateBackdropColors(self)
    self:SetBackdropColor(unpack(BackdropColor))
    self:SetBackdropBorderColor(unpack(BackdropBorderColor))
end

local function UpdateBackdrop(self)
    self:SetBackdrop(Backdrop)
    UpdateBackdropColors(self)
end

for _, tooltip in ipairs(TOOLTIPS) do
    UpdateBackdrop(tooltip)
end

for _, tooltip in ipairs(TOOLTIP_BORDERED_FRAMES) do
    UpdateBackdrop(tooltip)
    for _, text in ipairs(TOOLTIP_BORDERED_FRAMES_TEXTURES) do
        tooltip[text]:Hide()
    end
end

module:RegisterEvent("PLAYER_LOGIN", function()
    local LibDBIcon = LibStub("LibDBIcon-1.0", true)
    if LibDBIcon then
        for _, button in pairs(LibDBIcon.objects) do
            button:HookScript("OnEnter", function()
                UpdateBackdropColors(LibDBIconTooltip or GameTooltip)
            end)
        end
    end
    GameTooltip:HookScript("OnUpdate", UpdateBackdropColors)
end)

