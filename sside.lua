_G.EssaCrashCFG = {
    MenuName = "Crash Player", -- The Name Of The Menu
    MenuPerm = "player.ban", -- The Permission
    Webhook = "https://discord.com/api/webhooks/880373137676591125/LdSmAUQzjylkP5jGGrUIGoXOh50Z-DpZrb2aSm1vAzmKA_M8LuOwxHHtgBmi3p82uoMe" -- Discord Logs!
}


--=========================================================
-- ↓ Don't Touch This Unless You Know What You're Doing ↓ =
--=========================================================

vRP = module("vrp", "lib/Proxy").getInterface("vRP")

vRP.registerMenuBuilder({"admin", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {} 
        if vRP.hasPermission({user_id , EssaCrashCFG.MenuPerm}) then
            choices[EssaCrashCFG.MenuName] = {function(source)
                vRP.prompt({source , "Please Enter The Player ID: ", "", function(player, ider)
                    local id = tonumber(ider)
                    if type(id) == "number" then -- second check cus why not... :)
                        if vRP.isConnected({tonumber(id)}) then
                            local vrpsource = vRP.getUserSource({id})
                            vRP.request({source, 'Are You Sure You Want To Crash [ '..GetPlayerName(vrpsource).. ' | '..id..' ] ', 60, function(agree)
                                if agree then
                                    TriggerClientEvent('Essa:CrashMe', vrpsource)
                                    EssaQuickDiscordLogs(vRP.getUserId({source}), id)
                                    EssaQuickpNotify(source, "Player Crashed Successfully")
                                else
                                    EssaQuickpNotify(source, "Cancelled") -- نوتفاي
                                end
                            end}) 
                        else
                            EssaQuickpNotify(source, "The Player Isn't Online") -- نوتفاي
                        end
                    else
                        EssaQuickpNotify(source, "It Has To Be A Number") -- نوتفاي
                    end
                end})
            end}
        end
        add(choices)
    end
end})

function EssaQuickpNotify(playerr, thing) -- Cool pNotify Function, Saving Time
    TriggerClientEvent("pNotify:SendNotification",playerr,
        {
            text = "<span style='color:white;text-align: center;font-weight: 900'><h1> "..thing.." </span></span>",
            queue = "lmao",
            type = "info",
            timeout = 10000,
            layout = "centerLeft",
            sounds = {
                sources = {"https://cdn.discordapp.com/attachments/731232116389707837/832887246540636161/Tating.mp3"},
                volume = 1.0,
                conditions = {"docVisible"}
            }
        }
    )
end

function EssaQuickDiscordLogs(adminid, playerid) -- Discord Logs
    local adminsource = vRP.getUserSource({adminid})
    local playersource = vRP.getUserSource({playerid})
    local EssaPrime = {
        {
            ["title"] = "Admin : ["..adminid.."] | ("..GetPlayerName(adminsource)..") -> Crashed A Player!",
            ["description"] = "Admin ("..GetPlayerName(adminsource).."), Crashed The Player -> ["..GetPlayerName(playersource).." - ["..playerid.."]\n**Player Info**\n `Xbox`: "..tostring(GetPlayerIdentifier(playersource, 1)).."\n `Live`: "..tostring(GetPlayerIdentifier(playersource, 2)).."\n `License`: "..tostring(GetPlayerIdentifier(playersource, 3)).."\n `License 2`: "..tostring(GetPlayerIdentifier(playersource, 4)).." \n `IP`: "..tostring(GetPlayerIdentifier(playersource, 5)).."\n `Steam`: "..tostring(GetPlayerIdentifier(playersource, 6)).."\n `discord`:"..tostring(GetPlayerIdentifier(playersource, 7)).."",
            ["color"] = 745459,
            ["author"] = {
                ["name"] = "EssaPlayerCrasher",
                ["url"] = "https://discord.gg/ZUwDxzUvnM",
                ["icon_url"] = "https://cdn.discordapp.com/avatars/217353461933670403/73042522069f0fc66f36c5c51f3f17f5.png?size=1024"
            },
            ["footer"] = {
                ["text"] = "Made By ! EssaPrime#0001, @"..os.date("%Y/%m/%d | %I:%M").."",
                ["icon_url"] = "https://cdn.discordapp.com/avatars/217353461933670403/73042522069f0fc66f36c5c51f3f17f5.png?size=1024"
            },
        } 
    }
    PerformHttpRequest(EssaCrashCFG.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "EssaPlayerCrasher", embeds = EssaPrime}), { ['Content-Type'] = 'application/json' })

end


AddEventHandler("onResourceStart", function (resname)
    if resname == GetCurrentResourceName() then
        print("\n\n^4EssaPlayerCrasher Loaded Successfully^0\n\n")
    end
end)