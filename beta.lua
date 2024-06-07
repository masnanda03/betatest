--["MUFFINN COMMUNITY]--

function place(id,x,y)
    pkt = {}
    pkt.type = 3
    pkt.value = id
    pkt.px = math.floor(GetLocal().pos.x / 32 +x)
    pkt.py = math.floor(GetLocal().pos.y / 32 +y)
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end
function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end
AddHook("onvariant", "hook", function(var)
if var[0] == "OnDialogRequest" and var[1]:find("end_dialog|item_finder") then
return true
end
return false
end)

function placeplat()
    for y = starty, endy, 2 do 
        for x = startx, endx do
            if GetTile(x,y).fg == 0 then
                FindPath(x-1,y,100) 
                Sleep(delay_place)
                place(platform_id,1,0)
                Sleep(delay_place)
                while findItem(platform_id) == 0 do
                    Sleep(100)
                    SendPacket(2,"action|dialog_return\ndialog_name|item_search\n"..platform_id.."|1\n"..platform_id+1 .."|0")
                    Sleep(100)
                end
            end
        end
    end
end

while true do
    placeplat()
end
