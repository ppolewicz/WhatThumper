require "lib/lib_Callback2"

local cb_focus = Callback2.Create()

local HEALTH_THUMPERTYPE = {
                        -- info from:
	[10000]="Stock P",  -- that's measured on someone's thumper. Ratchet's thumper?
	[12500]="Stock P",  -- printer & my thumper
	[15000]="Light P",  -- printer & my thumper
	[17500]="Medium P", -- printer & my thumper
	[20000]="Heavy P",  -- printer
	[16000]="Stock S",  -- printer & my thumper
	[18000]="Light S",  -- printer & my thumper
	[21000]="Medium S", -- printer & my thumper
	[24000]="Heavy S",  -- printer
}

PLUGIN_TAG = '[WhatThumper]'

function OnEntityFocus(args)
	if args.entityId then
		info = Game.GetTargetInfo(args.entityId)
		if info and info.type == "resourcenode" then
			thumper = {}
			thumper.info = info
			vitals = Game.GetTargetVitals(args.entityId)
			--log("info: "..tostring(info))
			--log("vitals: "..tostring(vitals))
			if vitals then
				thumper.vitals = vitals
				if HEALTH_THUMPERTYPE[vitals.MaxHealth] then
					result = HEALTH_THUMPERTYPE[vitals.MaxHealth]
				else
					result = "Unknown"
				end
				cb_focus:Bind(print_system_message, result)
				cb_focus:Schedule(2)
				return
			end
		end
	end
	if cb_focus:Pending() then
		cb_focus:Cancel()
	end
end

function print_system_message(message)
	Component.GenerateEvent("MY_SYSTEM_MESSAGE", {text=PLUGIN_TAG.." "..message})
end
