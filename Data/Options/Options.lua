local ReagentTooltips = ReagentTooltips;
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentTooltips");

ReagentTooltips.options = {
	name = L["Reagent Tooltips"],
	type = 'group',
	args = {
			Disabled = {
				type = "toggle",
				name = L["Disable Reagent Tooltips"],
				desc = L["Disables Reagent Tooltips."],
				width = "full",
				get = function(info) return ReagentTooltips.db.profile.Disabled; end,
				set = function(info, v) ReagentTooltips.db.profile.Disabled = v;	end,
				order = 10
			},
			DisableProfession = {
				type = "toggle",
				name = L["Disable Profession Reagents"],
				desc = L["Disables Professions in the Reagent Tooltip."],
				width = "full",
				get = function(info) return ReagentTooltips.db.profile.DisableProfession; end,
				set = function(info, v) ReagentTooltips.db.profile.DisableProfession = v; end,
				order = 20
			},
			ToolTipCommma = {
				type = "toggle",
				name = L["Tooltip Commas"],
				desc = L["Seperates the results with commas and displays them in the Reagents Tooltip without taking up to much space."],
				width = "full",
				get = function(info) return ReagentTooltips.db.profile.ToolTipCommma; end,
				set = function(info, v) ReagentTooltips.db.profile.ToolTipCommma = v; end,
				order = 40
			},
	}
}
		

