const fetch = require('node-fetch');
const fs = require('fs');
const curry = require('curry');

function looseJsonParse(obj){
  return Function('"use strict";return (' + obj + ')')();
}

async function getReagents(url) {
  let res = await fetch(url);
  let html = await res.text();

  let listViewItemsJSMatch = html.match(/var listviewitems = (.*);\n/);

  if (!listViewItemsJSMatch) {
    throw "response did not contain a listviewitems array";
  }

  let listViewItemsJS = listViewItemsJSMatch[1];
  let listViewItems = looseJsonParse(listViewItemsJS);

  return listViewItems;
}

const wrapReagents = curry(function wrapReagents(name, list) {
  return { name, list };
});

async function getAndWrapReagents(name, url) {
  return await getReagents(url).then(wrapReagents(name));
}

async function getAndSaveAll() {
  let promises = [
    [ "alchemy",         "https://www.wowhead.com/items?filter=217:87;1:1;0:0" ],
    [ "blacksmithing",   "https://www.wowhead.com/items?filter=217:87;1:2;0:0" ],
    [ "cooking",         "https://www.wowhead.com/items?filter=217:87;1:3;0:0" ],
    [ "enchanting1",     "https://www.wowhead.com/items?filter=217:87;1:4;0:0" ],
    [ "enchanting2",     "https://www.wowhead.com/enchanting-trade-goods" ],
    [ "engineering",     "https://www.wowhead.com/items?filter=217:87;1:5;0:0" ],
    [ "inscription",     "https://www.wowhead.com/items?filter=217:87;1:15;0:0" ],
    [ "jewelcrafting1",  "https://www.wowhead.com/items?filter=217:87;1:7;0:0" ],
    [ "jewelcrafting2",  "https://www.wowhead.com/jewelcrafting-trade-goods" ],
    [ "leatherworking",  "https://www.wowhead.com/items?filter=217:87;1:8;0:0" ],
    [ "mining",          "https://www.wowhead.com/items?filter=217:87;1:9;0:0" ],
    [ "tailoring",       "https://www.wowhead.com/items?filter=217:87;1:10;0:0" ],
  ].map(([name, url]) => getAndWrapReagents(name, url));

  let all = await Promise.all(promises);

  all.forEach(({ name, list }) => {
    console.log(name);
    fs.writeFileSync(`${__dirname}/items-json/${name}.json`, JSON.stringify(list, null, 2));
  });
}

getAndSaveAll();
