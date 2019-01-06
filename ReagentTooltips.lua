ReagentTooltips = LibStub("AceAddon-3.0"):NewAddon("ReagentTooltips", "AceEvent-3.0", "AceConsole-3.0")
local AceConfig = LibStub("AceConfigDialog-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentTooltips");
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();

function ReagentTooltips:OnInitialize()
	ReagentTooltips:RegisterChatCommand("ReagentTooltips", "ChatCommand")

	ReagentTooltips.db = LibStub("AceDB-3.0"):New("ReagentTooltipsDB", ReagentTooltips.defaults, "profile");
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ReagentTooltips", ReagentTooltips.options)
	AceConfig:AddToBlizOptions("ReagentTooltips", "Reagent Tooltips");
end

function ReagentTooltips:OnEnable()
	if (ReagentTooltips:CheckDb() == true) then
		ReagentTooltips:HookTooltips();
	else
		message(L["All or part of ReagentTooltips's DB was not detected. Please exit the game and delete your ReagentTooltips folder and reinstall it to fix the problem."]);
	end
end

function ReagentTooltips:HookTooltips()
	GameTooltip:HookScript("OnTooltipSetItem", ReagentTooltips.ModifyItemTooltip);
end

function ReagentTooltips:ChatCommand()
	InterfaceOptionsFrame_OpenToCategory("Reagent Tooltips");
end

function ReagentTooltips:CheckDb()
	if (not ReagentTooltips.Alchemy) then
		return false;
	end
	if (not ReagentTooltips.Blacksmithing) then
		return false;
	end
	if (not ReagentTooltips.Cooking) then
		return false;
	end
	if (not ReagentTooltips.Enchanting) then
		return false;
	end
	if (not ReagentTooltips.Engineering) then
		return false;
	end
	if (not ReagentTooltips.FirstAid) then
		return false;
	end
	if (not ReagentTooltips.Inscription) then
		return false;
	end
	if (not ReagentTooltips.Jewelcrafting) then
		return false;
	end
	if (not ReagentTooltips.Leatherworking) then
		return false;
	end
	if (not ReagentTooltips.Mining) then
		return false;
	end
	if (not ReagentTooltips.Tailoring) then
		return false;
	end
	return true;
end

function ReagentTooltips.ModifyItemTooltip(tooltip)
	if (ReagentTooltips.db.profile.Disabled == false) then
		local ToolTipString = "";
		local TooltTipStringCount = 1;
		local itemName, itemLink = tooltip:GetItem();
		local ToolTipList = ReagentTooltips:SearchReagentDB(itemName);
		if (not itemName) or (not ToolTipList) or (#(ToolTipList) == 0) then
			return; --GTFO!
		end
		ReagentTooltips:SearchReagentDB(itemName);
		table.sort(ToolTipList);
		if (ReagentTooltips.db.profile.ToolTipCommma == false) then
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

function ReagentTooltips:SearchReagentDB(ItemName)
	if (not ItemName) or (not tostring(ItemName)) then
		return;
	end
	local ToolTipList = {};
	if (ReagentTooltips.db.profile.Disabled == false) then
		if (ReagentTooltips.db.profile.DisableProfession == false) then
			for k, v in pairs(ReagentTooltips.Alchemy) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Alchemy"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Blacksmithing) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Blacksmithing"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Cooking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Cooking"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Enchanting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Enchanting"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Engineering) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Engineering"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.FirstAid) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["First Aid"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Inscription) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Inscription"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Jewelcrafting) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Jewelcrafting"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Leatherworking) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Leatherworking"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Mining) do
				local item = GetItemInfo(v);
				if (item) and (ItemName == item) then
					table.insert(ToolTipList, BabbleInventory["Mining"]);
					break;
				end
			end
			for k, v in pairs(ReagentTooltips.Tailoring) do
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
