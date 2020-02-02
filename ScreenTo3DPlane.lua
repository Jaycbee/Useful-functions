local function  ScreenTo3DPlane(Pos, viewport, camera,Depth, Gui_Inset)
    local Cam_Size = Vector2.new(viewport.AbsoluteSize.X , viewport.AbsoluteSize.Y - (Gui_Inset or 0))
   local Height = Cam_Size.Y
      local Width = Cam_Size.X	
      local AspectRatio = (Cam_Size.X/Cam_Size.Y)
      local Cam_Pos = camera.CFrame.p
     local Scale = Cam_Pos.Z
      local fx = (2 * Scale)* (Pos.x/(Width-1)) -(Scale*1);
     local fy = (2 * Scale) * (Pos.y/(Height-1)) -(Scale*1);
     local yfov = camera.FieldOfView
    local Tangent = math.tan((math.rad(yfov/2)));
     local NX = ((AspectRatio * Tangent * fx) + Cam_Pos.X)
     local NY = (-Tangent * fy) + Cam_Pos.Y
      local NZ = Depth or 0
  return Vector3.new(NX , NY , NZ)
end 
