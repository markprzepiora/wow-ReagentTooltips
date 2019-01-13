ReagentTooltips = LibStub("AceAddon-3.0"):NewAddon("ReagentTooltips", "AceEvent-3.0", "AceConsole-3.0")
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local PROFESSIONS = {
  "Alchemy", "Blacksmithing", "Cooking", "Enchanting", "Engineering",
  "Inscription", "Jewelcrafting", "Leatherworking", "Mining", "Tailoring",
}

local filter = function(fn, collection)
  local result = {}
  for _, value in ipairs(collection) do
    if fn(value) then
      table.insert(result, value)
    end
  end
  return result
end

local map = function(fn, collection)
  local result = {}
  for _, value in ipairs(collection) do
    table.insert(result, fn(value))
  end
  return result
end

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
  local itemName, itemLink = tooltip:GetItem()
  local itemID = getItemIDFromLink(itemLink)
  local matchingProfessions = ReagentTooltips.GetProfessionsUsingItem(itemID)

  for _, v in ipairs(matchingProfessions) do
    tooltip:AddLine(v)
  end

  tooltip:Show()
end

function ReagentTooltips.GetProfessionsUsingItem(itemIDQuery)
  local professionHasItem = function(profession) return ReagentTooltips[profession][itemIDQuery] end
  local localize = function(profession) return BabbleInventory[profession] end
  local matchingProfessions = filter(professionHasItem, PROFESSIONS)

  return map(localize, matchingProfessions)
end
