MapTutorialWaypoint = {
	Editor = {	Icon = "W.bmp",	},
	Properties = {
		fileModel = "",
		sWaypointName = "",
	},
}

function MapTutorialWaypoint:OnInit()
	self:LoadObject(0, self.Properties.fileModel);
	self:Activate(1);
end

function MapTutorialWaypoint:OnReset()
	self:Activate(1);
end

function MapTutorialWaypoint:OnPropertyChange()
	self:OnReset();
end

function MapTutorialWaypoint:Event_Message(sender, msg)
	self.Properties.sWaypointName = msg;
end

function MapTutorialWaypoint:Event_Active(sender, msg)
	self.WaypointActive = msg;
end

function MapTutorialWaypoint:OnUpdate()
	local Pos = self:GetPos();
	self.X = Pos.x;
	self.Y = Pos.y;
	
	self:ActivateOutput("PosX", self.X);
	self:ActivateOutput("PosY", self.Y);
end

MapTutorialWaypoint.FlowEvents = {
	Inputs = {
		WayPointName = {	MapTutorialWaypoint.Event_Message, "string" },
		Activate = {	MapTutorialWaypoint.Event_Active, "bool" },
	},
	Outputs = {
		PosX = "Float",
		PosY = "Float",
	},
}