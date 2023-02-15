-------------------------------------------------------------------------------
-- ElvUI Minimap Button By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI)
local _G = getfenv(0)
local MMB = E.Libs.AceAddon:NewAddon("ElvUI_MinimapButton")
local L = E.Libs.ACL:GetLocale("ElvUI_MinimapButton", false)

MMB.addonName = "ElvUI_MinimapButton"

local IsShiftKeyDown = _G["IsShiftKeyDown"]
local pairs = pairs
local ReloadUI = _G["ReloadUI"]

local LDBI = LibStub("LibDBIcon-1.0")
local LDB = E.Libs.LDB:NewDataObject(MMB.addonName, {
    type = "launcher",
    text = "ElvUI",
    icon = [[Interface\Addons\ElvUI_MinimapButton\Textures\elvui.tga]],
    OnClick = function(_, button)
        if button == "LeftButton" then
            if IsShiftKeyDown() then
                E:ToggleMoveMode()
            else
                E:ToggleOptions()
            end
        elseif button == "RightButton" then
            if IsShiftKeyDown() then
                E:GetModule("ActionBars"):ActivateBindMode()
            else
                ReloadUI()
            end
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:ClearLines()
        tooltip:AddDoubleLine(("%s%s|r"):format(E.media.hexvaluecolor, L["ElvUI"]), ("%s: |cff5b7c99%.2f|r"):format(L["Version"], E.version), 1, 1, 1, 1, 1, 1)
        tooltip:AddLine(" ")
        tooltip:AddDoubleLine(L["Left Click:"], L["Toggle Configuration"], 1, 1, 1)
        tooltip:AddDoubleLine(L["Right Click:"], RELOADUI, 1, 1, 1)
        tooltip:AddDoubleLine(L["Shift + Left Click:"], L["Toggle Anchors"], 1, 1, 1)
        tooltip:AddDoubleLine(L["Shift + Right Click:"], L["Toggle Actionbar Keybind Mode"], 1, 1, 1)

        if E.Libs.EP.registeredPrefix then
            tooltip:AddLine(" ")
            tooltip:AddDoubleLine(L["Plugins:"], ("%s:"):format(L["Version"]))

            for _, plugin in pairs(E.Libs.EP.plugins) do
                if not plugin.isLib then
                    local r, g, b = E:HexToRGB(plugin.old and "ff3333" or "33ff33")
                    tooltip:AddDoubleLine(plugin.title, plugin.version, 1, 1, 1, r / 255, g / 255, b / 255)
                end
            end
        end
    end,
})

local db
local defaults = {
    global = {
        minimap = {
            hide = false,
        }
    }
}

function MMB:OnEnable()
    db.minimap.hide = false
    LDBI:Show(MMB.addonName)
end

function MMB:OnDisable()
    db.minimap.hide = true
    LDBI:Hide(MMB.addonName)
end

function MMB:OnInitialize()
    self.db = E.Libs.AceDB:New("ElvUI_MinimapButtonDB", defaults)
    db = self.db.global
    LDBI:Register(MMB.addonName, LDB, db.minimap)
    E.Libs.EP:RegisterPlugin(self.addonName)
end