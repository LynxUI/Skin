-- Modifies the dropdown slightly to make it (subjectively) slightly more pleasant to look at

local _, addon = ...

local Backdrop = addon:Import("Widgets:Backdrop")
local BackdropColor = addon:Import("Widgets:BackdropColor")
local BackdropBorderColor = addon:Import("Widgets:BackdropBorderColor") 

for i = 1, UIDROPDOWNMENU_MAXLEVELS do
    local dropDownMenuBackdrop = _G["DropDownList" .. i .. "MenuBackdrop"]
    if dropDownMenuBackdrop then
        dropDownMenuBackdrop:SetBackdrop(Backdrop)
        dropDownMenuBackdrop:SetBackdropColor(unpack(BackdropColor))
        dropDownMenuBackdrop:SetBackdropBorderColor(unpack(BackdropBorderColor))
    end
end