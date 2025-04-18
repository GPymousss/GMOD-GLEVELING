if SERVER then
	AddCSLuaFile("leveling/cl_modules.lua")
	include("leveling/sv_module.lua")
end

if CLIENT then
	include("leveling/cl_modules.lua")
end