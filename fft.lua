--@name FFT 
--@author EGR
--@client

local fft={}


bass.loadURL( "https://play.sas-media.ru/play_256", "3d noblock", function(Sound)
    Sound:play()
    hook.add("think","",function()
        Sound:setPos(chip():getPos())
        fft=Sound:getFFT(6)
    end)
end)
                
hook.add("render","",function()      
    render.setColor(Color(188,1,(fft[5] or 0)*10):hsvToRGB()) 
    render.draw3DBox(Vector(0,512,0),Angle(),Vector(),Vector(512*2))
                
    render.setColor(Color(188,1,(fft[6] or 0)*10):hsvToRGB()) 
    render.draw3DBox(Vector(512,512,0),Angle(0,0,90),Vector(),Vector(512))
    render.draw3DBox(Vector(-512,512,0),Angle(0,0,90),Vector(),Vector(512))
                    
    render.setColor(Color(188,1,(fft[7] or 0)*10):hsvToRGB()) 
    render.draw3DBox(Vector(0,0,0),Angle(0,0,90),Vector(),Vector(512))  
                
    render.setColor(Color(188,1,(fft[10] or 0)*10):hsvToRGB()) 
    render.draw3DBox(Vector(0,512,512),Angle(0,0,90),Vector(),Vector(512))
                
    for i=0,50,1 do
        render.setColor(Color(i*4,1,1):hsvToRGB())
        render.draw3DBox(Vector(0+i*10,512,250),Angle(),Vector(),Vector(10,-50-(fft[i+1] or 0)*350,10))
    end
end)



