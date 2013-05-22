------------------------------------------------
--                SackAssist
-- 	fork from DagAssist                   --
------------------------------------------------


if (not SackAssist) then
	SackAssist = {};
end

function SackAssist:Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

--Set up the minimap button

SAClicks=0;

SackAssist.MinimapButton = CreateFrame("Button", "SA_Minimap", Minimap, "SecureHandlerClickTemplate, SA_MinimapButton");
local btnMinimap = SackAssist.MinimapButton;
btnMinimap:RegisterForDrag("LeftButton");
btnMinimap:SetClampedToScreen(true);

local texture = btnMinimap:CreateTexture(nil, "ARTWORK");
texture:SetTexture("Interface\\AddOns\\SackAssist\\Images\\MinmapIconHighlight2");
texture:SetBlendMode("BLEND");
texture:SetAllPoints(btnMinimap);
btnMinimap:SetHighlightTexture(texture);
	
btnMinimap:Execute([[
	menuOpen = false;
	keepOpen = false;
	menuItems = table.new();
	
	Close = [=[
		menuOpen = false;
		menu:Hide();
		for i, button in ipairs(menuItems) do
			button:Hide();
		end
	]=]

	Show = [=[
		
		menuOpen = true;
		local previous;
		
		menu:Show();
		menu:SetPoint("TOPLEFT", self, "BOTTOMLEFT");
		
		local menuHeight = 20;
		for i, button in ipairs(menuItems) do
			-- print("Building button " .. tostring(i) .. " "  );
			local visible = button:GetAttribute("visible");
			local enabled = button:GetAttribute("enabled");
			local text = button:GetAttribute("text") or "whoknows";
							
			if (visible) then
				menuHeight = menuHeight + 18;
				if (previous) then
					button:SetPoint("TOPLEFT", previous, "BOTTOMLEFT");
				else
					button:SetPoint("TOPLEFT", menu, "TOPLEFT", 10, -10);
				end
				if (enabled) then
					button:Enable();
				else
					button:Disable();
				end
				previous = button;
				button:Show();
			--print("menuHeight is now "..menuHeight.." from button ".. tostring(i) .. " " .. text);
			end
		end
		
		menu:SetHeight(menuHeight);
	]=]
]]);

btnMinimap:SetAttribute("_onclick", [[ 
	if menuOpen then
		control:Run(Close);
	else
		control:Run(Show);
	end
]]);

SackAssist.Menu = CreateFrame("Frame", "SA_Menu", btnMinimap, "SecureHandlerBaseTemplate, SA_MenuContainer");
SackAssist.Menu:SetClampedToScreen(true);
SackAssist.Menu:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
SackAssist.Menu:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 1);
btnMinimap:SetFrameRef("menu", SackAssist.Menu);
btnMinimap:Execute([[
	menu = self:GetFrameRef("menu");
	table.insert(menuItems, menu);
]]);

btnMinimap:SetScript("OnDragStart", 
	function(this)

		this:StartMoving();
		this.Dragging = true;
		if (InCombatLockdown() ~= 1) then
			btnMinimap:Execute([[
				control:Run(Close);
			]]);
		end
	end
)

btnMinimap:SetScript("OnDragStop",
	function(this)
		
		this:StopMovingOrSizing();
		
		if (this.Dragging) then
			this.Dragging = false;
			local s = this:GetEffectiveScale();
			SA_Vars.Minimap.X = this:GetLeft() * s;
			SA_Vars.Minimap.Y = this:GetTop() * s;
		end
	end
)

btnMinimap:SetScript("OnEnter", 
	function()
		SackAssist:SetMenuItemVisibility();
	end
)

btnMinimap:RegisterForClicks("AnyDown");

function SackAssist:OnEvent(event,arg1,...)   -- s/b OnEvent(self,event,...) but for some reason that's not the way it's getting passed



	if (event == "PLAYER_ENTERING_WORLD") then

		SackAssist:BuildMenu(event);
	elseif (event == "EQUIPMENT_SETS_CHANGED") then
		SackAssist:BuildMenu(event);

	elseif (event == "PLAYER_LOGIN") then
		SackAssist:BuildMenu(event)

	elseif (event == "BAG_UPDATE") then
		SackAssist:BAG_UPDATE(event);
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		SackAssist:LEARNED_SPELL_IN_TAB(event);		
	elseif (event == "PLAYER_REGEN_ENABLED") then
		SackAssist:PLAYER_REGEN_ENABLED(event);
	elseif (event == "PLAYER_REGEN_DISABLED") then
		SackAssist:PLAYER_REGEN_DISABLED(event);
	end

end

btnMinimap:SetScript("OnEvent", SackAssist.OnEvent);

--btnMinimap:RegisterEvent("PLAYER_ENTERING_WORLD");
btnMinimap:RegisterEvent("PLAYER_LOGIN");
btnMinimap:RegisterEvent("EQUIPMENT_SETS_CHANGED");

function SackAssist:BuildMenu(event)
	if (not SA_Vars) then
		SA_Vars = {Minimap = {}};
	end

--reset menu items
btnMinimap:Execute([[ local x=0;
			if (menuItems) then  x = #menuItems end
			 if (x > 0) then
				for index= 1, #menuItems do
					table.remove(menuItems, 1); end
			end
		]]);


	if (SA_Vars.Minimap.X and SA_Vars.Minimap.Y) then
		--Restore last position
		local s = btnMinimap:GetEffectiveScale();

		btnMinimap:ClearAllPoints()
		btnMinimap:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", SA_Vars.Minimap.X / s, SA_Vars.Minimap.Y /s);
	else
		btnMinimap:SetPoint("CENTER", Minimap, "BOTTOMLEFT", 15, 15);
	end
	
	local menu = SackAssist.Menu;
	for index = 1, table.getn(SackAssist.MenuList) do 
		local value = SackAssist.MenuList[index];
		
		value.IconSet=false;	

		if ((value.type == "spell" or value.type == "buff") and value.id) then
			value.text = GetSpellInfo(value.id);
		elseif (value.type == "item" and value.id) then
			value.text = GetItemInfo(value.id);
		elseif (value.type == "macro" and value.id) then
				value.text, _, _ = GetMacroInfo(value.id);
				
		end
			
		local btnMenuItem;
		if (value.type == "header") or (value.type == "spacer") then
			btnMenuItem = _G["SA_MenuButton"..index] or CreateFrame("Button", "SA_MenuButton"..index, menu, "SecureHandlerBaseTemplate, SA_MenuLabelTemplate");
			if (value.reagent and value.reagent ~= "") then
				value.text = GetItemInfo(value.reagent);
			--print("Reagent found " .. value.text);
			end
		
		elseif value.type == "spell" or value.type == "buff" then
			btnMenuItem = _G["SA_MenuButton"..index] or CreateFrame("Button", "SA_MenuButton"..index, menu, "SecureActionButtonTemplate, SecureHandlerBaseTemplate, SA_MenuSpellButtonTemplate");
			btnMenuItem:SetAttribute("type","spell");
			btnMenuItem:SetAttribute("*spell1",value.text);
			btnMenuItem:SetAttribute("checkselfcast","1");
			btnMenuItem:SetAttribute("checkfocuscast","1");

		elseif value.type == "item" then
			btnMenuItem = _G["SA_MenuButton"..index] or CreateFrame("Button", "SA_MenuButton"..index, menu, "SecureActionButtonTemplate, SecureHandlerBaseTemplate, SA_MenuSpellButtonTemplate");
			btnMenuItem:SetAttribute("type","item");
			btnMenuItem:SetAttribute("*item1", value.text);
			btnMenuItem:SetAttribute("checkselfcast","1");
			btnMenuItem:SetAttribute("checkfocuscast","1");
			--print("Created a button for " .. value.id .. " " .. value.text);

		elseif value.type == "macro" then
			btnMenuItem = _G["SA_MenuButton"..index] or CreateFrame("Button", "SA_MenuButton"..index, menu, "SecureActionButtonTemplate, SecureHandlerBaseTemplate, SA_MenuSpellButtonTemplate");
			btnMenuItem:SetAttribute("type","macro");
			btnMenuItem:SetAttribute("macro", value.id);
			btnMenuItem:SetAttribute("checkselfcast","1");
			btnMenuItem:SetAttribute("checkfocuscast","1");

		end		
		btnMinimap:WrapScript(btnMenuItem, "OnClick", [[control:Run(Close)]])
		btnMenuItem:SetClampedToScreen(true);
		btnMenuItem:SetAttribute("visible", false);
		btnMenuItem:SetAttribute("enabled", false);
		
		value.button = btnMenuItem;
		--value.buttonIcon = getglobal("SA_MenuButton"..index.."Icon");
		value.buttonIcon = _G["SA_MenuButton"..index.."Icon"];		
	
		SackAssist:SetButtonIcon(value);
		btnMenuItem:SetFrameLevel(btnMenuItem:GetFrameLevel() + 1);
		btnMenuItem:SetText(value.text);
		
		btnMinimap:SetFrameRef("child", btnMenuItem);
		btnMinimap:Execute([[
			table.insert(menuItems, self:GetFrameRef("child"));
		]]);
	end


	--Equipment sets
	if (CanUseEquipmentSets() and GetNumEquipmentSets() > 0) then	

		local btnMenuItem;
		btnMenuItem =_G["SA_MenuButtonEquip"] or CreateFrame("Button", "SA_MenuButtonEquip", menu, "SecureHandlerBaseTemplate, SA_MenuLabelTemplate");
		btnMinimap:WrapScript(btnMenuItem, "OnClick", [[control:Run(Close)]])
		btnMenuItem:SetClampedToScreen(true);
		btnMenuItem:SetAttribute("visible", true);
		btnMenuItem:SetAttribute("enabled", true);
		btnMenuItem:SetFrameLevel(btnMenuItem:GetFrameLevel() + 1);
		btnMenuItem:SetText(EQUIPMENT_MANAGER);
		
		btnMinimap:SetFrameRef("child", btnMenuItem);
		btnMinimap:Execute([[
			table.insert(menuItems, self:GetFrameRef("child"));
		]]);

		for setnum = 1,GetNumEquipmentSets() do
		local setname, seticon, setID = GetEquipmentSetInfo(setnum);
		btnMenuItem = _G["SA_MenuButtonEquip"..setnum] or	CreateFrame("Button", "SA_MenuButtonEquip"..setnum, menu, "SecureHandlerBaseTemplate, SA_MenuSpellButtonTemplate");
	
		btnMenuItem:RegisterForClicks("AnyDown");
		btnMenuItem:SetScript("OnClick", function() EquipmentManager_EquipSet(setname) end);
		btnMinimap:WrapScript(btnMenuItem, "OnClick", [[control:Run(Close)]])
		
		btnMenuItem:SetClampedToScreen(true);
		btnMenuItem:SetAttribute("visible", true);
		btnMenuItem:SetAttribute("enabled", true);
		btnMenuItem:SetAttribute("type","equipment");
		btnMenuItem:SetFrameLevel(btnMenuItem:GetFrameLevel() + 1);
		btnMenuItem:SetText(setname);
		--local buttonIcon = getglobal("SA_MenuButtonEquip"..setnum.."Icon");
		local buttonIcon = _G["SA_MenuButtonEquip"..setnum.."Icon"];
		buttonIcon:SetTexture(seticon);
			btnMinimap:SetFrameRef("child", btnMenuItem);
		btnMinimap:Execute([[
			table.insert(menuItems, self:GetFrameRef("child"));
		]]);

		end
			


	end
	
	--Add the close button
	btnMenuItem =_G["SA_MenuButtonClose"] or CreateFrame("Button", "SA_MenuButtonClose", menu, "SecureActionButtonTemplate, SecureHandlerBaseTemplate, SA_MenuButtonTemplate");
	btnMenuItem:SetText("Close");
	btnMenuItem:SetAttribute("type", "click");
	btnMenuItem:SetAttribute("clickbutton", btnMinimap);
	btnMenuItem:SetAttribute("visible", true);
	btnMenuItem:SetAttribute("enabled", true);
	btnMinimap:SetFrameRef("child", btnMenuItem);
	btnMinimap:Execute([[
		table.insert(menuItems, self:GetFrameRef("child"));
	]]);
		
	SackAssist:SetMenuItemVisibility();
	SackAssist.MinimapButton:Show();
	
	btnMinimap:RegisterEvent("BAG_UPDATE");
	btnMinimap:RegisterEvent("LEARNED_SPELL_IN_TAB");
	btnMinimap:RegisterEvent("PLAYER_REGEN_DISABLED");
	btnMinimap:RegisterEvent("PLAYER_REGEN_ENABLED");
end

function SackAssist:BAG_UPDATE(event)
	SackAssist:SetMenuItemVisibility();
end
function SackAssist:LEARNED_SPELL_IN_TAB(event)
	SackAssist:SetMenuItemVisibility();
end
function SackAssist:PLAYER_REGEN_DISABLED(event)
	SackAssist:SetMenuItemVisibility();
end
function SackAssist:PLAYER_REGEN_ENABLED(event)
	SackAssist:SetMenuItemVisibility();
end

function SackAssist:PlayerKnowsSpell(spellId)
	-- Calling GetSpellInfo with the spellID will always return spell information.
	-- Calling GetSpellInfo with the spell name will only return a value if the player knows the spell
	-- By nesting two calls to GetSpellInfo, we can test if the player knows the spellId
	local value = GetSpellInfo(spellId);
	if (value ~= nil) then
		return (GetSpellInfo(value) ~= nil);
	else
		return false;
	end
end

-- Added by Leilanie
function SackAssist:PlayerHasItem(itemId)

itemId=":"..itemId..":"

	for bag = 0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local item = GetContainerItemLink (bag,slot);
			if (item ~= nil) then
				if item:find(itemId) then
					--local itemString = item:gsub("|", "---")
					--print ("Found ", itemId, " in ", itemString ," DA DEBUG")
					return true;
				end
			end
		end
	end
	for slot = 1,19 do
		local item = GetInventoryItemLink ("player",slot);
		if (item ~=nil) then
			if item:find(itemId) then
				return true;
			end
		end
	end
	return false;
end
-- End of Addition

function SackAssist:PlayerCanUseItem(itemId)
 local isUsable, _ = IsUsableItem(itemId)
  if (isUsable == 1) then return true; end
  return false;
end



function SackAssist:SetMenuItemVisibility()
	--Don't update the menu item visibility if the player is in combat.
	if (InCombatLockdown()) then
		return;
	end
	
	local previousItem = nil;
	for index = 1, table.getn(SackAssist.MenuList) do 
		local value = SackAssist.MenuList[index];

		if (not value.text) then
			if ((value.type == "spell" or value.type == "buff") and value.id) then
				value.text = GetSpellInfo(value.id);
			elseif (value.type == "item" and value.id) then
				value.text = GetItemInfo(value.id);
			elseif (value.type == "macro" and value.id) then
				value.text, _, _ = GetMacroInfo(value.id);
			end
		end
		
		if ((value.button) and (value.reagent) and (value.reagent ~= "")) then
			if (not value.reagentname) then value.reagentname = GetItemInfo(value.reagent) end
			if (value.text and value.reagentname) then
				-- If the item acting as reagent has never been seen by this client, then value.reagentname will be nil
				value.button:SetText(value.text .. " (" .. GetItemCount(value.reagentname, false) .. ")");
			end
		end

		if ((value.type) and (value.type ~= "") and (value.button)) then
			if (value.type == "header") then
				value.visible = true;
				
			elseif ((value.type == "spell") or (value.type == "buff")) then
				if ((value.text) and (value.text ~= "")) then
					if (SackAssist:PlayerKnowsSpell(value.text)) then
						value.visible = true;
						if (not value.IconSet) then
							SackAssist:SetButtonIcon(value);
						end
						
						if (IsUsableSpell(value.text)) then
							value.enabled = true;
						else
							value.enabled = false;
						end
						
						local startTime, duration, cooldownEnabled;	
						startTime, duration, cooldownEnabled = GetSpellCooldown(value.text);
						
						local secondsRemaining = math.ceil(duration - (GetTime() - startTime));
						if (secondsRemaining > 1) then
							if (secondsRemaining > 60) then
								secondsRemaining = math.ceil(secondsRemaining / 60);
								secondsRemaining = string.format(MINUTES_ABBR, secondsRemaining);
							else
								secondsRemaining = string.format(SECONDS_ABBR, secondsRemaining);
							end
							value.enabled = false;
							value.button:SetText(value.text.." ("..secondsRemaining..")");
						else
							value.button:SetText(value.text);
						end						
					else
						value.visible = false;
					end
				else
					value.visible = false;
				end
				
			elseif (value.type == "item") then
				if ((value.text) and (value.text ~= "")) then
				--	if ( (SackAssist:PlayerHasItem(value.id)) and (SackAssist:PlayerCanUseItem(value.id)) ) then 	
					if  (SackAssist:PlayerHasItem(value.id))  then 
						value.visible = true;
						if (not value.IconSet) then
							SackAssist:SetButtonIcon(value);
						end
						
						if (GetItemCount(value.text, false)) > 0 then
							local displayName = value.text;
							if (value.hearthstone) then
								--Set the text and cooldown
								displayName = GetBindLocation();
							end
							
							local startTime, duration, cooldownEnabled;	
							startTime, duration, cooldownEnabled = GetItemCooldown(value.id);
							
							local secondsRemaining = math.ceil(duration - (GetTime() - startTime));
							if ((cooldownEnabled == 1) and (secondsRemaining > 1)) then
								if (secondsRemaining > 60) then
									secondsRemaining = math.ceil(secondsRemaining / 60);
									secondsRemaining = string.format(MINUTES_ABBR, secondsRemaining);
								else
									secondsRemaining = string.format(SECONDS_ABBR, secondsRemaining);
								end
								value.enabled = false;
								value.button:SetText(displayName.." ("..secondsRemaining..")");
							else
								value.enabled = true;
								value.button:SetText(displayName);
							end
						else
							value.enabled = false;
						end
				-- Added by Leilanie
					else
						value.visible = false;
					end
				else
					value.visible = false;
				end
				-- End of Addition

			--macros should always show?
			elseif (value.type == "macro") then
				value.visible = true;
				value.enabled = true;
					if (not value.IconSet) then
						SackAssist:SetButtonIcon(value);
						end
				value.button:SetText(value.text);
				

			elseif (value.type == "special") then
				value.visible = true;
				
			elseif (value.type == "spacer") then
				value.visible = true;
				
			end
		
			-- remove tracking types if player has selected to do so
			if ((value.subtype == "tracking") and (SA_Vars.tracking=="no")) then
				value.visible = false;
			end
			
			
			if (value.enabled) then
				value.button:SetAttribute("enabled", true);
			else
				value.button:SetAttribute("enabled", false);
			end
			
			if (value.visible) then
				if previousItem then
					if ((value.type == "header") and (previousItem.type == "header")) then
						if previousItem.button then
							previousItem.button:SetAttribute("visible", false);
						end
						previousItem = previousItem.previous;
					end
				end
				
				if previousItem then
					value.count = previousItem.count + 1;
					value.previous = previousItem;
				else
					value.count = 1;
				end
				
				previousItem = value;
				
				value.button:SetAttribute("visible", true);
			else
				value.button:SetAttribute("visible", false);
			end
		end
		
	end
end

function SackAssist:SetButtonIcon(tableEntry)
	local itemTexture;
	if (tableEntry.text) then
		if ((tableEntry.type == "spell") or (tableEntry.type == "buff")) then
			itemTexture = GetSpellTexture(tableEntry.text);
			
		elseif tableEntry.type == "item" then
			--Get the item texture
			_, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(tableEntry.text);
		elseif tableEntry.type == "macro" then
			_, itemTexture, _ = GetMacroInfo(tableEntry.id);
		end		
	end
	
	if (itemTexture) then
		tableEntry.buttonIcon:SetTexture(itemTexture);
		tableEntry.IconSet = true;
	end
end

function SackAssist:Reset() -- Reset button to default position

	btnMinimap:ClearAllPoints();
	btnMinimap:SetPoint("CENTER", Minimap, "BOTTOMLEFT", 15, 15);

	local s = btnMinimap:GetEffectiveScale();
	SA_Vars.Minimap.X = btnMinimap:GetLeft() * s;
	SA_Vars.Minimap.Y = btnMinimap:GetTop() * s;
end


-- Slash commands
SLASH_SACKASSIST1 = '/sack';

function SlashCmdList.SACKASSIST(msg, editbox)
 if msg == 'reset' then
   SackAssist.Reset();
 elseif msg == 'rebuild' then
   SackAssist.BuildMenu(nil);
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffff6600SackAssist Usage: |cffffffff /sack |cffffff00reset |r (Resets button position)  |cffffff00rebuild |r (Reloads menu)")
 end
end

