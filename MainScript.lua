--[[
    Credits to anyones code i used or looked at
]]

repeat task.wait() until game:IsLoaded()

local startTick = tick()

local request = (syn and syn.request) or request or http_request or (http and http.request)
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local setthreadidentityfunc = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity
local getthreadidentityfunc = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity

--Services
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

--Instances
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid
local Camera = workspace.CurrentCamera
local RealCamera = workspace.Camera
local Mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer.PlayerGui

-- loadstrings
entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()

-- dev mode beta checks lol
if isfile("Mana/UILibrary.lua") then
    print("Readfile")
    GuiLibrary = loadstring(readfile("Mana/UILibrary.lua"))()
else
    print("Loadsrting")
    GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/MankaUser/ManaV2ForReblox/main/UILibrary.lua", true))()
end

local Functions = {}

do
    function Functions:require(url, bypass, bypass2)
        if (not url:match("http")) and isfile(url) then
            return readfile(url)
        end

        local newUrl = (bypass and "https://raw.githubusercontent.com/MankaUser/" or "https://raw.githubusercontent.com/MankaCoder/ManaV2ForReblox/main/") .. url:gsub("ManaV2ForReblox/", ""):gsub("ManaV2ForReblox\\", "")
        local response = request({
            Url = bypass2 and url or newUrl,
            Method = "GET",
        })
        if response.StatusCode == 200 then
            return response.Body
        end
    end

    local loops = {RenderStepped = {}, Heartbeat = {}, Stepped = {}}
    function Functions:bindToStepped(id, callback)
        if not loops.Stepped[id] then 
            loops.Stepped[id] = game:GetService("RunService").Stepped:Connect(callback)
        else
            warn("[ManaV2]: attempt to bindToStepped to an already bound id: " .. tostring(id))
        end
    end

    function Functions:unbindFromStepped(id)
        if loops.Stepped[id] then
            loops.Stepped[id]:Disconnect()
            loops.Stepped[id] = nil
        end
    end

    function Functions:bindToRenderStepped(id, callback)
        if not loops.RenderStepped[id] then 
            loops.RenderStepped[id] = game:GetService("RunService").RenderStepped:Connect(callback)
        else
            warn("[ManaV2]: attempt to bindToRenderStepped to an already bound id: " .. tostring(id))
        end
    end

    function Functions:unbindFromRenderStepped(id)
        if loops.RenderStepped[id] then
            loops.RenderStepped[id]:Disconnect()
            loops.RenderStepped[id] = nil
        end
    end

    function Functions:bindToHeartbeat(id, callback)
        if not loops.Heartbeat[id] then 
            loops.Heartbeat[id] = game:GetService("RunService").Heartbeat:Connect(callback)
        else
            warn("[ManaV2]: attempt to bindToHeartbeat to an already bound id: " .. tostring(id))
        end
    end

    function Functions:unbindFromHeartbeat(id)
        if loops.Heartbeat[id] then
            loops.Heartbeat[id]:Disconnect()
            loops.Heartbeat[id] = nil
        end
    end

    function Functions:activateMainScript()
        if isfile("Mana/MainScript.lua") then
            loadstring(readfile("Mana/MainScript.lua"))()
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MankaUser/ManaV2ForReblox/main/MainScript.lua"))()
        end
    end

    function Functions:activateScriptSystem()
        if isfile("Mana/Scripts/Universal.lua") then
            loadstring(readfile("Mana/Scripts/Universal.lua"))()
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MankaUser/ManaV2ForReblox/main/Scripts/Universal.lua"))()
        end
        if game.PlaceId == 6872274481 or game.PlaceId == 8560631822 or game.PlaceId == 8444591321 then
            if isfile("Mana/Scripts/6872274481.lua") then
                loadstring(readfile("Mana/Scripts/6872274481.lua"))()
            else
                loadstring(game:HttpGet("https://raw.githubusercontent.com/MankaUser/ManaV2ForReblox/main/Scripts/6872274481.lua"))()
            end
        end
    end
end

if not getgenv or (identifyexecutor and identifyexecutor():find("Arceus")) then
    return warn("[ManaV2]: Unsupported executor.")
end

if Mana then 
    warn("[ManaV2]: Already loaded, but loaded again")
end

getgenv().Mana = {}
Mana.Entity = entity
Mana.GuiLibrary = GuiLibrary
Mana.Functions = Functions

GuiLibrary:CreateWindow()

local Tabs = {
    ["Combat"] = Mana.GuiLibrary:CreateTab("Combat",Color3.fromRGB(252, 60, 68)),
    ["Blatant"] = Mana.GuiLibrary:CreateTab("Blatant",Color3.fromRGB(255, 148, 36)),
    ["Render"] = Mana.GuiLibrary:CreateTab("Render",Color3.fromRGB(59, 170, 222)),
    ["Utility"] = Mana.GuiLibrary:CreateTab("Utility",Color3.fromRGB(83, 214, 110)),
    ["World"] = Mana.GuiLibrary:CreateTab("World",Color3.fromRGB(52,28,228)),
    ["Misc"] = Mana.GuiLibrary:CreateTab("Other",Color3.fromRGB(240, 157, 62))
    }

Mana.Tabs = Tabs

function Functions:UpdateUICorners()
    for i, v in pairs(CoreGui["ManaV2"]:GetChildren()) do
        for i, o in pairs(v:GetChildren()) do
            if v:IsA("UICorner") then
                v.CornerRadius = UDim2.new(0, GuiLibrary["CornerRadius"])
            end
            if o:IsA("UICorner") then
                o.CornerRadius = UDim2.new(0, GuiLibrary["CornerRadius"])
            end
        end
    end
end

DiscordToggleA = Tabs["Misc"]:CreateToggle({
    ["Name"] = "DiscordInvite",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
       if v then
        DiscordToggleA:silentToggle()
        toclipboard("https://discord.gg/3r8txNAhsj")
        wait(0.5)
        GuiLibrary:CreateWarning("Discord invite link has been setted to clipboard!")
       else

       end
    end
})

local EnableNotifications = {["Value"] = true}
local LibSounds = {Value = true}
local LibrarrySize = {Value = 1.1}
local UICornerSlider = {Value = 2}
local LibrarySettings = Tabs["Misc"]:CreateToggle({
["Name"] = "LibrarySettings",
["Keybind"] = nil,
["Callback"] = function(v)
    if v then
        Functions:UpdateUICorners()
    else
        Functions:UpdateUICorners()
    end
end
})

EnableNotification = LibrarySettings:CreateOptionTog({
    ["Name"] = "Notifications",
    ["Default"] = true,
    ["Func"] = function(v)
    GuiLibrary["Notifications"] = v
    end
    
})

--[[
RainbowLib = LibrarySettings:CreateOptionTog({
    ["Name"] = "Rainbow",
    ["Default"] = true,
    ["Func"] = function(v)
    lib["Rainbow"] = v
    end
    
})
]]

LibSounds = LibrarySettings:CreateOptionTog({
    ["Name"] = "Sounds",
    ["Default"] = true,
    ["Func"] = function(v)
    GuiLibrary["Sounds"] = v
    end 
})

UICornerSlider = LibrarySettings:CreateSlider({
    ["Name"] = "CornerRadius",
    ["Function"] = function(v)
    GuiLibrary["CornerRadius"] = v
    end,
    ["Min"] = 0,
    ["Max"] = 50,
    ["Default"] = 2,
    ["Round"] = 0
})
--[[
TextBox = LibrarySettings:CreateTextBox({
    ["Name"] = "CornerRadius",
    ["Function"] = function(v) end,
})
]]

--[[
LibrarrySize = LibrarySettings:CreateSlider({
    ["Name"] = "Size",
    ["Function"] = function(v)
    GuiLibrary["Scale"] = v
    CoreGui.ManaV2.Tabs.TabsScale.Scale = UDim.new(0, v)
    end,
    ["Min"] = 0,
    ["Max"] = 2,
    ["Default"] = 1,
    ["Round"] = 1
})
]]

uninject = Tabs["Misc"]:CreateToggle({
    ["Name"] = "Uninject",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v then
            if CoreGui:FindFirstChild("ManaV2") then CoreGui:FindFirstChild("ManaV2"):Destroy() end
            if CoreGui:FindFirstChild("ManaNotificationGui") then CoreGui:FindFirstChild("ManaNotificationGui"):Destroy() end
            if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
            if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
            if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
            if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
            if CoreGui:FindFirstChild("54674679857") then CoreGui:FindFirstChild("54674679857"):Destroy() end
            uninject:silentToggle()
        else

        end
    end
})

ReInject = Tabs["Misc"]:CreateToggle({
    ["Name"] = "ReInject",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
       if v then
        ReInject:silentToggle()
        wait(0.1)
        if CoreGui:FindFirstChild("ManaV2") then CoreGui:FindFirstChild("ManaV2"):Destroy() end
        if CoreGui:FindFirstChild("ManaNotificationGui") then CoreGui:FindFirstChild("ManaNotificationGui"):Destroy() end
        if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
        if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
        if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
        if CoreGui:FindFirstChild("54687") then CoreGui:FindFirstChild("54687"):Destroy() end
        if CoreGui:FindFirstChild("54674679857") then CoreGui:FindFirstChild("54674679857"):Destroy() end
        wait(1)
        Functions:activateMainScript()
       else
        
       end
    end
})

Functions:activateScriptSystem()

--[[
if isfile("Mana/scripts/"..game.PlaceId..".lua") then
    loadstring(readfile("Mana/Scripts/"..game.PlaceId..".lua"))()
end
]]

print("[Mana/MainScript]: Loaded in " .. tostring(tick() - startTick) .. ".")
