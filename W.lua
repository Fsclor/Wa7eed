-- ~ Wa7eed The CrAzY ~ - نظام إدارة الضحايا
-- سكربت بواسطة Wa7eed
-- تم التحديث بإصلاح مشكلة الإشعارات نهائياً

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- 🔊 تشغيل الصوت التلقائي عند البدء
local SoundId = "rbxassetid://114512954419100"
local SoundName = "AutoPlayedSong"
local Duration = 25 -- المدة بالثواني

-- 1. Create a new Sound object
local Sound = Instance.new("Sound")
Sound.Name = SoundName

-- 2. Set the SoundId
Sound.SoundId = SoundId

-- 3. Set the parent to a location that exists and is accessible (e.g., Workspace)
Sound.Parent = game.Workspace

-- 4. Set Looping to false لأننا نريد التشغيل لمرة واحدة
Sound.Looped = false

-- 5. Set Volume (optional, adjust as needed, 0.5 is a good default)
Sound.Volume = 0.5

-- 6. Play the sound
Sound:Play()

-- 7. إيقاف الصوت بعد 25 ثانية
delay(Duration, function()
    Sound:Stop()
    print("تم إيقاف الصوت بعد " .. Duration .. " ثانية")
    
    -- Optional: إزالة كائن الصوت من workspace
    Sound:Destroy()
end)

-- Optional: Print a message to the console/output to confirm execution
print("Script executed successfully. Attempting to play Sound ID: " .. SoundId)
print("Sound object created at: " .. Sound.Parent.Name .. "/" .. Sound.Name)
print("الصوت سيتوقف تلقائياً بعد " .. Duration .. " ثانية")

-- ⚡ الأوامر التلقائية عند بدء التشغيل
local function executeStartupCommands()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- الانتظار حتى يتم تحميل اللعبة بالكامل
    task.wait(5)
    
    -- الأمر الثاني: إرسال كل 5 دقائق (تمت إضافته)
    while true do
        task.wait(300) -- 300 ثانية = 5 دقائق
        pcall(function()
            local SendMessage = ReplicatedStorage.Events.SendMessage
            SendMessage:FireServer("\226\152\133 \239\188\175\239\188\174 \239\188\179\239\189\131\239\188\178\239\189\137\239\188\176\239\188\180 \227\128\142 \239\188\183\239\189\129\239\188\151\239\189\133\239\189\133\239\189\132\227\128\143\226\152\133")
        end)
    end
end

-- تشغيل الأوامر التلقائية
coroutine.wrap(executeStartupCommands)()

-- نظام الإشعارات المحسن مع الإضافات الجديدة
local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "Notifications"
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.ResetOnSpawn = false
NotificationGui.Parent = CoreGui

local activeNotifications = {}
local lastVictim = nil

local function findIndex(tbl, item)
    for i, v in ipairs(tbl) do
        if v == item then
            return i
        end
    end
    return nil
end

local function showNotification(message, playerInfo, hasCloseButton)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 70)
    notification.Position = UDim2.new(1, -310, 0, 10 + (#activeNotifications * 80))
    notification.BackgroundColor3 = Color3.new(0, 0, 0)
    notification.BackgroundTransparency = 0.5
    notification.BorderSizePixel = 3
    notification.BorderColor3 = Color3.new(1, 1, 1)
    notification.ZIndex = 100
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notification
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -10, hasCloseButton and 0.7 or 1, hasCloseButton and -5 or 0)
    messageLabel.Position = UDim2.new(0, 5, 0, 5)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextColor3 = Color3.new(1, 1, 1)
    messageLabel.Text = message
    messageLabel.TextSize = 12
    messageLabel.Font = Enum.Font.GothamBlack
    messageLabel.TextWrapped = true
    messageLabel.Parent = notification
    
    -- زر الإغلاق يظهر فقط للإشعارات التي تحتاجه
    if hasCloseButton then
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 50, 0, 20)
        closeButton.Position = UDim2.new(0.5, -25, 0.7, 5)
        closeButton.BackgroundColor3 = Color3.new(0, 0, 0)
        closeButton.BackgroundTransparency = 0.5
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.Text = "تم"
        closeButton.TextSize = 10
        closeButton.Font = Enum.Font.GothamBlack
        closeButton.BorderSizePixel = 3
        closeButton.BorderColor3 = Color3.new(1, 1, 1)
        closeButton.Parent = notification
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 4)
        closeCorner.Parent = closeButton
        
        closeButton.MouseButton1Click:Connect(function()
            local index = findIndex(activeNotifications, notification)
            if index then
                table.remove(activeNotifications, index)
            end
            
            local tweenOut = TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 400, 0, notification.Position.Y.Offset)})
            tweenOut:Play()
            
            task.wait(0.5)
            notification:Destroy()
            
            for i, notif in ipairs(activeNotifications) do
                notif.Position = UDim2.new(1, -310, 0, 10 + ((i-1) * 80))
            end
        end)
    end
    
    if playerInfo then
        local playerImage = Instance.new("ImageLabel")
        playerImage.Size = UDim2.new(0, 40, 0, 40)
        playerImage.Position = UDim2.new(0, 10, 0, 15)
        playerImage.BackgroundColor3 = Color3.new(1, 1, 1)
        playerImage.BorderSizePixel = 2
        playerImage.BorderColor3 = Color3.new(1, 1, 1)
        playerImage.Image = playerInfo.Image
        playerImage.Parent = notification
        
        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(0, 4)
        imageCorner.Parent = playerImage
        
        messageLabel.Position = UDim2.new(0, 60, 0, 5)
        messageLabel.Size = UDim2.new(1, -70, hasCloseButton and 0.7 or 1, hasCloseButton and -5 or 0)
    end
    
    notification.Parent = NotificationGui
    table.insert(activeNotifications, notification)
    
    notification.Position = UDim2.new(1, 400, 0, notification.Position.Y.Offset)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tween = TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, -310, 0, notification.Position.Y.Offset)})
    tween:Play()
    
    -- الإشعارات العادية تختفي بعد 5 ثواني، إشعارات الخروج تبقى
    if not hasCloseButton then
        task.delay(5, function()
            if notification.Parent then
                local tweenOut = TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, 400, 0, notification.Position.Y.Offset)})
                tweenOut:Play()
                
                task.wait(0.5)
                notification:Destroy()
                
                local index = findIndex(activeNotifications, notification)
                if index then
                    table.remove(activeNotifications, index)
                end
            end
        end)
    end
end

-- الإشعار الترحيبي الجديد
local function showWelcomeNotifications()
    -- الانتظار قليلاً بعد انتهاء الأنيميشن
    task.wait(1)
    
    -- الإشعار الأول: ترحيب باللاعب
    local playerImage = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
    
    showNotification("منور في سكربت Wa7eed\n" .. player.Name, {
        Image = playerImage
    }, false)
    
    -- الانتظار قبل الإشعار الثاني
    task.wait(3)
    
    -- الإشعار الثاني: الدعوة لسيرفر الديسكورد
    showNotification("لا تنسى تنورنا في سيرفر ديسكورد\nفي اخبار هناك حياكم", nil, false)
    
    -- نسخ رابط الديسكورد تلقائياً
    task.wait(1)
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/RSF9vjrFF")
        end
    end)
end

-- أنيميشن البدء المحسن بدون خلفية
local function showStartupAnimation()
    local StartupGui = Instance.new("ScreenGui")
    StartupGui.Name = "StartupAnimation"
    StartupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    StartupGui.ResetOnSpawn = false

    local Logo = Instance.new("TextLabel")
    Logo.Size = UDim2.new(0, 800, 0, 200) -- تم التكبير
    Logo.Position = UDim2.new(0.5, -400, 0.5, -100) -- تم التكبير
    Logo.BackgroundTransparency = 1
    Logo.Text = "Wa7eed"
    Logo.TextColor3 = Color3.new(1, 1, 1)
    Logo.TextSize = 100 -- تم التكبير جداً
    Logo.Font = Enum.Font.GothamBlack
    Logo.Parent = StartupGui

    StartupGui.Parent = CoreGui

    -- أنيميشن الدخول
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenIn = TweenService:Create(Logo, tweenInfo, {TextColor3 = Color3.new(1, 1, 1), TextTransparency = 0})
    tweenIn:Play()

    -- أنيميشن حركة الماء للاسم
    local waveConnection
    waveConnection = RunService.Heartbeat:Connect(function()
        local time = tick()
        Logo.Rotation = math.sin(time * 2) * 1.5
        Logo.TextColor3 = Color3.new(1, 1, 1)
    end)

    task.wait(3)

    -- إيقاف أنيميشن الماء
    waveConnection:Disconnect()
    Logo.Rotation = 0

    -- أنيميشن إخفاء الاسم فقط (بدون خلفية)
    local tweenOut = TweenService:Create(Logo, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
    tweenOut:Play()

    task.wait(2)
    StartupGui:Destroy()
    
    -- بعد انتهاء الأنيميشن، عرض الإشعار الترحيبي
    coroutine.wrap(showWelcomeNotifications)()
end

-- تشغيل أنيميشن البدء
coroutine.wrap(showStartupAnimation)()

-- الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Wa7eedTheCrAzY"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- زر التفعيل
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.5
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Text = "W"
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.BorderSizePixel = 3
ToggleButton.BorderColor3 = Color3.new(1, 1, 1)
ToggleButton.ZIndex = 10

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = ToggleButton

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame

-- العنوان مع الأنيميشن الجديد
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.BackgroundTransparency = 0.5
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "~ Wa7eed The CrAzY ~"
Title.TextSize = 24
Title.Font = Enum.Font.GothamBlack
Title.BorderSizePixel = 3
Title.BorderColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Center

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = Title

-- أنيميشن السطوع المتكرر للعنوان
coroutine.wrap(function()
    while true do
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local tweenBright = TweenService:Create(Title, tweenInfo, {TextColor3 = Color3.new(1, 0.5, 0.5)})
        local tweenNormal = TweenService:Create(Title, tweenInfo, {TextColor3 = Color3.new(1, 1, 1)})
        
        tweenBright:Play()
        task.wait(1)
        tweenNormal:Play()
        task.wait(1)
    end
end)()

-- أزرار الأقسام
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(1, -20, 0, 40)
TabsFrame.Position = UDim2.new(0, 10, 0, 60)
TabsFrame.BackgroundTransparency = 1

local TabsGrid = Instance.new("UIGridLayout")
TabsGrid.CellPadding = UDim2.new(0, 5, 0, 0)
TabsGrid.CellSize = UDim2.new(0.19, 0, 1, 0)
TabsGrid.FillDirection = Enum.FillDirection.Horizontal
TabsGrid.Parent = TabsFrame

-- وظيفة إنشاء أزرار الأقسام
local function createTabButton(name)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 100, 0, 40)
    button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    button.BackgroundTransparency = 0.5
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.TextSize = 12
    button.Font = Enum.Font.GothamBlack
    button.BorderSizePixel = 3
    button.BorderColor3 = Color3.new(1, 1, 1)
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    return button
end

-- إنشاء أزرار الأقسام (تم إضافة قسم السبام)
local VictimTab = createTabButton("الضحيه")
local PlayerTab = createTabButton("اللاعب")
local FeaturesTab = createTabButton("المميزات")
local SpamTab = createTabButton("سبام")
local RightsTab = createTabButton("الحقوق")

VictimTab.Parent = TabsFrame
PlayerTab.Parent = TabsFrame
FeaturesTab.Parent = TabsFrame
SpamTab.Parent = TabsFrame
RightsTab.Parent = TabsFrame

-- إطارات المحتوى لكل قسم
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 240)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1

-- قسم الضحية
local VictimSection = Instance.new("Frame")
VictimSection.Name = "VictimSection"
VictimSection.Size = UDim2.new(1, 0, 1, 0)
VictimSection.Position = UDim2.new(0, 0, 0, 0)
VictimSection.BackgroundTransparency = 1
VictimSection.Visible = true

-- معلومات الضحية المحسنة
local VictimInfo = Instance.new("Frame")
VictimInfo.Name = "VictimInfo"
VictimInfo.Size = UDim2.new(1, 0, 0, 80)
VictimInfo.Position = UDim2.new(0, 0, 0, 0)
VictimInfo.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
VictimInfo.BackgroundTransparency = 0.5
VictimInfo.BorderSizePixel = 3
VictimInfo.BorderColor3 = Color3.new(1, 1, 1)

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = VictimInfo

local VictimAvatar = Instance.new("ImageLabel")
VictimAvatar.Name = "VictimAvatar"
VictimAvatar.Size = UDim2.new(0, 50, 0, 50)
VictimAvatar.Position = UDim2.new(0, 10, 0, 15)
VictimAvatar.BackgroundColor3 = Color3.new(1, 1, 1)
VictimAvatar.BorderSizePixel = 3
VictimAvatar.BorderColor3 = Color3.new(1, 1, 1)
VictimAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 6)
avatarCorner.Parent = VictimAvatar

local VictimName = Instance.new("TextLabel")
VictimName.Name = "VictimName"
VictimName.Size = UDim2.new(0, 350, 0, 25)
VictimName.Position = UDim2.new(0, 70, 0, 10)
VictimName.BackgroundTransparency = 1
VictimName.TextColor3 = Color3.new(1, 1, 1)
VictimName.Text = "لا يوجد ضحية محددة"
VictimName.TextSize = 14
VictimName.Font = Enum.Font.GothamBlack
VictimName.TextXAlignment = Enum.TextXAlignment.Left

-- معلومات الضحية الإضافية - تم التعديل هنا لإضافة المعلومات الجديدة
local VictimInfoText = Instance.new("TextLabel")
VictimInfoText.Name = "VictimInfoText"
VictimInfoText.Size = UDim2.new(0, 350, 0, 40)
VictimInfoText.Position = UDim2.new(0, 70, 0, 35)
VictimInfoText.BackgroundTransparency = 1
VictimInfoText.TextColor3 = Color3.new(1, 1, 1)
VictimInfoText.Text = "اللقب: -\nعمر الحساب: -\nID: -\nالأدوات: -"
VictimInfoText.TextSize = 9
VictimInfoText.Font = Enum.Font.GothamBold
VictimInfoText.TextXAlignment = Enum.TextXAlignment.Left
VictimInfoText.TextYAlignment = Enum.TextYAlignment.Top
VictimInfoText.TextWrapped = true

-- إطار الإدخال
local InputFrame = Instance.new("Frame")
InputFrame.Name = "InputFrame"
InputFrame.Size = UDim2.new(1, 0, 0, 30)
InputFrame.Position = UDim2.new(0, 0, 0, 90)
InputFrame.BackgroundTransparency = 1

local VictimInput = Instance.new("TextBox")
VictimInput.Name = "VictimInput"
VictimInput.Size = UDim2.new(0.7, 0, 1, 0)
VictimInput.Position = UDim2.new(0, 0, 0, 0)
VictimInput.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
VictimInput.BackgroundTransparency = 0.5
VictimInput.TextColor3 = Color3.new(1, 1, 1)
VictimInput.PlaceholderText = "أدخل اسم المستخدم (3 أحرف على الأقل)"
VictimInput.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
VictimInput.Text = ""
VictimInput.TextSize = 12
VictimInput.Font = Enum.Font.GothamBold
VictimInput.BorderSizePixel = 3
VictimInput.BorderColor3 = Color3.new(1, 1, 1)

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = VictimInput

local SetVictimButton = Instance.new("TextButton")
SetVictimButton.Name = "SetVictimButton"
SetVictimButton.Size = UDim2.new(0.28, 0, 1, 0)
SetVictimButton.Position = UDim2.new(0.72, 0, 0, 0)
SetVictimButton.BackgroundColor3 = Color3.new(0, 0, 0)
SetVictimButton.BackgroundTransparency = 0.5
SetVictimButton.TextColor3 = Color3.new(1, 1, 1)
SetVictimButton.Text = "تحديد الضحية"
SetVictimButton.TextSize = 12
SetVictimButton.Font = Enum.Font.GothamBlack
SetVictimButton.BorderSizePixel = 3
SetVictimButton.BorderColor3 = Color3.new(1, 1, 1)

local setCorner = Instance.new("UICorner")
setCorner.CornerRadius = UDim.new(0, 6)
setCorner.Parent = SetVictimButton

-- إطار التمرير للأزرار - تم التعديل هنا لإصلاح شريط التمرير
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 0, 120)
ScrollFrame.Position = UDim2.new(0, 0, 0, 130)
ScrollFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ScrollFrame.BackgroundTransparency = 0.5
ScrollFrame.BorderSizePixel = 3
ScrollFrame.BorderColor3 = Color3.new(1, 1, 1)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 8)
scrollCorner.Parent = ScrollFrame

-- شبكة الأزرار
local ButtonGrid = Instance.new("UIGridLayout")
ButtonGrid.CellPadding = UDim2.new(0, 5, 0, 5)
ButtonGrid.CellSize = UDim2.new(0, 110, 0, 30)
ButtonGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonGrid.SortOrder = Enum.SortOrder.LayoutOrder
ButtonGrid.Parent = ScrollFrame

-- وظيفة إنشاء الأزرار مع الأنيميشن
local function createButton(name, layoutOrder)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 110, 0, 30)
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.BackgroundTransparency = 0.5
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.TextSize = 10
    button.Font = Enum.Font.GothamBlack
    button.TextStrokeColor3 = Color3.new(0, 0, 0)
    button.TextStrokeTransparency = 0.3
    button.BorderSizePixel = 3
    button.BorderColor3 = Color3.new(1, 1, 1)
    button.LayoutOrder = layoutOrder
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- أنيميشن الزر عند المرور
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
            Size = UDim2.new(0, 115, 0, 32)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = Color3.new(0, 0, 0),
            Size = UDim2.new(0, 110, 0, 30)
        })
        tween:Play()
    end)
    
    button.Parent = ScrollFrame
    return button
end

-- إعادة ترتيب أزرار الضحية حسب القائمة المطلوبة (تم إضافة الزرين الجديدين وحذف زر بانق تشويش)
local victimButtons = {
    -- الأزرار الأساسية
    {name = "مشاهدة", type = "spectate", order = 1},
    {name = "انتقال", type = "teleport", order = 2},
    {name = "اعاده تعيين", type = "reset", order = 3},
    {name = "to", type = "to", order = 4},
    {name = "بانق", type = "bang", order = 5},
    {name = "بانق من الامام", type = "bangFront", order = 6},
    {name = "بانق بالراس", type = "headSuck", order = 7},
    -- الأزرار الجديدة المضافة
    {name = "تجميد بالكلبشه", type = "freezeCuff", order = 8},
    {name = "سحب بالكلبشه", type = "pullCuff", order = 9},
    {name = "تعليق بالكلبشه", type = "suspendCuff", order = 10},
    -- الزرين الجديدين المطلوبين
    {name = "حقيبه في الظهر", type = "backpackSit", order = 11},
    {name = "جلوس على الراس", type = "headSit", order = 12},
    -- باقي الأزرار
    {name = "اعاده تعيين تلقائي", type = "autoReset", order = 13},
    {name = "ايقاف 1", type = "undog", order = 14},
    {name = "ايقاف 2", type = "unneon", order = 15},
    {name = "ايقاف 3", type = "unwormify", order = 16},
    {name = "ايقاف الجميع", type = "stopAll", order = 17},
    {name = "ايقاف الجميع تلقائي", type = "autoStopAll", order = 18},
    {name = "معوق", type = "cripple", order = 19},
    {name = "معوق تلقائي", type = "autoCripple", order = 20},
    {name = "تطيير في الجو", type = "flyInAir", order = 21},
    {name = "تطيير في الجو تلقائي", type = "autoFlyInAir", order = 22},
    {name = "تعليق F", type = "suspendF", order = 23},
    {name = "فك تعليق F", type = "unsuspendF", order = 24},
    {name = "تعليق F تلقائي", type = "autoSuspendF", order = 25},
    {name = "تعليق القفز", type = "suspendJump", order = 26},
    {name = "فك تعليق القفز", type = "unsuspendJump", order = 27},
    {name = "قفز تلقائي", type = "autoJump", order = 28},
    {name = "تعليق الطيران", type = "suspendFly", order = 29},
    {name = "فك تعليق الطيران", type = "unsuspendFly", order = 30},
    {name = "تعليق طيران تلقائي", type = "autoSuspendFly", order = 31},
    {name = "ايقاف الطيران", type = "unfly", order = 32},
    {name = "كلب", type = "dog", order = 33},
    {name = "كلب تلقائي", type = "autoDog", order = 34},
    {name = "دوده", type = "worm", order = 35},
    {name = "منور", type = "neon", order = 36},
    {name = "ذهب", type = "gold", order = 37},
    {name = "شفاف", type = "glass", order = 38},
    {name = "اخفاء", type = "ref", order = 39},
    {name = "حجم كبير", type = "size3", order = 40},
    {name = "سكن تخريب", type = "charCrazy", order = 41},
    {name = "سكن Miri", type = "charMiri", order = 42},
    {name = "char", type = "char", order = 43},
    {name = "unchar", type = "unchar", order = 44},
    {name = "تفصيخ تيشرت", type = "shirt", order = 45},
    {name = "تفصيخ كامل", type = "pants", order = 46},
    {name = "فك الهيدلست", type = "head", order = 47},
    {name = "راس كبير", type = "giantDwarf", order = 48},
    {name = "اسود", type = "black", order = 49},
    {name = "ابيض", type = "white", order = 50},
    {name = "وردي", type = "pink", order = 51},
    {name = "بنفسجي", type = "purple", order = 52},
    {name = "ازرق فاتح", type = "blue", order = 53},
    {name = "ازرق", type = "darkblue", order = 54},
    {name = "اصفر", type = "yellow", order = 55},
    {name = "برتقالي", type = "orange", order = 56},
    {name = "احمر", type = "red", order = 57},
    {name = "اخضر", type = "green", order = 58},
    {name = "ايقاف اللون", type = "uncolour", order = 59},
    {name = "رقصه 1", type = "fryDance", order = 60},
    {name = "رقصه 2", type = "takethel", order = 61},
    {name = "فار يرقص", type = "ratDance", order = 62},
    {name = "جلوس 2", type = "cuteSit", order = 63},
    {name = "ميت", type = "fakeDeath", order = 64},
    {name = "دب", type = "fat", order = 65},
    {name = "نحيف", type = "thin", order = 66},
    {name = "مربع", type = "hide", order = 67},
    {name = "معضل", type = "buffify", order = 68},
    {name = "دبابه حربيه", type = "tank", order = 69},
    {name = "هليكوبتر", type = "helicopter", order = 70},
    {name = "طياره", type = "plane", order = 71},
    {name = "سياره", type = "car", order = 72},
    {name = "صندوق", type = "box", order = 73},
    {name = "عشوائي", type = "emote", order = 74},
    {name = "ارتجاج", type = "phase", order = 75},
    {name = "استلقاء في الهواء", type = "aura", order = 76},
    -- تم حذف زر ايقاف الدخان و ايقاف النار
    {name = "اختفاء خفيف 1", type = "shine", order = 77},
    {name = "اختفاء خفيف 2", type = "ghost", order = 78},
    {name = "سكن دوده", type = "wormify", order = 79},
    {name = "سكن بنت", type = "chibify", order = 80},
    {name = "سكن صغير", type = "plushify", order = 81},
    {name = "سكن ضفدع", type = "frogify", order = 82},
    {name = "سكن سبونج", type = "spongify", order = 83},
    {name = "سكن وحش", type = "creepify", order = 84},
    {name = "سكن وحش 2", type = "freakify", order = 85},
    {name = "سكن ديناصور", type = "dinofy", order = 86},
    {name = "سكن دب عبد", type = "fatify", order = 87},
    {name = "جسم ضخم", type = "bigify", order = 88},
    {name = "نسخ 1", type = "copy1", order = 89},
    {name = "نسخ 2", type = "copy2", order = 90},
    {name = "نسخ 3", type = "copy3", order = 91},
    {name = "نسخ 4", type = "copy4", order = 92},
    {name = "نسخ 5", type = "copy5", order = 93},
    {name = "نسخ 6", type = "copy6", order = 94},
    {name = "نسخ 7", type = "copy7", order = 95},
    {name = "نسخ 8", type = "copy8", order = 96},
    {name = "نسخ 9", type = "copy9", order = 97},
    {name = "نسخ 10", type = "copy10", order = 98},
    {name = "نسخ 11", type = "copy11", order = 99},
    {name = "نسخ 12", type = "copy12", order = 100},
    {name = "نسخ 13", type = "copy13", order = 101},
    {name = "نسخ 14", type = "copy14", order = 102},
    {name = "نسخ 15", type = "copy15", order = 103},
    {name = "نسخ 16", type = "copy16", order = 104},
    {name = "نسخ 17", type = "copy17", order = 105},
    {name = "نسخ 18", type = "copy18", order = 106},
    {name = "نسخ 19", type = "copy19", order = 107},
    {name = "نسخ 20", type = "copy20", order = 108},
    {name = "نسخ تلقائي 1", type = "autoCopy1", order = 109},
    {name = "نسخ تلقائي 2", type = "autoCopy2", order = 110},
    {name = "نسخ تلقائي 3", type = "autoCopy3", order = 111},
    {name = "نسخ تلقائي 4", type = "autoCopy4", order = 112},
    {name = "نسخ تلقائي 5", type = "autoCopy5", order = 113},
    {name = "نسخ تلقائي 6", type = "autoCopy6", order = 114}
}

local buttonInstances = {}

for _, buttonInfo in ipairs(victimButtons) do
    local button = createButton(buttonInfo.name, buttonInfo.order)
    buttonInstances[buttonInfo.type] = button
end

-- قسم السبام الجديد والمحدث
local SpamSection = Instance.new("Frame")
SpamSection.Name = "SpamSection"
SpamSection.Size = UDim2.new(1, 0, 1, 0)
SpamSection.Position = UDim2.new(0, 0, 0, 0)
SpamSection.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
SpamSection.BackgroundTransparency = 0.5
SpamSection.BorderSizePixel = 3
SpamSection.BorderColor3 = Color3.new(1, 1, 1)
SpamSection.Visible = false

local spamCorner = Instance.new("UICorner")
spamCorner.CornerRadius = UDim.new(0, 8)
spamCorner.Parent = SpamSection

-- إطار التمرير لقسم السبام الجديد
local SpamScrollFrame = Instance.new("ScrollingFrame")
SpamScrollFrame.Name = "SpamScrollFrame"
SpamScrollFrame.Size = UDim2.new(1, -20, 1, -20)
SpamScrollFrame.Position = UDim2.new(0, 10, 0, 10)
SpamScrollFrame.BackgroundTransparency = 1
SpamScrollFrame.ScrollBarThickness = 8
SpamScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 200)

-- شبكة الأزرار لقسم السبام الجديد
local SpamButtonGrid = Instance.new("UIGridLayout")
SpamButtonGrid.CellPadding = UDim2.new(0, 5, 0, 10)
SpamButtonGrid.CellSize = UDim2.new(1, -10, 0, 35)
SpamButtonGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
SpamButtonGrid.SortOrder = Enum.SortOrder.LayoutOrder
SpamButtonGrid.Parent = SpamScrollFrame

-- حقل الإدخال للسبام المخصص
local CustomSpamInput = Instance.new("TextBox")
CustomSpamInput.Name = "CustomSpamInput"
CustomSpamInput.Size = UDim2.new(1, -10, 0, 80)
CustomSpamInput.Position = UDim2.new(0, 5, 0, 5)
CustomSpamInput.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
CustomSpamInput.BackgroundTransparency = 0.5
CustomSpamInput.TextColor3 = Color3.new(1, 1, 1)
CustomSpamInput.PlaceholderText = "اكتب هنا الاسبام"
CustomSpamInput.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
CustomSpamInput.Text = ""
CustomSpamInput.TextSize = 12
CustomSpamInput.Font = Enum.Font.GothamBold
CustomSpamInput.TextWrapped = true
CustomSpamInput.ClearTextOnFocus = false
CustomSpamInput.BorderSizePixel = 3
CustomSpamInput.BorderColor3 = Color3.new(1, 1, 1)
CustomSpamInput.LayoutOrder = 1

local inputCorner2 = Instance.new("UICorner")
inputCorner2.CornerRadius = UDim.new(0, 6)
inputCorner2.Parent = CustomSpamInput

-- زر الإرسال العادي
local SendSpamButton = Instance.new("TextButton")
SendSpamButton.Name = "SendSpamButton"
SendSpamButton.Size = UDim2.new(1, -10, 0, 35)
SendSpamButton.Position = UDim2.new(0, 5, 0, 90)
SendSpamButton.BackgroundColor3 = Color3.new(0, 0, 0)
SendSpamButton.BackgroundTransparency = 0.5
SendSpamButton.TextColor3 = Color3.new(1, 1, 1)
SendSpamButton.Text = "ارسال"
SendSpamButton.TextSize = 14
SendSpamButton.Font = Enum.Font.GothamBlack
SendSpamButton.BorderSizePixel = 3
SendSpamButton.BorderColor3 = Color3.new(1, 1, 1)
SendSpamButton.LayoutOrder = 2

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 6)
sendCorner.Parent = SendSpamButton

-- زر السبام السريع
local FastSpamButton = Instance.new("TextButton")
FastSpamButton.Name = "FastSpamButton"
FastSpamButton.Size = UDim2.new(1, -10, 0, 35)
FastSpamButton.Position = UDim2.new(0, 5, 0, 130)
FastSpamButton.BackgroundColor3 = Color3.new(0, 0, 0)
FastSpamButton.BackgroundTransparency = 0.5
FastSpamButton.TextColor3 = Color3.new(1, 1, 1)
FastSpamButton.Text = "سبام سريع"
FastSpamButton.TextSize = 14
FastSpamButton.Font = Enum.Font.GothamBlack
FastSpamButton.BorderSizePixel = 3
FastSpamButton.BorderColor3 = Color3.new(1, 1, 1)
FastSpamButton.LayoutOrder = 3

local fastCorner = Instance.new("UICorner")
fastCorner.CornerRadius = UDim.new(0, 6)
fastCorner.Parent = FastSpamButton

-- أنيميشن الأزرار
SendSpamButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(SendSpamButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    })
    tween:Play()
end)

SendSpamButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(SendSpamButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0, 0, 0)
    })
    tween:Play()
end)

FastSpamButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(FastSpamButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    })
    tween:Play()
end)

FastSpamButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(FastSpamButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0, 0, 0)
    })
    tween:Play()
end)

-- إضافة العناصر إلى قسم السبام
CustomSpamInput.Parent = SpamScrollFrame
SendSpamButton.Parent = SpamScrollFrame
FastSpamButton.Parent = SpamScrollFrame

-- قسم المميزات الجديد والمحدث مع الإضافات الجديدة
local FeaturesSection = Instance.new("Frame")
FeaturesSection.Name = "FeaturesSection"
FeaturesSection.Size = UDim2.new(1, 0, 1, 0)
FeaturesSection.Position = UDim2.new(0, 0, 0, 0)
FeaturesSection.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FeaturesSection.BackgroundTransparency = 0.5
FeaturesSection.BorderSizePixel = 3
FeaturesSection.BorderColor3 = Color3.new(1, 1, 1)
FeaturesSection.Visible = false

local featuresCorner = Instance.new("UICorner")
featuresCorner.CornerRadius = UDim.new(0, 8)
featuresCorner.Parent = FeaturesSection

-- إطار التمرير لقسم المميزات - تم زيادة الطول
local FeaturesScrollFrame = Instance.new("ScrollingFrame")
FeaturesScrollFrame.Name = "FeaturesScrollFrame"
FeaturesScrollFrame.Size = UDim2.new(1, -20, 1, -20)
FeaturesScrollFrame.Position = UDim2.new(0, 10, 0, 10)
FeaturesScrollFrame.BackgroundTransparency = 1
FeaturesScrollFrame.ScrollBarThickness = 8
FeaturesScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500) -- تم زيادة الطول لاستيعاب الأزرار الجديدة

-- تغيير الشبكة إلى صفين
local FeaturesButtonGrid = Instance.new("UIGridLayout")
FeaturesButtonGrid.CellPadding = UDim2.new(0, 5, 0, 10)
FeaturesButtonGrid.CellSize = UDim2.new(0.48, -10, 0, 40) -- صفين
FeaturesButtonGrid.FillDirection = Enum.FillDirection.Horizontal
FeaturesButtonGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
FeaturesButtonGrid.SortOrder = Enum.SortOrder.LayoutOrder
FeaturesButtonGrid.Parent = FeaturesScrollFrame

-- إنشاء أزرار المميزات مع الإضافات الجديدة
local featuresButtons = {
    {name = "مضاد الكلبشه", type = "antiCuff", order = 1},
    {name = "ESP", type = "esp", order = 2},
    {name = "مضاد نسخ", type = "antiCopy", order = 3},
    {name = "مضاد النسخ بدون Mod", type = "antiCopyNoMod", order = 4},
    {name = "حقل الأوامر", type = "commandField", order = 5},
    {name = "لوك الكاميرا", type = "cameraLock", order = 6},
    {name = "اختراق الجدران", type = "wallHack", order = 7},
    {name = "مضاد AFK", type = "antiAFK", order = 8},
    {name = "اداه الانتقال", type = "teleportTool", order = 9},
    {name = "رقصات", type = "emotes", order = 10}
}

local featuresButtonInstances = {}
local featuresActive = {
    cameraLock = false,
    antiCopy = false,
    antiCopyNoMod = false,
    commandField = false,
    wallHack = false,
    antiAFK = false,
    teleportTool = false,
    emotes = false,
    antiCuff = false,
    esp = false
}

-- متغيرات للأزرار الجديدة
local wallHackConnection = nil
local antiAFKConnection = nil
local teleportToolInstance = nil

-- =============================================
-- الأزرار الجديدة في قسم المميزات
-- =============================================

-- زر مضاد الكلبشه الجديد
local antiCuffActive = false
local antiCuffConnection = nil

local function toggleAntiCuff()
    if antiCuffActive then
        -- إيقاف مضاد الكلبشه
        antiCuffActive = false
        if antiCuffConnection then
            antiCuffConnection:Disconnect()
            antiCuffConnection = nil
        end
        
        -- إعادة الحركة الطبيعية
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                hum.Sit = false
                hum.AutoRotate = true
            end
        end
        
        featuresButtonInstances["antiCuff"].Text = "مضاد الكلبشه"
        featuresButtonInstances["antiCuff"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- تفعيل مضاد الكلبشه
        antiCuffActive = true
        
        local function fixMovement()
            local char = player.Character
            if not char then return end

            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            -- نخلي اللاعب يمشي حتى لو هو Sit
            hum.AutoRotate = true
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

            -- كل ثانية نعيد تمكين الحركة بدون ما نلغي الـSit الحقيقي
            while hum.Parent and antiCuffActive do
                hum:ChangeState(Enum.HumanoidStateType.Running)
                hum.Sit = true -- نخليه جالس للسكريبت و السيرفر
                task.wait(0.1)
            end
        end

        -- تطبيق على الشخصية الحالية
        if player.Character then
            fixMovement()
        end
        
        -- مراقبة الشخصية الجديدة عند الرسبون
        antiCuffConnection = player.CharacterAdded:Connect(function()
            task.wait(0.5)
            if antiCuffActive then
                fixMovement()
            end
        end)
        
        featuresButtonInstances["antiCuff"].Text = "مضاد الكلبشه ✅"
        featuresButtonInstances["antiCuff"].BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

-- زر ESP الجديد
local espActive = false

local function toggleESP()
    if espActive then
        -- إيقاف ESP
        espActive = false
        
        -- تحميل الرابط مرة أخرى لإيقاف ESP
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20ESP"))()
        end)
        
        featuresButtonInstances["esp"].Text = "ESP"
        featuresButtonInstances["esp"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- تفعيل ESP
        espActive = true
        
        -- تحميل الرابط
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20ESP"))()
        end)
        
        featuresButtonInstances["esp"].Text = "ESP ✅"
        featuresButtonInstances["esp"].BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

local function createFeaturesButton(name, layoutOrder)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -10, 0, 40)
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.BackgroundTransparency = 0.5
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.TextSize = 12
    button.Font = Enum.Font.GothamBlack
    button.TextStrokeColor3 = Color3.new(0, 0, 0)
    button.TextStrokeTransparency = 0.3
    button.BorderSizePixel = 3
    button.BorderColor3 = Color3.new(1, 1, 1)
    button.LayoutOrder = layoutOrder
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- أنيميشن الزر عند المرور
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = Color3.new(0, 0, 0)
        })
        tween:Play()
    end)
    
    button.Parent = FeaturesScrollFrame
    return button
end

for _, buttonInfo in ipairs(featuresButtons) do
    local button = createFeaturesButton(buttonInfo.name, buttonInfo.order)
    featuresButtonInstances[buttonInfo.type] = button
end

-- زر اختراق الجدران المحسن والمعدل - تم الإصلاح
local wallHackLoop = nil
local function toggleWallHack()
    if featuresActive.wallHack then
        -- إيقاف اختراق الجدران
        featuresActive.wallHack = false
        if wallHackLoop then
            wallHackLoop:Disconnect()
            wallHackLoop = nil
        end
        if wallHackConnection then
            wallHackConnection:Disconnect()
            wallHackConnection = nil
        end
        
        -- إعادة تفعيل التصادم للشخصية
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        featuresButtonInstances["wallHack"].Text = "اختراق الجدران"
        featuresButtonInstances["wallHack"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- تفعيل اختراق الجدران المحسن
        featuresActive.wallHack = true
        
        local function disableCollision(char)
            if featuresActive.wallHack then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        -- تطبيق على الشخصية الحالية
        if player.Character then
            disableCollision(player.Character)
        end
        
        -- مراقبة الشخصية الجديدة عند الرسبون
        wallHackConnection = player.CharacterAdded:Connect(function(char)
            if featuresActive.wallHack then
                task.wait(1) -- انتظار تحميل الشخصية
                disableCollision(char)
            end
        end)
        
        -- حلقة مستمرة لضمان بقاء التصادم معطلاً
        wallHackLoop = RunService.Heartbeat:Connect(function()
            if featuresActive.wallHack and player.Character then
                disableCollision(player.Character)
            end
        end)
        
        featuresButtonInstances["wallHack"].Text = "اختراق الجدران ✅"
        featuresButtonInstances["wallHack"].BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

-- زر مضاد AFK
local function toggleAntiAFK()
    if featuresActive.antiAFK then
        -- إيقاف مضاد AFK
        featuresActive.antiAFK = false
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
        
        featuresButtonInstances["antiAFK"].Text = "مضاد AFK"
        featuresButtonInstances["antiAFK"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- تفعيل مضاد AFK
        featuresActive.antiAFK = true
        
        antiAFKConnection = RunService.Heartbeat:Connect(function()
            -- تحريك الكاميرا قليلاً لمنع AFK
            local camera = workspace.CurrentCamera
            if camera then
                camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(0.1), 0)
                task.wait(1)
                camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(-0.1), 0)
            end
            
            -- إرسال حركة افتراضية كل 30 ثانية
            pcall(function()
                if VirtualInputManager then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                end
            end)
        end)
        
        featuresButtonInstances["antiAFK"].Text = "مضاد AFK ✅"
        featuresButtonInstances["antiAFK"].BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

-- زر أداة الانتقال
local function createTeleportTool()
    local tool = Instance.new("Tool")
    tool.Name = "اداه الانتقال"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    
    local clickConnection
    tool.Activated:Connect(function()
        -- الحصول على موقع الماوس
        local mouse = player:GetMouse()
        local targetPosition = mouse.Hit.Position
        
        -- الانتقال إلى الموقع مع الحفاظ على الاتجاه
        if player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local currentCFrame = humanoidRootPart.CFrame
                humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0), currentCFrame.LookVector * 1000)
            end
        end
    end)
    
    return tool
end

local function toggleTeleportTool()
    if featuresActive.teleportTool then
        -- إزالة أداة الانتقال
        featuresActive.teleportTool = false
        if teleportToolInstance then
            teleportToolInstance:Destroy()
            teleportToolInstance = nil
        end
        
        featuresButtonInstances["teleportTool"].Text = "اداه الانتقال"
        featuresButtonInstances["teleportTool"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- إضافة أداة الانتقال
        featuresActive.teleportTool = true
        teleportToolInstance = createTeleportTool()
        
        -- إضافة الأداة إلى اللاعب
        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            teleportToolInstance.Parent = backpack
        end
        
        featuresButtonInstances["teleportTool"].Text = "اداه الانتقال ✅"
        featuresButtonInstances["teleportTool"].BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

-- زر الرقصات الجديد - مرة واحدة فقط
local function executeEmotes()
    if not featuresActive.emotes then
        featuresActive.emotes = true
        
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20Emotes"))()
        end)
        
        featuresButtonInstances["emotes"].Text = "رقصات ✅"
        featuresButtonInstances["emotes"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- تعطيل الزر بعد التنفيذ
        featuresButtonInstances["emotes"].Active = false
        featuresButtonInstances["emotes"].AutoButtonColor = false
    end
end

-- لوك الكاميرا الجديد (زر واحد) - تم التعديل ليعمل مرة واحدة فقط
local cameraLockExecuted = false
local function executeCameraLock()
    if not cameraLockExecuted then
        -- تحميل الرابط الجديد مباشرة مرة واحدة فقط
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20Look"))()
        end)
        
        cameraLockExecuted = true
        featuresButtonInstances["cameraLock"].Text = "لوك الكاميرا ✅"
        featuresButtonInstances["cameraLock"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- تعطيل الزر بعد التنفيذ
        featuresButtonInstances["cameraLock"].Active = false
        featuresButtonInstances["cameraLock"].AutoButtonColor = false
    else
        showNotification("⚠️ لوك الكاميرا مفعل مسبقاً", nil, false)
    end
end

-- مضاد نسخ
local antiCopyActive = false
local antiCopyThread = nil
local function toggleAntiCopy()
    antiCopyActive = not antiCopyActive
    
    if antiCopyActive then
        featuresButtonInstances["antiCopy"].Text = "مضاد نسخ ✅"
        featuresButtonInstances["antiCopy"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        antiCopyThread = coroutine.wrap(function()
            while antiCopyActive do
                pcall(function()
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
                    RequestCommandSilent:InvokeServer(".unwormify me  .undog me  .unneon me  .unchar me ")
                end)
                task.wait(5) -- كل 5 ثواني
            end
        end)()
    else
        if antiCopyThread then
            antiCopyThread = nil
        end
        
        featuresButtonInstances["antiCopy"].Text = "مضاد نسخ"
        featuresButtonInstances["antiCopy"].BackgroundColor3 = Color3.new(0, 0, 0)
    end
end

-- مضاد نسخ بدون Mod
local antiCopyNoModActive = false
local antiCopyNoModThread = nil
local function toggleAntiCopyNoMod()
    antiCopyNoModActive = not antiCopyNoModActive
    
    if antiCopyNoModActive then
        featuresButtonInstances["antiCopyNoMod"].Text = "مضاد نسخ بدون Mod ✅"
        featuresButtonInstances["antiCopyNoMod"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        antiCopyNoModThread = coroutine.wrap(function()
            while antiCopyNoModActive do
                pcall(function()
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
                    RequestCommandSilent:InvokeServer(".char ")
                end)
                task.wait(2) -- كل 2 ثانية
            end
        end)()
    else
        if antiCopyNoModThread then
            antiCopyNoModThread = nil
        end
        
        featuresButtonInstances["antiCopyNoMod"].Text = "مضاد نسخ بدون Mod"
        featuresButtonInstances["antiCopyNoMod"].BackgroundColor3 = Color3.new(0, 0, 0)
    end
end

-- حقل الاوامر المعدل والمصغر (بدون زر إغلاق)
local commandFieldActive = false
local commandFieldGui = nil
local function toggleCommandField()
    commandFieldActive = not commandFieldActive
    
    if commandFieldActive then
        featuresButtonInstances["commandField"].Text = "حقل الأوامر ✅"
        featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- إنشاء واجهة حقل الأوامر المعدلة والمصغرة
        commandFieldGui = Instance.new("ScreenGui")
        commandFieldGui.Name = "CommandFieldGui"
        commandFieldGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        commandFieldGui.ResetOnSpawn = false
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 300, 0, 250) -- تم التصغير
        mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125) -- تم التصغير
        mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        mainFrame.BackgroundTransparency = 0.5
        mainFrame.BorderSizePixel = 3
        mainFrame.BorderColor3 = Color3.new(1, 1, 1)
        mainFrame.Active = true
        mainFrame.Draggable = true
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = mainFrame
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 35)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        title.BackgroundTransparency = 0.5
        title.TextColor3 = Color3.new(1, 1, 1)
        title.Text = "حقل الأوامر - Wa7eed"
        title.TextSize = 14
        title.Font = Enum.Font.GothamBlack
        title.BorderSizePixel = 3
        title.BorderColor3 = Color3.new(1, 1, 1)
        title.TextXAlignment = Enum.TextXAlignment.Center
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 6)
        titleCorner.Parent = title
        
        local inputField = Instance.new("TextBox")
        inputField.Size = UDim2.new(0.9, 0, 0, 35)
        inputField.Position = UDim2.new(0.05, 0, 0, 45)
        inputField.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        inputField.BackgroundTransparency = 0.5
        inputField.TextColor3 = Color3.new(1, 1, 1)
        inputField.PlaceholderText = "أدخل الأمر هنا..."
        inputField.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
        inputField.Text = ""
        inputField.TextSize = 12
        inputField.Font = Enum.Font.GothamBold
        inputField.BorderSizePixel = 3
        inputField.BorderColor3 = Color3.new(1, 1, 1)
        inputField.ClearTextOnFocus = false -- منع مسح النص عند الضغط
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 6)
        inputCorner.Parent = inputField
        
        -- أزرار التنفيذ مع الأزرار الجديدة
        local buttonsFrame = Instance.new("Frame")
        buttonsFrame.Size = UDim2.new(0.9, 0, 0, 150) -- تم التعديل للطول الجديد
        buttonsFrame.Position = UDim2.new(0.05, 0, 0, 90)
        buttonsFrame.BackgroundTransparency = 1
        
        local buttonsGrid = Instance.new("UIGridLayout")
        buttonsGrid.CellPadding = UDim2.new(0, 3, 0, 3) -- تم التصغير
        buttonsGrid.CellSize = UDim2.new(0.48, 0, 0, 25) -- تم التصغير
        buttonsGrid.FillDirection = Enum.FillDirection.Horizontal
        buttonsGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
        buttonsGrid.SortOrder = Enum.SortOrder.LayoutOrder
        buttonsGrid.Parent = buttonsFrame
        
        local function createCommandButton(name, color)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 0, 25)
            button.BackgroundColor3 = color
            button.BackgroundTransparency = 0.5
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Text = name
            button.TextSize = 10 -- تم التصغير
            button.Font = Enum.Font.GothamBlack
            button.BorderSizePixel = 2
            button.BorderColor3 = Color3.new(1, 1, 1)
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = button
            
            return button
        end
        
        -- إنشاء جميع الأزرار المطلوبة (بدون زر إغلاق)
        local executeButton = createCommandButton("تنفيذ", Color3.new(0, 0.5, 0))
        local auto1Button = createCommandButton("تلقائي 1", Color3.new(0.2, 0.2, 0.6))
        local auto2Button = createCommandButton("تلقائي 2", Color3.new(0.2, 0.2, 0.6))
        local auto3Button = createCommandButton("تلقائي 3", Color3.new(0.2, 0.2, 0.6))
        local auto4Button = createCommandButton("تلقائي 4", Color3.new(0.2, 0.2, 0.6))
        local auto5Button = createCommandButton("تلقائي 5", Color3.new(0.2, 0.2, 0.6))
        local auto6Button = createCommandButton("تلقائي 6", Color3.new(0.2, 0.2, 0.6))
        local auto7Button = createCommandButton("تلقائي 7", Color3.new(0.2, 0.2, 0.6))
        
        executeButton.Parent = buttonsFrame
        auto1Button.Parent = buttonsFrame
        auto2Button.Parent = buttonsFrame
        auto3Button.Parent = buttonsFrame
        auto4Button.Parent = buttonsFrame
        auto5Button.Parent = buttonsFrame
        auto6Button.Parent = buttonsFrame
        auto7Button.Parent = buttonsFrame
        
        -- أحداث الأزرار
        executeButton.MouseButton1Click:Connect(function()
            local command = inputField.Text
            if command ~= "" then
                executeCommand(command)
            end
        end)
        
        local autoThreads = {}
        
        local function startAutoExecution(button, interval)
            if autoThreads[button] then
                autoThreads[button] = nil
                button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.6)
            else
                autoThreads[button] = true
                button.BackgroundColor3 = Color3.new(0, 0.5, 0)
                
                coroutine.wrap(function()
                    while autoThreads[button] do
                        local command = inputField.Text
                        if command ~= "" then
                            executeCommand(command)
                        end
                        task.wait(interval)
                    end
                end)()
            end
        end
        
        auto1Button.MouseButton1Click:Connect(function() startAutoExecution(auto1Button, 1) end)
        auto2Button.MouseButton1Click:Connect(function() startAutoExecution(auto2Button, 2) end)
        auto3Button.MouseButton1Click:Connect(function() startAutoExecution(auto3Button, 3) end)
        auto4Button.MouseButton1Click:Connect(function() startAutoExecution(auto4Button, 4) end)
        auto5Button.MouseButton1Click:Connect(function() startAutoExecution(auto5Button, 5) end)
        auto6Button.MouseButton1Click:Connect(function() startAutoExecution(auto6Button, 6) end)
        auto7Button.MouseButton1Click:Connect(function() startAutoExecution(auto7Button, 7) end)
        
        -- إغلاق عند الضغط على ESC
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Escape and commandFieldActive then
                commandFieldGui:Destroy()
                commandFieldActive = false
                featuresButtonInstances["commandField"].Text = "حقل الأوامر"
                featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0, 0, 0)
            end
        end)
        
        -- تجميع العناصر
        title.Parent = mainFrame
        inputField.Parent = mainFrame
        buttonsFrame.Parent = mainFrame
        mainFrame.Parent = commandFieldGui
        commandFieldGui.Parent = CoreGui
        
    else
        if commandFieldGui then
            commandFieldGui:Destroy()
            commandFieldGui = nil
        end
        
        featuresButtonInstances["commandField"].Text = "حقل الأوامر"
        featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0, 0, 0)
    end
end

-- توصيل الأزرار الجديدة في قسم المميزات
featuresButtonInstances["antiCuff"].MouseButton1Click:Connect(toggleAntiCuff)
featuresButtonInstances["esp"].MouseButton1Click:Connect(toggleESP)
featuresButtonInstances["wallHack"].MouseButton1Click:Connect(toggleWallHack)
featuresButtonInstances["antiAFK"].MouseButton1Click:Connect(toggleAntiAFK)
featuresButtonInstances["teleportTool"].MouseButton1Click:Connect(toggleTeleportTool)
featuresButtonInstances["cameraLock"].MouseButton1Click:Connect(executeCameraLock)
featuresButtonInstances["antiCopy"].MouseButton1Click:Connect(toggleAntiCopy)
featuresButtonInstances["antiCopyNoMod"].MouseButton1Click:Connect(toggleAntiCopyNoMod)
featuresButtonInstances["commandField"].MouseButton1Click:Connect(toggleCommandField)
featuresButtonInstances["emotes"].MouseButton1Click:Connect(executeEmotes)

-- باقي الأقسام
local PlayerSection = Instance.new("Frame")
PlayerSection.Name = "PlayerSection"
PlayerSection.Size = UDim2.new(1, 0, 1, 0)
PlayerSection.Position = UDim2.new(0, 0, 0, 0)
PlayerSection.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerSection.BackgroundTransparency = 0.5
PlayerSection.BorderSizePixel = 3
PlayerSection.BorderColor3 = Color3.new(1, 1, 1)
PlayerSection.Visible = false

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 8)
playerCorner.Parent = PlayerSection

local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Size = UDim2.new(1, -20, 1, -20)
PlayerLabel.Position = UDim2.new(0, 10, 0, 10)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.TextColor3 = Color3.new(1, 1, 1)
PlayerLabel.Text = "قسم اللاعب - قريباً"
PlayerLabel.TextSize = 18
PlayerLabel.Font = Enum.Font.GothamBlack
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Center
PlayerLabel.Parent = PlayerSection

-- قسم الحقوق المحدث والمحسن بدون صور
local RightsSection = Instance.new("Frame")
RightsSection.Name = "RightsSection"
RightsSection.Size = UDim2.new(1, 0, 1, 0)
RightsSection.Position = UDim2.new(0, 0, 0, 0)
RightsSection.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
RightsSection.BackgroundTransparency = 0.5
RightsSection.BorderSizePixel = 3
RightsSection.BorderColor3 = Color3.new(1, 1, 1)
RightsSection.Visible = false

local rightsCorner = Instance.new("UICorner")
rightsCorner.CornerRadius = UDim.new(0, 8)
rightsCorner.Parent = RightsSection

-- إطار التمرير لقسم الحقوق - تم زيادة الطول
local RightsScrollFrame = Instance.new("ScrollingFrame")
RightsScrollFrame.Name = "RightsScrollFrame"
RightsScrollFrame.Size = UDim2.new(1, -20, 1, -20)
RightsScrollFrame.Position = UDim2.new(0, 10, 0, 10)
RightsScrollFrame.BackgroundTransparency = 1
RightsScrollFrame.ScrollBarThickness = 8
RightsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)

-- المطور الرئيسي - بدون صورة
local OwnerFrame = Instance.new("Frame")
OwnerFrame.Name = "OwnerFrame"
OwnerFrame.Size = UDim2.new(1, 0, 0, 80)
OwnerFrame.Position = UDim2.new(0, 0, 0, 20)
OwnerFrame.BackgroundTransparency = 1
OwnerFrame.Parent = RightsScrollFrame

local OwnerTitle = Instance.new("TextLabel")
OwnerTitle.Name = "OwnerTitle"
OwnerTitle.Size = UDim2.new(1, -40, 0, 30)
OwnerTitle.Position = UDim2.new(0, 20, 0, 0)
OwnerTitle.BackgroundColor3 = Color3.new(0, 0, 0)
OwnerTitle.BackgroundTransparency = 0.5
OwnerTitle.TextColor3 = Color3.new(1, 1, 1)
OwnerTitle.Text = "OWNER"
OwnerTitle.TextSize = 20
OwnerTitle.Font = Enum.Font.GothamBlack
OwnerTitle.BorderSizePixel = 3
OwnerTitle.BorderColor3 = Color3.new(1, 1, 1)
OwnerTitle.TextXAlignment = Enum.TextXAlignment.Center

local ownerTitleCorner = Instance.new("UICorner")
ownerTitleCorner.CornerRadius = UDim.new(0, 8)
ownerTitleCorner.Parent = OwnerTitle

local OwnerInfo = Instance.new("TextLabel")
OwnerInfo.Name = "OwnerInfo"
OwnerInfo.Size = UDim2.new(1, -40, 0, 40)
OwnerInfo.Position = UDim2.new(0, 20, 0, 40)
OwnerInfo.BackgroundTransparency = 1
OwnerInfo.TextColor3 = Color3.new(1, 1, 1)
OwnerInfo.Text = "Wa7eed\n\n@sj3zx"
OwnerInfo.TextSize = 18
OwnerInfo.Font = Enum.Font.GothamBlack
OwnerInfo.TextXAlignment = Enum.TextXAlignment.Center
OwnerInfo.TextYAlignment = Enum.TextYAlignment.Center
OwnerInfo.Parent = OwnerFrame

OwnerTitle.Parent = OwnerFrame

-- مسافة
local Spacer1 = Instance.new("Frame")
Spacer1.Name = "Spacer1"
Spacer1.Size = UDim2.new(1, 0, 0, 20)
Spacer1.Position = UDim2.new(0, 0, 0, 110)
Spacer1.BackgroundTransparency = 1
Spacer1.Parent = RightsScrollFrame

-- المطور المساعد - بدون صورة
local ViceOwnerFrame = Instance.new("Frame")
ViceOwnerFrame.Name = "ViceOwnerFrame"
ViceOwnerFrame.Size = UDim2.new(1, 0, 0, 80)
ViceOwnerFrame.Position = UDim2.new(0, 0, 0, 140)
ViceOwnerFrame.BackgroundTransparency = 1
ViceOwnerFrame.Parent = RightsScrollFrame

local ViceOwnerTitle = Instance.new("TextLabel")
ViceOwnerTitle.Name = "ViceOwnerTitle"
ViceOwnerTitle.Size = UDim2.new(1, -40, 0, 30)
ViceOwnerTitle.Position = UDim2.new(0, 20, 0, 0)
ViceOwnerTitle.BackgroundColor3 = Color3.new(0, 0, 0)
ViceOwnerTitle.BackgroundTransparency = 0.5
ViceOwnerTitle.TextColor3 = Color3.new(1, 1, 1)
ViceOwnerTitle.Text = "VICE OWNER"
ViceOwnerTitle.TextSize = 20
ViceOwnerTitle.Font = Enum.Font.GothamBlack
ViceOwnerTitle.BorderSizePixel = 3
ViceOwnerTitle.BorderColor3 = Color3.new(1, 1, 1)
ViceOwnerTitle.TextXAlignment = Enum.TextXAlignment.Center

local viceOwnerTitleCorner = Instance.new("UICorner")
viceOwnerTitleCorner.CornerRadius = UDim.new(0, 8)
viceOwnerTitleCorner.Parent = ViceOwnerTitle

local ViceOwnerInfo = Instance.new("TextLabel")
ViceOwnerInfo.Name = "ViceOwnerInfo"
ViceOwnerInfo.Size = UDim2.new(1, -40, 0, 40)
ViceOwnerInfo.Position = UDim2.new(0, 20, 0, 40)
ViceOwnerInfo.BackgroundTransparency = 1
ViceOwnerInfo.TextColor3 = Color3.new(1, 1, 1)
ViceOwnerInfo.Text = "2EVER\n\n@2liiliil"
ViceOwnerInfo.TextSize = 18
ViceOwnerInfo.Font = Enum.Font.GothamBlack
ViceOwnerInfo.TextXAlignment = Enum.TextXAlignment.Center
ViceOwnerInfo.TextYAlignment = Enum.TextYAlignment.Center
ViceOwnerInfo.Parent = ViceOwnerFrame

ViceOwnerTitle.Parent = ViceOwnerFrame

-- مسافة
local Spacer2 = Instance.new("Frame")
Spacer2.Name = "Spacer2"
Spacer2.Size = UDim2.new(1, 0, 0, 20)
Spacer2.Position = UDim2.new(0, 0, 0, 230)
Spacer2.BackgroundTransparency = 1
Spacer2.Parent = RightsScrollFrame

-- نص الحقوق المحدث
local RightsText = Instance.new("TextLabel")
RightsText.Name = "RightsText"
RightsText.Size = UDim2.new(1, -20, 0, 60)
RightsText.Position = UDim2.new(0, 10, 0, 260)
RightsText.BackgroundTransparency = 1
RightsText.TextColor3 = Color3.new(1, 1, 1)
RightsText.Text = "هذه الحقوق محفوظه الي Wa7eed"
RightsText.TextSize = 20
RightsText.Font = Enum.Font.GothamBlack
RightsText.TextXAlignment = Enum.TextXAlignment.Center
RightsText.TextYAlignment = Enum.TextYAlignment.Center
RightsText.Parent = RightsScrollFrame

-- زر نسخ رابط الديسكورد المحدث
local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "DiscordButton"
DiscordButton.Size = UDim2.new(1, -40, 0, 40)
DiscordButton.Position = UDim2.new(0, 20, 0, 330)
DiscordButton.BackgroundColor3 = Color3.new(0, 0, 0)
DiscordButton.BackgroundTransparency = 0.5
DiscordButton.TextColor3 = Color3.new(1, 1, 1)
DiscordButton.Text = "انسخ سيرفرنا على الديسكورد"
DiscordButton.TextSize = 14
DiscordButton.Font = Enum.Font.GothamBlack
DiscordButton.BorderSizePixel = 3
DiscordButton.BorderColor3 = Color3.new(1, 1, 1)

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 10)
discordCorner.Parent = DiscordButton

-- أنيميشن زر الديسكورد
DiscordButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(DiscordButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
        Size = UDim2.new(1, -30, 0, 42)
    })
    tween:Play()
end)

DiscordButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(DiscordButton, tweenInfo, {
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.new(1, -40, 0, 40)
    })
    tween:Play()
end)

DiscordButton.MouseButton1Click:Connect(function()
    -- نسخ رابط الديسكورد
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/RSF9vjrFF")
            showNotification("✅ تم نسخ رابط الديسكورد: https://discord.gg/RSF9vjrFF", nil, false)
        end
    end)
end)

DiscordButton.Parent = RightsScrollFrame

-- تجميع العناصر
ScreenGui.Parent = CoreGui
ToggleButton.Parent = ScreenGui
MainFrame.Parent = ScreenGui
Title.Parent = MainFrame
TabsFrame.Parent = MainFrame
ContentFrame.Parent = MainFrame
VictimSection.Parent = ContentFrame
PlayerSection.Parent = ContentFrame
FeaturesSection.Parent = ContentFrame
SpamSection.Parent = ContentFrame
RightsSection.Parent = ContentFrame
VictimInfo.Parent = VictimSection
VictimAvatar.Parent = VictimInfo
VictimName.Parent = VictimInfo
VictimInfoText.Parent = VictimInfo
InputFrame.Parent = VictimSection
VictimInput.Parent = InputFrame
SetVictimButton.Parent = InputFrame
ScrollFrame.Parent = VictimSection
SpamScrollFrame.Parent = SpamSection
FeaturesScrollFrame.Parent = FeaturesSection
RightsScrollFrame.Parent = RightsSection

-- المتغيرات
local currentVictim = nil
local isSpectating = false
local originalCameraSubject = workspace.CurrentCamera.CameraSubject

-- متغيرات الأزرار الجديدة
local bangActive = false
local bangFrontActive = false

local bangConnection = nil
local bangFrontConnection = nil

local bangTargetPlayer = nil
local bangFrontTargetPlayer = nil

-- متغيرات لتتبع حالة الأزرار عند خروج الضحية
local bangWasActive = false
local bangFrontWasActive = false
local headSuckWasActive = false
local autoButtonsWasActive = {}

-- متغيرات زر بانق بالراس الجديد
local headSucking = false
local headSuckAnimTrack = nil
local headSuckConnection = nil
local headSuckTargetPlayer = nil
local headSuckCurrentDistance = 1.5
local headSuckMovingIn = true
local headSuckMovementSpeed = 0.5
local headSuckMinDistance = 0.5
local headSuckMaxDistance = 2.5

-- متغيرات الأزرار التلقائية الجديدة (مصححة)
local autoButtonsActive = {}
local autoButtonsThreads = {}

-- متغيرات السبام الجديدة
local fastSpamActive = false
local fastSpamThread = nil

-- قائمة الأسماء المحمية المحدثة
local protectedUsernames = {
    "sj3zx",
"fzd_20",
"fzd_200",
"sj3zxx", 
"sj3zxxx",
"1il5i",
"1il5f",
"eyad51533",
"awr_9351156",
"TM_704",
"DDO09793",
"KWT_20082",
"nanMrNoHackk",
"sj3zx"
}

-- وظيفة البحث عن لاعب محسنة
local function findPlayerByPartialName(partialName)
    local matches = {}
    partialName = partialName:lower()
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer.Name:lower() == partialName then
            return targetPlayer -- تطابق كامل
        elseif targetPlayer.DisplayName:lower() == partialName then
            return targetPlayer -- تطابق كامل للاسم المعروض
        end
    end
    
    -- إذا لم يكن هناك تطابق كامل، ابحث عن تطابق جزئي
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer.Name:lower():sub(1, #partialName) == partialName or 
           targetPlayer.DisplayName:lower():sub(1, #partialName) == partialName then
            table.insert(matches, targetPlayer)
        end
    end
    
    if #matches == 1 then
        return matches[1]
    elseif #matches > 1 then
        return nil -- أكثر من لاعب متطابق
    else
        return nil -- لا يوجد تطابق
    end
end

-- =============================================
-- الوظائف الجديدة المطلوبة
-- =============================================

-- وظيفة الحصول على عمر الحساب
local function getAccountAge(userId)
    local success, result = pcall(function()
        return game:GetService("Players"):GetPlayerByUserId(userId).AccountAge
    end)
    
    if success and result then
        local days = result
        local years = math.floor(days / 365)
        local months = math.floor((days % 365) / 30)
        local remainingDays = days % 30
        
        return years, months, remainingDays
    end
    
    return 0, 0, 0
end

-- وظيفة الحصول على أدوات الضحية
local function getVictimTools(victimPlayer)
    local tools = {}
    
    if victimPlayer and victimPlayer.Character then
        -- البحث في الظهر (Backpack)
        local backpack = victimPlayer:FindFirstChildOfClass("Backpack")
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool.Name)
                end
            end
        end
        
        -- البحث في الشخصية
        for _, tool in ipairs(victimPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(tools, tool.Name)
            end
        end
    end
    
    return tools
end

-- وظيفة تحويل قائمة الأدوات إلى نص
local function formatToolsList(tools)
    if #tools == 0 then
        return "لا يوجد أدوات"
    elseif #tools <= 3 then
        return table.concat(tools, ", ")
    else
        return table.concat(tools, ", ", 1, 3) .. " +" .. (#tools - 3)
    end
end

-- وظيفة تحديث معلومات الضحية المحسنة
local function updateVictimInfo(victimPlayer)
    if victimPlayer then
        VictimName.Text = "الضحية: " .. victimPlayer.Name
        
        -- تحديث الصورة
        pcall(function()
            VictimAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. victimPlayer.UserId .. "&width=150&height=150&format=png"
        end)
        
        -- تحديث المعلومات الإضافية
        local displayName = victimPlayer.DisplayName
        local userId = victimPlayer.UserId
        
        -- الحصول على عمر الحساب
        local years, months, days = getAccountAge(victimPlayer.UserId)
        local accountAgeText = ""
        
        if years > 0 then
            accountAgeText = years .. " سنة " .. months .. " شهر " .. days .. " يوم"
        elseif months > 0 then
            accountAgeText = months .. " شهر " .. days .. " يوم"
        else
            accountAgeText = days .. " يوم"
        end
        
        -- الحصول على الأدوات
        local tools = getVictimTools(victimPlayer)
        local toolsText = formatToolsList(tools)
        
        -- تحديث النص في إطار المعلومات
        VictimInfoText.Text = "اللقب: " .. displayName .. 
                             "\nعمر الحساب: " .. accountAgeText ..
                             "\nID: " .. userId ..
                             "\nالأدوات: " .. toolsText
        
        currentVictim = victimPlayer.Name
        lastVictim = victimPlayer.Name
        
        -- إشعار تحديد الضحية
        showNotification("✅ تم تحديد الضحية: " .. victimPlayer.Name, {
            Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. victimPlayer.UserId .. "&width=150&height=150&format=png"
        }, false)
    else
        VictimName.Text = "لا يوجد ضحية محددة"
        VictimAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        VictimInfoText.Text = "اللقب: -\nعمر الحساب: -\nID: -\nالأدوات: -"
        currentVictim = nil
    end
end

-- =============================================
-- تعديل شريط التمرير للأزرار
-- =============================================

-- تحديث حجم CanvasSize لشريط التمرير بناءً على عدد الأزرار
local function updateScrollFrameSize()
    local buttonCount = #victimButtons
    local rows = math.ceil(buttonCount / 4) -- 4 أزرار في كل صف
    local height = rows * 35 + (rows - 1) * 5 + 10 -- ارتفاع الأزرار + المسافات + هامش
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, height)
end

-- استدعاء الدالة لتحديد حجم شريط التمرير بعد إنشاء جميع الأزرار
task.defer(updateScrollFrameSize)

-- =============================================
-- وظائف الزرين الجديدين: تجميد بالكلبشه وسحب بالكلبشه
-- =============================================

-- وظيفة تجميد بالكلبشه
local function executeFreezeCuff()
    if not currentVictim then
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
        return
    end

    local targetName = currentVictim

    -- الكلمات اللي تدل على الكلبشة بأي اسم
    local keyWords = {"كلب", "cuff", "hand", "cuff", "arrest", "كلبشه", "كلبشة"}

    -- دالة تتحقق هل الأداة كلبشة
    local function isCuff(tool)
        local name = tool.Name:lower()
        for _, word in ipairs(keyWords) do
            if string.find(name, word:lower()) then
                return true
            end
        end
        return false
    end

    -- الحصول على جميع الكلبشات
    local function getAllCuffs()
        local cuffs = {}

        -- من الشنطة
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and isCuff(item) then
                table.insert(cuffs, item)
            end
        end

        -- من اليد
        if player.Character then
            for _, item in ipairs(player.Character:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
        end

        return cuffs
    end

    -- اختيار كلبشة عشوائية
    local function getRandomCuff()
        local cuffs = getAllCuffs()
        if #cuffs == 0 then return nil end
        return cuffs[math.random(1, #cuffs)]
    end

    -- الحصول على الهدف
    local target = Players:FindFirstChild(targetName)
    if not target or not target.Character then 
        showNotification("❌ الضحية غير موجود أو ليس لها شخصية", nil, false)
        return 
    end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then 
        showNotification("❌ الضحية لا تملك HumanoidRootPart", nil, false)
        return 
    end

    -- اختيار كلبشة من الموجودة
    local cuff = getRandomCuff()
    if not cuff then 
        showNotification("❌ لا توجد كلبشات في حوزتك", nil, false)
        return 
    end

    -- equip
    cuff.Parent = player.Character

    -- محاولة العثور على أي RemoteEvent داخل الأداة لتفعيل الكلبشة
    local remote
    for _, obj in ipairs(cuff:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            remote = obj
            break
        end
    end

    if remote then
        remote:FireServer(targetHRP)
        
        -- الانتظار ربع ثانية ثم إرجاع الكلبشة للشنطة
        task.wait(0.25)
        if cuff and cuff.Parent == player.Character then
            cuff.Parent = player.Backpack
        end
    else
        showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
    end
end

-- وظيفة سحب بالكلبشه (تم التعديل بإضافة تأخير نصف ثانية بين التنفيذين)
local function executePullCuff()
    if not currentVictim then
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
        return
    end

    local targetName = currentVictim

    -- الكلمات اللي تدل على الكلبشة بأي اسم
    local keyWords = {"كلب", "cuff", "hand", "cuff", "arrest", "كلبشه", "كلبشة"}

    -- دالة تتحقق هل الأداة كلبشة
    local function isCuff(tool)
        local name = tool.Name:lower()
        for _, word in ipairs(keyWords) do
            if string.find(name, word:lower()) then
                return true
            end
        end
        return false
    end

    -- الحصول على جميع الكلبشات
    local function getAllCuffs()
        local cuffs = {}

        -- من الشنطة
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and isCuff(item) then
                table.insert(cuffs, item)
            end
        end

        -- من اليد
        if player.Character then
            for _, item in ipairs(player.Character:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
        end

        return cuffs
    end

    -- اختيار كلبشة عشوائية
    local function getRandomCuff()
        local cuffs = getAllCuffs()
        if #cuffs == 0 then return nil end
        return cuffs[math.random(1, #cuffs)]
    end

    -- الحصول على الهدف
    local target = Players:FindFirstChild(targetName)
    if not target or not target.Character then 
        showNotification("❌ الضحية غير موجود أو ليس لها شخصية", nil, false)
        return 
    end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then 
        showNotification("❌ الضحية لا تملك HumanoidRootPart", nil, false)
        return 
    end

    -- اختيار كلبشة من الموجودة
    local cuff = getRandomCuff()
    if not cuff then 
        showNotification("❌ لا توجد كلبشات في حوزتك", nil, false)
        return 
    end

    -- equip
    cuff.Parent = player.Character

    -- محاولة العثور على أي RemoteEvent داخل الأداة لتفعيل الكلبشة
    local remote
    for _, obj in ipairs(cuff:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            remote = obj
            break
        end
    end

    if remote then
        -- التنفيذ الأول
        remote:FireServer(targetHRP)
        
        -- الانتظار نصف ثانية (0.5 ثانية)
        task.wait(0.5)
        
        -- التنفيذ الثاني بعد التأخير
        remote:FireServer(targetHRP)
        
        -- الانتظار ربع ثانية ثم إرجاع الكلبشة للشنطة
        task.wait(0.25)
        if cuff and cuff.Parent == player.Character then
            cuff.Parent = player.Backpack
        end
    else
        showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
    end
end

-- =============================================
-- وظيفة الزر الجديد: تعليق بالكلبشه (تم التعديل بإضافة تأخير ربع ثانية بين كل أمر)
-- =============================================
local function executeSuspendCuff()
    if not currentVictim then
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
        return
    end

    local targetName = currentVictim

    -- الكلمات اللي تدل على الكلبشة بأي اسم
    local keyWords = {"كلب", "cuff", "hand", "cuff", "arrest", "كلبشه", "كلبشة"}

    -- دالة تتحقق هل الأداة كلبشة
    local function isCuff(tool)
        local name = tool.Name:lower()
        for _, word in ipairs(keyWords) do
            if string.find(name, word:lower()) then
                return true
            end
        end
        return false
    end

    -- الحصول على جميع الكلبشات
    local function getAllCuffs()
        local cuffs = {}

        -- من الشنطة
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and isCuff(item) then
                table.insert(cuffs, item)
            end
        end

        -- من اليد
        if player.Character then
            for _, item in ipairs(player.Character:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
        end

        return cuffs
    end

    -- اختيار كلبشة عشوائية
    local function getRandomCuff()
        local cuffs = getAllCuffs()
        if #cuffs == 0 then return nil end
        return cuffs[math.random(1, #cuffs)]
    end

    -- الحصول على الهدف
    local target = Players:FindFirstChild(targetName)
    if not target or not target.Character then 
        showNotification("❌ الضحية غير موجود أو ليس لها شخصية", nil, false)
        return 
    end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then 
        showNotification("❌ الضحية لا تملك HumanoidRootPart", nil, false)
        return 
    end

    -- اختيار كلبشة من الموجودة
    local cuff = getRandomCuff()
    if not cuff then 
        showNotification("❌ لا توجد كلبشات في حوزتك", nil, false)
        return 
    end

    -- equip
    cuff.Parent = player.Character

    -- محاولة العثور على أي RemoteEvent داخل الأداة لتفعيل الكلبشة
    local remote
    for _, obj in ipairs(cuff:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            remote = obj
            break
        end
    end

    if remote then
        -- التنفيذ الأول: تفعيل الكلبشة
        remote:FireServer(targetHRP)
        
        -- الانتظار ربع ثانية (0.25 ثانية)
        task.wait(0.25)
        
        -- التنفيذ الثاني: أمر char
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
        if RequestCommandSilent then
            RequestCommandSilent:InvokeServer(".char ")
        end
        
        -- الانتظار ربع ثانية (0.25 ثانية)
        task.wait(0.25)
        
        -- التنفيذ الثالث: أمر unchar
        if RequestCommandSilent then
            RequestCommandSilent:InvokeServer(".unchar ")
        end
        
        -- الانتظار ربع ثانية ثم إرجاع الكلبشة للشنطة
        task.wait(0.25)
        if cuff and cuff.Parent == player.Character then
            cuff.Parent = player.Backpack
        end
    else
        showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
    end
end

-- =============================================
-- باقي الوظائف والأكواد الأصلية
-- =============================================

-- وظيفة تنفيذ الأمر الأساسية
local function executeCommand(command)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HDAdminHDClient = ReplicatedStorage:FindFirstChild("HDAdminHDClient")
    
    if HDAdminHDClient then
        local Signals = HDAdminHDClient:FindFirstChild("Signals")
        if Signals then
            local RequestCommandSilent = Signals:FindFirstChild("RequestCommandSilent")
            if RequestCommandSilent then
                pcall(function()
                    RequestCommandSilent:InvokeServer(command)
                end)
            end
        end
    end
end

-- وظائف تنفيذ الأوامر المعدلة (تستخدم currentVictim بدلاً من sj3zxx)
local function executeSuspendFlyCommand()
    if currentVictim then
        executeCommand(".fly " .. currentVictim .. " 10. ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUnsuspendFlyCommand()
    if currentVictim then
        executeCommand(".fly " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- وظائف تنفيذ الأوامر للزر الجديدة
local function executePhaseCommand()
    if currentVictim then
        executeCommand(".phase " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeCharCommand()
    if currentVictim then
        executeCommand(".char " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUncharCommand()
    if currentVictim then
        executeCommand(".unchar " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUndogCommand()
    if currentVictim then
        executeCommand(".undog " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUnneonCommand()
    if currentVictim then
        executeCommand(".unneon " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUnwormifyCommand()
    if currentVictim then
        executeCommand(".unwormify " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- وظائف تنفيذ الأوامر الأساسية
local function executeVictimCommand(command)
    if currentVictim then
        executeCommand(command .. " " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeColorCommand(color)
    if currentVictim then
        executeCommand(".colour " .. currentVictim .. " " .. color .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeFlyCommand(speed)
    if currentVictim then
        executeCommand(".fly " .. currentVictim .. " " .. speed .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeSpeedCommand(speed)
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " " .. speed .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeSizeCommand(size)
    if currentVictim then
        executeCommand(".size " .. currentVictim .. " " .. size .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeCharSkinCommand(char)
    if currentVictim then
        executeCommand(".char " .. currentVictim .. " " .. char .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- وظائف الأزرار الجديدة المطلوبة
local function executeWhiteCommand()
    if currentVictim then
        executeCommand(".color " .. currentVictim .. " White ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeSuspendFCommand()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUnsuspendFCommand()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. "  .unjp " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeSuspendJumpCommand()
    if currentVictim then
        executeCommand(".jp  " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeUnsuspendJumpCommand()
    if currentVictim then
        executeCommand(".unjp  " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeFlyInAirCommand()
    if currentVictim then
        executeCommand(".jp " .. currentVictim .. " 999999999999999999999999999999 .jump " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeStopAllCommand()
    if currentVictim then
        executeCommand(".unwormify " .. currentVictim .. "  .undog " .. currentVictim .. "  .unneon " .. currentVictim .. "  .unchar " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

local function executeCrippleCommand()
    if currentVictim then
        executeCommand(".sit  " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- وظائف الأزرار التلقائية الجديدة المعدلة الأوقات
local function toggleAutoButton(buttonType, commandFunction, interval)
    if autoButtonsActive[buttonType] then
        -- إيقاف الزر التلقائي
        autoButtonsActive[buttonType] = false
        if autoButtonsThreads[buttonType] then
            autoButtonsThreads[buttonType] = nil
        end
        
        if buttonInstances[buttonType] then
            buttonInstances[buttonType].Text = string.gsub(buttonInstances[buttonType].Text, " ✅", "")
            buttonInstances[buttonType].BackgroundColor3 = Color3.new(0, 0, 0)
        end
    else
        -- تشغيل الزر التلقائي
        autoButtonsActive[buttonType] = true
        if buttonInstances[buttonType] then
            buttonInstances[buttonType].Text = buttonInstances[buttonType].Text .. " ✅"
            buttonInstances[buttonType].BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
        
        -- بدء التنفيذ التلقائي (مصحح تماماً)
        autoButtonsThreads[buttonType] = coroutine.wrap(function()
            while autoButtonsActive[buttonType] and currentVictim do
                commandFunction()
                task.wait(interval) -- الوقت الحقيقي المطلوب
            end
        end)()
    end
end

-- وظيفة المشاهدة (تفعيل/إلغاء) - معدلة
local function toggleSpectate()
    if currentVictim and not isSpectating then
        local victimPlayer = findPlayerByPartialName(currentVictim)
        if victimPlayer and victimPlayer.Character then
            originalCameraSubject = workspace.CurrentCamera.CameraSubject
            workspace.CurrentCamera.CameraSubject = victimPlayer.Character:FindFirstChild("Humanoid")
            isSpectating = true
            buttonInstances["spectate"].Text = "إلغاء المشاهدة"
        end
    else
        workspace.CurrentCamera.CameraSubject = originalCameraSubject
        isSpectating = false
        buttonInstances["spectate"].Text = "مشاهدة"
    end
end

-- وظيفة الانتقال
local function teleportToPlayer()
    if currentVictim then
        local victimPlayer = findPlayerByPartialName(currentVictim)
        if victimPlayer and victimPlayer.Character then
            local humanoid = victimPlayer.Character:FindFirstChild("Humanoid")
            local rootPart = victimPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart then
                local localChar = player.Character
                if localChar then
                    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
                    if localRoot then
                        localRoot.CFrame = rootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end
        end
    end
end

-- وظائف الأزرار الجديدة المعدلة
-- زر بانق
local function playBangAnimation()
    local character = player.Character
    if not character then return nil end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return nil end

    -- إيقاف كل الأنميشنات القديمة
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://10714068222"
    local animTrack = humanoid:LoadAnimation(animation)
    animTrack.Looped = true
    animTrack:Play()
    animTrack:AdjustSpeed(2000)
    return animTrack
end

local function startBang()
    if not currentVictim then
        return
    end
    
    local targetPlayer = findPlayerByPartialName(currentVictim)
    if not targetPlayer then
        return
    end
    
    bangActive = true
    bangTargetPlayer = targetPlayer
    
    local currentAnimTrack = playBangAnimation()
    
    bangConnection = RunService.Heartbeat:Connect(function()
        if bangActive and bangTargetPlayer and bangTargetPlayer.Character then
            local targetHRP = bangTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local playerHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and playerHRP then
                local distance = 1
                playerHRP.CFrame = CFrame.new(targetHRP.Position + targetHRP.CFrame.LookVector * -distance, targetHRP.Position)
            end
            
            -- إعادة الأنميشن إذا فقدناها
            if not currentAnimTrack or not currentAnimTrack.IsPlaying then
                currentAnimTrack = playBangAnimation()
            end
        end
    end)
    
    buttonInstances["bang"].Text = "بانق ✅"
    buttonInstances["bang"].BackgroundColor3 = Color3.new(0, 0.5, 0)
end

local function stopBang()
    bangActive = false
    bangTargetPlayer = nil
    
    if bangConnection then
        bangConnection:Disconnect()
        bangConnection = nil
    end

    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end
    
    buttonInstances["bang"].Text = "بانق"
    buttonInstances["bang"].BackgroundColor3 = Color3.new(0, 0, 0)
end

local function toggleBang()
    if bangActive then
        stopBang()
    else
        startBang()
    end
end

-- زر بانق من الامام
local bangFrontFollowing = false
local bangFrontCurrentAnimTrack = nil

local function playBangFrontAnimation()
    local character = player.Character
    if not character then return nil end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return nil end
    
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://10714068222"
    local ok, animTrack = pcall(function()
        return humanoid:LoadAnimation(animation)
    end)
    
    if not ok or not animTrack then
        return nil
    end
    
    animTrack.Looped = true
    animTrack:Play()
    pcall(function() animTrack:AdjustSpeed(2000) end)
    return animTrack
end

local function applyBangFrontFollowStep(targetHRP, playerHRP)
    local forward = targetHRP.CFrame.LookVector
    local newPos = targetHRP.Position + forward * 1
    playerHRP.CFrame = CFrame.new(newPos, targetHRP.Position)
end

local function startBangFront()
    if not currentVictim then
        return
    end
    
    local targetPlayer = findPlayerByPartialName(currentVictim)
    if not targetPlayer then
        return
    end
    
    bangFrontTargetPlayer = targetPlayer
    bangFrontFollowing = true
    
    local currentAnimTrack = playBangFrontAnimation()
    bangFrontCurrentAnimTrack = currentAnimTrack

    if bangFrontConnection then
        bangFrontConnection:Disconnect()
        bangFrontConnection = nil
    end

    bangFrontConnection = RunService.Heartbeat:Connect(function()
        if bangFrontFollowing and bangFrontTargetPlayer and bangFrontTargetPlayer.Character then
            local targetHRP = bangFrontTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local playerHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and playerHRP then
                applyBangFrontFollowStep(targetHRP, playerHRP)
            end
            
            -- إعادة الأنميشن إذا فقدناها
            if not currentAnimTrack or not currentAnimTrack.IsPlaying then
                currentAnimTrack = playBangFrontAnimation()
                bangFrontCurrentAnimTrack = currentAnimTrack
            end
        end
    end)
    
    buttonInstances["bangFront"].Text = "بانق من الامام ✅"
    buttonInstances["bangFront"].BackgroundColor3 = Color3.new(0, 0.5, 0)
end

local function stopBangFront()
    bangFrontFollowing = false
    bangFrontTargetPlayer = nil
    
    if bangFrontConnection then
        bangFrontConnection:Disconnect()
        bangFrontConnection = nil
    end
    
    if bangFrontCurrentAnimTrack then
        bangFrontCurrentAnimTrack:Stop()
        bangFrontCurrentAnimTrack = nil
    end
    
    buttonInstances["bangFront"].Text = "بانق من الامام"
    buttonInstances["bangFront"].BackgroundColor3 = Color3.new(0, 0, 0)
end

local function toggleBangFront()
    if bangFrontFollowing then
        stopBangFront()
    else
        startBangFront()
    end
end

-- وظيفة زر بانق بالراس الجديد
local function updateHeadSuck()
    while headSucking do
        local localChar = game.Players.LocalPlayer.Character
        if not localChar then
            game:GetService("RunService").Heartbeat:Wait()
            continue
        end

        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid and headSucking then
            humanoid.Sit = true
            if not headSuckAnimTrack then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://2506281703"
                headSuckAnimTrack = humanoid:LoadAnimation(animation)
                headSuckAnimTrack:Play()
                headSuckAnimTrack:AdjustSpeed(1.5)
            end
        end

        if headSuckTargetPlayer and headSuckTargetPlayer.Character then
            local humanoidRootPart = localChar:FindFirstChild("HumanoidRootPart")
            local targetHead = headSuckTargetPlayer.Character:FindFirstChild("Head")
            if humanoidRootPart and targetHead then
                if headSuckMovingIn then
                    headSuckCurrentDistance = headSuckCurrentDistance - headSuckMovementSpeed
                    if headSuckCurrentDistance <= headSuckMinDistance then 
                        headSuckMovingIn = false 
                    end
                else
                    headSuckCurrentDistance = headSuckCurrentDistance + headSuckMovementSpeed
                    if headSuckCurrentDistance >= headSuckMaxDistance then 
                        headSuckMovingIn = true 
                    end
                end
                local faceDirection = targetHead.CFrame.LookVector
                local targetPosition = targetHead.Position + (faceDirection * headSuckCurrentDistance)
                targetPosition = Vector3.new(targetPosition.X, targetHead.Position.Y, targetPosition.Z)
                humanoidRootPart.CFrame = CFrame.new(targetPosition, targetHead.Position)
                humanoidRootPart.Velocity = Vector3.new(0, 2, 0)
            end
        end

        game:GetService("RunService").Heartbeat:Wait()
    end

    local localChar = game.Players.LocalPlayer.Character
    if localChar then
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then 
            humanoid.Sit = false 
        end
    end
    if headSuckAnimTrack then 
        headSuckAnimTrack:Stop() 
        headSuckAnimTrack = nil 
    end
end

local function startHeadSuck(target)
    headSuckTargetPlayer = target
    headSucking = true
    spawn(updateHeadSuck)
    
    buttonInstances["headSuck"].Text = "بانق بالراس ✅"
    buttonInstances["headSuck"].BackgroundColor3 = Color3.new(0, 0.5, 0)
end

local function stopHeadSuck()
    headSucking = false
    headSuckTargetPlayer = nil
    
    buttonInstances["headSuck"].Text = "بانق بالراس"
    buttonInstances["headSuck"].BackgroundColor3 = Color3.new(0, 0, 0)
end

local function toggleHeadSuck()
    if headSucking then
        stopHeadSuck()
    else
        if currentVictim then
            local targetPlayer = findPlayerByPartialName(currentVictim)
            if targetPlayer then
                startHeadSuck(targetPlayer)
            end
        end
    end
end

-- =============================================
-- الزرين الجديدين المطلوبين
-- =============================================

-- متغيرات زر حقيبة في الظهر
local backpackSitActive = false
local backpackSitConnection = nil

-- متغيرات زر جلوس على الراس
local headSitActive = false
local headSitConnection = nil
local headSitVelocity = nil

-- وظيفة زر حقيبة في الظهر
local function toggleBackpackSit()
    if backpackSitActive then
        -- إيقاف حقيبة في الظهر
        backpackSitActive = false
        if backpackSitConnection then
            backpackSitConnection:Disconnect()
            backpackSitConnection = nil
        end
        
        -- إعادة اللاعب إلى وضعه الطبيعي
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Sit = false
        end
        
        buttonInstances["backpackSit"].Text = "حقيبه في الظهر"
        buttonInstances["backpackSit"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        if not currentVictim then
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
            return
        end
        
        local targetPlayer = Players:FindFirstChild(currentVictim)
        if not targetPlayer then
            showNotification("❌ الضحية غير موجود", nil, false)
            return
        end
        
        backpackSitActive = true
        buttonInstances["backpackSit"].Text = "حقيبه في الظهر ✅"
        buttonInstances["backpackSit"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- بدء نظام حقيبة في الظهر
        backpackSitConnection = RunService.Heartbeat:Connect(function()
            if backpackSitActive and targetPlayer and targetPlayer.Character and player.Character then
                local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local playerHumanoid = player.Character:FindFirstChild("Humanoid")
                
                if targetRoot and playerRoot and playerHumanoid then
                    -- جعل اللاعب يجلس
                    playerHumanoid.Sit = true
                    
                    -- وضع اللاعب خلف الضحية
                    playerRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1.2) * CFrame.Angles(0, math.rad(180), 0)
                    
                    -- إيقاف الحركة
                    playerRoot.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end
end

-- وظيفة زر جلوس على الراس
local function toggleHeadSit()
    if headSitActive then
        -- إيقاف جلوس على الراس
        headSitActive = false
        if headSitConnection then
            headSitConnection:Disconnect()
            headSitConnection = nil
        end
        
        -- إزالة BodyVelocity
        if headSitVelocity then
            headSitVelocity:Destroy()
            headSitVelocity = nil
        end
        
        -- إعادة اللاعب إلى وضعه الطبيعي
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Sit = false
        end
        
        buttonInstances["headSit"].Text = "جلوس على الراس"
        buttonInstances["headSit"].BackgroundColor3 = Color3.new(0, 0, 0)
    else
        if not currentVictim then
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
            return
        end
        
        local targetPlayer = Players:FindFirstChild(currentVictim)
        if not targetPlayer then
            showNotification("❌ الضحية غير موجود", nil, false)
            return
        end
        
        headSitActive = true
        buttonInstances["headSit"].Text = "جلوس على الراس ✅"
        buttonInstances["headSit"].BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- إنشاء BodyVelocity لمنع الحركة
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            if not root:FindFirstChild("BreakVelocity") then
                headSitVelocity = Instance.new("BodyVelocity")
                headSitVelocity.Name = "BreakVelocity"
                headSitVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                headSitVelocity.Velocity = Vector3.new(0, 0, 0)
                headSitVelocity.Parent = root
            end
        end
        
        -- بدء نظام جلوس على الراس
        headSitConnection = RunService.Heartbeat:Connect(function()
            if headSitActive and targetPlayer and targetPlayer.Character and player.Character then
                local targetHead = targetPlayer.Character:FindFirstChild("Head")
                local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local playerHumanoid = player.Character:FindFirstChild("Humanoid")
                
                if targetHead and playerRoot and playerHumanoid then
                    -- جعل اللاعب يجلس
                    playerHumanoid.Sit = true
                    
                    -- وضع اللاعب فوق رأس الضحية
                    playerRoot.CFrame = targetHead.CFrame * CFrame.new(0, 2, 0)
                    
                    -- إيقاف الحركة
                    playerRoot.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end
end

-- وظيفة الطائرة
local function executePlaneCommand()
    if currentVictim then
        executeCommand(".plane " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- وظيفة سكن وحش 2
local function executeFreakifyCommand()
    if currentVictim then
        executeCommand(".freakify " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end

-- إعادة التفعيل التلقائي عند عودة الضحية
local function restartActiveEffects()
    if bangWasActive and currentVictim then
        startBang()
    end
    
    if bangFrontWasActive and currentVictim then
        startBangFront()
    end
    
    if headSuckWasActive and currentVictim then
        local targetPlayer = findPlayerByPartialName(currentVictim)
        if targetPlayer then
            startHeadSuck(targetPlayer)
        end
    end
    
    -- إعادة تفعيل الأزرار التلقائية
    for buttonType, wasActive in pairs(autoButtonsWasActive) do
        if wasActive and not autoButtonsActive[buttonType] then
            if buttonInstances[buttonType] then
                buttonInstances[buttonType]:MouseButton1Click()
            end
        end
    end
end

-- إعادة الأنميشن عند الرسبون
player.CharacterAdded:Connect(function()
    task.wait(1) -- انتظار تحميل الشخصية
    
    if bangActive then
        playBangAnimation()
    end
    
    if bangFrontFollowing then
        playBangFrontAnimation()
    end
    
    if headSucking then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://2506281703"
        headSuckAnimTrack = player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(animation)
        headSuckAnimTrack:Play()
        headSuckAnimTrack:AdjustSpeed(1.5)
    end
end)

-- =============================================
-- الوظائف الجديدة للسبام المخصص
-- =============================================

-- وظيفة الإرسال العادي
local function sendCustomSpam()
    local message = CustomSpamInput.Text
    if message ~= "" then
        local args = {
            message
        }
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
        end)
    else
        showNotification("❌ اكتب شيئاً في حقل السبام", nil, false)
    end
end

-- وظيفة السبام السريع
local function toggleFastSpam()
    if fastSpamActive then
        -- إيقاف السبام السريع
        fastSpamActive = false
        if fastSpamThread then
            fastSpamThread = nil
        end
        
        FastSpamButton.Text = "سبام سريع"
        FastSpamButton.BackgroundColor3 = Color3.new(0, 0, 0)
    else
        -- تشغيل السبام السريع
        local message = CustomSpamInput.Text
        if message == "" then
            showNotification("❌ اكتب شيئاً في حقل السبام أولاً", nil, false)
            return
        end
        
        fastSpamActive = true
        FastSpamButton.Text = "سبام سريع ✅"
        FastSpamButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        
        -- بدء السبام السريع
        fastSpamThread = coroutine.wrap(function()
            while fastSpamActive do
                local args = {
                    message
                }
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
                end)
                task.wait(0.01) -- سرعة مجنونة
            end
        end)()
    end
end

-- توصيل أزرار السبام الجديدة
SendSpamButton.MouseButton1Click:Connect(sendCustomSpam)
FastSpamButton.MouseButton1Click:Connect(toggleFastSpam)

-- نظام التبديل بين الأقسام
local function showSection(sectionName)
    VictimSection.Visible = (sectionName == "الضحيه")
    PlayerSection.Visible = (sectionName == "اللاعب")
    FeaturesSection.Visible = (sectionName == "المميزات")
    SpamSection.Visible = (sectionName == "سبام")
    RightsSection.Visible = (sectionName == "الحقوق")
    
    -- تحديث ألوان أزرار الأقسام
    VictimTab.BackgroundColor3 = (sectionName == "الضحيه") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    PlayerTab.BackgroundColor3 = (sectionName == "اللاعب") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    FeaturesTab.BackgroundColor3 = (sectionName == "المميزات") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    SpamTab.BackgroundColor3 = (sectionName == "سبام") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    RightsTab.BackgroundColor3 = (sectionName == "الحقوق") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
end

-- وظيفة إخفاء/إظهار القائمة الرئيسية مع الأنيميشن (تم التعديل)
local function toggleMainGUI()
    if MainFrame.Visible then
        -- إخفاء القائمة مع الأنيميشن
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tween:Play()
        
        -- أنيميشن زر التفعيل عند الإغلاق
        local buttonTween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.new(0, 0, 0),
            Rotation = 0
        })
        buttonTween:Play()
        
        task.wait(0.5)
        MainFrame.Visible = false
    else
        -- إظهار القائمة مع الأنيميشن
        MainFrame.Visible = true
        
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        local tweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 500, 0, 350),
            Position = UDim2.new(0.5, -250, 0.5, -175)
        })
        tween:Play()
        
        -- أنيميشن زر التفعيل عند الفتح
        local buttonTween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
            Rotation = 360
        })
        buttonTween:Play()
    end
end

-- إصلاح زر التفعيل
ToggleButton.MouseButton1Click:Connect(toggleMainGUI)

-- أحداث أزرار الأقسام
VictimTab.MouseButton1Click:Connect(function() showSection("الضحيه") end)
PlayerTab.MouseButton1Click:Connect(function() showSection("اللاعب") end)
FeaturesTab.MouseButton1Click:Connect(function() showSection("المميزات") end)
SpamTab.MouseButton1Click:Connect(function() showSection("سبام") end)
RightsTab.MouseButton1Click:Connect(function() showSection("الحقوق") end)

-- تحديد الضحية مع الحماية المحدثة
SetVictimButton.MouseButton1Click:Connect(function()
    local username = VictimInput.Text
    if username ~= "" then
        if #username >= 3 then
            -- التحقق من الأسماء المحمية المحدثة
            local isProtected = false
            for _, protectedName in ipairs(protectedUsernames) do
                if username:lower() == protectedName:lower() then
                    isProtected = true
                    break
                end
            end
            
            if isProtected then
                showNotification("❌ هذا المستخدم محمي ولا يمكن تحديده", nil, false)
                return
            end
            
            local victimPlayer = findPlayerByPartialName(username)
            if victimPlayer then
                -- التحقق مرة أخرى من الأسماء المحمية (في حالة البحث الجزئي)
                local victimUsername = victimPlayer.Name:lower()
                for _, protectedName in ipairs(protectedUsernames) do
                    if victimUsername == protectedName:lower() then
                        showNotification("❌ هذا المستخدم محمي ولا يمكن تحديده", nil, false)
                        return
                    end
                end
                
                updateVictimInfo(victimPlayer)
                VictimInput.Text = ""
            else
                showNotification("❌ لم يتم العثور على اللاعب: " .. username, nil, false)
            end
        else
            showNotification("❌ أدخل 3 أحرف على الأقل", nil, false)
        end
    else
        showNotification("❌ أدخل اسم المستخدم", nil, false)
    end
end)

-- توصيل جميع أزرار الضحية حسب الترتيب الجديد
buttonInstances["spectate"].MouseButton1Click:Connect(toggleSpectate)
buttonInstances["teleport"].MouseButton1Click:Connect(teleportToPlayer)
buttonInstances["reset"].MouseButton1Click:Connect(function() executeVictimCommand(".re") end)
buttonInstances["to"].MouseButton1Click:Connect(function() executeVictimCommand(".to") end)
buttonInstances["bang"].MouseButton1Click:Connect(toggleBang)
buttonInstances["bangFront"].MouseButton1Click:Connect(toggleBangFront)
buttonInstances["headSuck"].MouseButton1Click:Connect(toggleHeadSuck)

-- توصيل الزرين الجديدين (تم التعديل على وظيفتي سحب بالكلبشه وتعليق بالكلبشه)
buttonInstances["freezeCuff"].MouseButton1Click:Connect(executeFreezeCuff)
buttonInstances["pullCuff"].MouseButton1Click:Connect(executePullCuff) -- تم التعديل بإضافة تأخير نصف ثانية
buttonInstances["suspendCuff"].MouseButton1Click:Connect(executeSuspendCuff) -- تم التعديل بإضافة تأخير ربع ثانية

-- توصيل الزرين الجديدين المطلوبين
buttonInstances["backpackSit"].MouseButton1Click:Connect(toggleBackpackSit)
buttonInstances["headSit"].MouseButton1Click:Connect(toggleHeadSit)

buttonInstances["autoReset"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoReset", function() executeVictimCommand(".re") end, 2)
end)
buttonInstances["undog"].MouseButton1Click:Connect(executeUndogCommand)
buttonInstances["unneon"].MouseButton1Click:Connect(executeUnneonCommand)
buttonInstances["unwormify"].MouseButton1Click:Connect(executeUnwormifyCommand)
buttonInstances["stopAll"].MouseButton1Click:Connect(executeStopAllCommand)
buttonInstances["autoStopAll"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoStopAll", executeStopAllCommand, 5)
end)
buttonInstances["cripple"].MouseButton1Click:Connect(executeCrippleCommand)
buttonInstances["autoCripple"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCripple", executeCrippleCommand, 2)
end)
buttonInstances["flyInAir"].MouseButton1Click:Connect(executeFlyInAirCommand)
buttonInstances["autoFlyInAir"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoFlyInAir", executeFlyInAirCommand, 3)
end)
buttonInstances["suspendF"].MouseButton1Click:Connect(executeSuspendFCommand)
buttonInstances["unsuspendF"].MouseButton1Click:Connect(executeUnsuspendFCommand)
buttonInstances["autoSuspendF"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoSuspendF", executeSuspendFCommand, 2)
end)
buttonInstances["suspendJump"].MouseButton1Click:Connect(executeSuspendJumpCommand)
buttonInstances["unsuspendJump"].MouseButton1Click:Connect(executeUnsuspendJumpCommand)
buttonInstances["autoJump"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoJump", function() executeVictimCommand(".jump") end, 2)
end)
buttonInstances["suspendFly"].MouseButton1Click:Connect(executeSuspendFlyCommand)
buttonInstances["unsuspendFly"].MouseButton1Click:Connect(executeUnsuspendFlyCommand)
buttonInstances["autoSuspendFly"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoSuspendFly", function()
        if currentVictim then
            executeCommand(".fly " .. currentVictim .. " 10. ")
        end
    end, 2)
end)
buttonInstances["unfly"].MouseButton1Click:Connect(function() executeVictimCommand(".unfly") end)
buttonInstances["dog"].MouseButton1Click:Connect(function() executeVictimCommand(".dog") end)
buttonInstances["autoDog"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoDog", function() executeVictimCommand(".dog") end, 2)
end)
buttonInstances["worm"].MouseButton1Click:Connect(function() executeVictimCommand(".worm") end)
buttonInstances["neon"].MouseButton1Click:Connect(function() executeVictimCommand(".neon") end)
buttonInstances["gold"].MouseButton1Click:Connect(function() executeVictimCommand(".gold") end)
buttonInstances["glass"].MouseButton1Click:Connect(function() executeVictimCommand(".glass") end)
buttonInstances["ref"].MouseButton1Click:Connect(function() executeVictimCommand(".ref") end)
buttonInstances["size3"].MouseButton1Click:Connect(function() executeSizeCommand("3") end)
buttonInstances["charCrazy"].MouseButton1Click:Connect(function() executeCharSkinCommand("crazydalejrd") end)
buttonInstances["charMiri"].MouseButton1Click:Connect(function() executeCharSkinCommand("miri") end)
buttonInstances["char"].MouseButton1Click:Connect(executeCharCommand)
buttonInstances["unchar"].MouseButton1Click:Connect(executeUncharCommand)
buttonInstances["shirt"].MouseButton1Click:Connect(function() executeVictimCommand(".shirt") end)
buttonInstances["pants"].MouseButton1Click:Connect(function() executeVictimCommand(".pants") end)
buttonInstances["head"].MouseButton1Click:Connect(function() executeVictimCommand(".head") end)
buttonInstances["giantDwarf"].MouseButton1Click:Connect(function() executeVictimCommand(".giantDwarf") end)
buttonInstances["black"].MouseButton1Click:Connect(function() executeColorCommand("Black") end)
buttonInstances["white"].MouseButton1Click:Connect(executeWhiteCommand)
buttonInstances["pink"].MouseButton1Click:Connect(function() executeColorCommand("pink") end)
buttonInstances["purple"].MouseButton1Click:Connect(function() executeColorCommand("Purple") end)
buttonInstances["blue"].MouseButton1Click:Connect(function() executeColorCommand("Blue") end)
buttonInstances["darkblue"].MouseButton1Click:Connect(function() executeColorCommand("DarkBlue") end)
buttonInstances["yellow"].MouseButton1Click:Connect(function() executeColorCommand("Yellow") end)
buttonInstances["orange"].MouseButton1Click:Connect(function() executeColorCommand("Orange") end)
buttonInstances["red"].MouseButton1Click:Connect(function() executeColorCommand("Red") end)
buttonInstances["green"].MouseButton1Click:Connect(function() executeColorCommand("Green") end)
buttonInstances["uncolour"].MouseButton1Click:Connect(function() executeVictimCommand(".uncolour") end)
buttonInstances["fryDance"].MouseButton1Click:Connect(function() executeVictimCommand(".fryDance") end)
buttonInstances["takethel"].MouseButton1Click:Connect(function() executeVictimCommand(".takethel") end)
buttonInstances["ratDance"].MouseButton1Click:Connect(function() executeVictimCommand(".ratDance") end)
buttonInstances["cuteSit"].MouseButton1Click:Connect(function() executeVictimCommand(".cuteSit") end)
buttonInstances["fakeDeath"].MouseButton1Click:Connect(function() executeVictimCommand(".fakeDeath") end)
buttonInstances["fat"].MouseButton1Click:Connect(function() executeVictimCommand(".fat") end)
buttonInstances["thin"].MouseButton1Click:Connect(function() executeVictimCommand(".thin") end)
buttonInstances["hide"].MouseButton1Click:Connect(function() executeVictimCommand(".hide") end)
buttonInstances["buffify"].MouseButton1Click:Connect(function() executeVictimCommand(".buffify") end)
buttonInstances["tank"].MouseButton1Click:Connect(function() executeVictimCommand(".tank") end)
buttonInstances["helicopter"].MouseButton1Click:Connect(function() executeVictimCommand(".helicopter") end)
buttonInstances["plane"].MouseButton1Click:Connect(executePlaneCommand)
buttonInstances["car"].MouseButton1Click:Connect(function() executeVictimCommand(".car") end)
buttonInstances["box"].MouseButton1Click:Connect(function() executeVictimCommand(".Box") end)
buttonInstances["emote"].MouseButton1Click:Connect(function() executeVictimCommand(".emote") end)
buttonInstances["phase"].MouseButton1Click:Connect(executePhaseCommand)
buttonInstances["aura"].MouseButton1Click:Connect(function() executeVictimCommand(".aura") end)
-- تم حذف زر ايقاف الدخان و ايقاف النار
buttonInstances["shine"].MouseButton1Click:Connect(function() executeVictimCommand(".shine") end)
buttonInstances["ghost"].MouseButton1Click:Connect(function() executeVictimCommand(".ghost") end)
buttonInstances["wormify"].MouseButton1Click:Connect(function() executeVictimCommand(".wormify") end)
buttonInstances["chibify"].MouseButton1Click:Connect(function() executeVictimCommand(".chibify") end)
buttonInstances["plushify"].MouseButton1Click:Connect(function() executeVictimCommand(".plushify") end)
buttonInstances["frogify"].MouseButton1Click:Connect(function() executeVictimCommand(".frogify") end)
buttonInstances["spongify"].MouseButton1Click:Connect(function() executeVictimCommand(".spongify") end)
buttonInstances["creepify"].MouseButton1Click:Connect(function() executeVictimCommand(".creepify") end)
buttonInstances["freakify"].MouseButton1Click:Connect(executeFreakifyCommand)
buttonInstances["dinofy"].MouseButton1Click:Connect(function() executeVictimCommand(".dinofy") end)
buttonInstances["fatify"].MouseButton1Click:Connect(function() executeVictimCommand(".fatify") end)
buttonInstances["bigify"].MouseButton1Click:Connect(function() executeVictimCommand(".bigify") end)

-- أزرار النسخ
buttonInstances["copy1"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".dog " .. currentVictim .. " .size " .. currentVictim .. " 3 .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy2"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".worm " .. currentVictim .. " .size " .. currentVictim .. " 3 .neon " .. currentVictim .. " .colour " .. currentVictim .. " Black ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy3"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".emote " .. currentVictim .. " .size " .. currentVictim .. " 3 .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy4"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".giantDwarf " .. currentVictim .. " .fat " .. currentVictim .. " .size " .. currentVictim .. " 3 .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy5"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".giantDwarf " .. currentVictim .. " .size " .. currentVictim .. " 3 .thin " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " O ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy6"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".emote " .. currentVictim .. " .shine " .. currentVictim .. " .colour " .. currentVictim .. " Pink .sit " .. currentVictim .. " .size " .. currentVictim .. " 3 ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy7"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".char " .. currentVictim .. " miri .dog " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy8"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".helicopter " .. currentVictim .. " .thin " .. currentVictim .. " .sit " .. currentVictim .. " .size " .. currentVictim .. " 3 .neon " .. currentVictim .. " .colour " .. currentVictim .. " Y ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy9"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".takethel " .. currentVictim .. " .sit " .. currentVictim .. " .size " .. currentVictim .. " 2 .pants " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .fat " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy10"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".takethel " .. currentVictim .. " .speed " .. currentVictim .. " 01. .sit " .. currentVictim .. " .size " .. currentVictim .. " 2 .pants " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .fat " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy11"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".emote " .. currentVictim .. " .size " .. currentVictim .. " 3 .thin " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P .speed " .. currentVictim .. " 01. ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy12"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".wormify " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .dog " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P .speed " .. currentVictim .. " 01. ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy13"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".creepify " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .dog " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P .speed " .. currentVictim .. " 01. ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy14"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".frogify " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " Black .fakeDeath " .. currentVictim .. " .speed " .. currentVictim .. " 01. ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy15"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".dinofy " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .dog " .. currentVictim .. " .sit " .. currentVictim .. " .speed " .. currentVictim .. " 01. .neon " .. currentVictim .. " ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy16"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .emote " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy17"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .neon " .. currentVictim .. "  .colour " .. currentVictim .. " B ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy18"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .spongify " .. currentVictim .. " .emote " .. currentVictim .. " .sit " .. currentVictim .. " .size " .. currentVictim .. " 3 ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy19"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .car " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .sit " .. currentVictim .. "  .colour " .. currentVictim .. " pink ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

buttonInstances["copy20"].MouseButton1Click:Connect(function()
    if currentVictim then
        executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .thin " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
    else
        showNotification("❌ لم يتم تحديد ضحية", nil, false)
    end
end)

-- أزرار النسخ التلقائي
buttonInstances["autoCopy1"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy1", function()
        if currentVictim then
            executeCommand(".wormify  " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .dog " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P .speed " .. currentVictim .. " 01. ")
        end
    end, 2)
end)

buttonInstances["autoCopy2"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy2", function()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .emote " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P ")
        end
    end, 2)
end)

buttonInstances["autoCopy3"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy3", function()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .neon " .. currentVictim .. "  .colour " .. currentVictim .. " B ")
        end
    end, 2)
end)

buttonInstances["autoCopy4"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy4", function()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .spongify " .. currentVictim .. " .emote " .. currentVictim .. " .sit " .. currentVictim .. " .size " .. currentVictim .. " 3 ")
        end
    end, 2)
end)

buttonInstances["autoCopy5"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy5", function()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .car " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .sit " .. currentVictim .. "  .colour " .. currentVictim .. " pink ")
        end
    end, 2)
end)

buttonInstances["autoCopy6"].MouseButton1Click:Connect(function()
    toggleAutoButton("autoCopy6", function()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .thin " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
        end
    end, 2)
end)

-- التهيئة
showSection("الضحيه")

-- جعل زر التفعيل قابل للسحب
ToggleButton.Active = true
ToggleButton.Draggable = true

-- نظام تتبع دخول وخروج الضحية
local function trackVictimStatus()
    local lastVictimPlayer = nil
    
    Players.PlayerRemoving:Connect(function(leavingPlayer)
        if currentVictim and leavingPlayer.Name == currentVictim then
            showNotification("🛑 الضحية " .. leavingPlayer.Name .. " خرج من السيرفر", {
                Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. leavingPlayer.UserId .. "&width=150&height=150&format=png"
            }, true)
            lastVictimPlayer = leavingPlayer
        end
    end)
    
    Players.PlayerAdded:Connect(function(joiningPlayer)
        if currentVictim and joiningPlayer.Name == currentVictim then
            showNotification("✅ الضحية " .. joiningPlayer.Name .. " دخل إلى السيرفر", {
                Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. joiningPlayer.UserId .. "&width=150&height=150&format=png"
            }, false)
        end
    end)
end

-- بدء تتبع حالة الضحية
coroutine.wrap(trackVictimStatus)()