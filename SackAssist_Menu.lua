------------------------------------------------
--                 SackAssist                  --

------------------------------------------------

if (not SackAssist) then
	SackAssist = {};
end

--------------------------------------------------
-- To find a spell or item ID, use Wowhead.  Look up the item or spell and the check the URL for the ID
-- TelePort:Ironforge = http://www.wowhead.com/?spell=3562
-- ID = 3562
--------------------------------------------------

SackAssist.MenuList = {

	---------------
	--GUILD PERKS--
	---------------

		{["text"] = GUILD_PERKS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 83968}, --Mass Resurrection
		{["type"] = "spell", ["id"] = 83958}, --Mobile Banking

		
	-----------
	--CLASS ABILITIES--
	-----------
	
	--WARRIOR
		{["text"] = CLASS,	["type"] = "header"},
		
	--DEATHKNIGHT
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 50977}, --Death Gate
		{["type"] = "spell", ["id"] = 53428}, --Runeforging
		{["type"] = "spell", ["id"] = 3714},  --Path of Frost
		
	--PALADIN
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 19746}, --Concentration Aura
		{["type"] = "spell", ["id"] = 32223}, --Crusader Aura
		{["type"] = "spell", ["id"] = 465}, --Devotion Aura
		{["type"] = "spell", ["id"] = 19891}, --Fire Resistance Aura
		{["type"] = "spell", ["id"] = 19888}, --Frost Resistance Aura
		{["type"] = "spell", ["id"] = 7294}, --Retribution Aura
		{["type"] = "spell", ["id"] = 19876}, --Shadow Resistance Aura
	
	--PRIEST
		{["text"] = CLASS,	["type"] = "header"},
		
	--SHAMAN
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 556}, --Astral Recall
		{["type"] = "spell", ["id"] = 6196}, --Far Sight

	--DRUID
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 18960}, --Teleport: Moonglade
	
	
	--ROGUE
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 1804}, --Pick Lock
	
	--MAGE
		--Teleports
		{["text"] = "Teleports", ["type"] = "header"},
		{["type"] = "spell", ["id"] = 53140}, --Teleport: Dalaran
{["type"] = "spell", ["id"] = 120145}, --Teleport: Dalaran

		{["type"] = "spell", ["id"] = 3565}, --Teleport: Darnassus
		{["type"] = "spell", ["id"] = 32271}, --Teleport: Exodar
		{["type"] = "spell", ["id"] = 3562}, --Teleport: Ironforge
		{["type"] = "spell", ["id"] = 3567}, --Teleport: Orgrimmar
		{["type"] = "spell", ["id"] = 33690}, --Teleport: Shattrath
		{["type"] = "spell", ["id"] = 32272}, --Teleport: Silvermoon
		{["type"] = "spell", ["id"] = 49358}, --Teleport: Stonard
		{["type"] = "spell", ["id"] = 3561}, --Teleport: Stormwind
		{["type"] = "spell", ["id"] = 49359}, --Teleport: Theramore
		{["type"] = "spell", ["id"] = 3566}, --Teleport: Thunder Bluff
		{["type"] = "spell", ["id"] = 3563}, --Teleport: Undercity
		{["type"] = "spell", ["id"] = 88344}, --Teleport: Tol Barad (H)
		--{["type"] = "spell", ["id"] = 88342}, --Teleport: Tol Barad (A)  -- lookup is by spell name, don't need dupe
	{["type"] = "spell", ["id"] = 132621}, --Teleport: Vale

		
		--Portals
		{["text"] = "Portals", ["type"] = "header"},
		{["type"] = "spell", ["id"] = 53142}, --Portal: Dalaran
	{["type"] = "spell", ["id"] = 120146}, --Portal: Dalaran Crater

		{["type"] = "spell", ["id"] = 11419}, --Portal: Darnassus
		{["type"] = "spell", ["id"] = 32266}, --Portal: Exodar
		{["type"] = "spell", ["id"] = 11416}, --Portal: Ironforge
		{["type"] = "spell", ["id"] = 11417}, --Portal: Orgrimmar
		{["type"] = "spell", ["id"] = 33691}, --Portal: Shattrath
		{["type"] = "spell", ["id"] = 32267}, --Portal: Silvermoon
		{["type"] = "spell", ["id"] = 49361}, --Portal: Stonard
		{["type"] = "spell", ["id"] = 10059}, --Portal: Stormwind
		{["type"] = "spell", ["id"] = 49360}, --Portal: Theramore
		{["type"] = "spell", ["id"] = 11420}, --Portal: Thunder Bluff
		{["type"] = "spell", ["id"] = 11418}, --Portal: Undercity
		{["type"] = "spell", ["id"] = 88346}, --Portal: Tol Barad (H)
		--{["type"] = "spell", ["id"] = 88345}, --Portal: Tol Barad (A) -- lookup is by spell name, don't need dupe
		{["type"] = "spell", ["id"] = 132620}, --Portal: Vale

	--WARLOCK
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 126}, --Eye of Kilrogg
		{["type"] = "spell", ["id"] = 688}, --Summon Imp
	
		--Soul shards
		{["text"] = "", ["type"] = "header", ["reagent"] = 6265},
		{["type"] = "spell", ["id"] = 6366}, --Create Firestone
		{["type"] = "spell", ["id"] = 6201}, --Create Healthstone
		{["type"] = "spell", ["id"] = 2362}, --Create Spellstone
		{["type"] = "spell", ["id"] = 47884}, --Create Soulstone
		{["type"] = "spell", ["id"] = 29893}, --Ritual of Souls
		{["type"] = "spell", ["id"] = 698}, --Ritual of Summoning
		{["type"] = "spell", ["id"] = 691}, --Summon Felhunter
		{["type"] = "spell", ["id"] = 30146}, --Summon Felguard
		{["type"] = "spell", ["id"] = 712}, --Summon Succubus
		{["type"] = "spell", ["id"] = 697}, --Summon Voidwalker
	
	--HUNTER
		{["text"] = CLASS,	["type"] = "header"},
		{["type"] = "spell", ["id"] = 19506}, --Trueshot Aura
		{["type"] = "spell", ["id"] = 82661}, --Aspect of the Fox
		{["type"] = "spell", ["id"] = 5118}, --Aspect of the Cheetah
		{["type"] = "spell", ["id"] = 13165}, --Aspect of the Hawk
		{["type"] = "spell", ["id"] = 13159}, --Aspect of the Pack
		{["type"] = "spell", ["id"] = 20043}, --Aspect of the Wild
		{["type"] = "spell", ["id"] = 2641}, --Dismiss Pet
		{["type"] = "spell", ["id"] = 883}, --Call Pet 1
		{["type"] = "spell", ["id"] = 83242}, --Call Pet 2
		{["type"] = "spell", ["id"] = 83243}, --Call Pet 3
		{["type"] = "spell", ["id"] = 83244}, --Call Pet 4
		{["type"] = "spell", ["id"] = 83245}, --Call Pet 5		
	-----------
	--RACIALS--
	-----------

	--DRAENEI
		
	--DWARF

	--GNOME
	
	--HUMAN
	
	--NIGHT ELF
	
	--BLOOD ELF
	
	--ORC
	
	--TAUREN
	
	--TROLL
	
	--UNDEAD
	

	
	-----------
	--PROFESSIONS--
	{["text"] = TRADE_SKILLS, ["type"] = "header"},
	-----------
	
	--ALCHEMY
		{["type"] = "spell", ["id"] = 2259}, --Alchemy
		{["type"] = "spell", ["id"] = 28677}, --Elixir Master
		{["type"] = "spell", ["id"] = 28675}, --Potion Master
		{["type"] = "spell", ["id"] = 28672}, --Transmutation Master

	--ARCHAEOLOGY
		{["type"] = "spell", ["id"] = 78670}, --Archaeology
		{["type"] = "spell", ["id"] = 80451}, -- Survey

	--BLACKSMITHING
		{["type"] = "spell", ["id"] = 2018}, --Blacksmithing
		{["type"] = "spell", ["id"] = 9788}, --Armorsmithing
		{["type"] = "spell", ["id"] = 17041}, --Master Axesmith
		{["type"] = "spell", ["id"] = 17040}, --Master Hammersmith
		{["type"] = "spell", ["id"] = 17039}, --Master Swordsmith
	
	--COOKING
		{["type"] = "spell", ["id"] = 2550}, --Cooking
		{["type"] = "spell", ["id"] = 818}, --Basic Campfire
	
	--ENCHANTING
		{["type"] = "spell", ["id"] = 7411}, --Enchanting
		{["type"] = "spell", ["id"] = 13262}, --Disenchant
	
	--ENGINEERING
		{["type"] = "spell", ["id"] = 4036}, --Engineering
		{["type"] = "spell", ["id"] = 20219}, --Gnomish Engineer
		{["type"] = "spell", ["id"] = 20222}, --Goblin Engineer
		{["type"] = "item",  ["id"] = 30542}, --Dimensional Ripper: Area 52
		{["type"] = "item",  ["id"] = 18984}, --Dimensional Ripper: Everlook
		{["type"] = "item",  ["id"] = 18986}, --Ultrasafe Transporter: Gadgetzan
		{["type"] = "item",  ["id"] = 30544}, --Ultrasafe Transporter: Tolshey's Station
		{["type"] = "spell", ["id"] = 56273}, --Wormhole: Gadgetzan
		{["type"] = "item",  ["id"] = 48933}, --Wormhole Generator: Northrend
	
	--FIRST AID
		{["type"] = "spell", ["id"] = 3273}, --First Aid
	
	--FISHING
		{["type"] = "spell", ["id"] = 7620}, --Fishing
	
	--HERBALISM
	
	--INSCRIPTION
		{["type"] = "spell", ["id"] = 45357}, --Inscription
		{["type"] = "spell", ["id"] = 51005}, --Milling
		{["type"] = "spell", ["id"] = 52175}, --Decipher
	
	--JEWELCRAFTING
		{["type"] = "spell", ["id"] = 25229}, --Jewelcrafting
		{["type"] = "spell", ["id"] = 31252}, --Prospecting
	
	--LEATHERWORKING
		{["type"] = "spell", ["id"] = 2108}, --Leatherworking
	
	--MINING
		{["type"] = "spell", ["id"] = 2656}, --Smelting
	
	--SKINNING
	
	--TAILORING
		{["type"] = "spell", ["id"] = 3908}, --Tailoring
		
	
	-----------
	--HEARTHSTONE--
	{["text"] = HOME, ["type"] = "header"},
	-----------
		{["text"] = HOME, ["type"] = "item", ["hearthstone"] = true, ["id"] = 6948},

		{["type"] = "item", ["id"] = 37118}, --Scroll of Recall
		{["type"] = "item", ["id"] = 44314}, --Scroll of Recall II
		{["type"] = "item", ["id"] = 44315}, --Scroll of Recall III
		{["type"] = "item", ["id"] = 28585}, --Ruby Slippers
		{["type"] = "item", ["id"] = 54452, ["hearthstone"] = true}, --Ethereal Portal
		{["type"] = "item", ["id"] = 50287}, --Boots of the Bay
		{["type"] = "item", ["id"] = 64488, ["hearthstone"] = true}, -- The Innkeeper's Daughter

		-- Added by Leilanie
		{["type"] = "item", ["id"] = 32757}, --Blessed Medalion of Karabor
		{["type"] = "item", ["id"] = 40585}, --Signet of the Kirin Tor
		{["type"] = "item", ["id"] = 40586}, --Band of the Kirin Tor
		{["type"] = "item", ["id"] = 44934}, --Loop of the Kirin Tor
		{["type"] = "item", ["id"] = 44935}, --Ring of the Kirin Tor
		{["type"] = "item", ["id"] = 45688}, --Inscribed Band of the Kirin tor
		{["type"] = "item", ["id"] = 45689}, --Inscribed Loop of the Kirin Tor
		{["type"] = "item", ["id"] = 45690}, --Inscribed Ring of the Kirin Tor
		{["type"] = "item", ["id"] = 45691}, --Inscribed Signet of the Kirin Tor
		-- End of Addition.

		{["type"] = "item", ["id"] = 48954}, --Etched Band of the Kirin tor
		{["type"] = "item", ["id"] = 48955}, --Etched Loop of the Kirin Tor
		{["type"] = "item", ["id"] = 48956}, --Etched Ring of the Kirin Tor
		{["type"] = "item", ["id"] = 48957}, --Etched Signet of the Kirin Tor

		{["type"] = "item", ["id"] = 51560}, --Runed Band of the Kirin tor
		{["type"] = "item", ["id"] = 51558}, --Runed Loop of the Kirin Tor
		{["type"] = "item", ["id"] = 51559}, --Runed Ring of the Kirin Tor
		{["type"] = "item", ["id"] = 51557}, --Runed Signet of the Kirin Tor

		{["type"] = "item", ["id"] = 46874}, --Argent Crusader's Tabard

		{["type"] = "item", ["id"] = 52251}, --Jaina's Locket

		{["type"] = "item", ["id"] = 22589}, --Atiesh, Greatstaff of the Guardian
		{["type"] = "item", ["id"] = 22630}, --Atiesh, Greatstaff of the Guardian
		{["type"] = "item", ["id"] = 22631}, --Atiesh, Greatstaff of the Guardian
		{["type"] = "item", ["id"] = 22632}, --Atiesh, Greatstaff of the Guardian

		
		{["type"] = "item", ["id"] = 63352}, --Shroud of Cooperation (Stormwind)
		{["type"] = "item", ["id"] = 63353}, --Shroud of Cooperation (Orgrimmar)

		
		{["type"] = "item", ["id"] = 63206}, --Wrap of Unity (Stormwind)
		{["type"] = "item", ["id"] = 63207}, --Wrap of Unity (Orgrimmar)
				

		{["type"] = "item", ["id"] = 65360}, --Cloak of Coordination (Stormwind)
		{["type"] = "item", ["id"] = 65274}, --Cloak of Coordination (Stormwind)

		{["type"] = "item", ["id"] = 110560}, -- Garrison Hearthstone		

	
	--{["type"] = "spacer"}
	
};
