--[[
  Data Parsed from WowHead.com
]]

local ReagentHelper2 = ReagentHelper2;

ReagentHelper2.Cooking = {
	159, --Refreshing Spring Water
	723, --Goretusk Liver
	769, --Chunk of Boar Meat
	785, --Mageroyal
	1015, --Lean Wolf Flank
	1080, --Tough Condor Meat
	1179, --Ice Cold Milk
	1468, --Murloc Fin
	2251, --Gooey Spider Leg
	2452, --Swiftthistle
	2593, --Flask of Port
	2594, --Flagon of Mead
	2595, --Jug of Bourbon
	2596, --Skin of Dwarven Stout
	2672, --Stringy Wolf Meat
	2673, --Coyote Meat
	2674, --Crawler Meat
	2675, --Crawler Claw
	2677, --Boar Ribs
	2678, --Mild Spices
	2886, --Crag Boar Rib
	2924, --Crocolisk Meat
	3173, --Bear Meat
	3404, --Buzzard Wing
	3667, --Tender Crocolisk Meat
	3685, --Raptor Egg
	3712, --Turtle Meat
	3730, --Big Bear Meat
	3731, --Lion Meat
	3821, --Goldthorn
	4402, --Small Flame Sac
	4537, --Tel'Abim Banana
	4603, --Raw Spotted Yellowtail
	4655, --Giant Clam Meat
	5051, --Dig Rat
	5465, --Small Spider Leg
	5466, --Scorpid Stinger
	5467, --Kodo Meat
	5468, --Soft Frenzy Flesh
	5469, --Strider Meat
	5470, --Thunder Lizard Tail
	5471, --Stag Meat
	5503, --Clam Meat
	5504, --Tangy Clam Meat
	6289, --Raw Longjaw Mud Snapper
	6291, --Raw Brilliant Smallfish
	6303, --Raw Slitherskin Mackerel
	6308, --Raw Bristle Whisker Catfish
	6317, --Raw Loch Frenzy
	6361, --Raw Rainbow Fin Albacore
	6362, --Raw Rockscale Cod
	6522, --Deviate Fish
	6889, --Small Egg
	7974, --Zesty Clam Meat
	8150, --Deeprock Salt
	8365, --Raw Mithril Head Trout
	9061, --Goblin Rocket Fuel
	9260, --Volatile Rum
	12037, --Mystery Meat
	12184, --Raptor Flesh
	12202, --Tiger Meat
	12203, --Red Wolf Meat
	12204, --Heavy Kodo Meat
	12205, --White Spider Meat
	12206, --Tender Crab Meat
	12207, --Giant Egg
	12208, --Tender Wolf Meat
	12223, --Meaty Bat Wing
	12808, --Essence of Undeath
	13754, --Raw Glossy Mightfish
	13755, --Winter Squid
	13756, --Raw Summer Bass
	13757, --Lightning Eel
	13758, --Raw Redgill
	13759, --Raw Nightfin Snapper
	13760, --Raw Sunscale Salmon
	13888, --Darkclaw Lobster
	13889, --Raw Whitescale Salmon
	13893, --Large Raw Mightfish
	17194, --Holiday Spices
	17196, --Holiday Spirits
	18255, --Runn Tum Tuber
	20424, --Sandworm Meat
	21024, --Chimaerok Tenderloin
	21071, --Raw Sagefish
	21153, --Raw Greater Sagefish
	22577, --Mote of Shadow
	22644, --Crunchy Spider Leg
	24477, --Jaggal Clam Meat
	27422, --Barbed Gill Trout
	27425, --Spotted Feltail
	27429, --Zangarian Sporefish
	27435, --Figluster's Mudfish
	27437, --Icefin Bluefish
	27438, --Golden Darter
	27439, --Furious Crawdad
	27515, --Huge Spotted Feltail
	27516, --Enormous Barbed Gill Trout
	27668, --Lynx Meat
	27669, --Bat Flesh
	27671, --Buzzard Meat
	27674, --Ravager Flesh
	27677, --Chunk o' Basilisk
	27678, --Clefthoof Meat
	27681, --Warped Flesh
	27682, --Talbuk Venison
	30817, --Simple Flour
	31670, --Raptor Ribs
	31671, --Serpent Flesh
	33823, --Bloodfin Catfish
	33824, --Crescent-Tail Skullfish
	34412, --Sparkling Apple Cider
	34736, --Chunk o' Mammoth
	35562, --Bear Flank
	35948, --Savory Snowplum
	35949, --Tundra Berries
	36782, --Succulent Clam Meat
	41800, --Deep Sea Monsterbelly
	41801, --Moonglow Cuttlefish
	41802, --Imperial Manta Ray
	41803, --Rockfin Grouper
	41805, --Borean Man O' War
	41806, --Musselback Sculpin
	41807, --Dragonfin Angelfish
	41808, --Bonescale Snapper
	41809, --Glacial Salmon
	41810, --Fangtooth Herring
	41812, --Barrelhead Goby
	41813, --Nettlefish
	43007, --Northern Spices
	43009, --Shoveltusk Flank
	43010, --Worm Meat
	43011, --Worg Haunch
	43012, --Rhino Meat
	43013, --Chilled Meat
	43501, --Northern Egg
	44835, --Autumnal Herbs
	53062, --Sharptooth
	53063, --Mountain Trout
	53064, --Highland Guppy
	53066, --Blackbelly Mudfish
	53067, --Striped Lurker
	53068, --Lavascale Catfish
	53069, --Murglesnout
	53070, --Fathom Eel
	53071, --Algaefin Rockfish
	53072, --Deepsea Sagefish
	58265, --Highland Pomegranate
	58278, --Tropical Sunfruit
	60838, --Mysterious Fortune Card
	62778, --Toughened Flesh
	62779, --Monstrous Claw
	62780, --Snake Eye
	62781, --Giant Turtle Tongue
	62782, --Dragon Flank
	62783, --Basilisk "Liver"
	62784, --Crocolisk Tail
	62785, --Delicate Wing
	62786, --Cocoa Beans
	62791, --Blood Shrimp
	67229, --Stag Flank
	74659, --Farm Chicken
	74660, --Pandaren Peach
	74661, --Black Pepper
	74662, --Rice Flour
	74832, --Barley
	74833, --Raw Tiger Steak
	74834, --Mushan Ribs
	74837, --Raw Turtle Meat
	74838, --Raw Crab Meat
	74839, --Wildfowl Breast
	74840, --Green Cabbage
	74841, --Juicycrunch Carrot
	74842, --Mogu Pumpkin
	74843, --Scallions
	74844, --Red Blossom Leek
	74845, --Ginseng
	74846, --Witchberries
	74847, --Jade Squash
	74848, --Striped Melon
	74849, --Pink Turnip
	74850, --White Turnip
	74851, --Rice
	74852, --Yak Milk
	74853, --100 Year Soy Sauce
	74854, --Instant Noodles
	74856, --Jade Lungfish
	74857, --Giant Mantis Shrimp
	74859, --Emperor Salmon
	74860, --Redbelly Mandarin
	74861, --Tiger Gourami
	74863, --Jewel Danio
	74864, --Reef Octopus
	74865, --Krasarang Paddlefish
	74866, --Golden Carp
	75014, --Raw Crocolisk Belly
	85506, --Viseclaw Meat
	85583, --Needle Mushrooms
	85584, --Silkworm Pupa
	85585, --Red Beans
}
