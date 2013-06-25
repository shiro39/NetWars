--相關影片http://www.youtube.com/watch?v=CVyYAQbLxYE
MapTutorial = {
	Properties = {
		sMapFilePath = "",
	},
	Editor = {
		Icon = "T.bmp",
	},
};

function MapTutorial:OnInit()
	self:Activate(1);
end

function MapTutorial:OnUpdate()
	self:Waypoints();
	self:MapUpdate();
end

function MapTutorial:Event_Message(sender, msg)
	self.Properties.sMapFilePath = msg;
end

function MapTutorial:Waypoints()
	local WP = System.GetNearestEntityByClass(g_localActor:GetPos(), 9999, "MapTutorialWaypoint");
	if(WP == nil) then
		self.WPOnOff = 2;
	return end
	
	self.WPActive = WP.WaypointActive;
	
	if(self.WPActive == false) then
		self.WPOnOff = 2;
	return end
	
	local WPPosLoc = g_localActor:ToLocal(0, WP:GetPos());
	self.WPx = WPPosLoc.x;
	self.WPy = WPPosLoc.y;
	self.WPName = WP.Properties.sWaypointName;
	self.WPOnOff = 1;
end

function MapTutorial:MapUpdate()
	local MapFilePath = self.Properties.sMapFilePath;
	local ScreenEnt = System.GetEntityByName("ScreenTest");
	if(ScreenEnt == nil) then
	return end
	
	local Pos = g_localActor:GetPos();
	local PosX = Pos.x;
	local PosY = Pos.y;
	
	local vector = g_localActor:GetDirectionVector(1);
	local heading = -math.atan2(vector.x, vector.y)*180/math.pi;
	
	ScreenEnt:MaterialFlashInvoke(0, 1, 0, "MapNav", 
									PosX,
									PosY,
									heading,
									MapFilePath,
									self.WPx,
									self.WPy,
									self.WPName,
									self.WPOnOff);
end

MapTutorial.FlowEvents = {
	Inputs = {
		MapImageFilePath = {MapTutorial.Event_Message, "string"},
	},
	
	Outputs = {},
}