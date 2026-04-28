local Scy = loadstring(game:HttpGet("https://raw.githubusercontent.com/cypherisog69-eng/Scy-Client/refs/heads/main/Ui"))()
local window = Scy.new("My Hub", "v1.0")

local lp = game:GetService("Players").LocalPlayer

local main = window:Tab("Main", "M")
local settings = window:Tab("Settings", "S")

main:Section("Combat")
main:Toggle({Name="God Mode", Default=false, Callback=function(v)
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.MaxHealth = v and math.huge or 100
        lp.Character.Humanoid.Health = lp.Character.Humanoid.MaxHealth
    end
end})

main:Toggle({Name="Infinite Jump", Default=false, Callback=function(v)
    _G.InfJump = v
    if v then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump and lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end})

main:Button({Name="Rejoin", Callback=function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
end})

main:Button({Name="Reset Character", Callback=function()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.Health = 0
    end
end})

main:Section("Visuals")
main:Toggle({Name="Fullbright", Default=false, Callback=function(v)
    game:GetService("Lighting").Brightness = v and 10 or 1
    game:GetService("Lighting").ClockTime = v and 14 or 14
    game:GetService("Lighting").FogEnd = v and 100000 or 100000
    game:GetService("Lighting").GlobalShadows = not v
end})

main:Toggle({Name="No Fog", Default=false, Callback=function(v)
    game:GetService("Lighting").FogEnd = v and 100000 or 1000
end})

main:Dropdown({Name="Sky", Options={"Default","Night","Sunset"}, Default="Default", Callback=function(v)
    local lighting = game:GetService("Lighting")
    if v == "Night" then
        lighting.ClockTime = 0
    elseif v == "Sunset" then
        lighting.ClockTime = 18
    else
        lighting.ClockTime = 14
    end
end})

settings:Section("Player")
settings:Textbox({Name="Walkspeed", Default="16", PlaceHolder="16", Callback=function(v)
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = tonumber(v) or 16
    end
end})

settings:Textbox({Name="Jump Power", Default="50", PlaceHolder="50", Callback=function(v)
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.JumpPower = tonumber(v) or 50
    end
end})

settings:Section("Camera")
settings:Textbox({Name="Field of View", Default="70", PlaceHolder="70", Callback=function(v)
    workspace.CurrentCamera.FieldOfView = tonumber(v) or 70
end})

settings:Dropdown({Name="Camera Mode", Options={"Classic","Follow","Orbital"}, Default="Classic", Callback=function(v)
    if v == "Classic" then
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    elseif v == "Follow" then
        workspace.CurrentCamera.CameraType = Enum.CameraType.Follow
    elseif v == "Orbital" then
        workspace.CurrentCamera.CameraType = Enum.CameraType.Orbital
    end
end})

settings:Section("Misc")
settings:Toggle({Name="Hide GUI", Default=false, Callback=function(v)
    for _, gui in ipairs(lp.PlayerGui:GetChildren()) do
        if gui.Name ~= "ScyUI" then
            gui.Enabled = not v
        end
    end
end})

settings:Button({Name="Copy UserId", Callback=function()
    setclipboard(tostring(lp.UserId))
    window:Notify("Copied", tostring(lp.UserId), 3)
end})

window:Notify("My Hub", "Loaded!", 3)
