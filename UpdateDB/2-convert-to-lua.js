const fs = require('fs');
const path = require('path');

let files = [
  { jsonFileName: "alchemy.json",         luaName: "Alchemy" },
  { jsonFileName: "blacksmithing.json",   luaName: "Blacksmithing" },
  { jsonFileName: "cooking.json",         luaName: "Cooking" },
  { jsonFileName: "enchanting.json",      luaName: "Enchanting" },
  { jsonFileName: "engineering.json",     luaName: "Engineering" },
  { jsonFileName: "inscription.json",     luaName: "Inscription" },
  { jsonFileName: "jewelcrafting.json",   luaName: "Jewelcrafting" },
  { jsonFileName: "leatherworking.json",  luaName: "Leatherworking" },
  { jsonFileName: "mining.json",          luaName: "Mining" },
  { jsonFileName: "tailoring.json",       luaName: "Tailoring" },
];

files.forEach(({ jsonFileName, luaName }) => {
  let items = JSON.parse(fs.readFileSync(`${__dirname}/items-json/${jsonFileName}`));
  let luaItemLines = items.map(item => {
    const name = (item.name || "").replace(/^[0-9]/, '');
    return `  ${item.id}, --${name}`;
  });

  let lua = `--[[
  Data Parsed from WowHead.com
]]

local ReagentHelper3 = ReagentHelper3;

ReagentHelper3.${luaName} = {
${luaItemLines.join("\n")}
}
`;
  let outPath = path.join(__dirname, '..', 'Data', 'DB', 'Profession', `${luaName}.lua`);
  fs.writeFileSync(outPath, lua);
});
