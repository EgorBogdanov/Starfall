--@name Matrix
--@author EGR
--@client
local chars = {}
local lines = {}
local buffers = {"RT", "RT2"}

local i = 0
local buffernum = 1
local maximumLines = 64
local minimumLineLength = 5
local maximumLineLength = 55

render.createRenderTarget("RT")
render.createRenderTarget("RT2")

for i=33,125 do
    table.insert(chars,string.char(i))
end

hook.add("render","",function()
    local nextbuffer = (buffernum%#buffers)+1
    i = 1
    
    render.setRenderTargetTexture(buffers[buffernum])
    render.selectRenderTarget(buffers[nextbuffer])
    render.clear(Color(0,0,0,255))
    render.setColor(Color(255, 255, 255, 250))
    render.drawTexturedRect(0,8, 1024, 1024)

    while #lines < maximumLines do
        table.insert(lines, {
            x = math.random(1, 1024),
            y = 0,
            length = math.random(minimumLineLength, maximumLineLength)
        })
    end
    
    while i <= #lines do
        if lines[i].y - lines[i].length < 0 then
            part = 5 * lines[i].length / lines[i].y
            render.setColor(Color(0,part*2,0))
            render.drawRect(lines[i].x-2, 0,10,10)
            render.setColor(Color(0,part*10,0))
            render.drawText(lines[i].x, 0, chars[math.random(1, #chars)])
            
            lines[i].y = lines[i].y + 1
            i = i + 1
        else
            table.remove(lines, i)
        end
    end
    render.selectRenderTarget()
        
    render.setColor(Color(255, 255, 255, 255))
    render.setRenderTargetTexture(buffers[nextbuffer])
    render.drawTexturedRect(0, 0, 512, 512)
    buffernum = nextbuffer
end)
