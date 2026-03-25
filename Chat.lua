local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- رابط الخادم الخارجي (عدله حسب نشرك)
local SERVER_URL = "https://chat-di8m.onrender.com"

-- دالة HTTP موحدة
local function httpRequest(method, endpoint, body)
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)
    if not requestFunc then return nil end
    local success, response = pcall(function()
        return requestFunc({
            Url = SERVER_URL .. endpoint,
            Method = method,
            Headers = {["Content-Type"] = "application/json"},
            Body = body and HttpService:JSONEncode(body) or nil
        })
    end)
    if not success then return nil end
    return response
end

-- ========================
-- إنشاء واجهة المستخدم
-- ========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomChat"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- زر التبديل
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0.5, -25)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = "Chat"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

-- إطار الشات (مخفي افتراضياً)
local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0, 400, 0, 280)
chatFrame.Position = UDim2.new(0, 70, 0.5, -140)
chatFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chatFrame.BackgroundTransparency = 0.6
chatFrame.BorderSizePixel = 0
chatFrame.Visible = false
chatFrame.Parent = screenGui
Instance.new("UICorner", chatFrame).CornerRadius = UDim.new(0, 8)

-- شريط الرسائل
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -35)
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = chatFrame

local messageList = Instance.new("UIListLayout")
messageList.Parent = scrollFrame
messageList.Padding = UDim.new(0, 4)
messageList.SortOrder = Enum.SortOrder.LayoutOrder

-- حقل الإدخال
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, 0, 0, 35)
textBox.Position = UDim2.new(0, 0, 1, -35)
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.PlaceholderText = "اكتب رسالتك..."
textBox.ClearTextOnFocus = true
textBox.BorderSizePixel = 0
textBox.Parent = chatFrame

-- ========================
-- دالة إضافة رسالة للشات
-- ========================
local function addMessageToUI(playerName, message, timestamp)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0, 25)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextWrapped = true
    local timeStr = os.date("%H:%M", timestamp / 1000)
    textLabel.Text = string.format("[%s] %s: %s", timeStr, playerName, message)
    textLabel.Parent = scrollFrame

    task.wait(0.05)
    scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.CanvasSize.Y.Offset)
end

-- ========================
-- فقاعة فوق الرأس
-- ========================
local function showBubble(character, message)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end

    local oldBubble = head:FindFirstChild("ChatBubble")
    if oldBubble then oldBubble:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ChatBubble"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = billboard
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = message
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Font = Enum.Font.Gotham
    text.TextSize = 14
    text.TextWrapped = true
    text.Parent = frame

    task.wait(5)
    if billboard and billboard.Parent then
        billboard:Destroy()
    end
end

-- ========================
-- استقبال الرسائل (Polling كل ثانية)
-- ========================
local lastMessageCount = 0
local function fetchMessages()
    local response = httpRequest("GET", "/messages")
    if response and response.StatusCode == 200 then
        local success, data = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)
        if success and type(data) == "table" then
            -- عرض جميع الرسائل الجديدة (لا نعتمد على العداد لأنها تتغير باستمرار)
            for _, msg in ipairs(data) do
                -- نتجنب عرض الرسائل المكررة بفحص آخر ظهور
                -- لكن بما أن المصفوفة تمسح كل ثانيتين، يمكننا عرض كل ما نستقبله
                addMessageToUI(msg.playerName, msg.message, msg.timestamp)
                local sender = Players:FindFirstChild(msg.playerName)
                if sender then
                    local char = sender.Character
                    if char then
                        showBubble(char, msg.message)
                    else
                        sender.CharacterAdded:Connect(function(newChar)
                            showBubble(newChar, msg.message)
                        end)
                    end
                end
            end
        end
    end
end

-- جلب الرسائل كل ثانية
task.spawn(function()
    while task.wait(1) do
        fetchMessages()
    end
end)

-- ========================
-- إرسال رسالة جديدة
-- ========================
local function sendMessage(msg)
    if msg == "" then return end
    local response = httpRequest("POST", "/send", {
        playerName = player.Name,
        message = msg,
        timestamp = os.time() * 1000
    })
    if response and response.StatusCode == 429 then
        player:SendNotification("⚠️ تم رفض رسالتك بسبب الإرسال السريع")
    elseif not response or response.StatusCode ~= 200 then
        warn("فشل إرسال الرسالة")
    end
end

textBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local msg = textBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if msg ~= "" then
        sendMessage(msg)
        textBox.Text = ""
    end
end)

-- زر التبديل
local guiVisible = false
toggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    chatFrame.Visible = guiVisible
end)

-- جعل الشات قابل للسحب
local dragging = false
local dragInput, mousePos, framePos

chatFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = chatFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mousePos
        chatFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)