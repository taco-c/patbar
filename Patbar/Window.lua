import "Turbine"
import "Turbine.UI.Lotro"

Window = class(Turbine.UI.Lotro.Window)

function Window:Constructor(x, y, w, h)
    Turbine.UI.Lotro.Window.Constructor(self)
    self:SetPosition(x, y)
    self:SetSize(w, h)
    
    -- data[1]["value"] = player:GetMaxMorale
    -- Player:GetAttributes():GetArmor()
    -- self.PlayerData = data

    self.morale = Turbine.UI.Label()
    self.morale:SetParent(self)
    self.morale:SetPosition(25, 40)
    self.morale:SetSize(175, 100)
    self.morale:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
    self.morale:SetText("Morale:")

    self.morale_right = Turbine.UI.Label()
    self.morale_right:SetParent(self)
    self.morale_right:SetPosition(25, 40)
    self.morale_right:SetSize(175, 100)
    self.morale_right:SetTextAlignment(Turbine.UI.ContentAlignment.TopRight)

    self.armour = Turbine.UI.Label()
    self.armour:SetParent(self)
    self.armour:SetPosition(225, 40)
    self.armour:SetSize(175, 100)
    self.armour:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
    self.armour:SetText("Armour:")

    self.armour_right = Turbine.UI.Label()
    self.armour_right:SetParent(self)
    self.armour_right:SetPosition(225, 40)
    self.armour_right:SetSize(175, 100)
    self.armour_right:SetTextAlignment(Turbine.UI.ContentAlignment.TopRight)
    
    self:UpdateInfo()
end

function Window:UpdateInfo()
    self.Data = {
        Morale = format(math.round(player:GetMaxMorale())),
        Armour = format(math.round(player:GetAttributes():GetArmor()))
    }
    self.morale_right:SetText(self.Data.Morale)
    self.armour_right:SetText(self.Data.Armour)
end

function Window:ToggleVisible()
    self:SetVisible(not self:IsVisible())
    if self:IsVisible() then
        self:UpdateInfo()
    end
end

function format( number )
    local left, num, right = string.match( number, "^([^%d]*%d)(%d*)(.-)$" )
	return left .. num:reverse():gsub( "(%d%d%d)", "%1," ):reverse() .. right
end