--@name SkeletonParty
--@author EGR
--@shared

if CLIENT then
    local url = 'https://dl.dropboxusercontent.com/s/pje3wlwhyc0r2a0/Hampton%2Bthe%2BHampster%2BHamster%2BDance%2BSong_muzlishko.ru.mp3?dl=0'
    local fft = {}
    bass.loadURL( url, '3d noblock', function(Sound)
        Sound:play()
        hook.add("think","",function()
            Sound:setPos(owner():getPos())
            fft=Sound:getFFT(6)
        end)
        hook.add("drawhud",'',function()
            local Color = Color((timer.curtime()*10)%360, (fft[6] or 0)*40, (fft[6] or 0)*40):hsvToRGB()
            Color:setA( 50)
            render.setColor(Color)
            render.drawRect(0,0,2000,2000)
        end)
    end)
else
    local holo      = {}
    local pos       = chip():getPos()
    local ang       = Angle()
    local model     = 'models/player/skeleton.mdl'
    local scale     = Vector(1)
    local smoth     = 10
    local n         = 24
    local animation = 'ACT_GMOD_TAUNT_DANCE'
    
    for i=1,n do
        holo[i] = holograms.create( pos, ang, model, scale )
        holo[i]:setColor(Color(i*(360/n),1,1,150):hsvToRGB())
        holo[i]:setAnimation(animation, 0, 1 )
        
    end
    timer.create( "Reset", 7, 0, function()
        for i=1,#holo do
            holo[i]:setAnimation(animation, 0, 1 )
        end
    end )
    hook.add('tick','',function()
        for i=1,#holo do
            if i==1 then
                target= owner()
            else
                target = holo[i-1]
            end
            local targetPos = target:getPos()-target:getAngles():getForward()*20
            local targetAng = target:getAngles()
            
            local movePos   = holo[i]:getPos()    + (targetPos - holo[i]:getPos()   )/smoth
            local moveAng   = holo[i]:getAngles() + (targetAng - holo[i]:getAngles())/smoth
            
            holo[i]:setPos(movePos)
            holo[i]:setAngles(moveAng)
        end
    end)
end
