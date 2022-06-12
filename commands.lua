local commands = {

        sus = function(player)
            if lp.Name ~= master then
                for i,v in pairs(game.Players:GetPlayers())do
                    if string.sub(string.lower(v.DisplayName),0,#player[1]) == string.lower(player[1]) then
                        local stupid = Instance.new('Animation')
                        stupid.AnimationId = 'rbxassetid://148840371'
                        local hummy = game:GetService("Players").LocalPlayer.Character.Humanoid
                        pcall(function()
                            hummy.Parent.Pants:Destroy()
                        end)
                        pcall(function()
                            hummy.Parent.Shirt:Destroy()
                        end)
                        local notfunny = hummy:LoadAnimation(stupid)
                        notfunny:Play()
                        notfunny:AdjustSpeed(30)
                        while hummy.Health ~= 0 and task.wait() or hummy ~= nil and task.wait() do
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)
                        end
                    end
                end
            end
        end,
        spamreport = function(player)
            local victim
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                    victim = v.Name
                end
            end

            local lastsuccess = tick()

            while task.wait() and game.Players:FindFirstChild(victim) do
                local s,e = pcall(function()
                    game.Players:ReportAbuse(game.Players[victim], "Cheating/Exploiting", math.random(1000,9999))
                end)
                if not s then 
                    warn(e) 
                    task.wait(math.ceil(tick()-lastsuccess))
                else
                    game.StarterGui:SetCore("SendNotification", {Title="Reported!",Text="Reported "..victim})
                    lastsuccess = tick()
                end
            end
            game.StarterGui:SetCore("SendNotification", {Title="Success!",Text="Banned "..victim..", or he left."})
        end,
        unsus = function()
            isbang = false
            bang:Stop()
        end,
        obby = function(player)
            if lp.Name == master then return end
            
           local character = game.Players.LocalPlayer.Character
            
            
            game.Players.LocalPlayer.Character = nil
            game.Players.LocalPlayer.Character = character
            if character.Humanoid.RigType == Enum.HumanoidRigType.R15 then 
                for i,v in pairs(character:GetChildren()) do
                    if v:IsA("Accessory") then
                        for i,v in pairs(v.Handle:GetChildren()) do
                            if v:IsA("Attachment") then
                                v:Destroy()
                            end
                        end
                    end
                end
            end
            wait(game.Players.RespawnTime + 0.5)
            if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                character.Humanoid:FindFirstChildOfClass("NumberValue"):Destroy()
            end
            --hat drop
            character.HumanoidRootPart:Destroy()
            for i,v in pairs(character:GetChildren()) do
                if v:IsA("BasePart") and v.Name ~= "Head" then
                    v:Destroy()
                end
            end
            character.Head:Destroy()
            
            wait(1)
            settings().Physics.AllowSleep = false 
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
                game:GetService("RunService").RenderStepped:Connect(function()
                    if NetworkIsSleeping == true then
                    NetworkIsSleeping = false
                    end
                end)
                for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
                    if v:IsA("BasePart") and v.Name ~="HumanoidRootPart"  then 
                    game:GetService("RunService").Heartbeat:connect(function()
                    v.Velocity = Vector3.new(20,20,20)
                    wait(0.5)
                    end)
                end
            end
            wait(0.1)
            
            local function align(x,b)
                x.CanCollide = false
                x.Mesh:Destroy()
                local att0 = Instance.new("Attachment", x)
                att0.Position = Vector3.new(0,0,0)
                local att1 = Instance.new("Attachment", b)
                att1.Position = Vector3.new(0,0,0)
                att1.Orientation = Vector3.new(0,0,0)
                local AP = Instance.new("AlignPosition", x)
                AP.Attachment0 = att0
                AP.Attachment1 = att1
                AP.RigidityEnabled = false
                AP.ReactionForceEnabled = false
                AP.ApplyAtCenterOfMass = true
                AP.MaxForce = 9999999
                AP.MaxVelocity = math.huge
                AP.Responsiveness = 200
                local AO = Instance.new("AlignOrientation", x)
                AO.Attachment0 = att0
                AO.Attachment1 = att1
                AO.ReactionTorqueEnabled = false
                AO.PrimaryAxisOnly = false
                AO.MaxTorque = 9999999
                AO.MaxAngularVelocity = math.huge
                AO.Responsiveness = 200
            end
            
            

            for i,v in pairs(character.Humanoid:GetAccessories()) do
                local part = Instance.new("Part",workspace);part.CFrame = workspace[master].Torso.CFrame;part.Anchored = true;part.Transparency = 1;part.Name = i
                v.Name = i
                align(v.Handle, part)
            end
            
            
            
        end,
        go = function(args)
            if lp.Name == master then return end
            if tostring(h) == args[1] then
                workspace[args[2]].CFrame = workspace[master].Torso.CFrame
            end
        end,
        newadmin = function(player)
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Whitelisted "..player[1].."!", "All")
            writefile("admins/"..player[1]..".admin",player[1])
            if lp.Name == master then
                Output("Added "..player[1].." as an *Admin*!")
            end
            Admins = listfiles("admins")
            _G.PlayerChatStop()
        end,
        unadmin = function(player)
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Unwhitelisted "..player[1].."!", "All")
            delfile("admins/"..player[1]..".admin")
            if lp.Name == master then
                Output("Removed "..player[1].." as an *Admin*!")
            end
            Admins = listfiles("admins")
            _G.PlayerChatStop()
        end,
        rj = function()
            if lp.Name ~= master then
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
            end
        end,
        nofling = function(player)
            local changed = false
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(string.sub(v.DisplayName,0,#player[1])) == string.lower(player[1]) and not changed then
                    player = v.Name
                    changed = true
                end
            end
            if not changed then
                return
            end
            task.spawn(function()
                while task.wait() do
                    task.spawn(function()
                        for i, x in pairs(game.Players[player].Character:GetDescendants()) do
                            if x:IsA("BasePart") and not x.Anchored then
                                x.Anchored = true
                            end
                        end
                    end)
                end
            end)
        end,
        goto = function(player)
            local player2
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                    player2 = v
                end
            end
            lp.Character.HumanoidRootPart.CFrame = player2.Character.HumanoidRootPart.CFrame
        end,

        advert = function(said,speaker)
            if isadvert then
                if lp.Name ~= master then 
                    isadvert = false
                elseif lp.Name == master then
                    Output("Use -un advert before adverting something else! The bot(s) will now stop repeating the last quote")
                end
            end
            isadvert = true
            if lp.Name ~= master then
                while isadvert do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(said, "All")
                    wait(4)
                end
            end
        end,
        unadvert = function(speaker)
            isadvert = false
        end,
        wsa = function(number,speaker)
            print(number)
            if lp.Name ~= master then
                lp.Character.Humanoid.WalkSpeed = number
            else
                print("u are master")
            end
        end,
        follow = function(player,speaker)
            if isfollow == true and lp.Name ~= master then 
                isfollow = false
            end
            print(player[1])
            isfollow = true
            
            while isfollow and task.wait() do
                wait()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            
                            lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,(tonumber(string.sub(lp.Name,#lp.Name))+2))
                        end
                    end
                end
            end
        end,
        walk = function(player)
            if isfollow == true and lp.Name ~= master then  
                isfollow = false
            end
            print(player[1])
            isfollow = true
            
            while isfollow and task.wait() do
                wait()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            
                            lp.Character.Humanoid:MoveTo(Vector3.new(v.Character.HumanoidRootPart.Position.X,v.Character.HumanoidRootPart.Position.Y,v.Character.HumanoidRootPart.Position.Z*(tonumber(string.sub(lp.Name,#lp.Name)))+2))
                        end
                    end
                end
            end
        end,
        stand = function(player,speaker)
            if isstand == true and lp.Name ~= master then 
                
                isstand = false
            elseif isstand == true and lp.Name == master then
                Output("Use -unfollow before trying to follow someone else! The bots will now stop following...")
            end
            print(player[1])
            isstand = true
            
            while isstand and task.wait() do
                for i,v in pairs(game.Players:GetPlayers()) do
                    if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            
                            lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame*CFrame.new(-2,2,2)
                            
                        end
                    end
                end
            end
        end,
        swarm = function(player)
            if isswarm == true and lp.Name ~= master then 
                
                isswarm = false
            elseif isswarm == true and lp.Name == master then
                Output("Use -unfollow before trying to follow someone else! The bots will now stop following...")
            end
            print(player[1])
            isswarm = true
            local p = nil
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(player[1]) == string.lower(string.sub(v.DisplayName,0,#player[1])) and lp.Name ~= master then
                    p = v
                end
            end
            if p == nil then return end
            lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            while isswarm do
                wait(0.2)
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    lp.Character.Humanoid:MoveTo(Vector3.new(p.Character.HumanoidRootPart.Position.X + math.random(-5.8,5.4),p.Character.HumanoidRootPart.Position.Y + 0,p.Character.HumanoidRootPart.Position.Z +math.random(-4,4.8)))
                end    
            end
        end,
        unfollow = function(player,speaker)
            print("un")
            isfollow = false
        end,
        unswarm = function(player,speaker)
            print("un")
            isswarm = false
        end,
        unstand = function(player,speaker)
            print("un")
            isstand = false
        end,
        jump = function(speaker)
            if lp.Name ~= master then
                lp.Character:FindFirstChildOfClass("Humanoid").Jump = true
            end
        end,
        sit = function(speaker)
            if lp.Name ~= master then
            lp.Character:FindFirstChildOfClass("Humanoid").Sit = not lp.Character:FindFirstChildOfClass("Humanoid").Sit
            end
        end,
        bringbot = function(bot,speaker)
            if lp.Name == bot  then
                lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
            elseif bot == "all" then
                if lp.Name ~= master then
                    lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
                end
            elseif bot == "das" then
                if lp.Name == "dasdasdaslol"  then
                    lp.Character.HumanoidRootPart.CFrame = game.Players[speaker].Character.HumanoidRootPart.CFrame
                end
            end
        end,
        killbot = function(bot,speaker)
            if lp.Name == bot then
                lp.Character.Humanoid.Health = 0
            elseif bot == "das" then
                if lp.Name == "dasdasdaslol"  then
                    lp.Character.Humanoid.Health = 0            
                end
            end
        end,
        resetbots = function(speaker)
            if lp.Name ~= master then
                lp.Character.Humanoid.Health = 0
            end
        end,
        say = function(said,speaker)
            if lp.Name ~= master then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(said, "All")
            end
        end,

        copy = function(said,speaker)
            local p = nil
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(said[1]) == string.lower(string.sub(v.DisplayName,0,#said[1])) and lp.Name ~= master then
                    p = v
                end
            end
            if p then
                p.Chatted:Connect(function(message)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("yeah "..message, "All")
                end)
            end
        end,
        hold = function(said,speaker)
            print(said[1])
            for i,v in pairs(lp.Backpack:GetChildren()) do
                
                if i == tonumber(said[1]) then
                    v.Parent = lp.Character
                end
            end
        end,
        quit = function(speaker)
            if lp.Name ~= master then
                game:shutdown() 
            end
        end,
        cmds = function(speaker)
            loadstring(game:HttpGet('https://pastebin.com/raw/rVm4TgBB'))();
            if lp.Name == master then
                Output("wsa [number], follow [player], -unfollow [player], -bhop, -un bhop, -bring bot [bot username], -kill bot [bot username], -reset bots, -bot say [quote], -quit -fling [Player Name (Doesn't have to be full username)]")
            end
        end,
        output = function(text)
            if lp.Name == master then
                Output(text[1])
            end
        end,
        exe = function(Message)
            if lp.Name ~= master then
                local Function = loadstring(Message)
                local S, E = pcall(Function)
                if not S then
                    Output(E)
                end
            end
        end,
        fling = function(plrr,speaker)
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(plrr[1]) == string.lower(string.sub(v.DisplayName,0,#plrr[1])) and lp.Name ~= master then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("flinging", "All")
                    local Target = v
                    local Thrust = Instance.new('BodyThrust', lp.Character.HumanoidRootPart)
                    Thrust.Force = Vector3.new(9999,9999,9999)
                    Thrust.Name = "YeetForce"
                    repeat
                        lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                        Thrust.Location = Target.Character.HumanoidRootPart.Position
                        game:FindService("RunService").Heartbeat:wait()
                    until not Target.Character:FindFirstChild("Head") or lp.Character.Humanoid.Health == 0
                end
            end
        end,
        rotate = function(args)
            if isrotate then isrotate = false end
            isrotate = true
            local p = nil
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(args[1]) == string.lower(string.sub(v.DisplayName,0,#args[1])) and lp.Name ~= master then
                    p = v
                end
            end
            while wait(0.01) and isrotate do
                rotaten+=tonumber(args[2])
                lp.Character.HumanoidRootPart.Position = _G.RPAO(p.Character.HumanoidRootPart,args[3],rotaten)
            end
        end,
        unrotate = function()
            isrotate = false
        end,
        stack = function(args)
            local p
            for i,v in pairs(game.Players:GetPlayers()) do
                if string.lower(args[1]) == string.lower(string.sub(v.DisplayName,0,#args[1])) and lp.Name ~= master then
                    p = v
                end
            end
            dostack = true
            workspace.Gravity = 0
            while dostack and task.wait() do 

                lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,5*h,0)
            end
        end,
        unstack = function()
            dostack = false
            workspace.Gravity = 196
        end,
        
    }
                
