--@name Cum
--@author EGR
--@server

local j = 0
local rad = 60
local holo = {}
local smoth=2
local maxHolos= 50

for i=1,maxHolos do
    holo[i] = holograms.create( chip():getPos(), Angle(0), "models/holograms/hq_icosphere.mdl", Vector(1.2-1/maxHolos * i) )
end

hook.add('tick','',function()
    for i=1,#holo do
        local targetPos = nil
        if i==1 then
            target= owner()
            targetPos = target:getPos() + Vector(math.cos(j) * rad,math.sin(j) * rad,80)
        else
            target = holo[i-1]
            targetPos = target:getPos()
        end
        
        local movePos   = holo[i]:getPos()    + (targetPos - holo[i]:getPos()   ) / smoth       
        holo[i]:setPos(movePos)
    end
    j=(j+0.02)%360

