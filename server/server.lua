EnableClearChat = true -- Set to true if you want to enable /clearchat. If you do this command it will clear the chat for everyone in the server.
EnableCleanChat = true -- Set to true if you want to enable /cleanchat. If you do this command it will clear the chat in the client side.
Permission = 'chat.clear'

Webhook = '' -- Webhook link to send the clear chat logs.
whcolor = '' -- Webhook color to set the webhook color lol.

if Webhook == '' then
    print('Chat-Clear: You haven\'t set a webhook to this script.')
else
    print('Chat-Clear: This script was connected to the webhook successfully.' )
end

if whcolor == '' then
    print('Chat-Clear: You haven\'t set a webhook color to this script.')
end

if EnableClearChat == true then
RegisterCommand("clearchat", function(source, args)
   if IsPlayerAceAllowed(source, Permission) then
        TriggerClientEvent("chat:clear", -1)
            Citizen.Wait(10)
        TriggerClientEvent('chatMessage', -1, "^1^*The chat has been cleared by a staff member.")
        sendToDiscord(whcolor, '**Clear Chat Log**', '**Player Name: **' .. GetPlayerName(source) .. '\n**Player ID:** ' .. source, date)
    else
        TriggerClientEvent('chatMessage', source, "^8^*You dont have sufficient permissions to execute this command.")
    end
end, false)
end

if EnableCleanChat == true then
    RegisterCommand("cleanchat", function(source, args)
        TriggerClientEvent("chat:clear", source)
            Citizen.Wait(10)
        TriggerClientEvent('chatMessage', source, "^2^*Your chat has been cleaned successfully.")
    end, false)
end


function sendToDiscord(color, title, message, footer)
    local date = os.date(("%x | %I:%M:%S %p"))
    local embed = {
        {
            ['color']       = color,
            ['title']       = title,
            ['description'] = message,
            ['footer']      = {
                ["text"] = "Clear Chat Log · ".. date,
            },
        }
    }
    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
