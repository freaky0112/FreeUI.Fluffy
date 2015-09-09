


local db

db = {
	["speed"] = 50,
	["increment"] = 5,
	["distance"] = 50,
}

	----------------
	--- Prehooks ---
	----------------

local oldZoomIn = CameraZoomIn
local oldZoomOut = CameraZoomOut

function CameraZoomIn(distance)
	oldZoomIn(db.increment)
end

function CameraZoomOut(distance)
	oldZoomOut(db.increment)
end

-- tried this out in the SotA demolishers
-- the normal camera zoom functions seemed to be used instead
-- I suppose both can be used interchangeably
local oldVehicleZoomIn = VehicleCameraZoomIn
local oldVehicleZoomOut = VehicleCameraZoomOut

function VehicleCameraZoomIn(distance)
	oldVehicleZoomIn(db.increment)
end

function VehicleCameraZoomOut(distance)
	oldVehicleZoomOut(db.increment)
end

	---------------
	--- Options ---
	---------------

local cvar = {
	"cameraDistanceMoveSpeed",
	"cameraDistanceMax",
	"cameraDistanceMaxFactor",
}

local defaults = {
	db_version = 1.3, -- update this on (major) savedvars changes
	increment = 4,
	speed = 20,
	distance = 50,
}



	----------------------
	--- Initialization ---
	----------------------

-- delay setting/overriding the CVars because it's either
-- not yet ready or is being reverted/overridden by something else
-- not sure if there is any event to wait for instead
C_Timer.After(1, function()
		SetCVar("cameraDistanceMoveSpeed", db.speed)
		SetCVar("cameraDistanceMax", db.distance)
		-- cameraDistanceMax should be the only thing controlling
		-- the max camera distance, for accuracy and simplicity's sake
		SetCVar("cameraDistanceMaxFactor", 1)
	end
)

local f = CreateFrame("Frame")

function f:OnEvent(event, addon)

	


	self:SetScript("OnUpdate", f.OnUpdate)
	self:UnregisterEvent(event)
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)






