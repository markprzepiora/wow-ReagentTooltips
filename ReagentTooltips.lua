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
  if (ReagentTooltips:CheckDb()) then
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
  return not not (
    ReagentTooltips.Alchemy and
    ReagentTooltips.Blacksmithing and
    ReagentTooltips.Cooking and
    ReagentTooltips.Enchanting and
    ReagentTooltips.Engineering and
    ReagentTooltips.FirstAid and
    ReagentTooltips.Inscription and
    ReagentTooltips.Jewelcrafting and
    ReagentTooltips.Leatherworking and
    ReagentTooltips.Mining and
    ReagentTooltips.Tailoring
  )
end

function ReagentTooltips.ModifyItemTooltip(tooltip)
  if (not ReagentTooltips.db.profile.Disabled) then
    local ToolTipString = "";
    local TooltTipStringCount = 1;
    local itemName, itemLink = tooltip:GetItem();
    local ToolTipList = ReagentTooltips:SearchReagentDB(itemName);
    if (not itemName) or (not ToolTipList) or (#(ToolTipList) == 0) then
      return;
    end
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
  if (ReagentTooltips.db.profile.Disabled) or (not ItemName) or (not tostring(ItemName)) then
    return {};
  end

  local ToolTipList = {};

  local professions = {
    "Alchemy",
    "Blacksmithing",
    "Cooking",
    "Enchanting",
    "Engineering",
    "FirstAid",
    "Inscription",
    "Jewelcrafting",
    "Leatherworking",
    "Mining",
    "Tailoring",
  };

  for k, profession in ipairs(professions) do
    for k, v in pairs(ReagentTooltips[profession]) do
      local item = GetItemInfo(v);
      if (item) and (ItemName == item) then
        table.insert(ToolTipList, BabbleInventory[profession]);
        break;
      end
    end
  end

  return ToolTipList;
end
