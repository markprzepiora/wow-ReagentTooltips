ReagentTooltips = LibStub("AceAddon-3.0"):NewAddon("ReagentTooltips")
local Localize = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local PROFESSIONS = {
  "Alchemy", "Blacksmithing", "Cooking", "Enchanting", "Engineering",
  "Inscription", "Jewelcrafting", "Leatherworking", "Mining", "Tailoring",
}

local getItemIDFromLink = function(itemLink)
  -- Regex taken from http://wowwiki.wikia.com/wiki/ItemLink
  local _, _, _, _, id, _, _, _, _, _, _, _, _, _ = string.find(
    itemLink,
    "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"
  )
  return id and tonumber(id)
end

function ReagentTooltips:OnEnable()
  GameTooltip:HookScript("OnTooltipSetItem", ReagentTooltips.ModifyItemTooltip)
end

function ReagentTooltips.ModifyItemTooltip(tooltip)
  local _, itemLink = tooltip:GetItem()
  local itemID = getItemIDFromLink(itemLink)

  for _, profession in ipairs(PROFESSIONS) do
    if ReagentTooltips[profession][itemID] then
      tooltip:AddLine(Localize[profession])
    end
  end
end
