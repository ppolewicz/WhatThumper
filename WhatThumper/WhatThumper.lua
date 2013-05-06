require "lib/lib_Callback2"

local cb_focus = Callback2.Create()

PLUGIN_TAG = '[WhatThumper]'

function OnEntityFocus(args)
	if args.entityId then
		local info = Game.GetTargetInfo(args.entityId)
		if info.type == "resourcenode" then
			cb_focus:Bind(print_system_message, info.thumper_name)
			cb_focus:Schedule(2)
			return
		end
	end
	if cb_focus:Pending() then
		cb_focus:Cancel()
	end
end

function print_system_message(message)
	Component.GenerateEvent("MY_SYSTEM_MESSAGE", {text=PLUGIN_TAG.." "..message})
end
