--@name Cum
--@author EGR
--@server

local holo = holograms.create( chip():getPos(), Angle(0), "models/holograms/hq_icosphere.mdl", Vector(0.8) )
local pos = 1
local j = 0
local size = 10
local rad = 60
local holoAr = {}
for i=1,50 do
    holoAr[i] = holograms.create( chip():getPos(), Angle(0), "models/holograms/hq_icosphere.mdl", Vector(0.8-i/80) )
    --holoAr[i]:setColor(Color(i,1,1):hsvToRGB())
end

--holo: setTrails( 5, 0,20, 'trails/laser', Color(0,255,255), 1, 0 )

hook.add('tick','',function()
    local targetPos = chip():getOwner():getPos() + Vector(math.cos(j)*rad,math.sin(j)*rad,80)
    local movePos   = holo:getPos() + (targetPos - holo:getPos())/50
    local pos = holo:getPos()
    j=(j+0.1)%360
    holo:setPos(movePos)
    
    
    
    for i=1,#holoAr do
        local posBuf = holoAr[i]:getPos()
        movePos =  holoAr[i]:getPos() + (pos - holoAr[i]:getPos())
        holoAr[i]:setPos(movePos)
        pos = posBuf
    end
end)
