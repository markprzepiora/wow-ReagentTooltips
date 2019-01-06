ReagentTooltips = LibStub("AceAddon-3.0"):NewAddon("ReagentTooltips", "AceEvent-3.0", "AceConsole-3.0")
local AceConfig = LibStub("AceConfigDialog-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("ReagentTooltips");
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local PROFESSIONS = {
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
  for _, profession in ipairs(PROFESSIONS) do
    if (not ReagentTooltips[profession]) then
      return false
    end
  end

  return true
end

function ReagentTooltips:GetItemIDFromLink(itemLink)
  -- Regex taken from http://wowwiki.wikia.com/wiki/ItemLink
  local _, _, _, _, id, _, _, _, _, _, _, _, _, _ = string.find(
    itemLink,
    "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"
  )
  return id and tonumber(id);
end

local mod = function(n, k)
  return n - math.floor(n/k)*k
end

function ReagentTooltips.ModifyItemTooltip(tooltip)
  if (not ReagentTooltips.db.profile.Disabled) then
    local ToolTipString = "";
    local itemName, itemLink = tooltip:GetItem();
    local itemID = ReagentTooltips:GetItemIDFromLink(itemLink);
    local ToolTipList = ReagentTooltips:SearchReagentDB(itemID);
    if (not itemID) or (not ToolTipList) or (#(ToolTipList) == 0) then
      return;
    end
    table.sort(ToolTipList);
    if (not ReagentTooltips.db.profile.ToolTipCommma) then
      -- In the normal case, we just put one profession on each line
      for _, v in pairs(ToolTipList) do
        tooltip:AddLine(v);
      end
    else
      for index, v in pairs(ToolTipList) do
        if (ToolTipString == "") then
          ToolTipString = v;
        else
          -- When we reach three words on a line, split
          if (index > 3 and mod(index, 3) == 1) then
            tooltip:AddLine(ToolTipString .. ",");
            ToolTipString = v;
          -- Until then, join with commas
          else
            ToolTipString = ToolTipString .. ", " .. v;
          end
        end
      end
      tooltip:AddLine(ToolTipString);
    end
    tooltip:Show();
  end
end

function ReagentTooltips:SearchReagentDB(itemIDQuery)
  local ToolTipList = {};

  for _, profession in ipairs(PROFESSIONS) do
    if (ReagentTooltips[profession][itemIDQuery]) then
      table.insert(ToolTipList, BabbleInventory[profession]);
    end
  end

  return ToolTipList;
end
