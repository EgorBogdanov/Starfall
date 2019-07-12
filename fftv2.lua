--@name FFT Circle
--@author EGR
--@client

local n = 128
local fft = {}
local url = 'https://dl.dropboxusercontent.com/s/vespsdiw0hf0bm2/dj.Lev%2Cdj.Graff_Slava%2Cdj.Miki%20%E2%80%93%20The%20Abyss%20of%20Your%20Soul.mp3'
local mul = 100
local fftmul=500
local NumSegment = 2
local high = 150

bass.loadURL( url, '3d noblock', function(Sound)
    Sound:play()
    hook.add("think","",function()
        Sound:setPos(chip():getPos()+Vector(0,0,high))
        fft=Sound:getFFT(6)
    end)
end)

hook.add("postdrawopaquerenderables",'',function()
    for i=1,n do
        local deg = (math.pi / n *i)*2
        local x = math.sin(deg)
        local y = math.cos(deg)
        local pos = Vector(0,x,y+high/mul)*mul
        local ang = Angle(0,0,-deg * 180/math.pi)
        
        render.setColor(Color((timer.curtime()*10)%360 + 360 / n * i,1,1):hsvToRGB())
        render.draw3DBox( chip():localToWorld(pos), chip():getAngles()+ang,Vector(), Vector(10,10,10+(fft[i%(n/NumSegment)] or 0)*fftmul) )  
    end
end)
