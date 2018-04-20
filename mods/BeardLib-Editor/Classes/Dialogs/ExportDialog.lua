ExportDialog = ExportDialog or class(MenuDialog)
ExportDialog.type_name = "ExportDialog"
function ExportDialog:_Show(params)
    local p = table.merge({title = "Export a unit", yes = "Export", no = "Close", w = 600}, params)
    if not self.super._Show(self, p) then
        return
    end
    self._units = params.units
    self._assets_manager = params.assets_manager
    MenuUtils:new(self, self._menu:Menu({name = "holder", index = 3, auto_height = true}))

    local semi_opt = {help = "Semi optional asset, some units don't need it and some do, better keep it on."}
    local opt = {help = "Optional asset, the game can load it by itself."}
    
    self:Divider("Include:")
    self:Toggle("NetworkUnits", nil, true)
    self:Toggle("Animations", nil, true, semi_opt)
    self:Toggle("SoundBanks", nil, true, semi_opt)
    self:Toggle("Textures", nil, false, opt)
    self:Toggle("Models", nil, false, opt)
    self:Toggle("CookedPhysics", nil, false, opt)
end

function ExportDialog:hide(success)
    if success then
        self._assets_manager:load_from_extract(self._units, {
            animation = not self:GetItem("Animations"):Value(),
            bnk = not self:GetItem("SoundBanks"):Value(),
            texture = not self:GetItem("Textures"):Value(),
            model = not self:GetItem("Models"):Value(),
            cooked_physics = not self:GetItem("CookedPhysics"):Value(),
            network_unit = not self:GetItem("NetworkUnits"):Value()
        }, true)
    end
    return ExportDialog.super.hide(self, success)
end