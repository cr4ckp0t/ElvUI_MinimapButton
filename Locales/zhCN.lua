-------------------------------------------------------------------------------
-- ElvUI_MinimapButton By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local debug = false
--@debug@
debug = true
--@end-debug@
local E, _, _, _, _ = unpack(ElvUI)
local L = E.Libs.ACL:NewLocale("ElvUI_MinimapButton", "zhCN", true, debug)
if not L then return end

--@localization(locale="zhCN", format="lua_additive_table", same-key-is-true=true, escape-non-ascii=true, handle-unlocalized="english")@