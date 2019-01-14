const fs = require('fs');
const path = require('path');
const { sortBy, uniqBy, prop } = require('ramda');

let id = prop('id');
let sortByID = sortBy(id);
let uniqByID = uniqBy(id);

function merge(itemses) {
  let allItems = [].concat(...itemses);
  return uniqByID(allItems);
}

function coerceArray(object) {
  return Array.isArray(object) ? object : [object];
}

let files = [
  { jsonFileName: "alchemy.json", luaName: "Alchemy" },
  { jsonFileName: "blacksmithing.json", luaName: "Blacksmithing" },
  { jsonFileName: "cooking.json", luaName: "Cooking" },
  { jsonFileName: ["enchanting1.json", "enchanting2.json"], luaName: "Enchanting" },
  { jsonFileName: "engineering.json", luaName: "Engineering" },
  { jsonFileName: "inscription.json", luaName: "Inscription" },
  { jsonFileName: ["jewelcrafting1.json", "jewelcrafting2.json"], luaName: "Jewelcrafting" },
  { jsonFileName: "leatherworking.json", luaName: "Leatherworking" },
  { jsonFileName: "mining.json", luaName: "Mining" },
  { jsonFileName: "tailoring.json", luaName: "Tailoring" },
];

function loadJSON(filename) {
  return JSON.parse(fs.readFileSync(`${__dirname}/items-json/${filename}`));
}

files.forEach(({ jsonFileName, luaName }) => {
  let jsonFileNames = coerceArray(jsonFileName);
  let itemses = jsonFileNames.map(filename => loadJSON(filename));
  let items = merge(itemses);
  let itemsSortedByID = sortByID(items);
  let luaItemLines = itemsSortedByID.map(item => {
    const name = (item.name || "").replace(/^[0-9]/, '');
    return `  [${item.id}]=true, --${name}`;
  });

  let lua = `--[[
  Data Parsed from WowHead.com
]]

local ReagentTooltips = ReagentTooltips;

ReagentTooltips.${luaName} = {
${luaItemLines.join("\n")}
}
`;
  let outPath = path.join(__dirname, '..', 'Data', 'DB', 'Profession', `${luaName}.lua`);
  fs.writeFileSync(outPath, lua);
});
