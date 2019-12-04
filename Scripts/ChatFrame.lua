CHAT_FRAME_FADE_OUT_TIME = 0							

CHAT_TAB_HIDE_DELAY = 0										

CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0	

CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0		

CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1	
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0

for i = 1, NUM_CHAT_WINDOWS do
    local name = ("ChatFrame%d"):format(i)
    local frame = _G[name]

    -- Removes the ugly left-side background of the chat frame
    _G[(frame:GetName() .. "ButtonFrame")]:Hide()
    
    local tab = _G[frame:GetName() .. "Tab"]
    tab.noMouseAlpha = 0
    FCFTab_UpdateAlpha(frame)
    
    -- Enough of these ugly chat tabs!
    local tabName = tab:GetName()
    _G[tabName .. "Left"]:SetTexture(nil)
    _G[tabName .. "Middle"]:SetTexture(nil)
    _G[tabName .. "Right"]:SetTexture(nil)
end