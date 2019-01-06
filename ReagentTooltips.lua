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
    ReagentTooltips.Inscription and
    ReagentTooltips.Jewelcrafting and
    ReagentTooltips.Leatherworking and
    ReagentTooltips.Mining and
    ReagentTooltips.Tailoring
  )
end

function ReagentTooltips:GetItemIDFromLink(itemLink)
  -- Regex taken from http://wowwiki.wikia.com/wiki/ItemLink
  local _, _, _, _, id, _, _, _, _, _, _, _, _, _ = string.find(
    itemLink,
    "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"
  )
  return id and tonumber(id);
end

function ReagentTooltips.ModifyItemTooltip(tooltip)
  if (not ReagentTooltips.db.profile.Disabled) then
    local ToolTipString = "";
    local TooltTipStringCount = 1;
    local itemName, itemLink = tooltip:GetItem();
    local itemID = ReagentTooltips:GetItemIDFromLink(itemLink);
    local ToolTipList = ReagentTooltips:SearchReagentDB(itemID);
    if (not itemID) or (not ToolTipList) or (#(ToolTipList) == 0) then
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

function ReagentTooltips:SearchReagentDB(itemIDQuery)
  if (ReagentTooltips.db.profile.Disabled) or (not itemIDQuery) or (not tostring(itemIDQuery)) then
    return {};
  end

  local ToolTipList = {};
  local professions = {
    "Alchemy",
    "Blacksmithing",
    "Cooking",
    "Enchanting",
    "Engineering",
    "Inscription",
    "Jewelcrafting",
    "Leatherworking",
    "Mining",
    "Tailoring",
  };

  for k, profession in ipairs(professions) do
    for k, itemID in pairs(ReagentTooltips[profession]) do
      if (itemIDQuery == itemID) then
        table.insert(ToolTipList, BabbleInventory[profession]);
        break;
      end
    end
  end

  return ToolTipList;
end
