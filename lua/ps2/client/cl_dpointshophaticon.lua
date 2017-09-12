local PANEL = {}

function PANEL:Init( )
end

function PANEL:PerformLayout()
	self.BaseClass.PerformLayout(self)

	self.Label:SetWide(self:GetWide())
	self.Label:SetPos(0, self:GetTall() - 25)
	self.Label:SetTall(25)
end

function PANEL:SetItemClass( itemClass )
	if itemClass.iconInfo.shop.useMaterialIcon then
		DPointshopItemIcon.SetItemClass( self, itemClass )
		if Material(itemClass.iconInfo.shop.iconMaterial) then
			self.image:SetImage( itemClass.iconInfo.shop.iconMaterial )
		else
			LibK.GLib.Error("Invalid Material :" .. tostring(itemClass.iconInfo.shop.iconMaterial) .. " for item " .. self:GetPrintName())
		end
	else
		-- Delegate to DCsgoItemIcon
		self.BaseClass.SetItemClass( self, itemClass )
	end
end

function PANEL:SetItem( item )
	self:SetItemClass( item.class )
end

function PANEL:OnSelected( )
	hook.Run( "PACItemSelected", self.itemClass )
end

function PANEL:OnDeselected( )
	hook.Run( "PACItemDeSelected", self.itemClass )
end

derma.DefineControl( "DPointshopHatIcon", "", PANEL, "DCsgoItemIcon" )