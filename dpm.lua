-- ╔══════════════════════════════════════╗
-- ║         DPM CLASSIC MOD MENU        ║
-- ║             made by DPM             ║
-- ╚══════════════════════════════════════╝

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local TS               = game:GetService("TeleportService")

local LP  = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local Char, Hum, Root
local function refreshChar(c)
    Char = c
    Hum  = c:WaitForChild("Humanoid")
    Root = c:WaitForChild("HumanoidRootPart")
end
refreshChar(LP.Character or LP.CharacterAdded:Wait())
LP.CharacterAdded:Connect(refreshChar)

-- =============================================
--  GAME DETECTION
-- =============================================
local placeId   = game.PlaceId
local gameName  = "UNKNOWN"
local gameColor = Color3.new(1,1,1)

local knownGames = {
    [189707] = {name="Natural Disaster", short="NDS"},
    [11450306] = {name="Hide & Seek Extreme", short="HSE"},
    [142823291] = {name="Murder Mystery 2", short="MM2"},
    [185655149] = {name="Work at a Pizza Place", short="WAAP"},
    [155615604] = {name="Jailbreak", short="JB"},
    [537413528] = {name="Tower of Hell", short="TOH"},
    [606849621] = {name="Adopt Me", short="AM"},
    [920587237] = {name="Piggy", short="PIG"},
    [3232544781] = {name="Brookhaven", short="BH"},
    [2788229376] = {name="Arsenal", short="ARS"},
    [3262984307] = {name="Blox Fruits", short="BF"},
    [6872265039] = {name="Pet Simulator X", short="PSX"},
}

local gameData = knownGames[placeId]
if gameData then
    gameName = gameData.name
end

-- =============================================
--  THEME
-- =============================================
local T = {
    bg      = Color3.fromRGB(10,10,10),
    panel   = Color3.fromRGB(22,22,22),
    panelOn = Color3.fromRGB(32,32,32),
    bar     = Color3.fromRGB(15,15,15),
    off     = Color3.fromRGB(45,45,45),
    text    = Color3.fromRGB(215,215,215),
    textDim = Color3.fromRGB(90,90,90),
    sep     = Color3.fromRGB(30,30,30),
    red     = Color3.fromRGB(185,40,40),
    tabOn   = Color3.new(1,1,1),
    tabOff  = Color3.fromRGB(26,26,26),
}

-- =============================================
--  ROOT GUI
-- =============================================
local SG = Instance.new("ScreenGui")
SG.Name           = "DPMClassic"
SG.ResetOnSpawn   = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true
SG.Parent         = game.CoreGui

-- =============================================
--  MAIN FRAME
-- =============================================
local MF = Instance.new("Frame")
MF.Name             = "Main"
MF.Size             = UDim2.new(0,340,0,390)
MF.Position         = UDim2.new(0.5,-170,0.5,-195)
MF.BackgroundColor3 = T.bg
MF.BorderSizePixel  = 0
MF.ClipsDescendants = true
MF.Parent           = SG
Instance.new("UICorner", MF).CornerRadius = UDim.new(0,12)

local MFStroke = Instance.new("UIStroke")
MFStroke.Color       = Color3.new(1,1,1)
MFStroke.Thickness   = 1
MFStroke.Transparency= 0.65
MFStroke.Parent      = MF

task.spawn(function()
    local t = 0
    while MF and MF.Parent do
        t = t + task.wait(0.05)
        MFStroke.Transparency = 0.48 + math.sin(t*1.1)*0.3
    end
end)

-- =============================================
--  TITLE BAR
-- =============================================
local TB = Instance.new("Frame")
TB.Size             = UDim2.new(1,0,0,44)
TB.BackgroundColor3 = T.bar
TB.BorderSizePixel  = 0
TB.ZIndex           = 6
TB.Parent           = MF
Instance.new("UICorner", TB).CornerRadius = UDim.new(0,12)

local TBFill = Instance.new("Frame")
TBFill.Size             = UDim2.new(1,0,0,12)
TBFill.Position         = UDim2.new(0,0,1,-12)
TBFill.BackgroundColor3 = T.bar
TBFill.BorderSizePixel  = 0
TBFill.ZIndex           = 6
TBFill.Parent           = TB

local TBSep = Instance.new("Frame")
TBSep.Size             = UDim2.new(1,0,0,1)
TBSep.Position         = UDim2.new(0,0,1,0)
TBSep.BackgroundColor3 = T.sep
TBSep.BorderSizePixel  = 0
TBSep.ZIndex           = 7
TBSep.Parent           = TB

local Dot = Instance.new("Frame")
Dot.Size             = UDim2.new(0,6,0,6)
Dot.Position         = UDim2.new(0,11,0.5,-3)
Dot.BackgroundColor3 = Color3.new(1,1,1)
Dot.BorderSizePixel  = 0
Dot.ZIndex           = 7
Dot.Parent           = TB
Instance.new("UICorner", Dot).CornerRadius = UDim.new(1,0)
task.spawn(function()
    local t = 0
    while Dot and Dot.Parent do
        t = t + task.wait(0.05)
        local v = 0.5 + math.abs(math.sin(t*1.5))*0.5
        Dot.BackgroundColor3 = Color3.fromRGB(
            math.floor(255*v),math.floor(255*v),math.floor(255*v))
    end
end)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Text               = "DPM CLASSIC"
TitleLbl.Size               = UDim2.new(1,-95,0,18)
TitleLbl.Position           = UDim2.new(0,24,0,4)
TitleLbl.BackgroundTransparency = 1
TitleLbl.TextColor3         = Color3.new(1,1,1)
TitleLbl.TextSize           = 13
TitleLbl.Font               = Enum.Font.GothamBold
TitleLbl.TextXAlignment     = Enum.TextXAlignment.Left
TitleLbl.ZIndex             = 7
TitleLbl.Parent             = TB

local SubLbl = Instance.new("TextLabel")
SubLbl.Text               = "made by DPM  ·  " .. gameName
SubLbl.Size               = UDim2.new(1,-95,0,12)
SubLbl.Position           = UDim2.new(0,24,0,26)
SubLbl.BackgroundTransparency = 1
SubLbl.TextColor3         = T.textDim
SubLbl.TextSize           = 8
SubLbl.Font               = Enum.Font.Gotham
SubLbl.TextXAlignment     = Enum.TextXAlignment.Left
SubLbl.ZIndex             = 7
SubLbl.Parent             = TB

local MinBtn = Instance.new("TextButton")
MinBtn.Text             = "─"
MinBtn.Size             = UDim2.new(0,24,0,24)
MinBtn.Position         = UDim2.new(1,-56,0.5,-12)
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3       = Color3.new(1,1,1)
MinBtn.TextSize         = 12
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.BorderSizePixel  = 0
MinBtn.ZIndex           = 7
MinBtn.Parent           = TB
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,5)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text             = "✕"
CloseBtn.Size             = UDim2.new(0,24,0,24)
CloseBtn.Position         = UDim2.new(1,-28,0.5,-12)
CloseBtn.BackgroundColor3 = T.red
CloseBtn.TextColor3       = Color3.new(1,1,1)
CloseBtn.TextSize         = 11
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.BorderSizePixel  = 0
CloseBtn.ZIndex           = 7
CloseBtn.Parent           = TB
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,5)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(MF, TweenInfo.new(0.2,Enum.EasingStyle.Quart), {
        Size = minimized and UDim2.new(0,340,0,44) or UDim2.new(0,340,0,390)
    }):Play()
    MinBtn.Text = minimized and "+" or "─"
end)
CloseBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

-- =============================================
--  DRAG — title + sides + bottom
-- =============================================
local drag, dragStart, frameStart = false, nil, nil
local function startDrag(i)
    if i.UserInputType == Enum.UserInputType.Touch or
       i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag=true; dragStart=i.Position; frameStart=MF.Position
    end
end
local function endDrag(i)
    if i.UserInputType == Enum.UserInputType.Touch or
       i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag=false
    end
end

TB.InputBegan:Connect(startDrag)
TB.InputEnded:Connect(endDrag)

local function sideStrip(xScale, xOff, w)
    local s=Instance.new("TextButton")
    s.Text=""; s.Size=UDim2.new(0,w,1,0)
    s.Position=UDim2.new(xScale,xOff,0,0)
    s.BackgroundTransparency=1; s.BorderSizePixel=0
    s.ZIndex=9; s.Parent=MF
    s.InputBegan:Connect(startDrag)
    s.InputEnded:Connect(endDrag)
end
sideStrip(0,0,10)
sideStrip(1,-10,10)

local bot=Instance.new("TextButton")
bot.Text=""; bot.Size=UDim2.new(1,0,0,10)
bot.Position=UDim2.new(0,0,1,-10)
bot.BackgroundTransparency=1; bot.BorderSizePixel=0
bot.ZIndex=9; bot.Parent=MF
bot.InputBegan:Connect(startDrag)
bot.InputEnded:Connect(endDrag)

UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.Touch or
                 i.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=i.Position-dragStart
        MF.Position=UDim2.new(
            frameStart.X.Scale,frameStart.X.Offset+d.X,
            frameStart.Y.Scale,frameStart.Y.Offset+d.Y)
    end
end)

-- =============================================
--  TAB BAR  (y=44)
-- =============================================
local TabBar = Instance.new("Frame")
TabBar.Size             = UDim2.new(1,0,0,32)
TabBar.Position         = UDim2.new(0,0,0,44)
TabBar.BackgroundColor3 = Color3.fromRGB(13,13,13)
TabBar.BorderSizePixel  = 0
TabBar.ZIndex           = 5
TabBar.Parent           = MF

local TabSep=Instance.new("Frame")
TabSep.Size=UDim2.new(1,0,0,1); TabSep.Position=UDim2.new(0,0,1,0)
TabSep.BackgroundColor3=T.sep; TabSep.BorderSizePixel=0; TabSep.ZIndex=5; TabSep.Parent=TabBar

local TabList=Instance.new("UIListLayout")
TabList.FillDirection=Enum.FillDirection.Horizontal
TabList.HorizontalAlignment=Enum.HorizontalAlignment.Center
TabList.VerticalAlignment=Enum.VerticalAlignment.Center
TabList.Padding=UDim.new(0,3); TabList.Parent=TabBar

local TabPad=Instance.new("UIPadding")
TabPad.PaddingLeft=UDim.new(0,4); TabPad.PaddingRight=UDim.new(0,4); TabPad.Parent=TabBar

-- =============================================
--  CONTENT AREA (y=76)
-- =============================================
local ContentArea=Instance.new("Frame")
ContentArea.Size=UDim2.new(1,0,1,-76)
ContentArea.Position=UDim2.new(0,0,0,76)
ContentArea.BackgroundTransparency=1
ContentArea.ClipsDescendants=true
ContentArea.BorderSizePixel=0
ContentArea.Parent=MF

-- =============================================
--  TAB SYSTEM
-- =============================================
local tabNames = {"GENERAL","MOVE","COMBAT","VISUAL","GAME","FUN"}
local tabs  = {}
local pages = {}

for _,name in ipairs(tabNames) do
    local page=Instance.new("Frame")
    page.Name=name; page.Size=UDim2.new(1,0,1,0)
    page.BackgroundTransparency=1; page.BorderSizePixel=0
    page.Visible=false; page.Parent=ContentArea

    local lC=Instance.new("ScrollingFrame")
    lC.Name="Left"; lC.Size=UDim2.new(0.5,-5,1,0)
    lC.Position=UDim2.new(0,3,0,0); lC.BackgroundTransparency=1
    lC.BorderSizePixel=0; lC.ScrollBarThickness=2
    lC.ScrollBarImageColor3=Color3.fromRGB(50,50,50)
    lC.CanvasSize=UDim2.new(0,0,0,0)
    lC.AutomaticCanvasSize=Enum.AutomaticSize.Y; lC.Parent=page
    local ll=Instance.new("UIListLayout")
    ll.Padding=UDim.new(0,4); ll.HorizontalAlignment=Enum.HorizontalAlignment.Center
    ll.SortOrder=Enum.SortOrder.LayoutOrder; ll.Parent=lC
    local lp=Instance.new("UIPadding")
    lp.PaddingTop=UDim.new(0,5); lp.PaddingBottom=UDim.new(0,5); lp.Parent=lC

    local rC=Instance.new("ScrollingFrame")
    rC.Name="Right"; rC.Size=UDim2.new(0.5,-5,1,0)
    rC.Position=UDim2.new(0.5,2,0,0); rC.BackgroundTransparency=1
    rC.BorderSizePixel=0; rC.ScrollBarThickness=2
    rC.ScrollBarImageColor3=Color3.fromRGB(50,50,50)
    rC.CanvasSize=UDim2.new(0,0,0,0)
    rC.AutomaticCanvasSize=Enum.AutomaticSize.Y; rC.Parent=page
    local rl=Instance.new("UIListLayout")
    rl.Padding=UDim.new(0,4); rl.HorizontalAlignment=Enum.HorizontalAlignment.Center
    rl.SortOrder=Enum.SortOrder.LayoutOrder; rl.Parent=rC
    local rp=Instance.new("UIPadding")
    rp.PaddingTop=UDim.new(0,5); rp.PaddingBottom=UDim.new(0,5); rp.Parent=rC

    pages[name]={page=page,left=lC,right=rC,count=0}

    local btn=Instance.new("TextButton")
    btn.Text=name; btn.Size=UDim2.new(0,46,0,22)
    btn.BackgroundColor3=T.tabOff; btn.TextColor3=T.textDim
    btn.TextSize=8; btn.Font=Enum.Font.GothamBold
    btn.BorderSizePixel=0; btn.ZIndex=6; btn.Parent=TabBar
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5)

    btn.MouseButton1Click:Connect(function()
        for _,n in ipairs(tabNames) do
            pages[n].page.Visible=false
            TweenService:Create(tabs[n],TweenInfo.new(0.12),{
                BackgroundColor3=T.tabOff,TextColor3=T.textDim
            }):Play()
        end
        pages[name].page.Visible=true
        TweenService:Create(btn,TweenInfo.new(0.12),{
            BackgroundColor3=T.tabOn,TextColor3=Color3.fromRGB(10,10,10)
        }):Play()
    end)
    tabs[name]=btn
end

pages["GENERAL"].page.Visible=true
tabs["GENERAL"].BackgroundColor3=T.tabOn
tabs["GENERAL"].TextColor3=Color3.fromRGB(10,10,10)

-- =============================================
--  TOGGLE HELPER
-- =============================================
local function toggle(tabName,name,desc,cb)
    local entry=pages[tabName]
    local state=false
    entry.count=entry.count+1
    local col=(entry.count%2==1) and entry.left or entry.right

    local card=Instance.new("Frame")
    card.Name=name; card.Size=UDim2.new(1,0,0,56)
    card.BackgroundColor3=T.panel; card.BorderSizePixel=0
    card.LayoutOrder=entry.count; card.ZIndex=3; card.Parent=col
    Instance.new("UICorner",card).CornerRadius=UDim.new(0,8)

    local topLine=Instance.new("Frame")
    topLine.Size=UDim2.new(1,-12,0,2); topLine.Position=UDim2.new(0,6,0,0)
    topLine.BackgroundColor3=T.off; topLine.BorderSizePixel=0
    topLine.ZIndex=4; topLine.Parent=card
    Instance.new("UICorner",topLine).CornerRadius=UDim.new(0,2)

    local nm=Instance.new("TextLabel")
    nm.Text=name; nm.Size=UDim2.new(1,-8,0,18)
    nm.Position=UDim2.new(0,7,0,7); nm.BackgroundTransparency=1
    nm.TextColor3=T.text; nm.TextSize=10; nm.Font=Enum.Font.GothamBold
    nm.TextXAlignment=Enum.TextXAlignment.Left
    nm.TextTruncate=Enum.TextTruncate.AtEnd; nm.ZIndex=4; nm.Parent=card

    local ds=Instance.new("TextLabel")
    ds.Text=desc; ds.Size=UDim2.new(1,-8,0,11)
    ds.Position=UDim2.new(0,7,0,24); ds.BackgroundTransparency=1
    ds.TextColor3=T.textDim; ds.TextSize=8; ds.Font=Enum.Font.Gotham
    ds.TextXAlignment=Enum.TextXAlignment.Left
    ds.TextTruncate=Enum.TextTruncate.AtEnd; ds.ZIndex=4; ds.Parent=card

    local pill=Instance.new("Frame")
    pill.Size=UDim2.new(0,30,0,16); pill.Position=UDim2.new(0,7,1,-22)
    pill.BackgroundColor3=T.off; pill.BorderSizePixel=0
    pill.ZIndex=4; pill.Parent=card
    Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)

    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,12,0,12); knob.Position=UDim2.new(0,2,0.5,-6)
    knob.BackgroundColor3=Color3.fromRGB(70,70,70); knob.BorderSizePixel=0
    knob.ZIndex=5; knob.Parent=pill
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)

    local stLbl=Instance.new("TextLabel")
    stLbl.Text="OFF"; stLbl.Size=UDim2.new(0,26,0,16)
    stLbl.Position=UDim2.new(0,40,1,-22); stLbl.BackgroundTransparency=1
    stLbl.TextColor3=T.textDim; stLbl.TextSize=8; stLbl.Font=Enum.Font.GothamBold
    stLbl.TextXAlignment=Enum.TextXAlignment.Left; stLbl.ZIndex=4; stLbl.Parent=card

    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1
    btn.Text=""; btn.ZIndex=5; btn.Parent=card

    btn.MouseButton1Click:Connect(function()
        state=not state
        local ti=TweenInfo.new(0.15,Enum.EasingStyle.Quart)
        if state then
            TweenService:Create(pill,ti,{BackgroundColor3=Color3.new(1,1,1)}):Play()
            TweenService:Create(knob,ti,{Position=UDim2.new(1,-14,0.5,-6),BackgroundColor3=Color3.fromRGB(12,12,12)}):Play()
            TweenService:Create(topLine,ti,{BackgroundColor3=Color3.new(1,1,1)}):Play()
            TweenService:Create(nm,ti,{TextColor3=Color3.new(1,1,1)}):Play()
            TweenService:Create(card,ti,{BackgroundColor3=T.panelOn}):Play()
            stLbl.Text="ON"; stLbl.TextColor3=Color3.new(1,1,1)
        else
            TweenService:Create(pill,ti,{BackgroundColor3=T.off}):Play()
            TweenService:Create(knob,ti,{Position=UDim2.new(0,2,0.5,-6),BackgroundColor3=Color3.fromRGB(70,70,70)}):Play()
            TweenService:Create(topLine,ti,{BackgroundColor3=T.off}):Play()
            TweenService:Create(nm,ti,{TextColor3=T.text}):Play()
            TweenService:Create(card,ti,{BackgroundColor3=T.panel}):Play()
            stLbl.Text="OFF"; stLbl.TextColor3=T.textDim
        end
        cb(state)
    end)
end

-- =============================================
--  GENERAL TAB  (works in every game)
-- =============================================
toggle("GENERAL","Full Bright","removes fog + shadows",function(on)
    Lighting.Brightness=on and 10 or 1; Lighting.ClockTime=14
    Lighting.FogEnd=on and 1e6 or 100000; Lighting.GlobalShadows=not on
    Lighting.Ambient=on and Color3.new(1,1,1) or Color3.fromRGB(127,127,127)
end)

toggle("GENERAL","Anti AFK","prevents idle kick",function(on)
    if on then LP.Idled:Connect(function() LP:Move(Vector3.new(0,0,-1),true) end) end
end)

toggle("GENERAL","ESP Names+HP","labels above all players",function(on)
    local esps={}
    local function add(p)
        if p==LP then return end
        local function onChar(c)
            task.wait(0.5)
            local hrp=c:FindFirstChild("HumanoidRootPart")
            local hum=c:FindFirstChild("Humanoid")
            if not hrp then return end
            local bb=Instance.new("BillboardGui")
            bb.Size=UDim2.new(0,110,0,40); bb.StudsOffset=Vector3.new(0,3.5,0)
            bb.AlwaysOnTop=true; bb.Adornee=hrp; bb.Parent=hrp
            local nl=Instance.new("TextLabel")
            nl.Size=UDim2.new(1,0,0,20); nl.BackgroundTransparency=1
            nl.Text=p.Name; nl.TextColor3=Color3.new(1,1,1)
            nl.TextSize=11; nl.Font=Enum.Font.GothamBold; nl.Parent=bb
            local hl=Instance.new("TextLabel")
            hl.Size=UDim2.new(1,0,0,14); hl.Position=UDim2.new(0,0,0,22)
            hl.BackgroundTransparency=1; hl.TextSize=9; hl.Font=Enum.Font.Gotham; hl.Parent=bb
            RunService.Heartbeat:Connect(function()
                if hum then
                    hl.Text=string.format("HP %.0f/%.0f",hum.Health,hum.MaxHealth)
                    local f=hum.Health/hum.MaxHealth
                    hl.TextColor3=Color3.fromRGB(math.floor(255*(1-f)),math.floor(210*f),0)
                end
            end)
            esps[p]=bb
        end
        if p.Character then onChar(p.Character) end
        p.CharacterAdded:Connect(onChar)
    end
    if on then
        for _,p in pairs(Players:GetPlayers()) do add(p) end
        Players.PlayerAdded:Connect(add)
    else for _,v in pairs(esps) do v:Destroy() end; esps={} end
end)

toggle("GENERAL","Crosshair","white dot at screen center",function(on)
    local ex=SG:FindFirstChild("_dpmCH"); if ex then ex:Destroy() end
    if on then
        local ch=Instance.new("Frame"); ch.Name="_dpmCH"
        ch.Size=UDim2.new(0,10,0,10); ch.Position=UDim2.new(0.5,-5,0.5,-5)
        ch.BackgroundColor3=Color3.new(1,1,1); ch.BackgroundTransparency=0.2
        ch.BorderSizePixel=0; ch.Parent=SG
        Instance.new("UICorner",ch).CornerRadius=UDim.new(1,0)
    end
end)

toggle("GENERAL","No Fog","clears all fog",function(on)
    Lighting.FogStart=on and 1e8 or 0; Lighting.FogEnd=on and 1e9 or 100000
end)

toggle("GENERAL","Chams X-Ray","outlines all players",function(on)
    local function apply(p)
        if p==LP then return end
        local function onChar(c)
            for _,pt in pairs(c:GetDescendants()) do
                if pt:IsA("BasePart") then
                    local s=Instance.new("SelectionBox"); s.Adornee=pt
                    s.Color3=Color3.new(1,1,1); s.LineThickness=0.04
                    s.SurfaceTransparency=0.82; s.SurfaceColor3=Color3.new(1,1,1)
                    s.Parent=pt; s.Name="_dpmcham"
                end
            end
        end
        if p.Character then onChar(p.Character) end
        p.CharacterAdded:Connect(onChar)
    end
    if on then
        for _,p in pairs(Players:GetPlayers()) do apply(p) end
        Players.PlayerAdded:Connect(apply)
    else
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _,d in pairs(p.Character:GetDescendants()) do
                    if d.Name=="_dpmcham" then d:Destroy() end
                end
            end
        end
    end
end)

toggle("GENERAL","Print Remotes","logs all remotes to output",function(on)
    if on then
        for _,v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                print("[DPM] "..v:GetFullName())
            end
        end
    end
end)

toggle("GENERAL","Invisible","makes your char transparent",function(on)
    if not Char then return end
    for _,p in pairs(Char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
            p.LocalTransparencyModifier=on and 1 or 0
        end
    end
end)

-- =============================================
--  MOVE TAB
-- =============================================
toggle("MOVE","Speed x3","walk 3× faster",function(on)
    RunService.Heartbeat:Connect(function()
        if Hum then Hum.WalkSpeed=on and 48 or 16 end
    end)
end)

toggle("MOVE","Speed x6","walk 6× faster",function(on)
    RunService.Heartbeat:Connect(function()
        if Hum then Hum.WalkSpeed=on and 96 or 16 end
    end)
end)

local ijOn=false
toggle("MOVE","Infinite Jump","jump with no limit",function(on) ijOn=on end)
UserInputService.JumpRequest:Connect(function()
    if ijOn and Hum then Hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

toggle("MOVE","No Clip","phase through walls",function(on)
    RunService.Stepped:Connect(function()
        if on and Char then
            for _,p in pairs(Char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end
    end)
end)

toggle("MOVE","Low Gravity","float slowly",function(on)
    workspace.Gravity=on and 28 or 196.2
end)

toggle("MOVE","Bunny Hop","auto-jump on land",function(on)
    RunService.Heartbeat:Connect(function()
        if on and Hum and Hum:GetState()==Enum.HumanoidStateType.Landed then
            Hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

toggle("MOVE","Double-Tap TP","double-tap to teleport",function(on)
    local conn,last=nil,0
    if on then
        conn=UserInputService.TouchTap:Connect(function(pos)
            local now=tick()
            if now-last<0.4 then
                local ray=Cam:ScreenPointToRay(pos[1].X,pos[1].Y)
                local res=workspace:Raycast(ray.Origin,ray.Direction*500,RaycastParams.new())
                if res and Root then Root.CFrame=CFrame.new(res.Position+Vector3.new(0,3,0)) end
            end
            last=now
        end)
    elseif conn then conn:Disconnect() end
end)

local flyOn=false; local flyBV,flyBG; local flyDir=Vector3.zero
toggle("MOVE","Fly","freefly — d-pad appears",function(on)
    flyOn=on
    if on then
        flyBV=Instance.new("BodyVelocity")
        flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.Velocity=Vector3.zero; flyBV.Parent=Root
        flyBG=Instance.new("BodyGyro")
        flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5); flyBG.P=1e4; flyBG.Parent=Root
    else
        if flyBV then flyBV:Destroy() flyBV=nil end
        if flyBG then flyBG:Destroy() flyBG=nil end
        flyDir=Vector3.zero
    end
end)

RunService.RenderStepped:Connect(function()
    if flyOn and flyBV then flyBV.Velocity=flyDir*55; flyBG.CFrame=Cam.CFrame end
    FlyHUD.Visible=flyOn
end)

FlyHUD=Instance.new("Frame")
FlyHUD.Size=UDim2.new(0,160,0,120); FlyHUD.Position=UDim2.new(1,-174,1,-138)
FlyHUD.BackgroundTransparency=1; FlyHUD.Visible=false; FlyHUD.Parent=SG

local function mFB(lbl,x,y,w,h,dir)
    local b=Instance.new("TextButton")
    b.Text=lbl; b.Size=UDim2.new(0,w,0,h); b.Position=UDim2.new(0,x,0,y)
    b.BackgroundColor3=Color3.fromRGB(14,14,14); b.TextColor3=Color3.new(1,1,1)
    b.TextSize=16; b.Font=Enum.Font.GothamBold; b.BorderSizePixel=0; b.Parent=FlyHUD
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    local st=Instance.new("UIStroke"); st.Color=Color3.fromRGB(40,40,40); st.Thickness=1; st.Parent=b
    b.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyDir=flyDir+dir
            TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=Color3.new(1,1,1),TextColor3=Color3.fromRGB(10,10,10)}):Play()
        end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyDir=flyDir-dir
            TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(14,14,14),TextColor3=Color3.new(1,1,1)}):Play()
        end
    end)
end
mFB("↑",54,0,48,48,Vector3.new(0,0,-1))
mFB("↓",54,52,48,48,Vector3.new(0,0,1))
mFB("←",2,26,48,48,Vector3.new(-1,0,0))
mFB("→",106,26,48,48,Vector3.new(1,0,0))
mFB("▲",2,88,72,28,Vector3.new(0,1,0))
mFB("▼",84,88,72,28,Vector3.new(0,-1,0))

-- =============================================
--  COMBAT TAB
-- =============================================
local aimbotOn=false
toggle("COMBAT","Aimbot","snaps cam to nearest head",function(on) aimbotOn=on end)
toggle("COMBAT","Body Fallback","target torso if no head",function(on) _G.dpm_bf=on end)

local FOV=140
RunService.RenderStepped:Connect(function()
    if not aimbotOn then return end
    local best,bd=nil,FOV
    local cx=Cam.ViewportSize.X/2; local cy=Cam.ViewportSize.Y/2
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local tgt=p.Character:FindFirstChild("Head")
            if not tgt and _G.dpm_bf then tgt=p.Character:FindFirstChild("HumanoidRootPart") end
            if tgt then
                local hum=p.Character:FindFirstChild("Humanoid")
                if hum and hum.Health>0 then
                    local pos,vis=Cam:WorldToViewportPoint(tgt.Position)
                    if vis then
                        local d=(Vector2.new(pos.X,pos.Y)-Vector2.new(cx,cy)).Magnitude
                        if d<bd then bd=d; best=tgt end
                    end
                end
            end
        end
    end
    if best then Cam.CFrame=CFrame.new(Cam.CFrame.Position,best.Position) end
end)

toggle("COMBAT","God Mode","lock HP at max",function(on)
    RunService.Heartbeat:Connect(function()
        if on and Hum then Hum.Health=Hum.MaxHealth end
    end)
end)

toggle("COMBAT","Kill Aura 8st","auto-kill close range",function(on)
    RunService.Heartbeat:Connect(function()
        if not on or not Root then return end
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                local hum=p.Character:FindFirstChild("Humanoid")
                if hrp and hum and (hrp.Position-Root.Position).Magnitude<8 then hum.Health=0 end
            end
        end
    end)
end)

toggle("COMBAT","Fling Others","launches nearby players",function(on)
    RunService.Heartbeat:Connect(function()
        if not on or not Root then return end
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position-Root.Position).Magnitude<15 then
                    local bv=Instance.new("BodyVelocity")
                    bv.MaxForce=Vector3.new(1e5,1e5,1e5)
                    bv.Velocity=Vector3.new(math.random(-80,80),80,math.random(-80,80))
                    bv.Parent=hrp; game:GetService("Debris"):AddItem(bv,0.2)
                end
            end
        end
    end)
end)

toggle("COMBAT","Freeze Others","anchors all enemies",function(on)
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            for _,pt in pairs(p.Character:GetDescendants()) do
                if pt:IsA("BasePart") then pt.Anchored=on end
            end
        end
    end
end)

toggle("COMBAT","Anti Knockback","roots your character",function(on)
    if Root then Root.Anchored=on end
end)

-- =============================================
--  VISUAL TAB
-- =============================================
toggle("VISUAL","Big Heads","scales enemy heads x3",function(on)
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local h=p.Character:FindFirstChild("Head")
            if h then h.Size=on and Vector3.new(3,3,3) or Vector3.new(2,1,1) end
        end
    end
end)

toggle("VISUAL","Black Sky","sets sky to black",function(on)
    Lighting.Ambient=on and Color3.fromRGB(0,0,0) or Color3.fromRGB(127,127,127)
    Lighting.OutdoorAmbient=on and Color3.fromRGB(0,0,0) or Color3.fromRGB(127,127,127)
end)

toggle("VISUAL","Wireframe Map","terrain transparent",function(on)
    for _,p in pairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") and not p:IsDescendantOf(LP.Character or Instance.new("Model")) then
            p.LocalTransparencyModifier=on and 0.85 or 0
        end
    end
end)

toggle("VISUAL","Remove Particles","disables particle FX",function(on)
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled=not on
        end
    end
end)

toggle("VISUAL","Show All Names","always-visible nametags",function(on)
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hum=p.Character:FindFirstChild("Humanoid")
            if hum then
                hum.DisplayDistanceType=on
                    and Enum.HumanoidDisplayDistanceType.Always
                    or  Enum.HumanoidDisplayDistanceType.Subject
            end
        end
    end
end)

toggle("VISUAL","Rainbow Char","cycles your body color",function(on)
    task.spawn(function()
        local h=0
        while on do
            h=(h+0.01)%1
            if Char then
                for _,p in pairs(Char:GetDescendants()) do
                    if p:IsA("BasePart") then p.Color=Color3.fromHSV(h,0.8,1) end
                end
            end
            task.wait(0.05)
        end
    end)
end)

-- =============================================
--  GAME-SPECIFIC TAB
-- =============================================

-- NATURAL DISASTER SURVIVAL (189707)
if placeId == 189707 then
    toggle("GAME","Safe Spot TP","tp to highest point",function(on)
        if on and Root then
            local highest,hY=nil,-math.huge
            for _,p in pairs(workspace:GetDescendants()) do
                if p:IsA("BasePart") and p.Position.Y>hY then
                    hY=p.Position.Y; highest=p
                end
            end
            if highest then Root.CFrame=CFrame.new(highest.Position+Vector3.new(0,5,0)) end
        end
    end)

    toggle("GAME","No Disaster DMG","god mode for disasters",function(on)
        RunService.Heartbeat:Connect(function()
            if on and Hum then Hum.Health=Hum.MaxHealth end
        end)
    end)

    toggle("GAME","Disaster ESP","shows disaster location",function(on)
        if on then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (
                    v.Name:lower():find("lava") or
                    v.Name:lower():find("flood") or
                    v.Name:lower():find("meteor") or
                    v.Name:lower():find("tsunami")) then
                    local bb=Instance.new("BillboardGui")
                    bb.Size=UDim2.new(0,80,0,30); bb.AlwaysOnTop=true
                    bb.StudsOffset=Vector3.new(0,3,0); bb.Adornee=v; bb.Parent=v
                    local lbl=Instance.new("TextLabel")
                    lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                    lbl.Text="⚠ "..v.Name; lbl.TextColor3=Color3.new(1,1,1)
                    lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                end
            end
        end
    end)

    toggle("GAME","Fly Over Disaster","instant fly toggle",function(on)
        flyOn=on
        if on then
            flyBV=Instance.new("BodyVelocity")
            flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.Velocity=Vector3.zero; flyBV.Parent=Root
            flyBG=Instance.new("BodyGyro")
            flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5); flyBG.P=1e4; flyBG.Parent=Root
        else
            if flyBV then flyBV:Destroy() flyBV=nil end
            if flyBG then flyBG:Destroy() flyBG=nil end
            flyDir=Vector3.zero
        end
    end)

-- HIDE AND SEEK EXTREME (11450306)
elseif placeId == 11450306 then
    toggle("GAME","Seeker ESP","always see the seeker",function(on)
        local esps={}
        local function tag(p)
            if not p.Character then return end
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local bb=Instance.new("BillboardGui")
            bb.Size=UDim2.new(0,100,0,30); bb.StudsOffset=Vector3.new(0,4,0)
            bb.AlwaysOnTop=true; bb.Adornee=hrp; bb.Parent=hrp
            local lbl=Instance.new("TextLabel")
            lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
            lbl.Text="IT: "..p.Name; lbl.TextColor3=Color3.new(1,0.2,0.2)
            lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
            esps[p]=bb
        end
        if on then
            for _,p in pairs(Players:GetPlayers()) do tag(p) end
        else
            for _,v in pairs(esps) do v:Destroy() end; esps={}
        end
    end)

    toggle("GAME","Speed Hider","move fast while hiding",function(on)
        RunService.Heartbeat:Connect(function()
            if Hum then Hum.WalkSpeed=on and 40 or 16 end
        end)
    end)

    toggle("GAME","Hide Under Map","no-clip into floor",function(on)
        if on and Root then
            Root.CFrame=CFrame.new(Root.Position+Vector3.new(0,-10,0))
        end
    end)

    toggle("GAME","Hider Radar","shows all hider positions",function(on)
        if on then
            for _,p in pairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bb=Instance.new("BillboardGui")
                        bb.Name="_hiderESP"; bb.Size=UDim2.new(0,90,0,26)
                        bb.StudsOffset=Vector3.new(0,3.5,0); bb.AlwaysOnTop=true
                        bb.Adornee=hrp; bb.Parent=hrp
                        local lbl=Instance.new("TextLabel")
                        lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                        lbl.Text=p.Name; lbl.TextColor3=Color3.new(1,1,1)
                        lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                    end
                end
            end
        else
            for _,p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _,v in pairs(p.Character:GetDescendants()) do
                        if v.Name=="_hiderESP" then v:Destroy() end
                    end
                end
            end
        end
    end)

-- MURDER MYSTERY 2 (142823291)
elseif placeId == 142823291 then
    toggle("GAME","Role ESP","shows murderer/sheriff",function(on)
        if on then
            local function checkRole(p)
                if not p.Character then return end
                local tool=p.Character:FindFirstChildOfClass("Tool")
                if not tool then return end
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local isGun=tool.Name:lower():find("gun") or tool.Name:lower():find("sheriff")
                local isKnife=tool.Name:lower():find("knife")
                local bb=Instance.new("BillboardGui")
                bb.Name="_mm2esp"; bb.Size=UDim2.new(0,100,0,28)
                bb.StudsOffset=Vector3.new(0,4,0); bb.AlwaysOnTop=true
                bb.Adornee=hrp; bb.Parent=hrp
                local lbl=Instance.new("TextLabel")
                lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                if isKnife then
                    lbl.Text="MURDERER"; lbl.TextColor3=Color3.new(1,0.2,0.2)
                elseif isGun then
                    lbl.Text="SHERIFF"; lbl.TextColor3=Color3.new(0.2,0.8,1)
                else
                    lbl.Text=p.Name; lbl.TextColor3=Color3.new(1,1,1)
                end
            end
            RunService.Heartbeat:Connect(function()
                if not on then return end
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=LP then checkRole(p) end
                end
            end)
        else
            for _,p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _,v in pairs(p.Character:GetDescendants()) do
                        if v.Name=="_mm2esp" then v:Destroy() end
                    end
                end
            end
        end
    end)

    toggle("GAME","Coin Collector TP","tp to all coins",function(on)
        if on then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("coin") and Root then
                    Root.CFrame=CFrame.new(v.Position+Vector3.new(0,3,0))
                    task.wait(0.1)
                end
            end
        end
    end)

    toggle("GAME","Knife ESP","shows knife location",function(on)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("knife") then
                local bb=Instance.new("BillboardGui")
                bb.Size=UDim2.new(0,80,0,26); bb.AlwaysOnTop=true
                bb.StudsOffset=Vector3.new(0,3,0); bb.Adornee=v; bb.Parent=v
                local lbl=Instance.new("TextLabel")
                lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                lbl.Text="KNIFE"; lbl.TextColor3=Color3.new(1,0.3,0.3)
                lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
            end
        end
    end)

-- TOWER OF HELL (537413528)
elseif placeId == 537413528 then
    toggle("GAME","Skip Tower","fly to top instantly",function(on)
        if on and Root then
            local highest,hY=nil,-math.huge
            for _,p in pairs(workspace:GetDescendants()) do
                if p:IsA("BasePart") and p.Position.Y>hY then
                    hY=p.Position.Y; highest=p
                end
            end
            if highest then Root.CFrame=CFrame.new(highest.Position+Vector3.new(0,6,0)) end
        end
    end)

    toggle("GAME","No Fall Death","god mode on fall",function(on)
        RunService.Heartbeat:Connect(function()
            if on and Hum then Hum.Health=Hum.MaxHealth end
        end)
    end)

    toggle("GAME","Infinite Jump TOH","jump on every frame",function(on)
        RunService.Heartbeat:Connect(function()
            if on and Hum then
                Hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end)

-- JAILBREAK (155615604)
elseif placeId == 155615604 then
    toggle("GAME","Vehicle Speed","boosts current vehicle",function(on)
        RunService.Heartbeat:Connect(function()
            if not on then return end
            local vehicle=LP.Character and LP.Character:FindFirstAncestorOfClass("Model")
            if vehicle then
                local seat=vehicle:FindFirstChildOfClass("VehicleSeat")
                if seat then seat.MaxSpeed=on and 300 or 100 end
            end
        end)
    end)

    toggle("GAME","Rob Highlight","highlights banks/stores",function(on)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (
                v.Name:lower():find("bank") or
                v.Name:lower():find("jewelry") or
                v.Name:lower():find("museum")) then
                local s=Instance.new("SelectionBox"); s.Adornee=v
                s.Color3=Color3.new(1,1,0); s.LineThickness=0.06
                s.SurfaceTransparency=0.7; s.Name="_jbhl"; s.Parent=v
            end
        end
    end)

    toggle("GAME","Cop ESP","highlights all cops",function(on)
        RunService.Heartbeat:Connect(function()
            if not on then return end
            for _,p in pairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and not hrp:FindFirstChild("_copESP") then
                        local bb=Instance.new("BillboardGui"); bb.Name="_copESP"
                        bb.Size=UDim2.new(0,90,0,26); bb.StudsOffset=Vector3.new(0,3.5,0)
                        bb.AlwaysOnTop=true; bb.Adornee=hrp; bb.Parent=hrp
                        local lbl=Instance.new("TextLabel")
                        lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                        lbl.Text=p.Name; lbl.TextColor3=Color3.new(0.4,0.8,1)
                        lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                    end
                end
            end
        end)
    end)

-- BROOKHAVEN (3232544781)
elseif placeId == 3232544781 then
    toggle("GAME","Speed Walk","move super fast",function(on)
        RunService.Heartbeat:Connect(function()
            if Hum then Hum.WalkSpeed=on and 60 or 16 end
        end)
    end)

    toggle("GAME","Noclip Props","walk through buildings",function(on)
        RunService.Stepped:Connect(function()
            if on and Char then
                for _,p in pairs(Char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end)
    end)

-- ADOPT ME (606849621)
elseif placeId == 606849621 then
    toggle("GAME","Pet ESP","highlights all nearby pets",function(on)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:lower():find("pet") then
                local hrp=v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                if hrp then
                    local bb=Instance.new("BillboardGui")
                    bb.Size=UDim2.new(0,80,0,24); bb.AlwaysOnTop=true
                    bb.StudsOffset=Vector3.new(0,3,0); bb.Adornee=hrp; bb.Parent=hrp
                    local lbl=Instance.new("TextLabel")
                    lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
                    lbl.Text=v.Name; lbl.TextColor3=Color3.new(1,1,1)
                    lbl.TextSize=10; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                end
            end
        end
    end)

    toggle("GAME","Baby Speed","toddler speed boost",function(on)
        RunService.Heartbeat:Connect(function()
            if Hum then Hum.WalkSpeed=on and 50 or 16 end
        end)
    end)

-- GENERIC FALLBACK for unrecognized games
else
    toggle("GAME","Collect All","tp to every interactable",function(on)
        if on and Root then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (
                    v.Name:lower():find("coin") or
                    v.Name:lower():find("gem") or
                    v.Name:lower():find("cash") or
                    v.Name:lower():find("item")) then
                    Root.CFrame=CFrame.new(v.Position+Vector3.new(0,3,0))
                    task.wait(0.08)
                end
            end
        end
    end)

    toggle("GAME","Win Teleport","tp to end/goal area",function(on)
        if on and Root then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (
                    v.Name:lower():find("end") or
                    v.Name:lower():find("goal") or
                    v.Name:lower():find("finish") or
                    v.Name:lower():find("win")) then
                    Root.CFrame=CFrame.new(v.Position+Vector3.new(0,5,0))
                    break
                end
            end
        end
    end)

    toggle("GAME","Highlight All Parts","outlines workspace",function(on)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(LP.Character or Instance.new("Model")) then
                local s=Instance.new("SelectionBox"); s.Adornee=v
                s.Color3=Color3.new(1,1,1); s.LineThickness=0.03
                s.SurfaceTransparency=0.9; s.Name="_dpmhl"; s.Parent=v
            end
        end
    end)

    toggle("GAME","Remote Logger","logs game remotes",function(on)
        if on then
            for _,v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    print("[DPM-GAME] "..v:GetFullName())
                end
            end
        end
    end)
end

-- =============================================
--  FUN TAB
-- =============================================
toggle("FUN","Spam Jump","vibrates character",function(on)
    task.spawn(function()
        while on do
            if Hum then Hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            task.wait(0.05)
        end
    end)
end)

toggle("FUN","Tiny Mode","shrinks char to 10%",function(on)
    if Char then
        local hum=Char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.BodyDepthScale.Value=on and 0.1 or 1
            hum.BodyHeightScale.Value=on and 0.1 or 1
            hum.BodyWidthScale.Value=on and 0.1 or 1
            hum.HeadScale.Value=on and 0.1 or 1
        end
    end
end)

toggle("FUN","Giant Mode","scales char to 500%",function(on)
    if Char then
        local hum=Char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.BodyDepthScale.Value=on and 5 or 1
            hum.BodyHeightScale.Value=on and 5 or 1
            hum.BodyWidthScale.Value=on and 5 or 1
            hum.HeadScale.Value=on and 5 or 1
        end
    end
end)

toggle("FUN","Seizure Gravity","random gravity 0.1s",function(on)
    task.spawn(function()
        while on do workspace.Gravity=math.random(20,500) task.wait(0.1) end
        workspace.Gravity=196.2
    end)
end)

toggle("FUN","Chat Spam","sends msgs every 2s",function(on)
    local msgs={"L","ez","ratio","no diff","DPM Classic","skill issue","bro can't play"}
    task.spawn(function()
        while on do
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("DefaultChatSystemChatEvents")
                    :WaitForChild("SayMessageRequest")
                    :FireServer(msgs[math.random(#msgs)],"All")
            end)
            task.wait(2)
        end
    end)
end)

toggle("FUN","Fling Others","launches nearby players",function(on)
    RunService.Heartbeat:Connect(function()
        if not on or not Root then return end
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position-Root.Position).Magnitude<15 then
                    local bv=Instance.new("BodyVelocity")
                    bv.MaxForce=Vector3.new(1e5,1e5,1e5)
                    bv.Velocity=Vector3.new(math.random(-80,80),80,math.random(-80,80))
                    bv.Parent=hrp; game:GetService("Debris"):AddItem(bv,0.2)
                end
            end
        end
    end)
end)

-- =============================================
--  NOTIFICATION
-- =============================================
local function notify(msg)
    local n=Instance.new("Frame")
    n.Size=UDim2.new(0,200,0,34); n.Position=UDim2.new(0.5,-100,-0.08,0)
    n.BackgroundColor3=Color3.fromRGB(14,14,14); n.BorderSizePixel=0; n.Parent=SG
    Instance.new("UICorner",n).CornerRadius=UDim.new(0,7)
    local st=Instance.new("UIStroke"); st.Color=Color3.new(1,1,1)
    st.Thickness=1; st.Transparency=0.65; st.Parent=n
    local side=Instance.new("Frame"); side.Size=UDim2.new(0,3,1,-8)
    side.Position=UDim2.new(0,0,0,4); side.BackgroundColor3=Color3.new(1,1,1)
    side.BorderSizePixel=0; side.Parent=n
    Instance.new("UICorner",side).CornerRadius=UDim.new(0,3)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-10,1,0)
    lbl.Position=UDim2.new(0,9,0,0); lbl.BackgroundTransparency=1
    lbl.Text=msg; lbl.TextColor3=Color3.new(1,1,1); lbl.TextSize=10
    lbl.Font=Enum.Font.GothamBold; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=n
    TweenService:Create(n,TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Position=UDim2.new(0.5,-100,0.02,0)
    }):Play()
    task.delay(2.2,function()
        TweenService:Create(n,TweenInfo.new(0.2),{Position=UDim2.new(0.5,-100,-0.08,0)}):Play()
        task.wait(0.22); n:Destroy()
    end)
end

task.delay(0.5,function()
    notify("DPM Classic  ·  "..gameName)
end)
print("DPM Classic loaded — "..gameName.." ("..placeId..")")
