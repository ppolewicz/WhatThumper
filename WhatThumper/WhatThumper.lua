require "string"
require "lib/lib_Slash";

local pairs = pairs
local math = math
local string = string

PLUGIN_TAG = '[WhatThumper]'

-- event handlers

function OnComponentLoad()
	InitializeSlashCommands()
end

-- Slash commands

local SLASH_CMDS = {}

function InitializeSlashCommands()
	LIB_SLASH.BindCallback({slash_list = "whatthumper, wt", description = "", func = SLASH_CMDS.cmdroot})
end

SLASH_CMDS.cmdroot = function(text)
	local option, message = text[1], text[2]
	if option ~= nil then
  		if not ( SLASH_CMDS[option] ) then log("["..option.."] Not Found") return nil end
  		SLASH_CMDS[option](message)
	else
		ShowThumperType()
	end
end

SLASH_CMDS.test = function(text)
	log(tostring(targetInfo()))
end

-- other functions

function print_system_message(message)
	Component.GenerateEvent("MY_SYSTEM_MESSAGE", {text=PLUGIN_TAG.." "..message})
end

function targetInfo()
	local ri = Player.GetReticleInfo()
	if not ri or not ri.entityId then
		print_system_message("It seems that You are not looking on any entity")
		return nil
	end
	local entityId = ri.entityId
	return Game.GetTargetInfo(entityId)
end

function ShowThumperType()
	local info = targetInfo()
	if not info then
		return
	elseif not info.type == "resourcenode" or not info.thumper_name then
		print_system_message("It seems that You are looking on something, but it's not a thumper")
		return
	end
	print_system_message(info.thumper_name)
end
