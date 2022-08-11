if syn then
    if game:IsLoaded() then
        game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport("")
            end
        end)

        local scriptVer = "0.12b"

        local changelogs = {
            "UI Improvements",
            "New Webhook System"
        }

        local CoreUI = game:GetService("CoreGui")
        local StarterGui = game:GetService("StarterGui")
        local HttpService = game:GetService("HttpService")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Debris = game:GetService("Debris")

        local DataTable = {}
        local ToggleList = {}

        local function sendWebhookMsg(url, title, text)
            local data = 
                {
                    ["content"] = "",
                    ["embeds"] = {{
                        ["title"] = "**Grand Mid Online "..scriptVer.."**",
                        ["type"] = "rich",
                        ["color"] = tonumber(0xffffff),
                        ["fields"] = {
                            {
                                ["name"] = "__"..title.."__",
                                ["value"] = text,
                                ["inline"] = false
                            },
                        }
                    }}
                }

            local newdata = game:GetService("HttpService"):JSONEncode(data)
            local headers = {
                ["content-type"] = "application/json"
             }
             request = http_request or request or HttpPost or syn.request
             local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
             request(abcdef)
        end

        local function notif(text)
            StarterGui:SetCore("SendNotification", {
                Title = "Grand Mid Online v"..scriptVer;
                Text = text;
                Duration = 3;
            })
        end

        local function encodedName()
            return tostring(HttpService:GenerateGUID(false))
        end

        if CoreUI:FindFirstChild("GMO_"..scriptVer) then
            CoreUI:FindFirstChild("GMO_"..scriptVer):Destroy()
        end

        local function TransparencyToToggle(item)
            local toggled = false
            if item ~= nil then
                if item.ImageTransparency == 0 then
                    toggled = true
                else
                    toggled = false
                end
            end

            return toggled
        end

        local mofy = 0.4125
        local mofx = 0.4125

        local function MakeDraggable(gui)
            local dragging
            local dragInput
            local dragStart
            local startPos

            function Lerp(a, b, m)
                return a + (b - a) * m
            end;

            local lastMousePos
            local lastGoalPos
            local DRAG_SPEED = (8);
            function Update(dt)
                if not (startPos) then return end;
                if not (dragging) and (lastGoalPos) then
                    gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
                    return 
                end;

                local delta = (lastMousePos - UserInputService:GetMouseLocation())
                local xGoal = (startPos.X.Offset - delta.X);
                local yGoal = (startPos.Y.Offset - delta.Y);
                lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
                gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
            end;

            gui.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = gui.Position
                    lastMousePos = UserInputService:GetMouseLocation()

                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            gui.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end)

            RunService.Heartbeat:Connect(Update)
        end

        local Screen = Instance.new("ScreenGui")
        Screen.Name = "GMO_"..scriptVer
        Screen.Parent = CoreUI
        syn.protect_gui(Screen)
        local LoadUI = Instance.new("Frame")
        LoadUI.Name = encodedName()
        LoadUI.Size = UDim2.new(0, 341, 0, 57)
        LoadUI.Position = UDim2.new(mofx, 0, 1.2, 0) -- 0.55
        LoadUI.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        LoadUI.Parent = Screen
        local UICorner = Instance.new("UICorner")
        UICorner.Name = encodedName()
        UICorner.Parent = LoadUI
        TweenService:Create(LoadUI, TweenInfo.new(1.5, Enum.EasingStyle.Back) ,{Position = UDim2.new(mofx, 0, mofy, 0)}):Play()

        local Title = Instance.new("TextLabel")
        Title.Name = encodedName()
        Title.BackgroundTransparency = 1
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.SourceSansSemibold
        Title.Position = UDim2.new(0.023, 0, 0.035, 0)
        Title.Size = UDim2.new(0.911, 0, 0.263, 0) -- 0.947
        Title.Text = "Grand Mid Online "..scriptVer
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextTransparency = 1
        Title.TextScaled = true
        Title.Parent = LoadUI

        local StatusText = Instance.new("TextLabel")
        StatusText.Name = encodedName()
        StatusText.BackgroundTransparency = 1
        StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusText.Font = Enum.Font.SourceSansSemibold
        StatusText.Position = UDim2.new(0.023, 0, 0.035, 0)
        StatusText.Size = UDim2.new(0.947, 0, 0.263, 0) -- 0.947
        StatusText.Text = ""
        StatusText.TextXAlignment = Enum.TextXAlignment.Right
        StatusText.TextTransparency = 1
        StatusText.TextScaled = true
        StatusText.Parent = LoadUI

        local LoadBar = Instance.new("Frame")
        LoadBar.Name = encodedName()
        LoadBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        LoadBar.Position = UDim2.new(0.029, 0, 0.351, 0)
        LoadBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LoadBar.Size = UDim2.new(0.941, 0, 0.509, 0)
        LoadBar.BackgroundTransparency = 1
        LoadBar.BorderSizePixel = 0
        LoadBar.Parent = LoadUI

        local LoaderBar = Instance.new("Frame")
        LoaderBar.Name = encodedName()
        LoaderBar.BackgroundColor3 = Color3.fromRGB(0, 255, 55)
        LoaderBar.BorderSizePixel = 0
        LoaderBar.Size = UDim2.new(0, 0, 1, 0)
        LoaderBar.BackgroundTransparency = 1
        LoaderBar.Parent = LoadBar

        wait(1.5)
        TweenService:Create(Title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        TweenService:Create(StatusText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        TweenService:Create(LoadBar, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(LoaderBar, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

        -- Authorization
        wait(1)
        StatusText.Text = "Authorizing"
        TweenService:Create(LoaderBar, TweenInfo.new(1), {Size = UDim2.new(0.25, 0, 1, 0)}):Play()
        wait(3)

        local userAllowed = true
        if userAllowed then
            notif("Hello sir")
            StatusText.TextColor3 = Color3.fromRGB(0, 255, 76)
            StatusText.Text = "Authorized!"

            TweenService:Create(LoaderBar, TweenInfo.new(1), {Size = UDim2.new(0.5, 0, 1, 0)}):Play()
            wait(2)


            StatusText.Text = "Loading UI"
            delay(3, function()
                StatusText.Text = "Loading Files"
            end)
            TweenService:Create(LoaderBar, TweenInfo.new(5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
            local Main = Instance.new("Frame")
            Main.Name = encodedName()
            Main.Position = UDim2.new(mofx, 0, mofy - 0.05, 0)
            Main.Size = UDim2.new(0, 473, 0, 339) -- 0.55
            Main.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Main.BackgroundTransparency = 1
            Main.Parent = Screen
            local UICorner = Instance.new("UICorner")
            UICorner.Name = encodedName()
            UICorner.Parent = Main
            MakeDraggable(Main)

            local Inside = Instance.new("Frame")
            Inside.Name = encodedName()
            Inside.Size = UDim2.new(0.254, 0, 0.768, 0)
            Inside.Position = UDim2.new(0.024, 0, 0.201, 0) -- 0.55
            Inside.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Inside.BackgroundTransparency = 1
            Inside.Parent = Main
            local InsideTitle = Instance.new("TextLabel")
            InsideTitle.Name = encodedName()
            InsideTitle.BackgroundTransparency = 1
            InsideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            InsideTitle.Font = Enum.Font.SourceSansSemibold
            InsideTitle.Position = UDim2.new(0, 0, 0.023, 0)
            InsideTitle.Size = UDim2.new(0.997, 0, 0.081, 0) -- 0.947
            InsideTitle.Text = "Tab"
            InsideTitle.TextTransparency = 1
            InsideTitle.TextScaled = true
            InsideTitle.TextScaled = true
            InsideTitle.Parent = Inside
            local InsideLine = Instance.new("Frame")
            InsideLine.Name = encodedName()
            InsideLine.Size = UDim2.new(0.877, 0, 0.005, 0)
            InsideLine.Position = UDim2.new(0.071, 0, 0.134, 0) -- 0.55
            InsideLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InsideLine.BackgroundTransparency = 1
            InsideLine.BorderSizePixel = 0
            InsideLine.Parent = Inside
            local UICorner = Instance.new("UICorner")
            UICorner.Name = encodedName()
            UICorner.Parent = Inside

            local Icon = Instance.new("ImageLabel")
            Icon.Name = encodedName()
            Icon.BackgroundTransparency = 1
            Icon.Position = UDim2.new(0.056, 0, 0.041, 0)
            Icon.Size = UDim2.new(0.114, 0, 0.157, 0)
            Icon.Image = "rbxassetid://9725861567"
            Icon.ImageTransparency = 1
            Icon.Parent = Main

            local NTitle = Instance.new("TextLabel")
            NTitle.Name = encodedName()
            NTitle.BackgroundTransparency = 1
            NTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            NTitle.Font = Enum.Font.SourceSansSemibold
            NTitle.Position = UDim2.new(0.195, 0, 0.043, 0)
            NTitle.Size = UDim2.new(0.527, 0, 0.066, 0) -- 0.947
            NTitle.Text = "Grand Mid Online"
            NTitle.TextXAlignment = Enum.TextXAlignment.Left
            NTitle.TextTransparency = 1
            NTitle.TextScaled = true
            NTitle.Parent = Main
            local Description = Instance.new("TextLabel")
            Description.Name = encodedName()
            Description.BackgroundTransparency = 1
            Description.TextColor3 = Color3.fromRGB(255, 255, 255)
            Description.Font = Enum.Font.SourceSansItalic
            Description.Position = UDim2.new(0.195, 0, 0.109, 0)
            Description.Size = UDim2.new(0.527, 0, 0.066, 0) -- 0.947
            Description.Text = "Makes the game easier to play!"
            Description.TextXAlignment = Enum.TextXAlignment.Left
            Description.TextTransparency = 1
            Description.TextScaled = true
            Description.Parent = Main
            local Version = Instance.new("TextLabel")
            Version.Name = encodedName()
            Version.BackgroundTransparency = 1
            Version.TextColor3 = Color3.fromRGB(255, 255, 255)
            Version.Font = Enum.Font.SourceSansItalic
            Version.Position = UDim2.new(0.722, 0, 0.109, 0)
            Version.Size = UDim2.new(0.256, 0, 0.066, 0) -- 0.947
            Version.Text = "Version "..scriptVer
            Version.TextXAlignment = Enum.TextXAlignment.Right
            Version.TextTransparency = 1
            Version.TextScaled = true
            Version.Parent = Main

            -- \\ UI
            local SelectionFrame = Instance.new("Frame")
            SelectionFrame.Name = encodedName()
            SelectionFrame.Position = UDim2.new(0.1, 0, 0.166, 0)
            SelectionFrame.Size = UDim2.new(0.042, 0, 0.046, 0)
            SelectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectionFrame.BackgroundTransparency = 1
            SelectionFrame.Parent = Inside
            local SelectionCorner = Instance.new("UICorner")
            SelectionCorner.CornerRadius = UDim.new(1, 0)
            SelectionCorner.Parent = SelectionFrame
            local SelectionFrameTween

            local function SelectionEffect(gui)
                if gui then
                    gui.MouseEnter:Connect(function()
                        gui.Font = Enum.Font.SourceSansSemibold
                        gui.TextSize = 21
                    end)
                    gui.MouseLeave:Connect(function()
                        gui.Font = Enum.Font.SourceSansLight
                        gui.TextSize = 20
                    end)
                    gui.MouseButton1Click:Connect(function()
                        local function Tween(OBJInstance,Goal,Duration)
                            local T = TweenService:Create(OBJInstance,TweenInfo.new(Duration),Goal)
                            T:Play()
                        end

                        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

                        local CircleEffect = Instance.new("Frame")
                        CircleEffect.Name = encodedName()
                        CircleEffect.Parent = gui
                        local CircleCorner = Instance.new("UICorner")
                        CircleCorner.CornerRadius = UDim.new(1, 0)
                        CircleCorner.Parent = CircleEffect
                        local ASX,ASY = gui.AbsoluteSize.X, gui.AbsoluteSize.Y
                        local APX,APY = gui.AbsolutePosition.X, gui.AbsolutePosition.Y
                        local MX,MY = Mouse.X,Mouse.Y
                        local Pos = UDim2.new(0,MX-APX,0,MY-APY)
                        local UBC3 = gui.BackgroundColor3
                        local UR,UG,UB = UBC3.R, UBC3.G, UBC3.B
                        CircleEffect.ZIndex = 100001
                        CircleEffect.AnchorPoint = Vector2.new(0.5,0.5)
                        CircleEffect.Position = Pos
                        local MS = UDim2.fromOffset(math.max(ASX,ASY),math.max(ASX,ASY))
                        CircleEffect:TweenSize(MS,"Out","Sine",0.5)
                        Tween(CircleEffect,{BackgroundTransparency = 1}, 0.5)
                        Debris:AddItem(CircleEffect, 0.5)
                    end)
                end
            end

            local function SectionOnSelect(gui, name)
                if gui then
                    gui.MouseButton1Click:Connect(function()
                        local YPos = gui.Position.Y.Scale -- 0.03
                        local PlacingPosition = UDim2.new(SelectionFrame.Position.X.Scale, 0, YPos + 0.04, 0) -- 0.106
                        if SelectionFrame.Position ~= PlacingPosition then
                            if SelectionFrameTween ~= nil then
                                SelectionFrameTween:Pause()
                            end

                            local TweenSpeed = 0.126 * 4 -- per 1s
                            local TweenTime = gui.Position.X.Scale / TweenSpeed
                            SelectionFrameTween = TweenService:Create(SelectionFrame, TweenInfo.new(TweenTime), {Position = PlacingPosition})
                            SelectionFrameTween:Play()

                            local choosenSectionFrame = Main:FindFirstChild(name.."_"..scriptVer)
                            if choosenSectionFrame then
                                for _, v in pairs(Main:GetChildren()) do
                                    if v:IsA("Frame") and v:FindFirstChild("Tab") then
                                        if v.Name == name.."_"..scriptVer then
                                            v.Visible = true
                                            v.BackgroundTransparency = 0
                                        else
                                            v.Visible = false
                                            v.BackgroundTransparency = 1
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end

            local function AddSection(text)
                local YSize = 0.126
                local XPos = 0.139
                local SectionSize = UDim2.new(0.717, 0, YSize, 0)
                local AmountOfSection = Inside:GetChildren()
                local PlacingPosition = UDim2.new(XPos, 0, 0 + (YSize * (#AmountOfSection - 3)), 0)

                local Section = Instance.new("TextButton")
                Section.Name = encodedName()
                Section.BackgroundTransparency = 1
                Section.TextTransparency = 1
                Section.Position = PlacingPosition
                Section.Size = SectionSize
                Section.Font = Enum.Font.SourceSansLight
                Section.TextSize = 20
                Section.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section.Text = text
                Section.Parent = Inside
                Section.ClipsDescendants = true
                SelectionEffect(Section)
                SectionOnSelect(Section, text)

                return Section
            end

            local function AddToggle(tab, text, description)
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = encodedName()
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0.147, 0)
                ToggleFrame.Parent = tab

                local ToggleFramePosition = UDim2.new(0, 0, 0.019 + (0.147 * (#tab:GetChildren() - 3)), 0)
                ToggleFrame.Position = ToggleFramePosition

                local ToggleName = Instance.new("TextLabel")
                ToggleName.Name = encodedName()
                ToggleName.BackgroundTransparency = 1
                ToggleName.Size = UDim2.new(0.569, 0, 0.496, 0)
                ToggleName.Position = UDim2.new(0.018, 0, 0.032, 0)
                ToggleName.Text = text
                ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleName.TextScaled = true
                ToggleName.TextXAlignment = Enum.TextXAlignment.Left
                ToggleName.Font = Enum.Font.SourceSansSemibold
                ToggleName.Parent = ToggleFrame

                local ToggleDescription = Instance.new("TextLabel")
                ToggleDescription.Name = encodedName()
                ToggleDescription.BackgroundTransparency = 1
                ToggleDescription.Size = UDim2.new(0.849, 0, 0.34, 0)
                ToggleDescription.Position = UDim2.new(0.018, 0, 0.544, 0)
                ToggleDescription.Text = description
                ToggleDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleDescription.TextScaled = true
                ToggleDescription.TextXAlignment = Enum.TextXAlignment.Left
                ToggleDescription.Font = Enum.Font.SourceSansLight
                ToggleDescription.Parent = ToggleFrame

                local Toggle = Instance.new("ImageButton")
                Toggle.Name = encodedName()
                Toggle.BorderColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.BorderSizePixel = 2
                Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Toggle.Position = UDim2.new(0.896, 0, 0.183, 0)
                Toggle.Size = UDim2.new(0.062, 0, 0.523, 0)
                Toggle.Image = "rbxassetid://6972569034"
                Toggle.ImageTransparency = 1
                Toggle.Parent = ToggleFrame
                ToggleList[text] = Toggle

                if DataTable[text] == true then
                    Toggle.ImageTransparency = 0
                end

                local CurrentTransparentTween
                Toggle.MouseButton1Click:Connect(function()
                    if Toggle.ImageTransparency == 1 then
                        if CurrentTransparentTween ~= nil then
                            CurrentTransparentTween:Pause()
                        end

                        CurrentTransparentTween = TweenService:Create(Toggle, TweenInfo.new(0.25), {ImageTransparency = 0}):Play()
                    else
                        if CurrentTransparentTween ~= nil then
                            CurrentTransparentTween:Pause()
                        end

                        CurrentTransparentTween = TweenService:Create(Toggle, TweenInfo.new(0.25), {ImageTransparency = 1}):Play()
                    end

                    local function Tween(OBJInstance,Goal,Duration)
                        local T = TweenService:Create(OBJInstance,TweenInfo.new(Duration),Goal)
                        T:Play()
                    end
    
                    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    
                    local CircleEffect = Instance.new("Frame")
                    CircleEffect.Name = encodedName()
                    CircleEffect.Parent = Toggle
                    local CircleCorner = Instance.new("UICorner")
                    CircleCorner.CornerRadius = UDim.new(1, 0)
                    CircleCorner.Parent = CircleEffect
                    local ASX,ASY = Toggle.AbsoluteSize.X, Toggle.AbsoluteSize.Y
                    local APX,APY = Toggle.AbsolutePosition.X, Toggle.AbsolutePosition.Y
                    local MX,MY = Mouse.X,Mouse.Y
                    local Pos = UDim2.new(0,MX-APX,0,MY-APY)
                    local UBC3 = Toggle.BackgroundColor3
                    local UR,UG,UB = UBC3.R, UBC3.G, UBC3.B
                    CircleEffect.ZIndex = 100001
                    CircleEffect.AnchorPoint = Vector2.new(0.5,0.5)
                    CircleEffect.Position = Pos
                    local MS = UDim2.fromOffset(math.max(ASX,ASY),math.max(ASX,ASY))
                    CircleEffect:TweenSize(MS,"Out","Sine",0.5)
                    Tween(CircleEffect,{BackgroundTransparency = 1}, 0.5)
                    Debris:AddItem(CircleEffect, 0.5)
                end)

                return Toggle
            end

            local ChangelogSection = Instance.new("Frame")
            ChangelogSection.Name = "Changelog_"..scriptVer
            ChangelogSection.Size = UDim2.new(0.687, 0, 0.768, 0)
            ChangelogSection.Position = UDim2.new(0.292, 0, 0.201, 0) -- 0.55
            ChangelogSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ChangelogSection.BackgroundTransparency = 1
            ChangelogSection.Parent = Main
            local UICorner = Instance.new("UICorner")
            UICorner.Name = encodedName()
            UICorner.Parent = ChangelogSection
            local ChangelogTitle = Instance.new("TextLabel")
            ChangelogTitle.Name = encodedName()
            ChangelogTitle.BackgroundTransparency = 1
            ChangelogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ChangelogTitle.Font = Enum.Font.SourceSansSemibold
            ChangelogTitle.Position = UDim2.new(0, 0, 0.023, 0)
            ChangelogTitle.Size = UDim2.new(0.997, 0, 0.081, 0) -- 0.947
            ChangelogTitle.Text = "Changelogs - Version "..scriptVer
            ChangelogTitle.TextTransparency = 1
            ChangelogTitle.TextScaled = true
            ChangelogTitle.TextScaled = true
            ChangelogTitle.Parent = ChangelogSection
            local ChangelogLine = Instance.new("Frame")
            ChangelogLine.Name = encodedName()
            ChangelogLine.Size = UDim2.new(0.877, 0, 0.005, 0)
            ChangelogLine.Position = UDim2.new(0.071, 0, 0.134, 0) -- 0.55
            ChangelogLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChangelogLine.BackgroundTransparency = 1
            ChangelogLine.BorderSizePixel = 0
            ChangelogLine.Parent = ChangelogSection
            local Signature = Instance.new("BoolValue")
            Signature.Name = "Tab"
            Signature.Parent = ChangelogSection

            -- Load Changelogs

            local XPosition = 0.025
            local YPosition = 0.115
            local XSize = 0.972
            local YSize = 0.069

            for _, changes in pairs(changelogs) do
                local logsAmount = ChangelogSection:GetChildren()

                local newLogs = Instance.new("TextLabel")
                newLogs.Name = encodedName()
                newLogs.BackgroundTransparency = 1
                newLogs.TextTransparency = 1
                newLogs.Font = Enum.Font.SourceSansLight
                newLogs.TextScaled = true
                newLogs.TextColor3 = Color3.fromRGB(255, 255, 255)
                newLogs.Size = UDim2.new(XSize, 0, YSize, 0)
                newLogs.Position = UDim2.new(XPosition, 0, YPosition + (YSize * (#logsAmount - 3)), 0)
                newLogs.TextXAlignment = Enum.TextXAlignment.Left
                newLogs.Text = "- "..changes
                newLogs.Parent = ChangelogSection
            end

            -- // Main Tab

            local MainSection = Instance.new("Frame")
            MainSection.Name = "Main_"..scriptVer
            MainSection.Size = UDim2.new(0.687, 0, 0.768, 0)
            MainSection.Position = UDim2.new(0.292, 0, 0.201, 0) -- 0.55
            MainSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MainSection.BackgroundTransparency = 1
            MainSection.Visible = false
            MainSection.Parent = Main
            local MainCorner = Instance.new("UICorner")
            MainCorner.Name = encodedName()
            MainCorner.Parent = MainSection
            local Signature = Instance.new("BoolValue")
            Signature.Name = "Tab"
            Signature.Parent = MainSection

            local WebhookFrame = Instance.new("Frame")
            WebhookFrame.Name = encodedName()
            WebhookFrame.BackgroundTransparency = 1
            WebhookFrame.Size = UDim2.new(1, 0, 0.233, 0)
            WebhookFrame.Position = UDim2.new(0, 0, 0.019, 0)
            WebhookFrame.Parent = MainSection
            local WebhookTitle = Instance.new("TextLabel")
            WebhookTitle.Name = encodedName()
            WebhookTitle.BackgroundTransparency = 1
            WebhookTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            WebhookTitle.TextTransparency = 1
            WebhookTitle.Font = Enum.Font.SourceSansSemibold
            WebhookTitle.TextScaled = true
            WebhookTitle.TextXAlignment = Enum.TextXAlignment.Left
            WebhookTitle.Text = "Webhook URL"
            WebhookTitle.Size = UDim2.new(0.637, 0, 0.231, 0)
            WebhookTitle.Position = UDim2.new(0.022, 0, 0, 0)
            WebhookTitle.Parent = WebhookFrame
            local WebhookURL = Instance.new("TextBox")
            WebhookURL.Name = encodedName()
            WebhookURL.BackgroundTransparency = 1
            WebhookURL.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            WebhookURL.TextColor3 = Color3.fromRGB(255, 255, 255)
            WebhookURL.TextTransparency = 1
            WebhookURL.Font = Enum.Font.SourceSans
            WebhookURL.Text = ""
            WebhookURL.TextWrapped = true
            WebhookURL.TextSize = 14
            WebhookURL.PlaceholderColor3 = Color3.fromRGB(132, 132, 132)
            WebhookURL.PlaceholderText = "Enter Discord Webhook URL here..."
            WebhookURL.TextColor3 = Color3.fromRGB(255, 255, 255)
            WebhookURL.TextXAlignment = Enum.TextXAlignment.Left
            WebhookURL.Size = UDim2.new(0.951, 0, 0.313, 0)
            WebhookURL.Position = UDim2.new(0.022, 0, 0.313, 0)
            WebhookURL.Parent = WebhookFrame
            local URLCorner = Instance.new("UICorner")
            URLCorner.Name = encodedName()
            URLCorner.CornerRadius = UDim.new(0.25, 0)
            URLCorner.Parent = WebhookURL
            local TestWebhookButton = Instance.new("TextButton")
            TestWebhookButton.Name = encodedName()
            TestWebhookButton.Size = UDim2.new(0.951, 0, 0.313, 0)
            TestWebhookButton.Position = UDim2.new(0.022, 0, 0.676, 0)
            TestWebhookButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            TestWebhookButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TestWebhookButton.Font = Enum.Font.SourceSansSemibold
            TestWebhookButton.Text = "Test Webhook"
            TestWebhookButton.BackgroundTransparency = 1
            TestWebhookButton.TextTransparency = 1
            TestWebhookButton.TextSize = 15
            TestWebhookButton.ClipsDescendants = true
            TestWebhookButton.Parent = WebhookFrame
            local TestWebhookButtonCorner = Instance.new("UICorner")
            TestWebhookButtonCorner.Name = encodedName()
            TestWebhookButtonCorner.CornerRadius = UDim.new(0.25, 0)
            TestWebhookButtonCorner.Parent = TestWebhookButton
            TestWebhookButton.MouseButton1Click:Connect(function()
                local function Tween(OBJInstance,Goal,Duration)
                    local T = TweenService:Create(OBJInstance,TweenInfo.new(Duration),Goal)
                    T:Play()
                end

                local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

                local CircleEffect = Instance.new("Frame")
                CircleEffect.Name = encodedName()
                CircleEffect.Parent = TestWebhookButton
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = CircleEffect
                local ASX,ASY = TestWebhookButton.AbsoluteSize.X, TestWebhookButton.AbsoluteSize.Y
                local APX,APY = TestWebhookButton.AbsolutePosition.X, TestWebhookButton.AbsolutePosition.Y
                local MX,MY = Mouse.X,Mouse.Y
                local Pos = UDim2.new(0,MX-APX,0,MY-APY)
                local UBC3 = TestWebhookButton.BackgroundColor3
                local UR,UG,UB = UBC3.R, UBC3.G, UBC3.B
                CircleEffect.ZIndex = 100001
                CircleEffect.AnchorPoint = Vector2.new(0.5,0.5)
                CircleEffect.Position = Pos
                local MS = UDim2.fromOffset(math.max(ASX,ASY),math.max(ASX,ASY))
                CircleEffect:TweenSize(MS,"Out","Sine",0.5)
                Tween(CircleEffect,{BackgroundTransparency = 1}, 0.5)
                Debris:AddItem(CircleEffect, 0.5)
            end)
            TestWebhookButton.MouseButton1Click:Connect(function()
                local url = WebhookURL.Text
                sendWebhookMsg(url, "Webhook Test", "Valkyrie is the best scripter :)")
            end)

            -- // Farm Tab

            local FarmSection = Instance.new("Frame")
            FarmSection.Name = "Farm_"..scriptVer
            FarmSection.Size = UDim2.new(0.687, 0, 0.768, 0)
            FarmSection.Position = UDim2.new(0.292, 0, 0.201, 0) -- 0.55
            FarmSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            FarmSection.BackgroundTransparency = 1
            FarmSection.Parent = Main
            local FarmCorner = Instance.new("UICorner")
            FarmCorner.Name = encodedName()
            FarmCorner.Parent = FarmSection
            local Signature = Instance.new("BoolValue")
            Signature.Name = "Tab"
            Signature.Parent = FarmSection

            -- // Player Tab

            local PlayerSection = Instance.new("Frame")
            PlayerSection.Name = "Player_"..scriptVer
            PlayerSection.Size = UDim2.new(0.687, 0, 0.768, 0)
            PlayerSection.Position = UDim2.new(0.292, 0, 0.201, 0) -- 0.55
            PlayerSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PlayerSection.BackgroundTransparency = 1
            PlayerSection.Visible = false
            PlayerSection.Parent = Main
            local PlayerCorner = Instance.new("UICorner")
            PlayerCorner.Name = encodedName()
            PlayerCorner.Parent = PlayerSection
            local Signature = Instance.new("BoolValue")
            Signature.Name = "Tab"
            Signature.Parent = PlayerSection

            -- // Settings Tab

            local SettingSection = Instance.new("Frame")
            SettingSection.Name = "Setting_"..scriptVer
            SettingSection.Size = UDim2.new(0.687, 0, 0.768, 0)
            SettingSection.Position = UDim2.new(0.292, 0, 0.201, 0) -- 0.55
            SettingSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SettingSection.BackgroundTransparency = 1
            SettingSection.Visible = false
            SettingSection.Parent = Main
            local PlayerCorner = Instance.new("UICorner")
            PlayerCorner.Name = encodedName()
            PlayerCorner.Parent = SettingSection
            local Signature = Instance.new("BoolValue")
            Signature.Name = "Tab"
            Signature.Parent = SettingSection

            -- //////////////////////

            local ChangelogButton = AddSection("Changelog")
            local MainButton = AddSection("Main")
            local FarmButton = AddSection("Farm")
            local PlayerButton = AddSection("Player")
            local SettingButton = AddSection("Setting")

            wait(3)

            -- \\ Files // --

            if isfolder("Grand Mid Online") == true then
                notif("Loading API Folders...")
                if isfile("Grand Mid Online/"..game:GetService("Players").LocalPlayer.Name..".txt") then
                    DataTable = HttpService:JSONDecode(readfile("Grand Mid Online/"..game:GetService("Players").LocalPlayer.Name..".txt"))
                    WebhookURL.Text = DataTable["WebhookURL"]
                else
                    writefile("Grand Mid Online/"..game:GetService("Players").LocalPlayer.Name..".txt", HttpService:JSONEncode(DataTable))
                end
            else
                notif("Creating API Folders since this is the first time you run Grand Mid Online...")
                makefolder("Grand Mid Online")
                writefile("Grand Mid Online/"..game:GetService("Players").LocalPlayer.Name..".txt", HttpService:JSONEncode(DataTable))
            end

            local function SaveDataTable()
                DataTable = {
                    WebhookURL = WebhookURL.Text
                }

                for name, toggle in pairs(ToggleList) do
                    if toggle ~= nil then
                        if toggle:IsA("ImageButton") then
                            local toggled = TransparencyToToggle(toggle)
                            notif(tostring(toggled))
                            DataTable[name] = toggled
                        end
                    end
                end

                if isfolder("Grand Mid Online") == true then
                    writefile("Grand Mid Online/"..game:GetService("Players").LocalPlayer.Name..".txt", HttpService:JSONEncode(DataTable))
                else
                    notif("DataTable save was unsuccessful!")
                end
            end

            ---//Toggles\\---

            local AutoSave = AddToggle(SettingSection, "Auto Save", "- Auto-save Script Settings every 5 seconds")
            local AutoReconnect = AddToggle(SettingSection, "Auto Reconnect", "- Auto Reconnect when disconnected")

            --// Data Save \\--

            spawn(function()
                while wait(5) do
                    if TransparencyToToggle(AutoSave) == true then
                        SaveDataTable()
                    end
                end
            end)

            -----------------

            spawn(function()
                repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
                local PromptOverlay = game.CoreGui.RobloxPromptGui.promptOverlay
                local TeleportService = game:GetService("TeleportService")
                
                PromptOverlay.ChildAdded:connect(function(v)
                    if TransparencyToToggle(ToggleList["Auto Reconnect"]) == true then
                        if v.Name == 'ErrorPrompt' then
                            repeat
                                TeleportService:Teleport(game.PlaceId)
                                wait(2)
                            until false
                        end
                    end
                end)
            end)

            wait(2)
            TweenService:Create(LoadUI, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Title, TweenInfo.new(1), {TextTransparency = 1}):Play()
            TweenService:Create(StatusText, TweenInfo.new(1), {TextTransparency = 1}):Play()
            TweenService:Create(LoadBar, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            TweenService:Create(LoaderBar, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            StatusText.Text = "Completed!"
            wait(1)
            LoadUI:Destroy()

            -- Main UI / Shows
            wait(0.5)
            Main.BackgroundTransparency = 0
            Inside.BackgroundTransparency = 0
            Icon.ImageTransparency = 0
            NTitle.TextTransparency = 0
            Description.TextTransparency = 0
            Version.TextTransparency = 0
            ChangelogSection.BackgroundTransparency = 0
            SelectionFrame.BackgroundTransparency = 0
            InsideTitle.TextTransparency = 0
            InsideLine.BackgroundTransparency = 0
            WebhookTitle.TextTransparency = 0
            WebhookURL.BackgroundTransparency = 0
            WebhookURL.TextTransparency = 0
            TestWebhookButton.TextTransparency = 0
            TestWebhookButton.BackgroundTransparency = 0
            for _, v in pairs(Inside:GetChildren()) do
                if v:IsA("TextButton") then
                    v.TextTransparency = 0
                end
            end
            for _, v in pairs(ChangelogSection:GetChildren()) do
                if v:IsA("TextLabel") then
                    v.TextTransparency = 0
                elseif v:IsA("Frame") then
                    v.BackgroundTransparency = 0
                end
            end
        else
            notif("Invaid key! If you believe this is a mistake, contact our staff.")
            StatusText.TextColor3 = Color3.fromRGB(255, 0, 0)
            StatusText.Text = "Authorization Failed!"
            wait(3)
            Screen:Destroy()
        end
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Grand Mid Online";
        Text = "Only Synapse X supported!";
        Duration = 3;
    })
end