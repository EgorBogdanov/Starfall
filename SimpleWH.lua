--@name Simple WH
--@author EGR
--@client

hook.add("postdrawopaquerenderables",'',function()
    local players = find.allPlayers()
    for i=1,#players do
        render.setColor(team.getColor( players[i]:getTeam()))
        render.draw3DWireframeBox( players[i]:getPos(), Angle(),players[i]:obbCenter()-players[i]:obbSize(), players[i]:obbSize() )
    end
end)
