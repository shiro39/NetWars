Teleporter = {
	Editor = 
	{
		Icon= "AreaTrigger.bmp",
	},
	Properties = 
	{
		teleportDirX = 0,
		teleportDirY = 0,
		teleportDirZ = 0,
		object_3DModel = "Editor/Objects/test.cgf"
	},
}


-- The OnInit function is called every time this entity is spawned.
function Teleporter:OnInit()
	self:OnReset();
end


-- The OnPropertyChange function is called every time you change
-- a property within Sandbox RollupBar for this entity.
function Teleporter:OnPropertyChange()
	self:OnReset();
end

-- The OnReset function is called if the entity gets reset. For example,
-- if you jump into game in Sandbox.
function Teleporter:OnReset()
--this will set the selected 3D Model on the entity
	if(self.Properties.object_MyModel ~= "") then
		self:LoadObject(0, self.Properties.object_3DModel);
	end
	self:PhysicalizeThis();
end

function Teleporter:OnCollision(sender)
	Log("%s", sender:Dump());
end

function Teleporter:PhysicalizeThis()
	local Physics = {
		bRigidBody=1,
		bRigidBodyActive = 0,
		bRigidBodyAfterDeath =1,
		bResting = 1,
		Density = 5,
		Mass = 1000,
	};
	EntityCommon.PhysicalizeRigid( self, 0, Physics, 1 );
end

function Teleporter:IsUsable(user)
	return 1;
end

function Teleporter:Event_Enable()
	BroadcastEvent(self, "Enable");
end

function Teleporter:Event_Disable()
	Log("System is diabled!");
end

function Teleporter:OnUsed(user)
	Log("%s",user:GetName()); 
	--user = System:GetEntityByName("Dude");
	BroadcastEvent(self, "Enable");
	
	if(not user) then
		return 0;
	end
	--compute target position from current position + teleport direction
	local vCurPos = {};
	user:GetWorldPos(vCurPos);
	local vTargetDir = {}; -- assign a temp vector as targetDir "Type"
	vTargetDir.x = self.Properties.teleportDirX;
	vTargetDir.y = self.Properties.teleportDirY;
	vTargetDir.z = self.Properties.teleportDirZ;
	local vTargetPos = vecAdd(vCurPos, vTargetDir);
	--set target position on player entity
	user:SetWorldPos(vTargetPos);
	
	
end

Teleporter.FlowEvents = 
{
	Inputs = 
	{
		Activate = {Teleporter.OnUsed, "entity"},
	},
	Outputs = 
	{
		Enable = "bool",
	},
}