local ReagentHelper3 = ReagentHelper3;
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentHelper3");

ReagentHelper3.options = {
	name = L["Reagent Helper 3"],
	type = 'group',
	args = {
			Disabled = {
				type = "toggle",
				name = L["Disable Reagent Helper 3"],
				desc = L["Disables Reagent Helper 3."],
				width = "full",
				get = function(info) return ReagentHelper3.db.profile.Disabled; end,
				set = function(info, v) ReagentHelper3.db.profile.Disabled = v;	end,
				order = 10
			},
			DisableProfession = {
				type = "toggle",
				name = L["Disable Profession Reagents"],
				desc = L["Disables Professions in the Reagent Tooltip."],
				width = "full",
				get = function(info) return ReagentHelper3.db.profile.DisableProfession; end,
				set = function(info, v) ReagentHelper3.db.profile.DisableProfession = v; end,
				order = 20
			},
			ToolTipCommma = {
				type = "toggle",
				name = L["Tooltip Commas"],
				desc = L["Seperates the results with commas and displays them in the Reagents Tooltip without taking up to much space."],
				width = "full",
				get = function(info) return ReagentHelper3.db.profile.ToolTipCommma; end,
				set = function(info, v) ReagentHelper3.db.profile.ToolTipCommma = v; end,
				order = 40
			},
	}
}
		

