-- the starting point of western cauldron
wx=569184.0
wy=440873.0
wzb=1203.66


--wx=564470.0
--wy=440873.0
--wzb=1028.0

-- directional unit vector along channel
dx=-math.sqrt(0.5)
dy=-math.sqrt(0.5)
-- normal vector to channel
dnx=-dy
dny=dx



function initialcavity(x,y)
   relx=-(x-wx)
   rely=-(y-wy)
   xdir = IfThenElse(relx < 0, -1.0, 1.0)
   ydir = IfThenElse(rely < 0, -1.0, 1.0)
   distance=math.sqrt(relx^2 + rely^2)
   -- print(rely - relx*dx/dy)
   -- normaldistance =(rely - relx*(dx/dy))
   if ( (xdir > 0.0) and (ydir > 0.0) ) then
      if (distance < channellength) then
	 normaldistance = math.abs((rely - relx*(dx/dy))/(dnx*dy/dx - dny))
	 -- aligneddistance = math.abs((relx/dx) + ((rely - relx*(dx/dy))/(dnx*dy/dx - dny))*(dnx/dx))
	 -- aligneddistance = 0.0
	 -- normaldistance = 0.0
	 realamplitude= channelampl*math.max(1 - (distance/channellength)^8, 0.0)
	 channeldeformation = realamplitude*math.max(1.0 - (normaldistance/channelwidth)^2, 0.0)
	 -- print (deformation,channeldeformation)
	 -- print("distance:", distance," normaldistance:", normaldistance," aligneddistance:",aligneddistance. "deformation:",deformation)
	 return channeldeformation
      else
	 return 0.0
      end
   else
      return 0.0
   end	    
end

function appliedpressure(x,y,z)
   relx=-(x-wx)
   rely=-(y-wy)
   xdir = IfThenElse(relx < 0, -1.0, 1.0)
   ydir = IfThenElse(rely < 0, -1.0, 1.0)
   distance=math.sqrt(relx^2 + rely^2)
   pressure = 0.0
   if ( (xdir > 0.0) and (ydir > 0.0) ) then
      if (distance < channellength) then
	 normaldistance = math.abs((rely - relx*(dx/dy))/(dnx*dy/dx - dny))
	 if (normaldistance < channelwidth) then
	    pressure = math.max((waterlevel - z)*rhow*gravity,0.0)
	 end
      end
   end
   return pressure
end   

function applypressure2(x,y)
   relx=-(x-wx)
   rely=-(y-wy)
   xdir = IfThenElse(relx < 0, -1.0, 1.0)
   ydir = IfThenElse(rely < 0, -1.0, 1.0)
   distance=math.sqrt(relx^2 + rely^2)
   flag = -1.0
   if ( (xdir > 0.0) and (ydir > 0.0) ) then
      if (distance <= channellength) then
	 normaldistance = math.abs((rely - relx*(dx/dy))/(dnx*dy/dx - dny))
	 if (normaldistance <= channelwidth) then
	    flag = 1.0
	 end
      end
   end
   return flag
end

function getfilmpressure(x,y,z,distance,cryop)
   if (distance > 3000.0) then
      return pcs*cryop
   else
      cavityp = math.max(rhoi*gravity*(waterlevel - z), pcs*cryop)
      return cavityp
   end
end

function applypressure3(x,y,ndistance)
   relx=-(x-wx)
   rely=-(y-wy)
   xdir = IfThenElse(relx < 0, -1.0, 1.0)
   ydir = IfThenElse(rely < 0, -1.0, 1.0)
   distance=math.sqrt(relx^2 + rely^2)
   flag = -1.0
   if (ndistance > 3000.0) then
      flag = 1.0
   elseif ( (xdir > 0.0) and (ydir > 0.0) ) then
      if (distance <= channellength) then
	 -- normaldistance = math.abs((rely - relx*(dx/dy))/(dnx*dy/dx - dny))
	 if (ndistance <= channelwidth) then
	    flag = 1.0
	 end
      end
   end
   return flag
end

function applypressure(x,y)
   relx=-(x-wx)
   rely=-(y-wy)
   xdir = IfThenElse(relx < 0, -1.0, 1.0)
   ydir = IfThenElse(rely < 0, -1.0, 1.0)
   distance=math.sqrt(relx^2 + rely^2)
   return IfThenElse(( (distance < channelwidth) and ( (xdir > 0.0) and (ydir > 0.0) ) ), 1.0, -1.0)
end   



function cryostaticpressure(depth)
   return rhoi*gravity*depth
end   

function IfThenElse(condition,t,f) 
   if condition then
     return t
   else
     return f
   end 
end

function isinside(x,y)
   relx=-(x-wx)
   rely=-(y-wy)
   distance=math.sqrt(relx^2 + rely^2)
   if (distance > 0.0) then
      if (distance < 0.25*channellength) then
	 normaldistance = math.abs((rely - relx*(dx/dy))/(dnx*dy/dx - dny))
	 if (normaldistance < channelwidth) then
	    return 1.0
	 else
	    return 0.0
	 end
      else
	  return 0.0
      end
   else
      return 0.0
   end
end
