local _, addon = ...
local module = addon:NewModule("AceHook-3.0")

local ActionBar = addon:Import("ActionBar")

local PETBAR_PATTERN = "PetAction%s"
local STANCEBAR_PATTERN = "Stance%sNormalTexture2"
local ACTIONBAR_PATTERN = "Action%s"
local BOTTOMRIGHT_ACTIONBAR_PATTERM = "MultiBarBottomRight%s"

local NUM_STANCE_SLOTS = 10
local NUM_PET_ACTION_SLOTS = 10

local textures = {
    MainMenuBarArtFrame.LeftEndCap,
    MainMenuBarArtFrame.RightEndCap,
    MainMenuBarArtFrameBackground.BackgroundLarge,
    MainMenuBarArtFrameBackground.BackgroundSmall,
    SlidingActionBarTexture0,
    SlidingActionBarTexture1,
    StanceBarLeft,
    StanceBarMiddle,
    StanceBarRight
}

local function SetActionButtonFloatingBackground(button)
    local floatingBG = button:CreateTexture(button:GetName() .. "FloatingBG", "BACKGROUND", nil, -1)
    floatingBG:SetTexture([[Interface\Buttons\UI-Quickslot]])
    floatingBG:SetPoint("TOPLEFT", button, "TOPLEFT", -15, 15)
    floatingBG:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 15, -15)
    floatingBG:SetAlpha(0.4)
end

function module:OnInitialize()
    for _, text in ipairs(textures) do
        text:SetAlpha(0)
        text:SetTexture(nil)
    end

    for stance in ActionBar:GetButtons(STANCEBAR_PATTERN, NUM_STANCE_SLOTS) do
        stance:SetAlpha(0)
        stance:SetTexture(nil)
    end

    for button in ActionBar:GetButtons(ACTIONBAR_PATTERN) do
        SetActionButtonFloatingBackground(button)
        button:SetAttribute("showgrid", 1)
        button:Show()
    end

    PetActionBarFrame.showgrid = 1;
    for button in ActionBar:GetButtons(PETBAR_PATTERN, NUM_PET_ACTION_SLOTS) do
        local texture = _G[button:GetName() .. "NormalTexture2"]
        texture:SetAlpha(0.4)
        button:Show()
    end

    for button in ActionBar:GetButtons(BOTTOMRIGHT_ACTIONBAR_PATTERM, 6) do
        SetActionButtonFloatingBackground(button)
        button.noGrid = nil
        button:SetAttribute("showgrid", 1)
        button:Show()
    end
end

module:SecureHook("MultiActionBar_ShowAllGrids", function(reason)
    ActionBar:ShowGrid(ACTIONBAR_PATTERN)
    ActionBar:ShowGrid(BOTTOMRIGHT_ACTIONBAR_PATTERM, 6)

    for index = 1, NUM_PET_ACTION_SLOTS do
		local button = _G["PetActionButton" .. index]
        if button then
            button:SetAlpha(1.0)
        end
    end
end)

module:SecureHook("MultiActionBar_HideAllGrids", function(reason)
    if (ALWAYS_SHOW_MULTIBARS == "1" or ALWAYS_SHOW_MULTIBARS == 1) and reason ~= ACTION_BUTTON_SHOW_GRID_REASON_CVAR then return end
    
    ActionBar:HideGrid(ACTIONBAR_PATTERN)
    ActionBar:HideGrid(BOTTOMRIGHT_ACTIONBAR_PATTERM, 6)

    for index = 1, NUM_PET_ACTION_SLOTS do
        local name = "PetActionButton" .. index
        local button = _G[name]
        if button then
            local icon = _G[name .. "Icon"]
            if icon and icon:GetTexture() then
                button:SetAlpha(1.0)
            else
                button:SetAlpha(0)
            end
        end
    end
end)