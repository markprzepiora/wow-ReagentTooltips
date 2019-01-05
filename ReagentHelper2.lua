ReagentHelper2 = LibStub("AceAddon-3.0"):NewAddon("ReagentHelper2", "AceEvent-3.0", "AceConsole-3.0")
local AceConfig = LibStub("AceConfigDialog-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentHelper2");
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();

function ReagentHelper2:OnInitialize()
	ReagentHelper2:RegisterChatCommand("rh", "ChatCommand")
	ReagentHelper2:RegisterChatCommand("rh2", "ChatCommand")
	ReagentHelper2:RegisterChatCommand("reagenthelper", "ChatCommand")
	ReagentHelper2:RegisterChatCommand("reagenthelper2", "ChatCommand")

	ReagentHelper2.db = LibStub("AceDB-3.0"):New("ReagentHelper2DB", ReagentHelper2.defaults, "profile");
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ReagentHelper2", ReagentHelper2.options)
	AceConfig:AddToBlizOptions("ReagentHelper2", "Reagent Helper 2");
end

function ReagentHelper2:OnEnable()
	if (ReagentHelper2:CheckDb() == true) then
		ReagentHelper2:HookTooltips();
	else
		message(L["All or part of ReagentHelper2's DB was not detected. Please exit the game and delete your ReagentHelper2 folder and reinstall it to fix the problem."]);
	end
end

function ReagentHelper2:HookTooltips()
	GameTooltip:HookScript("OnTooltipSetItem", ReagentHelper2.ModifyItemTooltip);
end

function ReagentHelper2:ChatCommand()
	InterfaceOptionsFrame_OpenToCategory("Reagent Helper 2");
end

function ReagentHelper2:CheckDb()
	if (not ReagentHelper2.Alchemy) then
		return false;
	end
	if (not ReagentHelper2.Blacksmithing) then
		return false;
	end
	if (not ReagentHelper2.Cooking) then
		return false;
	end
	if (not ReagentHelper2.Enchanting) then
		return false;
	end
	if (not ReagentHelper2.Engineering) then
		return false;
	end
	if (not ReagentHelper2.FirstAid) then
		return false;
	end
	if (not ReagentHelper2.Inscription) then
		return false;
	end
	if (not ReagentHelper2.Jewelcrafting) then
		return false;
	end
	if (not ReagentHelper2.Leatherworking) then
		return false;
	end
	if (not ReagentHelper2.Mining) then
		return false;
	end
	if (not ReagentHelper2.Tailoring) then
		return false;
	end
	return true;
end

function ReagentHelper2.ModifyItemTooltip(tooltip)
	if (ReagentHelper2.db.profile.Disabled == false) then
		local ToolTipString = "";
		local TooltTipStringCount = 1;
		local itemName, itemLink = tooltip:GetItem();
		local ToolTipList = ReagentHelper2:SearchReagentDB(itemName);
		if (not itemName) or (not ToolTipList) or (#(ToolTipList) == 0) then
			return; --GTFO!
		end
		ReagentHelper2:SearchReagentDB(itemName);
		table.sort(ToolTipList);
		if (ReagentHelper2.db.profile.ToolTipCommma == false) then
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

function ReagentHelper2:SearchReagentDB(ItemName)
	if (not ItemName) or (not tostring(ItemName)) then
		return;
	end
	local ToolTipList = {};
	if (ReagentHelper2.db.profile.Disabled == false) then
		if (ReagentHelper2.db.profile.DisableProfession == false) then
			for k, v in pairs(ReagentHelper2.Alchemy) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Alchemy"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Blacksmithing) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Blacksmithing"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Cooking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Cooking"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Enchanting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Enchanting"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Engineering) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Engineering"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.FirstAid) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["First Aid"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Inscription) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Inscription"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Jewelcrafting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Jewelcrafting"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Leatherworking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Leatherworking"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Mining) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Mining"]);
					break;
				end
			end
			for k, v in pairs(ReagentHelper2.Tailoring) do
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