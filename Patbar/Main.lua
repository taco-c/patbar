import "Turbine"
import "Turbine.UI.Lotro"
import "Turbine.Gameplay"

import "Patbar.Patbar" -- Eller: Minibar,

function math.format( number )
    local left, num, right = string.match( number, "^([^%d]*%d)(%d*)(.-)$" )
	return left .. num:reverse():gsub( "(%d%d%d)", "%1," ):reverse() .. right
end

player = Turbine.Gameplay.LocalPlayer.GetInstance()
screen_w, screen_h = Turbine.UI.Display.GetSize()

-- win_w, win_h = 850, 240
win_w, win_h = 430, 315
win_x, win_y = screen_w / 2 - win_w / 2, 40
-- win_pos = Turbine.Load(Turbine.DataScope.Character, "Patbar", )

-- Bar
bar = Turbine.UI.Window()
bar:SetPosition(0, 0)
bar:SetSize(screen_w, 32)
bar:SetBackColor(Turbine.UI.Color(0.1, 0, 0, 0))

-- Control
control = Turbine.UI.Control()
control:SetParent(bar)
control:SetSize(400, 32)
control:SetPosition(screen_w / 2 - control:GetWidth() / 2, 0)

function control:MouseClick()
    window:ToggleVisible()
end

-- Label
label = Turbine.UI.Label()
label:SetParent(control)
label:SetWidth(400)
label:SetText(player:GetLevel() .. " " .. player:GetName())
label:SetPosition(0, 10)
label:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter);
label:SetFontStyle( Turbine.UI.FontStyle.Outline )

function label:MouseClick()
    window:ToggleVisible()
end

-- Window
window = Patbar.Patbar.Window(win_x, win_y, win_w, win_h)

-- Player stats changed
function updatePlayerInfo()
    if window:IsVisible() then
        window:UpdateInfo()
    end
end

function player:LevelChanged()
    label:SetText(player:GetLevel() .. " " .. player:GetName())
end

function player.MaxMoraleChanged()
    updatePlayerInfo()
end

function player.MaxPowerChanged()
    updatePlayerInfo()
end

-- Init
window:ToggleVisible() --while debugging/creating 
bar:SetVisible(true)