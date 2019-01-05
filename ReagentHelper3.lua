ReagentHelper3 = LibStub("AceAddon-3.0"):NewAddon("ReagentHelper3", "AceEvent-3.0", "AceConsole-3.0")
local AceConfig = LibStub("AceConfigDialog-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentHelper3");
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();

function ReagentHelper3:OnInitialize()
	ReagentHelper3:RegisterChatCommand("rh", "ChatCommand")
	ReagentHelper3:RegisterChatCommand("rh3", "ChatCommand")
	ReagentHelper3:RegisterChatCommand("reagenthelper", "ChatCommand")
	ReagentHelper3:RegisterChatCommand("reagenthelper3", "ChatCommand")

	ReagentHelper3.db = LibStub("AceDB-3.0"):New("ReagentHelper3DB", ReagentHelper3.defaults, "profile");
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ReagentHelper3", ReagentHelper3.options)
	AceConfig:AddToBlizOptions("ReagentHelper3", "Reagent Helper 3");
end

function ReagentHelper3:OnEnable()
	if (ReagentHelper3:CheckDb() == true) then
		ReagentHelper3:HookTooltips();
	else
		message(L["All or part of ReagentHelper3's DB was not detected. Please exit the game and delete your ReagentHelper3 folder and reinstall it to fix the problem."]);
	end
end

function ReagentHelper3:HookTooltips()
	GameTooltip:HookScript("OnTooltipSetItem", ReagentHelper3.ModifyItemTooltip);
end

function ReagentHelper3:ChatCommand()
	InterfaceOptionsFrame_OpenToCategory("Reagent Helper 3");
end

function ReagentHelper3:CheckDb()
	if (not ReagentHelper3.Alchemy) then
		return false;
	end
	if (not ReagentHelper3.Blacksmithing) then
		return false;
	end
	if (not ReagentHelper3.Cooking) then
		return false;
	end
	if (not ReagentHelper3.Enchanting) then
		return false;
	end
	if (not ReagentHelper3.Engineering) then
		return false;
	end
	if (not ReagentHelper3.FirstAid) then
		return false;
	end
	if (not ReagentHelper3.Inscription) then
		return false;
	end
	if (not ReagentHelper3.Jewelcrafting) then
		return false;
	end
	if (not ReagentHelper3.Leatherworking) then
		return false;
	end
	if (not ReagentHelper3.Mining) then
		return false;
	end
	if (not ReagentHelper3.Tailoring) then
		return false;
	end
	return true;
end

function ReagentHelper3.ModifyItemTooltip(tooltip)
	if (ReagentHelper3.db.profile.Disabled == false) then
		local ToolTipString = "";
		local TooltTipStringCount = 1;
		local itemName, itemLink = tooltip:GetItem();
		local ToolTipList = ReagentHelper3:SearchReagentDB(itemName);
		if (not itemName) or (not ToolTipList) or (#(ToolTipList) == 0) then
			return; --GTFO!
		end
		ReagentHelper3:SearchReagentDB(itemName);
		table.sort(ToolTipList);
		if (ReagentHelper3.db.profile.ToolTipCommma == false) then
			for k, v in pairs(ToolTipList) do
				tooltip:AddLine(v);
			end
		else
			for k, v in pairs(ToolTipList) do
				if (ToolTipString == "") or (ToolTipString == nil) then
					ToolTipString = v;
					TooltTipStringCount = TooltTipStringCount + 1;
				else
					if (TooltTipStringCount == 4) or (TooltTipStringCount == 7) or (TooltTipStringCount == 10) then
						tooltip:AddLine(ToolTipString..",");
						ToolTipString = "";
						ToolTipString = v;
						TooltTipStringCount = TooltTipStringCount + 1;
					else
						ToolTipString = ToolTipString..", "..v;
						TooltTipStringCount = TooltTipStringCount + 1;
					end
				end
			end
			tooltip:AddLine(ToolTipString);
		end
		tooltip:Show();
	end
end

function ReagentHelper3:SearchReagentDB(ItemName)
	if (not ItemName) or (not tostring(ItemName)) then
		return;
	end
	local ToolTipList = {};
	if (ReagentHelper3.db.profile.Disabled == false) then
		if (ReagentHelper3.db.profile.DisableProfession == false) then
			for k, v in pairs(ReagentHelper3.Alchemy) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Alchemy"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Blacksmithing) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Blacksmithing"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Cooking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Cooking"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Enchanting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Enchanting"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Engineering) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Engineering"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.FirstAid) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["First Aid"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Inscription) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Inscription"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Jewelcrafting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Jewelcrafting"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Leatherworking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Leatherworking"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Mining) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Mining"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper3.Tailoring) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Tailoring"]);
					break;
				end
			end
		end		
	end
	return ToolTipList;
end
