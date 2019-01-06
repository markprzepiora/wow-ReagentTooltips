ReagentTooltips = LibStub("AceAddon-3.0"):NewAddon("ReagentTooltips", "AceEvent-3.0", "AceConsole-3.0")
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

function ReagentTooltips:OnEnable()
  GameTooltip:HookScript("OnTooltipSetItem", ReagentTooltips.ModifyItemTooltip);
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
  local itemName, itemLink = tooltip:GetItem();
  local itemID = ReagentTooltips:GetItemIDFromLink(itemLink);
  local ToolTipList = ReagentTooltips:GetProfessionsUsingItem(itemID);

  if (not itemID) or (not ToolTipList) or (#(ToolTipList) == 0) then
    return;
  end

  table.sort(ToolTipList);

  for _, v in pairs(ToolTipList) do
    tooltip:AddLine(v);
  end

  tooltip:Show();
end

function ReagentTooltips:GetProfessionsUsingItem(itemIDQuery)
  local ToolTipList = {};

  for _, profession in ipairs(PROFESSIONS) do
    if (ReagentTooltips[profession][itemIDQuery]) then
      table.insert(ToolTipList, BabbleInventory[profession]);
    end
  end

  return ToolTipList;
end
