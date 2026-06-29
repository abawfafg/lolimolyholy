local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local unlocked = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VeryEZ"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.5
Background.Visible = true
Background.Parent = ScreenGui

local Blur = Instance.new("BlurEffect")
Blur.Size = 10
Blur.Enabled = true
Blur.Parent = Lighting

-- ===== АДАПТИВНЫЙ РАЗМЕР ЭКРАНА =====
local screenSize = workspace.CurrentCamera.ViewportSize
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local calculatedWidth, calculatedHeight, sidebarWidth

if isMobile then
    local maxWidth = math.min(650, screenSize.X - 20)
    local maxHeight = math.min(500, screenSize.Y - 20)
    local aspectRatio = 650 / 500
    calculatedWidth = maxWidth
    calculatedHeight = calculatedWidth / aspectRatio
    if calculatedHeight > maxHeight then
        calculatedHeight = maxHeight
        calculatedWidth = calculatedHeight * aspectRatio
    end
    sidebarWidth = math.min(140, calculatedWidth * 0.25)
    sidebarWidth = math.max(90, sidebarWidth)
else
    calculatedWidth = 650
    calculatedHeight = 500
    sidebarWidth = 160
end

-- Окно
local MainFrame = Instance.new("Frame")
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, calculatedWidth, 0, calculatedHeight)
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Transparency = 0.9
Stroke.Parent = MainFrame

-- Сайдбар
local Sidebar = Instance.new("Frame")
Sidebar.BackgroundTransparency = 1
Sidebar.Size = UDim2.new(0, sidebarWidth, 1, 0)
Sidebar.Parent = MainFrame

local Divider = Instance.new("Frame")
Divider.AnchorPoint = Vector2.new(1, 0)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BackgroundTransparency = 0.9
Divider.BorderSizePixel = 0
Divider.Position = UDim2.new(1, 8, 0, 0)
Divider.Size = UDim2.new(0, 1, 1, 0)
Divider.Parent = Sidebar

-- ============== ЗАГОЛОВОК ==============
local TitleBar = Instance.new("Frame")
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 31)
TitleBar.Parent = Sidebar

local Controls = Instance.new("Frame")
Controls.BackgroundTransparency = 1
Controls.Size = UDim2.new(0, 70, 1, 0)
Controls.Position = UDim2.new(0, 10, 0, 0)
Controls.Parent = TitleBar

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 12, 0, 12)
ExitBtn.Position = UDim2.new(0, 0, 0.5, -6)
ExitBtn.BackgroundColor3 = Color3.fromRGB(250, 93, 86)
ExitBtn.BorderSizePixel = 0
ExitBtn.Text = ""
ExitBtn.AutoButtonColor = false
ExitBtn.Parent = Controls

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(1, 0)
ExitCorner.Parent = ExitBtn

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 12, 0, 12)
MinBtn.Position = UDim2.new(0, 22, 0.5, -6)
MinBtn.BackgroundColor3 = Color3.fromRGB(252, 190, 57)
MinBtn.BorderSizePixel = 0
MinBtn.Text = ""
MinBtn.AutoButtonColor = false
MinBtn.Parent = Controls

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinBtn

local TitleDivider = Instance.new("Frame")
TitleDivider.AnchorPoint = Vector2.new(0, 1)
TitleDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleDivider.BackgroundTransparency = 0.9
TitleDivider.BorderSizePixel = 0
TitleDivider.Position = UDim2.new(0, 0, 1, 0)
TitleDivider.Size = UDim2.new(1, 8, 0, 1)
TitleDivider.Parent = TitleBar

-- ============== ИНФОРМАЦИЯ (ВЕРХ) ==============
local Info = Instance.new("Frame")
Info.BackgroundTransparency = 1
Info.Position = UDim2.new(0, 0, 0, 31)
Info.Size = UDim2.new(1, 0, 0, 60)
Info.Parent = Sidebar

local InfoDivider = Instance.new("Frame")
InfoDivider.AnchorPoint = Vector2.new(0, 1)
InfoDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfoDivider.BackgroundTransparency = 0.9
InfoDivider.BorderSizePixel = 0
InfoDivider.Position = UDim2.new(0, 0, 1, 0)
InfoDivider.Size = UDim2.new(1, 8, 0, 1)
InfoDivider.Parent = Info

local InfoHolder = Instance.new("Frame")
InfoHolder.BackgroundTransparency = 1
InfoHolder.Size = UDim2.new(1, 0, 1, 0)
InfoHolder.Parent = Info

local InfoPadding = Instance.new("UIPadding")
InfoPadding.PaddingBottom = UDim.new(0, 10)
InfoPadding.PaddingLeft = UDim.new(0, 23)
InfoPadding.PaddingRight = UDim.new(0, 22)
InfoPadding.PaddingTop = UDim.new(0, 10)
InfoPadding.Parent = InfoHolder

local TitleFrame = Instance.new("Frame")
TitleFrame.BackgroundTransparency = 1
TitleFrame.Size = UDim2.new(1, 0, 1, 0)
TitleFrame.Parent = InfoHolder

local Title = Instance.new("TextLabel")
Title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.Text = "ETHEREAL BETA [v1.0]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextTransparency = 0.1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Top
Title.AutomaticSize = Enum.AutomaticSize.Y
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 0)
Title.Parent = TitleFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.FontFace = Font.new("rbxassetid://12187365364")
Subtitle.RichText = true
Subtitle.Text = "67 POCOYO 67"
Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.TextSize = 13
Subtitle.TextTransparency = 0.7
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextYAlignment = Enum.TextYAlignment.Top
Subtitle.AutomaticSize = Enum.AutomaticSize.Y
Subtitle.BackgroundTransparency = 1
Subtitle.LayoutOrder = 1
Subtitle.Size = UDim2.new(1, 0, 0, 0)
Subtitle.Parent = TitleFrame

local TitleLayout = Instance.new("UIListLayout")
TitleLayout.Padding = UDim.new(0, 3)
TitleLayout.SortOrder = Enum.SortOrder.LayoutOrder
TitleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TitleLayout.Parent = TitleFrame

-- ============== TOPBAR ==============
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.BackgroundTransparency = 1
Topbar.Position = UDim2.new(0, sidebarWidth + 10, 0, 0)
Topbar.Size = UDim2.new(1, -(sidebarWidth + 20), 0, 50)
Topbar.Parent = MainFrame

local TopbarDivider = Instance.new("Frame")
TopbarDivider.AnchorPoint = Vector2.new(0, 1)
TopbarDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopbarDivider.BackgroundTransparency = 0.9
TopbarDivider.BorderSizePixel = 0
TopbarDivider.Position = UDim2.new(0, 0, 1, 0)
TopbarDivider.Size = UDim2.new(1, -30, 0, 1)
TopbarDivider.Parent = Topbar

local CurrentTabText = Instance.new("TextLabel")
CurrentTabText.Name = "CurrentTabText"
CurrentTabText.Size = UDim2.new(1, -30, 1, 0)
CurrentTabText.Position = UDim2.new(0, 15, 0, 0)
CurrentTabText.BackgroundTransparency = 1
CurrentTabText.Text = "Main"
CurrentTabText.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentTabText.TextXAlignment = Enum.TextXAlignment.Left
CurrentTabText.TextYAlignment = Enum.TextYAlignment.Center
CurrentTabText.FontFace = Font.new("rbxassetid://12187365364")
CurrentTabText.TextSize = 18
CurrentTabText.TextTransparency = 0.5
CurrentTabText.Parent = Topbar

-- ============== КОНТЕНТ ==============
local Content = Instance.new("Frame")
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, sidebarWidth + 10, 0, 50)
Content.Size = UDim2.new(1, -(sidebarWidth + 20), 1, -50)
Content.Parent = MainFrame

-- ============== ВКЛАДКИ ==============
local tabs = {}
local currentTab = nil
local tabIcons = {
	Main = { active = "109850365516950", inactive = "109850365516950" },
	Visuals = { active = "122786359769789", inactive = "122786359769789" },
	Skinchanger = { active = "106484558074420", inactive = "106484558074420" },
	Misc = { active = "130656298392600", inactive = "130656298392600" },
	Configs = { active = "73367585733399", inactive = "73367585733399" },
	Settings = { active = "109474902245299", inactive = "109474902245299" }
}

local tabList = {
	{name = "Main", group = 1},
	{name = "Visuals", group = 2},
	{name = "Skinchanger", group = 2},
	{name = "Misc", group = 3},
	{name = "Configs", group = 3},
	{name = "Settings", group = 3}
}

local function CreateTab(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.Parent = Sidebar

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(1, -10, 1, -6)
	bg.Position = UDim2.new(0, 5, 0, 3)
	bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bg.BackgroundTransparency = 0.85
	bg.BorderSizePixel = 0
	bg.Visible = false
	bg.Parent = btn

	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = bg

	local iconLabel = Instance.new("ImageLabel")
	iconLabel.Size = UDim2.new(0, 20, 1, 0)
	iconLabel.Position = UDim2.new(0, 12, 0, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Image = "rbxassetid://" .. tabIcons[name].inactive
	iconLabel.ScaleType = Enum.ScaleType.Fit
	iconLabel.Parent = btn

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -40, 1, 0)
	nameLabel.Position = UDim2.new(0, 40, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = name
	nameLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	nameLabel.TextSize = 15
	nameLabel.Parent = btn

	btn.MouseEnter:Connect(function()
		if currentTab ~= name then
			nameLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
		end
	end)
	btn.MouseLeave:Connect(function()
		if currentTab ~= name then
			nameLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
		end
	end)

	return btn, nameLabel, iconLabel, bg
end

local yPos = 100
local currentGroup = 1
for i, tabData in ipairs(tabList) do
	local name = tabData.name
	local group = tabData.group
	if group ~= currentGroup and i > 1 then
		local sep = Instance.new("Frame")
		sep.Size = UDim2.new(1, 5, 0, 1)
		sep.Position = UDim2.new(0.02, 0, 0, yPos)
		sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sep.BackgroundTransparency = 0.9
		sep.BorderSizePixel = 0
		sep.Parent = Sidebar
		yPos = yPos + 15
		currentGroup = group
	end

	local btn, nameLabel, iconLabel, bg = CreateTab(name)
	btn.Position = UDim2.new(0.02, 0, 0, yPos)
	tabs[name] = {
		Button = btn,
		NameLabel = nameLabel,
		IconLabel = iconLabel,
		Bg = bg
	}

	btn.MouseButton1Click:Connect(function()
		currentTab = name
		for tabName, tab in pairs(tabs) do
			local active = tabName == currentTab
			tab.Bg.Visible = active
			tab.NameLabel.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 200)
			tab.IconLabel.Image = "rbxassetid://" .. tabIcons[tabName].active
			tab.IconLabel.ImageTransparency = 0
		end
		CurrentTabText.Text = currentTab
	end)

	yPos = yPos + 45
end

currentTab = "Main"
for tabName, tab in pairs(tabs) do
	local active = tabName == currentTab
	tab.Bg.Visible = active
	tab.NameLabel.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 200)
	tab.IconLabel.Image = "rbxassetid://" .. tabIcons[tabName].active
	tab.IconLabel.ImageTransparency = 0
end
CurrentTabText.Text = "Main"

-- ============== КОМПОНЕНТЫ UI ==============
local pages = {}

local searchRegistry = {}
local searchCards = {}
local function registerSearchable(holder, text)
	table.insert(searchRegistry, { holder = holder, text = string.lower(text or "") })
end

local Theme = {
	Accent = Color3.fromRGB(252, 190, 57),
	AccentHover = Color3.fromRGB(255, 205, 90),
	refreshers = {},
}
function Theme.onChange(fn)
	table.insert(Theme.refreshers, fn)
	pcall(fn)
end
function Theme.apply()
	for _, fn in ipairs(Theme.refreshers) do pcall(fn) end
end
function Theme.set(color)
	Theme.Accent = color
	local h, s, v = color:ToHSV()
	Theme.AccentHover = Color3.fromHSV(h, math.max(s - 0.08, 0), math.min(v + 0.12, 1))
	Theme.apply()
end
Theme.onChange(function() MinBtn.BackgroundColor3 = Theme.Accent end)

-- ============== СИСТЕМА КОНФИГОВ ==============
local Cfg = { Flags = {}, Defaults = {} }
Cfg.FOLDER = "EtherealBeta"
Cfg.CONFIG_FOLDER = "EtherealBeta/configs"
Cfg.AUTOLOAD_FILE = "EtherealBeta/autoload.json"
Cfg.hasFS = (writefile and readfile and isfolder and makefolder and listfiles) and true or false

function Cfg.register(parent, label, api)
	if pages["Configs"] and parent and parent:IsDescendantOf(pages["Configs"]) then return end
	local cardName = (parent and parent.Name) or "Card"
	local name = cardName .. " :: " .. tostring(label)
	Cfg.Flags[name] = api
	local ok, val = pcall(api.Get)
	if ok then Cfg.Defaults[name] = val end
end

function Cfg.ensureFolders()
	if not Cfg.hasFS then return end
	if not isfolder(Cfg.FOLDER) then makefolder(Cfg.FOLDER) end
	if not isfolder(Cfg.CONFIG_FOLDER) then makefolder(Cfg.CONFIG_FOLDER) end
end

function Cfg.getData()
	local data = {}
	for name, api in pairs(Cfg.Flags) do
		local ok, v = pcall(api.Get)
		if ok then data[name] = v end
	end
	return data
end

function Cfg.applyData(data)
	for name, val in pairs(data) do
		local api = Cfg.Flags[name]
		if api then pcall(api.Set, val) end
	end
end

function Cfg.list()
	local list = {}
	if Cfg.hasFS and isfolder(Cfg.CONFIG_FOLDER) then
		for _, path in ipairs(listfiles(Cfg.CONFIG_FOLDER)) do
			if path:sub(-5) == ".json" then
				local n = path:match("([^/\\]+)%.json$")
				if n then table.insert(list, { name = n, path = path }) end
			end
		end
	end
	return list
end

function Cfg.exists(name)
	for _, e in ipairs(Cfg.list()) do
		if e.name == name then return true end
	end
	return false
end

function Cfg.save(name)
	if not Cfg.hasFS then return false end
	Cfg.ensureFolders()
	return (pcall(function()
		writefile(Cfg.CONFIG_FOLDER .. "/" .. name .. ".json", HttpService:JSONEncode(Cfg.getData()))
	end))
end

function Cfg.load(name)
	if not Cfg.hasFS then return end
	local target
	for _, e in ipairs(Cfg.list()) do
		if e.name == name then target = e.path break end
	end
	if not target then return end
	local ok, data = pcall(function() return HttpService:JSONDecode(readfile(target)) end)
	if ok and type(data) == "table" then Cfg.applyData(data) end
end

function Cfg.delete(name)
	if not Cfg.hasFS or not delfile then return false end
	local target
	for _, e in ipairs(Cfg.list()) do
		if e.name == name then target = e.path break end
	end
	if not target then return false end
	pcall(delfile, target)
	if isfile and isfile(target) then
		pcall(delfile, target)
	end
	local stillThere = (isfile and isfile(target)) or false
	return not stillThere
end

function Cfg.saveAutoload(enabled, name)
	if not Cfg.hasFS then return end
	Cfg.ensureFolders()
	pcall(function()
		writefile(Cfg.AUTOLOAD_FILE, HttpService:JSONEncode({ enabled = enabled, name = name }))
	end)
end

function Cfg.getAutoload()
	if Cfg.hasFS and isfile and isfile(Cfg.AUTOLOAD_FILE) then
		local ok, d = pcall(function() return HttpService:JSONDecode(readfile(Cfg.AUTOLOAD_FILE)) end)
		if ok and type(d) == "table" then return d end
	end
	return { enabled = false }
end

function Cfg.reset()
	for name, api in pairs(Cfg.Flags) do
		if Cfg.Defaults[name] ~= nil then pcall(api.Set, Cfg.Defaults[name]) end
	end
end

local function CreatePage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.Size = UDim2.new(1, 0, 1, 0)
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.ScrollBarThickness = 6
	page.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	page.ScrollBarImageTransparency = 0.5
	page.TopImage = "rbxassetid://115122166951013"
	page.MidImage = "rbxassetid://95591733073455"
	page.BottomImage = "rbxassetid://86927157225558"
	page.Visible = false
	page.Parent = Content

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 16)
	pad.PaddingBottom = UDim.new(0, 16)
	pad.PaddingLeft = UDim.new(0, 18)
	pad.PaddingRight = UDim.new(0, 18)
	pad.Parent = page

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = page

	pages[name] = page
	return page
end

local function CreateHeader(parent, text)
	local header = Instance.new("TextLabel")
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 0, 26)
	header.Text = text
	header.TextColor3 = Color3.fromRGB(255, 255, 255)
	header.TextTransparency = 0.25
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.TextYAlignment = Enum.TextYAlignment.Bottom
	header.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	header.TextSize = 13
	header.Parent = parent
	registerSearchable(header, text)
	return header
end

local function CreateToggle(parent, text, default, callback, fitText)
	local holder = Instance.new("Frame")
	holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	holder.BackgroundTransparency = 0.95
	holder.BorderSizePixel = 0
	holder.Size = UDim2.new(1, 0, 0, 38)
	holder.Parent = parent

	local hCorner = Instance.new("UICorner")
	hCorner.CornerRadius = UDim.new(0, 8)
	hCorner.Parent = holder

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, 14, 0, 0)
	label.Size = UDim2.new(1, -70, 1, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(235, 235, 245)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	label.TextSize = 14
	label.Parent = holder

	if fitText then
		label.AnchorPoint = Vector2.new(0, 0.5)
		label.Position = UDim2.new(0, 14, 0.5, 0)
		label.Size = UDim2.new(1, -68, 0, 18)
		label.TextWrapped = true
		label.TextScaled = true
		local labelConstraint = Instance.new("UITextSizeConstraint")
		labelConstraint.MaxTextSize = 14
		labelConstraint.MinTextSize = 8
		labelConstraint.Parent = label
	end

	local switch = Instance.new("TextButton")
	switch.AnchorPoint = Vector2.new(1, 0.5)
	switch.Position = UDim2.new(1, -12, 0.5, 0)
	switch.Size = UDim2.new(0, 40, 0, 22)
	switch.AutoButtonColor = false
	switch.Text = ""
	switch.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	switch.Parent = holder

	local swCorner = Instance.new("UICorner")
	swCorner.CornerRadius = UDim.new(1, 0)
	swCorner.Parent = switch

	local knob = Instance.new("Frame")
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.Position = UDim2.new(0, 3, 0.5, 0)
	knob.Size = UDim2.new(0, 16, 0, 16)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switch

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local state = default and true or false
	local tw = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function apply(animated)
		local onColor = Theme.Accent
		local offColor = Color3.fromRGB(60, 60, 70)
		local knobPos = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
		if animated then
			TweenService:Create(switch, tw, {BackgroundColor3 = state and onColor or offColor}):Play()
			TweenService:Create(knob, tw, {Position = knobPos}):Play()
		else
			switch.BackgroundColor3 = state and onColor or offColor
			knob.Position = knobPos
		end
	end

	switch.MouseButton1Click:Connect(function()
		state = not state
		apply(true)
		if callback then callback(state) end
	end)

	apply(false)
	Theme.onChange(function()
		if state then switch.BackgroundColor3 = Theme.Accent end
	end)

	registerSearchable(holder, text)
	local api = {
		Get = function() return state end,
		Set = function(v)
			state = v and true or false
			apply(true)
			if callback then callback(state) end
		end,
	}
	Cfg.register(parent, text, api)
	return api
end

local activeSliderUpdate = nil
UserInputService.InputChanged:Connect(function(input)
	if activeSliderUpdate and input.UserInputType == Enum.UserInputType.MouseMovement then
		activeSliderUpdate(input)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		activeSliderUpdate = nil
	end
end)

local function CreateSlider(parent, text, min, max, default, suffix, callback)
	local holder = Instance.new("Frame")
	holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	holder.BackgroundTransparency = 0.95
	holder.BorderSizePixel = 0
	holder.Size = UDim2.new(1, 0, 0, 54)
	holder.Parent = parent

	local hCorner = Instance.new("UICorner")
	hCorner.CornerRadius = UDim.new(0, 8)
	hCorner.Parent = holder

	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 14)
	pad.PaddingRight = UDim.new(0, 14)
	pad.Parent = holder

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, 0, 0, 8)
	label.Size = UDim2.new(1, 0, 0, 18)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(235, 235, 245)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	label.TextSize = 14
	label.Parent = holder

	local track = Instance.new("Frame")
	track.AnchorPoint = Vector2.new(0, 0.5)
	track.Position = UDim2.new(0, 0, 1, -14)
	track.Size = UDim2.new(1, -34, 0, 6)
	track.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	track.BorderSizePixel = 0
	track.Parent = holder

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = Theme.Accent
	fill.BorderSizePixel = 0
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local knob = Instance.new("Frame")
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.new(0, 0, 0.5, 0)
	knob.Size = UDim2.new(0, 14, 0, 14)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.ZIndex = 2
	knob.Parent = track

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local hitbox = Instance.new("TextButton")
	hitbox.BackgroundTransparency = 1
	hitbox.Text = ""
	hitbox.AutoButtonColor = false
	hitbox.AnchorPoint = Vector2.new(0, 0.5)
	hitbox.Position = UDim2.new(0, 0, 1, -14)
	hitbox.Size = UDim2.new(1, -64, 0, 24)
	hitbox.ZIndex = 3
	hitbox.Parent = holder

	local valueHolder = Instance.new("Frame")
	valueHolder.AnchorPoint = Vector2.new(1, 0.5)
	valueHolder.Position = UDim2.new(1, 5, 1, -16)
	valueHolder.Size = UDim2.new(0, 25, 0, 23)
	valueHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	valueHolder.BorderSizePixel = 0
	valueHolder.Parent = holder

	local vhCorner = Instance.new("UICorner")
	vhCorner.CornerRadius = UDim.new(0, 6)
	vhCorner.Parent = valueHolder

	local vhStroke = Instance.new("UIStroke")
	vhStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	vhStroke.Color = Color3.fromRGB(255, 255, 255)
	vhStroke.Transparency = 0.85
	vhStroke.Parent = valueHolder

	local valueBox = Instance.new("TextBox")
	valueBox.BackgroundTransparency = 1
	valueBox.Size = UDim2.new(1, 0, 1, 0)
	valueBox.TextColor3 = Theme.Accent
	valueBox.TextXAlignment = Enum.TextXAlignment.Center
	valueBox.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	valueBox.TextSize = 14
	valueBox.ClearTextOnFocus = false
	valueBox.TextEditable = true
	valueBox.Text = ""
	valueBox.Parent = valueHolder

	local value = default
	local sliderDragging = false

	local function setFromScale(scale)
		scale = math.clamp(scale, 0, 1)
		value = math.floor((min + (max - min) * scale) + 0.5)
		local realScale = (value - min) / (max - min)
		fill.Size = UDim2.new(realScale, 0, 1, 0)
		knob.Position = UDim2.new(realScale, 0, 0.5, 0)
		valueBox.Text = tostring(value) .. (suffix or "")
		if callback then callback(value) end
	end

	local function setValue(v)
		v = math.clamp(v, min, max)
		setFromScale((v - min) / (max - min))
	end

	local function updateFromInput(input)
		local rel = input.Position.X - track.AbsolutePosition.X
		setFromScale(rel / track.AbsoluteSize.X)
	end

	hitbox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			sliderDragging = true
			activeSliderUpdate = updateFromInput
			updateFromInput(input)
		end
	end)

	valueBox.Focused:Connect(function()
		valueBox.Text = tostring(value)
	end)

	valueBox.FocusLost:Connect(function()
		local n = tonumber(string.match(valueBox.Text, "%-?%d+%.?%d*"))
		if n then
			setValue(n)
		else
			setFromScale((value - min) / (max - min))
		end
	end)

	setFromScale((default - min) / (max - min))

	Theme.onChange(function()
		fill.BackgroundColor3 = Theme.Accent
		valueBox.TextColor3 = Theme.Accent
	end)

	registerSearchable(holder, text)
	local api = {
		Get = function() return value end,
		Set = function(v) setValue(v) end,
	}
	Cfg.register(parent, text, api)
	return api
end

local function CreateCard(parent, titleText, size)
	local card = Instance.new("Frame")
	card.Name = titleText or "Card"
	card.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	card.BackgroundTransparency = 0.2
	card.BorderSizePixel = 0
	card.Size = size or UDim2.new(1, 0, 0, 0)
	card.AutomaticSize = Enum.AutomaticSize.Y
	card.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Transparency = 0.9
	stroke.Parent = card

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 14)
	pad.PaddingBottom = UDim.new(0, 14)
	pad.PaddingLeft = UDim.new(0, 14)
	pad.PaddingRight = UDim.new(0, 14)
	pad.Parent = card

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = card

	if titleText then
		local title = Instance.new("TextLabel")
		title.BackgroundTransparency = 1
		title.Size = UDim2.new(1, 0, 0, 22)
		title.Text = titleText
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		title.TextSize = 16
		title.Parent = card
	end

	table.insert(searchCards, card)
	return card
end

local function CreateTextInput(parent, labelText, placeholder, callback)
	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.new(1, 0, 0, 48)
	holder.Parent = parent

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Size = UDim2.new(1, 0, 0, 16)
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(235, 235, 245)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	label.TextSize = 13
	label.Parent = holder

	local boxFrame = Instance.new("Frame")
	boxFrame.Position = UDim2.new(0, 0, 0, 20)
	boxFrame.Size = UDim2.new(1, 0, 0, 26)
	boxFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	boxFrame.BorderSizePixel = 0
	boxFrame.Parent = holder

	local bfCorner = Instance.new("UICorner")
	bfCorner.CornerRadius = UDim.new(0, 6)
	bfCorner.Parent = boxFrame

	local bfStroke = Instance.new("UIStroke")
	bfStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	bfStroke.Color = Color3.fromRGB(255, 255, 255)
	bfStroke.Transparency = 0.85
	bfStroke.Parent = boxFrame

	local bfPad = Instance.new("UIPadding")
	bfPad.PaddingLeft = UDim.new(0, 8)
	bfPad.PaddingRight = UDim.new(0, 8)
	bfPad.Parent = boxFrame

	local box = Instance.new("TextBox")
	box.BackgroundTransparency = 1
	box.Size = UDim2.new(1, 0, 1, 0)
	box.Text = ""
	box.PlaceholderText = placeholder or ""
	box.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.FontFace = Font.new("rbxassetid://12187365364")
	box.TextSize = 14
	box.ClearTextOnFocus = false
	box.TextEditable = true
	box.Parent = boxFrame

	box.FocusLost:Connect(function(enterPressed)
		if callback then callback(box.Text, enterPressed) end
	end)

	registerSearchable(holder, labelText)
	return {
		Get = function() return box.Text end,
		Set = function(v) box.Text = tostring(v) end,
	}
end

local function CreateColumns(page)
	local cols = Instance.new("Frame")
	cols.Name = "Columns"
	cols.BackgroundTransparency = 1
	cols.Size = UDim2.new(1, 0, 0, 0)
	cols.AutomaticSize = Enum.AutomaticSize.Y
	cols.Parent = page

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.Padding = UDim.new(0, 12)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.VerticalAlignment = Enum.VerticalAlignment.Top
	layout.Parent = cols

	local function makeCol(order)
		local col = Instance.new("Frame")
		col.BackgroundTransparency = 1
		col.Size = UDim2.new(0.5, -6, 0, 0)
		col.AutomaticSize = Enum.AutomaticSize.Y
		col.LayoutOrder = order
		col.Parent = cols
		local l = Instance.new("UIListLayout")
		l.Padding = UDim.new(0, 12)
		l.SortOrder = Enum.SortOrder.LayoutOrder
		l.Parent = col
		return col
	end

	return makeCol(1), makeCol(2)
end

local function CreateDropdown(parent, options, default, callback)
	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.new(1, 0, 0, 0)
	holder.AutomaticSize = Enum.AutomaticSize.Y
	holder.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = holder

	local box = Instance.new("TextButton")
	box.LayoutOrder = 0
	box.Size = UDim2.new(1, 0, 0, 34)
	box.AutoButtonColor = false
	box.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	box.BorderSizePixel = 0
	box.Text = ""
	box.Parent = holder

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 6)
	boxCorner.Parent = box

	local boxStroke = Instance.new("UIStroke")
	boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	boxStroke.Color = Color3.fromRGB(255, 255, 255)
	boxStroke.Transparency = 0.85
	boxStroke.Parent = box

	local selectedLabel = Instance.new("TextLabel")
	selectedLabel.BackgroundTransparency = 1
	selectedLabel.Position = UDim2.new(0, 12, 0, 0)
	selectedLabel.Size = UDim2.new(1, -40, 1, 0)
	selectedLabel.Text = default or options[1]
	selectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
	selectedLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	selectedLabel.TextSize = 14
	selectedLabel.Parent = box

	local arrow = Instance.new("TextLabel")
	arrow.BackgroundTransparency = 1
	arrow.AnchorPoint = Vector2.new(1, 0.5)
	arrow.Position = UDim2.new(1, -12, 0.5, 0)
	arrow.Size = UDim2.new(0, 16, 0, 16)
	arrow.Text = "v"
	arrow.TextColor3 = Color3.fromRGB(180, 180, 190)
	arrow.TextSize = 12
	arrow.FontFace = Font.new("rbxassetid://12187365364")
	arrow.Parent = box

	local listFrame = Instance.new("Frame")
	listFrame.LayoutOrder = 1
	listFrame.Visible = false
	listFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	listFrame.BorderSizePixel = 0
	listFrame.Size = UDim2.new(1, 0, 0, 0)
	listFrame.AutomaticSize = Enum.AutomaticSize.Y
	listFrame.Parent = holder

	local lfCorner = Instance.new("UICorner")
	lfCorner.CornerRadius = UDim.new(0, 6)
	lfCorner.Parent = listFrame

	local lfStroke = Instance.new("UIStroke")
	lfStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	lfStroke.Color = Color3.fromRGB(255, 255, 255)
	lfStroke.Transparency = 0.85
	lfStroke.Parent = listFrame

	local lfPad = Instance.new("UIPadding")
	lfPad.PaddingTop = UDim.new(0, 4)
	lfPad.PaddingBottom = UDim.new(0, 4)
	lfPad.Parent = listFrame

	local lfLayout = Instance.new("UIListLayout")
	lfLayout.SortOrder = Enum.SortOrder.LayoutOrder
	lfLayout.Parent = listFrame

	local value = default or options[1]
	local open = false
	local function setOpen(s)
		open = s
		listFrame.Visible = s
		arrow.Text = s and "^" or "v"
	end

	box.MouseButton1Click:Connect(function()
		setOpen(not open)
	end)

	for _, opt in ipairs(options) do
		local optBtn = Instance.new("TextButton")
		optBtn.Size = UDim2.new(1, 0, 0, 30)
		optBtn.BackgroundTransparency = 1
		optBtn.AutoButtonColor = false
		optBtn.Text = ""
		optBtn.Parent = listFrame

		local optLabel = Instance.new("TextLabel")
		optLabel.BackgroundTransparency = 1
		optLabel.Position = UDim2.new(0, 12, 0, 0)
		optLabel.Size = UDim2.new(1, -24, 1, 0)
		optLabel.Text = opt
		optLabel.TextColor3 = (opt == value) and Theme.Accent or Color3.fromRGB(220, 220, 230)
		optLabel.TextXAlignment = Enum.TextXAlignment.Left
		optLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		optLabel.TextSize = 14
		optLabel.Parent = optBtn

		optBtn.MouseEnter:Connect(function()
			if opt ~= value then optLabel.TextColor3 = Color3.fromRGB(255, 255, 255) end
		end)
		optBtn.MouseLeave:Connect(function()
			if opt ~= value then optLabel.TextColor3 = Color3.fromRGB(220, 220, 230) end
		end)
		optBtn.MouseButton1Click:Connect(function()
			value = opt
			selectedLabel.Text = opt
			for _, child in ipairs(listFrame:GetChildren()) do
				if child:IsA("TextButton") then
					local lbl = child:FindFirstChildWhichIsA("TextLabel")
					if lbl then
						lbl.TextColor3 = (lbl.Text == value) and Theme.Accent or Color3.fromRGB(220, 220, 230)
					end
				end
			end
			setOpen(false)
			if callback then callback(value) end
		end)
	end

	Theme.onChange(function()
		for _, child in ipairs(listFrame:GetChildren()) do
			if child:IsA("TextButton") then
				local lbl = child:FindFirstChildWhichIsA("TextLabel")
				if lbl then
					lbl.TextColor3 = (lbl.Text == value) and Theme.Accent or Color3.fromRGB(220, 220, 230)
				end
			end
		end
	end)

	registerSearchable(holder, table.concat(options, " "))
	local api = {
		Get = function() return value end,
		Set = function(v)
			value = v
			selectedLabel.Text = v
			if callback then callback(value) end
		end,
	}
	Cfg.register(parent, "Skybox", api)
	return api
end

local function CreateButton(parent, text, callback, secondary)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.AutoButtonColor = false
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn.TextSize = 14
	btn.Parent = parent

	local baseColor = secondary and Color3.fromRGB(45, 45, 52) or Theme.Accent
	local hoverColor = secondary and Color3.fromRGB(55, 55, 64) or Theme.AccentHover
	btn.BackgroundColor3 = baseColor
	btn.TextColor3 = secondary and Color3.fromRGB(235, 235, 245) or Color3.fromRGB(20, 20, 20)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	if secondary then
		local stroke = Instance.new("UIStroke")
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Transparency = 0.85
		stroke.Parent = btn
	end

	local tw = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, tw, {BackgroundColor3 = hoverColor}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, tw, {BackgroundColor3 = baseColor}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)

	if not secondary then
		Theme.onChange(function()
			baseColor = Theme.Accent
			hoverColor = Theme.AccentHover
			btn.BackgroundColor3 = baseColor
		end)
	end

	registerSearchable(btn, text)
	return btn
end

local function showPage(name)
	for n, p in pairs(pages) do
		p.Visible = (n == name)
	end
end

for _, tabData in ipairs(tabList) do
	CreatePage(tabData.name)
end

for name, tab in pairs(tabs) do
	tab.Button.MouseButton1Click:Connect(function()
		showPage(name)
	end)
end

-- ============== СОДЕРЖИМОЕ MAIN ==============
local AutoSell = { Enabled = false, Delay = 5, Filters = {} }
local ItemsESP = { Enabled = false, Distance = 150 }
local PriceFilters = {
	UseMinPrice = false,
	MinPrice = 0,
	UseSpawnChance = false,
	MaxSpawnChance = 50,
	Rarity = {},
	Economy = {},
}

do
local MainPage = pages["Main"]

local columns = Instance.new("Frame")
columns.Name = "Columns"
columns.BackgroundTransparency = 1
columns.Size = UDim2.new(1, 0, 0, 0)
columns.AutomaticSize = Enum.AutomaticSize.Y
columns.Parent = MainPage

local columnsLayout = Instance.new("UIListLayout")
columnsLayout.FillDirection = Enum.FillDirection.Horizontal
columnsLayout.Padding = UDim.new(0, 12)
columnsLayout.SortOrder = Enum.SortOrder.LayoutOrder
columnsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
columnsLayout.Parent = columns

local function CreateColumn(order)
	local col = Instance.new("Frame")
	col.BackgroundTransparency = 1
	col.Size = UDim2.new(0.5, -6, 0, 0)
	col.AutomaticSize = Enum.AutomaticSize.Y
	col.LayoutOrder = order
	col.Parent = columns
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 12)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = col
	return col
end

local leftCol = CreateColumn(1)
local rightCol = CreateColumn(2)

local AutoSellFrame = CreateCard(leftCol, "Auto Sell")
CreateToggle(AutoSellFrame, "Enable Auto Sell", false, function(on) AutoSell.Enabled = on end)
CreateSlider(AutoSellFrame, "Auto Sell Delay", 1, 30, 5, "s", function(v) AutoSell.Delay = v end)
CreateHeader(AutoSellFrame, "Sell Filters")
local sellRarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Exclusive", "Mythic"}
for _, rarity in ipairs(sellRarities) do
	CreateToggle(AutoSellFrame, "Sell " .. rarity, false, function(on) AutoSell.Filters[rarity] = on end)
end

local PriceCard = CreateCard(leftCol, "Price")
CreateToggle(PriceCard, "Use Min Price Filter", false, function(on) PriceFilters.UseMinPrice = on end, true)
CreateTextInput(PriceCard, "Min Price", "Введите число...", function(text)
	PriceFilters.MinPrice = tonumber(text) or 0
end)

local ChancesCard = CreateCard(leftCol, "Chances")
CreateToggle(ChancesCard, "Use Spawn Chance", false, function(on) PriceFilters.UseSpawnChance = on end, true)
CreateSlider(ChancesCard, "Max Spawn Chance (%)", 0, 100, 50, "", function(v) PriceFilters.MaxSpawnChance = v end)

local ItemsESPFrame = CreateCard(rightCol, "Items ESP")
CreateToggle(ItemsESPFrame, "ESP Enabled", false, function(on) ItemsESP.Enabled = on end)
CreateSlider(ItemsESPFrame, "Distance", 0, 400, 150, "", function(v) ItemsESP.Distance = v end)

local RarityCard = CreateCard(rightCol, "Rarity Filters")
local rarityFilters = {"Epic", "Legendary", "Exclusive", "Mythic"}
for _, r in ipairs(rarityFilters) do
	CreateToggle(RarityCard, r, false, function(on) PriceFilters.Rarity[r] = on end)
end

local EconomyCard = CreateCard(rightCol, "Economy Filters")
local economyFilters = {"Safe", "Normal", "Risky", "Trap", "Jackpot"}
for _, e in ipairs(economyFilters) do
	CreateToggle(EconomyCard, e, false, function(on) PriceFilters.Economy[e] = on end)
end

showPage("Main")
end

-- ============== СОДЕРЖИМОЕ CONFIGS ==============
do
	local ConfigsPage = pages["Configs"]
	local ConfigCard = CreateCard(ConfigsPage, "Config Manager")

	local statusLabel
	local function setStatus(t) if statusLabel then statusLabel.Text = t end end

	local nameInput = CreateTextInput(ConfigCard, "Config Name", "Введите имя...")

	local selectedConfig = nil
	local refreshConfigList

	CreateButton(ConfigCard, "Create / Save", function()
		local n = (nameInput.Get() or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if n == "" then setStatus("Введите имя конфига") return end
		if not Cfg.hasFS then setStatus("Executor не поддерживает файлы") return end
		if Cfg.exists(n) then
			setStatus("Конфиг \"" .. n .. "\" уже существует")
			return
		end
		if Cfg.save(n) then
			setStatus("Сохранено: " .. n)
			nameInput.Set("")
			refreshConfigList()
		else
			setStatus("Ошибка сохранения")
		end
	end, true)

	CreateHeader(ConfigCard, "Saved Configs")

	local ddHolder = Instance.new("Frame")
	ddHolder.BackgroundTransparency = 1
	ddHolder.Size = UDim2.new(1, 0, 0, 0)
	ddHolder.AutomaticSize = Enum.AutomaticSize.Y
	ddHolder.Parent = ConfigCard

	local ddLayout = Instance.new("UIListLayout")
	ddLayout.Padding = UDim.new(0, 6)
	ddLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ddLayout.Parent = ddHolder

	local ddBox = Instance.new("TextButton")
	ddBox.LayoutOrder = 0
	ddBox.Size = UDim2.new(1, 0, 0, 34)
	ddBox.AutoButtonColor = false
	ddBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	ddBox.BorderSizePixel = 0
	ddBox.Text = ""
	ddBox.Parent = ddHolder

	local ddCorner = Instance.new("UICorner")
	ddCorner.CornerRadius = UDim.new(0, 6)
	ddCorner.Parent = ddBox

	local ddStroke = Instance.new("UIStroke")
	ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ddStroke.Color = Color3.fromRGB(255, 255, 255)
	ddStroke.Transparency = 0.85
	ddStroke.Parent = ddBox

	local ddSelected = Instance.new("TextLabel")
	ddSelected.BackgroundTransparency = 1
	ddSelected.Position = UDim2.new(0, 12, 0, 0)
	ddSelected.Size = UDim2.new(1, -40, 1, 0)
	ddSelected.Text = "Выбери конфиг"
	ddSelected.TextColor3 = Color3.fromRGB(200, 200, 210)
	ddSelected.TextXAlignment = Enum.TextXAlignment.Left
	ddSelected.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	ddSelected.TextSize = 14
	ddSelected.Parent = ddBox

	local ddArrow = Instance.new("TextLabel")
	ddArrow.BackgroundTransparency = 1
	ddArrow.AnchorPoint = Vector2.new(1, 0.5)
	ddArrow.Position = UDim2.new(1, -12, 0.5, 0)
	ddArrow.Size = UDim2.new(0, 16, 0, 16)
	ddArrow.Text = "v"
	ddArrow.TextColor3 = Color3.fromRGB(180, 180, 190)
	ddArrow.TextSize = 12
	ddArrow.FontFace = Font.new("rbxassetid://12187365364")
	ddArrow.Parent = ddBox

	local ddList = Instance.new("Frame")
	ddList.LayoutOrder = 1
	ddList.Visible = false
	ddList.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	ddList.BorderSizePixel = 0
	ddList.Size = UDim2.new(1, 0, 0, 0)
	ddList.AutomaticSize = Enum.AutomaticSize.Y
	ddList.Parent = ddHolder

	local ddlCorner = Instance.new("UICorner")
	ddlCorner.CornerRadius = UDim.new(0, 6)
	ddlCorner.Parent = ddList

	local ddlStroke = Instance.new("UIStroke")
	ddlStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ddlStroke.Color = Color3.fromRGB(255, 255, 255)
	ddlStroke.Transparency = 0.85
	ddlStroke.Parent = ddList

	local ddlPad = Instance.new("UIPadding")
	ddlPad.PaddingTop = UDim.new(0, 4)
	ddlPad.PaddingBottom = UDim.new(0, 4)
	ddlPad.Parent = ddList

	local ddlLayout = Instance.new("UIListLayout")
	ddlLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ddlLayout.Parent = ddList

	local ddOpen = false
	local function setDdOpen(state)
		ddOpen = state
		ddList.Visible = state
		ddArrow.Text = state and "^" or "v"
	end
	ddBox.MouseButton1Click:Connect(function()
		setDdOpen(not ddOpen)
	end)

	refreshConfigList = function()
		for _, c in ipairs(ddList:GetChildren()) do
			if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
		end
		local list = Cfg.list()
		local stillExists = false
		for _, e in ipairs(list) do if e.name == selectedConfig then stillExists = true break end end
		if not stillExists then
			selectedConfig = nil
			ddSelected.Text = "Выбери конфиг"
			ddSelected.TextColor3 = Color3.fromRGB(200, 200, 210)
		end
		if #list == 0 then
			local empty = Instance.new("TextLabel")
			empty.BackgroundTransparency = 1
			empty.Size = UDim2.new(1, 0, 0, 28)
			empty.Text = Cfg.hasFS and "   Нет сохранённых конфигов" or "   Executor без поддержки файлов"
			empty.TextColor3 = Color3.fromRGB(150, 150, 160)
			empty.TextXAlignment = Enum.TextXAlignment.Left
			empty.FontFace = Font.new("rbxassetid://12187365364")
			empty.TextSize = 13
			empty.Parent = ddList
			return
		end
		for _, e in ipairs(list) do
			local optBtn = Instance.new("TextButton")
			optBtn.Size = UDim2.new(1, 0, 0, 30)
			optBtn.BackgroundTransparency = 1
			optBtn.AutoButtonColor = false
			optBtn.Text = ""
			optBtn.Parent = ddList

			local optLabel = Instance.new("TextLabel")
			optLabel.BackgroundTransparency = 1
			optLabel.Position = UDim2.new(0, 12, 0, 0)
			optLabel.Size = UDim2.new(1, -24, 1, 0)
			optLabel.Text = e.name
			optLabel.TextColor3 = (e.name == selectedConfig) and Theme.Accent or Color3.fromRGB(220, 220, 230)
			optLabel.TextXAlignment = Enum.TextXAlignment.Left
			optLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			optLabel.TextSize = 14
			optLabel.Parent = optBtn

			optBtn.MouseEnter:Connect(function()
				if e.name ~= selectedConfig then optLabel.TextColor3 = Color3.fromRGB(255, 255, 255) end
			end)
			optBtn.MouseLeave:Connect(function()
				if e.name ~= selectedConfig then optLabel.TextColor3 = Color3.fromRGB(220, 220, 230) end
			end)
			optBtn.MouseButton1Click:Connect(function()
				selectedConfig = e.name
				ddSelected.Text = e.name
				ddSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
				for _, child in ipairs(ddList:GetChildren()) do
					if child:IsA("TextButton") then
						local lbl = child:FindFirstChildWhichIsA("TextLabel")
						if lbl then
							lbl.TextColor3 = (lbl.Text == selectedConfig) and Theme.Accent or Color3.fromRGB(220, 220, 230)
						end
					end
				end
				setDdOpen(false)
				setStatus("Выбран: " .. e.name)
			end)
		end
	end

	CreateButton(ConfigCard, "Load Selected", function()
		if not selectedConfig then setStatus("Сначала выбери конфиг") return end
		Cfg.load(selectedConfig)
		setStatus("Загружено: " .. selectedConfig)
	end, true)

	CreateButton(ConfigCard, "Delete Selected", function()
		if not selectedConfig then setStatus("Сначала выбери конфиг") return end
		local nm = selectedConfig
		if Cfg.delete(nm) then
			setStatus("Удалено: " .. nm)
		else
			setStatus("Не удалось удалить: " .. nm)
		end
		refreshConfigList()
	end, true)

	CreateButton(ConfigCard, "Refresh List", function()
		refreshConfigList()
		setStatus("Список обновлён")
	end, true)

	statusLabel = Instance.new("TextLabel")
	statusLabel.LayoutOrder = 50
	statusLabel.BackgroundTransparency = 1
	statusLabel.Size = UDim2.new(1, 0, 0, 18)
	statusLabel.Text = ""
	statusLabel.TextColor3 = Theme.Accent
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.FontFace = Font.new("rbxassetid://12187365364")
	statusLabel.TextSize = 12
	statusLabel.Parent = ConfigCard

	local AutoLoadCard = CreateCard(ConfigsPage, "Auto Load")
	local autoToggle = CreateToggle(AutoLoadCard, "Auto Load Config", false, function(on)
		Cfg.saveAutoload(on, selectedConfig)
		if on then
			setStatus("Auto Load: " .. (selectedConfig or "конфиг не выбран"))
		else
			setStatus("Auto Load выключен")
		end
	end)

	local ResetCard = CreateCard(ConfigsPage, "Reset")
	CreateButton(ResetCard, "Reset to Default", function()
		Cfg.reset()
		setStatus("Сброшено к стандартным")
	end, true)

	refreshConfigList()

	task.defer(function()
		local al = Cfg.getAutoload()
		if al and al.enabled and al.name then
			selectedConfig = al.name
			ddSelected.Text = al.name
			ddSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
			Cfg.load(al.name)
			autoToggle.Set(true)
			refreshConfigList()
			setStatus("Auto-loaded: " .. al.name)
		end
	end)
end

-- ============== СОДЕРЖИМОЕ VISUALS ==============
local WorldVisuals = { TransparentGlass = false, TimeChanger = false, TimeOfDay = 12, Skybox = "Black Storm" }
local NicknamePins = { CustomNickname = false, Nickname = "", RainbowNickname = false, PinsAboveName = false, Pins = {} }
local MoneySpoof = { Enabled = false, Amount = 0 }

do
local VisualsLeft, VisualsRight = CreateColumns(pages["Visuals"])

local WorldCard = CreateCard(VisualsLeft, "World Visuals")
CreateToggle(WorldCard, "Transparent Glass", false, function(on) WorldVisuals.TransparentGlass = on end, true)
CreateToggle(WorldCard, "Time Changer", false, function(on) WorldVisuals.TimeChanger = on end)
CreateSlider(WorldCard, "Time Of Day", 0, 24, 12, "", function(v) WorldVisuals.TimeOfDay = v end)
CreateHeader(WorldCard, "Select Skybox")
CreateDropdown(WorldCard, {"Black Storm", "Blue Space", "HD", "Realistic", "Snow"}, "Black Storm", function(v) WorldVisuals.Skybox = v end)

local NickCard = CreateCard(VisualsLeft, "Nickname & Pins")
CreateToggle(NickCard, "Custom Nickname", false, function(on) NicknamePins.CustomNickname = on end, true)
CreateTextInput(NickCard, "Nickname", "Введите ник...", function(text) NicknamePins.Nickname = text end)
CreateToggle(NickCard, "Rainbow Nickname", false, function(on) NicknamePins.RainbowNickname = on end, true)
CreateToggle(NickCard, "Pins Above Name", false, function(on) NicknamePins.PinsAboveName = on end, true)

local MoneyCard = CreateCard(VisualsLeft, "Money Spoof")
CreateToggle(MoneyCard, "Money Spoof", false, function(on) MoneySpoof.Enabled = on end)
CreateTextInput(MoneyCard, "Money Amount", "Введите сумму...", function(text) MoneySpoof.Amount = tonumber(text) or 0 end)

local PinsCard = CreateCard(VisualsRight, "Select Pins")
local pinsList = {"Dev", "TT", "Mod", "YT", "VIP", "Adm", "Ver", "Star", "Own", "Prem"}
for _, p in ipairs(pinsList) do
	CreateToggle(PinsCard, p, false, function(on) NicknamePins.Pins[p] = on end)
end
end

-- ============== СОДЕРЖИМОЕ MISC ==============
local MiscOther = { InstantTake = false, PotatoMode = false }
local Movement = { SpeedEnabled = false, WalkSpeed = 16, InfinityJump = false }

do
local MiscLeft, MiscRight = CreateColumns(pages["Misc"])

local OtherCard = CreateCard(MiscLeft, "Other")
CreateHeader(OtherCard, "Instant Take")
CreateToggle(OtherCard, "Instant Take", false, function(on) MiscOther.InstantTake = on end)
CreateHeader(OtherCard, "Potato Mode")
CreateToggle(OtherCard, "Potato Mode", false, function(on) MiscOther.PotatoMode = on end)

local ServerHopCard = CreateCard(MiscLeft, "Server Hop")
CreateButton(ServerHopCard, "Teleport to random server", function()
	if VeryEZ_ServerHop then VeryEZ_ServerHop() end
end)

local MovementCard = CreateCard(MiscRight, "Movement")
CreateToggle(MovementCard, "Speed Enabled", false, function(on) Movement.SpeedEnabled = on end)
CreateSlider(MovementCard, "Walkspeed", 16, 32, 16, "", function(v) Movement.WalkSpeed = v end)
CreateToggle(MovementCard, "Infinity Jump", false, function(on) Movement.InfinityJump = on end)
end

-- ============== СТРОКА ПОИСКА ==============
local function runSearch(query)
	query = string.lower(query)
	query = query:gsub("^%s+", ""):gsub("%s+$", "")

	for _, item in ipairs(searchRegistry) do
		local match = (query == "") or (string.find(item.text, query, 1, true) ~= nil)
		item.holder.Visible = match
	end

	for _, card in ipairs(searchCards) do
		if query == "" then
			card.Visible = true
		else
			local anyVisible = false
			for _, item in ipairs(searchRegistry) do
				if item.holder.Visible and item.holder:IsDescendantOf(card) then
					anyVisible = true
					break
				end
			end
			card.Visible = anyVisible
		end
	end
end

local SearchHolder = Instance.new("Frame")
SearchHolder.Name = "SearchHolder"
SearchHolder.AnchorPoint = Vector2.new(0, 0.5)
SearchHolder.Position = UDim2.new(0, 80, 0.5, 0)
SearchHolder.Size = UDim2.new(0, 200, 0, 30)
SearchHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
SearchHolder.BackgroundTransparency = 0.2
SearchHolder.BorderSizePixel = 0
SearchHolder.Parent = Topbar

local shCorner = Instance.new("UICorner")
shCorner.CornerRadius = UDim.new(0, 8)
shCorner.Parent = SearchHolder

local shStroke = Instance.new("UIStroke")
shStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
shStroke.Color = Color3.fromRGB(255, 255, 255)
shStroke.Transparency = 0.9
shStroke.Parent = SearchHolder

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(0, 9, 0.5, 0)
SearchIcon.Size = UDim2.new(0, 16, 0, 16)
SearchIcon.Image = "rbxassetid://133221122642351"
SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 160)
SearchIcon.ScaleType = Enum.ScaleType.Fit
SearchIcon.Parent = SearchHolder

local SearchBox = Instance.new("TextBox")
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 32, 0, 0)
SearchBox.Size = UDim2.new(1, -42, 1, 0)
SearchBox.Text = ""
SearchBox.PlaceholderText = "Поиск..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.FontFace = Font.new("rbxassetid://12187365364")
SearchBox.TextSize = 14
SearchBox.ClearTextOnFocus = false
SearchBox.TextEditable = true
SearchBox.Parent = SearchHolder

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	runSearch(SearchBox.Text)
end)

local LEFT_GAP = 14
local RIGHT_MARGIN = 15
local function updateSearchLayout()
	local textEnd = CurrentTabText.AbsolutePosition.X + CurrentTabText.TextBounds.X
	local leftEdge = textEnd + LEFT_GAP
	local rightEdge = MainFrame.AbsoluteSize.X - (Topbar.AbsolutePosition.X - MainFrame.AbsolutePosition.X) - RIGHT_MARGIN
	local localLeft = leftEdge - Topbar.AbsolutePosition.X
	local width = math.max(rightEdge - localLeft, 90)
	SearchHolder.Position = UDim2.new(0, localLeft, 0.5, 0)
	SearchHolder.Size = UDim2.new(0, width, 0, 30)
end

CurrentTabText:GetPropertyChangedSignal("TextBounds"):Connect(updateSearchLayout)
CurrentTabText:GetPropertyChangedSignal("Text"):Connect(updateSearchLayout)
MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSearchLayout)
task.defer(updateSearchLayout)

-- ============== ИНФО ОБ ИГРОКЕ (НИЗ СЛЕВА) ==============
local UserInfo = Instance.new("Frame")
UserInfo.AnchorPoint = Vector2.new(0, 1)
UserInfo.BackgroundTransparency = 1
UserInfo.Position = UDim2.new(0, 0, 1, 0)
UserInfo.Size = UDim2.new(1, 0, 0, 64)
UserInfo.Parent = Sidebar

local UserDivider = Instance.new("Frame")
UserDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserDivider.BackgroundTransparency = 0.9
UserDivider.BorderSizePixel = 0
UserDivider.Position = UDim2.new(0, -20, 0, -20)
UserDivider.Size = UDim2.new(1, 42, 0, 1)
UserDivider.Parent = UserInfo

local UserPad = Instance.new("UIPadding")
UserPad.PaddingLeft = UDim.new(0, 18)
UserPad.PaddingRight = UDim.new(0, 14)
UserPad.PaddingTop = UDim.new(0, 12)
UserPad.PaddingBottom = UDim.new(0, 12)
UserPad.Parent = UserInfo

local Avatar = Instance.new("ImageLabel")
Avatar.AnchorPoint = Vector2.new(0, 0.5)
Avatar.Position = UDim2.new(0, 0, 0.5, 0)
Avatar.Size = UDim2.new(0, 38, 0, 38)
Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
Avatar.BorderSizePixel = 0
Avatar.Image = ""
Avatar.Parent = UserInfo

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = Avatar

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
AvatarStroke.Color = Color3.fromRGB(255, 255, 255)
AvatarStroke.Transparency = 0.85
AvatarStroke.Parent = Avatar

local NameFrame = Instance.new("Frame")
NameFrame.AnchorPoint = Vector2.new(0, 0.5)
NameFrame.BackgroundTransparency = 1
NameFrame.Position = UDim2.new(0, 48, 0.5, 0)
NameFrame.Size = UDim2.new(1, -48, 1, 0)
NameFrame.Parent = UserInfo

local NameLayout = Instance.new("UIListLayout")
NameLayout.Padding = UDim.new(0, 1)
NameLayout.SortOrder = Enum.SortOrder.LayoutOrder
NameLayout.VerticalAlignment = Enum.VerticalAlignment.Center
NameLayout.Parent = NameFrame

local DisplayName = Instance.new("TextLabel")
DisplayName.LayoutOrder = 0
DisplayName.BackgroundTransparency = 1
DisplayName.Size = UDim2.new(1, 0, 0, 17)
DisplayName.Text = LP.DisplayName
DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayName.TextXAlignment = Enum.TextXAlignment.Left
DisplayName.TextTruncate = Enum.TextTruncate.AtEnd
DisplayName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
DisplayName.TextSize = 14
DisplayName.Parent = NameFrame

local Username = Instance.new("TextLabel")
Username.LayoutOrder = 1
Username.BackgroundTransparency = 1
Username.Size = UDim2.new(1, 0, 0, 15)
Username.Text = "@" .. LP.Name
Username.TextColor3 = Color3.fromRGB(180, 180, 195)
Username.TextXAlignment = Enum.TextXAlignment.Left
Username.TextTruncate = Enum.TextTruncate.AtEnd
Username.FontFace = Font.new("rbxassetid://12187365364")
Username.TextSize = 12
Username.Parent = NameFrame

task.spawn(function()
	local ok, thumb = pcall(function()
		return Players:GetUserThumbnailAsync(
			LP.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)
	end)
	if ok and thumb then
		Avatar.Image = thumb
	end
end)

-- ============== SETTINGS ==============
do
	local SettingsPage = pages["Settings"]

	local origDisplay = DisplayName.Text
	local origUser = Username.Text
	local origAvatar = Avatar.Image

	local custCard = CreateCard(SettingsPage, "Customization")

	local accentRGB = { r = 252, g = 190, b = 57 }
	local rainbowOn = false
	local rSlider, gSlider, bSlider, rainbowToggle

	local function rebuildAccent()
		Theme.set(Color3.fromRGB(accentRGB.r, accentRGB.g, accentRGB.b))
	end

	CreateHeader(custCard, "Accent Color")
	rSlider = CreateSlider(custCard, "Accent R", 0, 255, accentRGB.r, "", function(v)
		accentRGB.r = v
		if not rainbowOn then rebuildAccent() end
	end)
	gSlider = CreateSlider(custCard, "Accent G", 0, 255, accentRGB.g, "", function(v)
		accentRGB.g = v
		if not rainbowOn then rebuildAccent() end
	end)
	bSlider = CreateSlider(custCard, "Accent B", 0, 255, accentRGB.b, "", function(v)
		accentRGB.b = v
		if not rainbowOn then rebuildAccent() end
	end)

	rainbowToggle = CreateToggle(custCard, "Rainbow Accent", false, function(on)
		rainbowOn = on
	end)

	CreateButton(custCard, "Reset Accent", function()
		rainbowOn = false
		rainbowToggle.Set(false)
		accentRGB.r, accentRGB.g, accentRGB.b = 252, 190, 57
		rSlider.Set(252)
		gSlider.Set(190)
		bSlider.Set(57)
		rebuildAccent()
	end, true)

	task.spawn(function()
		while task.wait(0.06) do
			if rainbowOn then
				Theme.set(Color3.fromHSV((tick() % 5) / 5, 0.75, 1))
			end
		end
	end)

	local protectCard = CreateCard(SettingsPage, "Protect Name")
	CreateToggle(protectCard, "Enable Protect Name", false, function(on)
		if on then
			DisplayName.Text = "PROTECTED"
			Username.Text = "@PROTECTED"
			Avatar.Image = ""
			Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
		else
			DisplayName.Text = origDisplay
			Username.Text = origUser
			Avatar.Image = origAvatar
		end
	end)
end

-- ============== ОСТРОВОК ==============
local Island = Instance.new("Frame")
Island.Name = "Island"
Island.AnchorPoint = Vector2.new(0.5, 0)
Island.Position = UDim2.new(0.5, 0, 0, -80)
Island.Size = UDim2.new(0, 0, 0, 34)
Island.AutomaticSize = Enum.AutomaticSize.X
Island.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Island.BackgroundTransparency = 0.05
Island.BorderSizePixel = 0
Island.Visible = true
Island.Parent = ScreenGui

local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(1, 0)
IslandCorner.Parent = Island

local IslandStroke = Instance.new("UIStroke")
IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
IslandStroke.Color = Color3.fromRGB(255, 255, 255)
IslandStroke.Transparency = 0.9
IslandStroke.Parent = Island

local IslandPad = Instance.new("UIPadding")
IslandPad.PaddingLeft = UDim.new(0, 14)
IslandPad.PaddingRight = UDim.new(0, 8)
IslandPad.Parent = Island

local IslandLayout = Instance.new("UIListLayout")
IslandLayout.FillDirection = Enum.FillDirection.Horizontal
IslandLayout.Padding = UDim.new(0, 10)
IslandLayout.SortOrder = Enum.SortOrder.LayoutOrder
IslandLayout.VerticalAlignment = Enum.VerticalAlignment.Center
IslandLayout.Parent = Island

local IslandTitle = Instance.new("TextLabel")
IslandTitle.LayoutOrder = 0
IslandTitle.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
IslandTitle.Text = "ETHEREAL BETA [UNDETECTED]"
IslandTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IslandTitle.TextSize = 14
IslandTitle.TextTransparency = 0.1
IslandTitle.BackgroundTransparency = 1
IslandTitle.AutomaticSize = Enum.AutomaticSize.X
IslandTitle.Size = UDim2.new(0, 0, 1, 0)
IslandTitle.Parent = Island

local IslandBtn = Instance.new("TextButton")
IslandBtn.LayoutOrder = 1
IslandBtn.AnchorPoint = Vector2.new(0, 0.5)
IslandBtn.Size = UDim2.new(0, 18, 0, 18)
IslandBtn.BackgroundColor3 = Color3.fromRGB(139, 195, 74)
IslandBtn.BorderSizePixel = 0
IslandBtn.Text = ""
IslandBtn.AutoButtonColor = false
IslandBtn.Parent = Island

local IslandBtnCorner = Instance.new("UICorner")
IslandBtnCorner.CornerRadius = UDim.new(1, 0)
IslandBtnCorner.Parent = IslandBtn

Theme.onChange(function() IslandBtn.BackgroundColor3 = Theme.Accent end)

-- ============== ПЕРЕТАСКИВАНИЕ ==============
local function makeDraggable(frame, dragHandle)
	local dragging, dragInput, dragStart, startPos
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(MainFrame, TitleBar)
makeDraggable(Island, IslandTitle)

-- ============== АНИМАЦИИ ==============
local ISLAND_SHOWN = UDim2.new(0.5, 0, 0, 8)
local ISLAND_HIDDEN = UDim2.new(0.5, 0, 0, -80)
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local isMinimized = false
local animating = false

local function getMainShown()
	return UDim2.new(0.5, 0, 0.5, 0)
end
local function getMainHidden()
	return UDim2.new(0.5, 0, 0, -300)
end

local function minimize()
	if isMinimized or animating then return end
	isMinimized = true
	animating = true

	TweenService:Create(Blur, tweenInfo, {Size = 0}):Play()
	TweenService:Create(Background, tweenInfo, {BackgroundTransparency = 1}):Play()
	local mainTween = TweenService:Create(MainFrame, tweenInfo, {Position = getMainHidden()})
	mainTween:Play()
	mainTween.Completed:Connect(function()
		MainFrame.Visible = false
		Background.Visible = false
		Island.Position = ISLAND_HIDDEN
		Island.Visible = true
		TweenService:Create(Island, tweenInfo, {Position = ISLAND_SHOWN}):Play()
		task.delay(tweenInfo.Time, function() animating = false end)
	end)
end

local function restore()
	if not isMinimized or animating then return end
	isMinimized = false
	animating = true

	local islandTween = TweenService:Create(Island, tweenInfo, {Position = ISLAND_HIDDEN})
	islandTween:Play()
	islandTween.Completed:Connect(function()
		Island.Visible = false
		MainFrame.Position = getMainHidden()
		MainFrame.Visible = true
		Background.Visible = true
		Blur.Enabled = true
		TweenService:Create(Blur, tweenInfo, {Size = 10}):Play()
		TweenService:Create(Background, tweenInfo, {BackgroundTransparency = 0.5}):Play()
		TweenService:Create(MainFrame, tweenInfo, {Position = getMainShown()}):Play()
		task.delay(tweenInfo.Time, function() animating = false end)
	end)
end

MinBtn.MouseButton1Click:Connect(minimize)
IslandBtn.MouseButton1Click:Connect(restore)

ExitBtn.MouseButton1Click:Connect(function()
	Blur:Destroy()
	ScreenGui:Destroy()
end)

local function hoverDot(btn, normal, hover)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hover}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normal}):Play()
	end)
end
hoverDot(ExitBtn, Color3.fromRGB(250, 93, 86), Color3.fromRGB(255, 120, 113))

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if not unlocked then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		if MainFrame.Visible and not isMinimized then
			minimize()
		elseif isMinimized then
			restore()
		else
			MainFrame.Visible = true
			Background.Visible = true
		end
	end
end)

-- ====================================================================
-- ФУНКЦИОНАЛ (ENGINE)
-- ====================================================================
do
	local RunService = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TeleportService = game:GetService("TeleportService")
	local Camera = workspace.CurrentCamera

	local CONFIG = {
		Enabled = false, Range = 150, MinPrice = 0, MaxChance = 50,
		UseMinPrice = false, UseMinChance = false,
		ShowPrice = true, ShowDistance = true, ShowRarity = true,
		ShowName = true, ShowChance = true, ShowEconomy = true,
		InstantTake = false,
		AutoSell_Enabled = false, AutoSell_Delay = 5,
		PotatoMode = false,
		Sell_Filters = { Common=false, Uncommon=false, Rare=false, Epic=false, Legendary=false, Exclusive=false, Mythic=false },
		Filters = {
			rarity = { Epic=true, Legendary=true, Exclusive=true, Mythic=true },
			economy = { safe=true, normal=true, risky=true, trap=true, jackpot=true },
		},
		HiddenItems = { "Acne Studios Jacket", "ERD Archive Trousers", "Prada Re-Nylon Jacket" },
	}

	local INF_JUMP_ENABLED = false
	local TRANSPARENT_GLASS_ENABLED = false
	local MONEY_SPOOF_ENABLED = false
	local SPOOFED_MONEY_AMOUNT = 1000
	local TIME_CHANGER_ENABLED = false
	local SPEED_ENABLED = false
	local CURRENT_TIME = 14
	local CURRENT_SPEED = 16
	local RemovedGlassObjects = {}
	local OriginalSky = nil
	local CurrentSkybox = nil
	local PotatoModeActive = false
	local NICK_ENABLED = false
	local PIN_ENABLED = false
	local RAINBOW_NICK_ENABLED = false
	local customNickname = ""
	local originalNameText = nil
	local originalNamePos = nil
	local pinIconsContainer = nil

	local PIN_TYPES = {
		Developer = "rbxassetid://10885640682",
		YouTube = "rbxassetid://1275974017",
		TikTok = "rbxassetid://137014429261024",
		Moderator = "rbxassetid://9209424449",
		Verify = "rbxassetid://138018675655074",
		Star = "rbxassetid://11419703997",
		Premium = "rbxassetid://9254254993",
		VIP = "rbxassetid://6031097225",
		Admin = "rbxassetid://7072707198",
		Owner = "rbxassetid://6031094678"
	}
	local SELECTED_PINS = {}

	local PIN_KEYMAP = {
		Dev = "Developer", TT = "TikTok", Mod = "Moderator", YT = "YouTube",
		VIP = "VIP", Adm = "Admin", Ver = "Verify", Star = "Star",
		Own = "Owner", Prem = "Premium",
	}

	local SkyboxAssets = {
		["Classic"] = nil,
		["Black Storm"] = {
			Bk = "rbxassetid://15502511288", Dn = "rbxassetid://15502508460",
			Ft = "rbxassetid://15502510289", Lf = "rbxassetid://15502507918",
			Rt = "rbxassetid://15502509398", Up = "rbxassetid://15502511911"
		},
		["HD"] = {
			Bk = "http://www.roblox.com/asset/?id=16553658937", Dn = "http://www.roblox.com/asset/?id=16553660713",
			Ft = "http://www.roblox.com/asset/?id=16553662144", Lf = "http://www.roblox.com/asset/?id=16553664042",
			Rt = "http://www.roblox.com/asset/?id=16553665766", Up = "http://www.roblox.com/asset/?id=16553667750"
		},
		["Snow"] = {
			Bk = "http://www.roblox.com/asset/?id=155657655", Dn = "http://www.roblox.com/asset/?id=155674246",
			Ft = "http://www.roblox.com/asset/?id=155657609", Lf = "http://www.roblox.com/asset/?id=155657671",
			Rt = "http://www.roblox.com/asset/?id=155657619", Up = "http://www.roblox.com/asset/?id=155674931"
		},
		["Blue Space"] = {
			Bk = "rbxassetid://15536110634", Dn = "rbxassetid://15536112543",
			Ft = "rbxassetid://15536116141", Lf = "rbxassetid://15536114370",
			Rt = "rbxassetid://15536118762", Up = "rbxassetid://15536117282"
		},
		["Realistic"] = {
			Bk = "rbxassetid://653719502", Dn = "rbxassetid://653718790",
			Ft = "rbxassetid://653719067", Lf = "rbxassetid://653719190",
			Rt = "rbxassetid://653718931", Up = "rbxassetid://653719321"
		},
	}

	local RARITY_COLORS = {
		Common = Color3.fromRGB(190, 190, 195),
		Uncommon = Color3.fromRGB(90, 210, 90),
		Rare = Color3.fromRGB(90, 160, 255),
		Epic = Color3.fromRGB(190, 90, 255),
		Legendary = Color3.fromRGB(255, 185, 20),
		Exclusive = Color3.fromRGB(255, 235, 170),
		Mythic = Color3.fromRGB(250, 30, 30),
	}
	
	local ECONOMY_COLORS = {
		safe = Color3.fromRGB(110, 210, 110),
		normal = Color3.fromRGB(110, 210, 255),
		risky = Color3.fromRGB(255, 160, 60),
		trap = Color3.fromRGB(250, 90, 90),
		jackpot = Color3.fromRGB(255, 0, 0),
	}

	local function getHRP()
		local char = LP.Character
		return char and char:FindFirstChild("HumanoidRootPart")
	end

	local function anyTrue(t)
		if type(t) ~= "table" then return false end
		for _, v in pairs(t) do if v then return true end end
		return false
	end

	local function shouldSkipPotato(object)
		if not object then return true end
		local name = object.Name or ""
		if name == "GaragePart" then return true end
		if string.find(name, "ShopZone") == 1 then return true end
		return false
	end
	
	local function applyPotatoMode()
		pcall(function()
			if PotatoModeActive then return end
			Lighting.GlobalShadows = false
			Lighting.ShadowSoftness = 0
			local atmosphere = Lighting:FindFirstChild("Atmosphere")
			if atmosphere then atmosphere:Destroy() end
			for _, obj in pairs(workspace:GetChildren()) do
				pcall(function()
					if obj:IsA("BasePart") and obj.Name ~= "Baseplate" then
						if shouldSkipPotato(obj) then return end
						obj.Material = Enum.Material.SmoothPlastic
						obj.Color = Color3.fromRGB(200, 200, 200)
						obj.Reflectance = 0
						obj.Transparency = 0
						for _, decal in pairs(obj:GetChildren()) do
							if decal:IsA("Decal") or decal:IsA("Texture") then decal:Destroy() end
						end
					end
				end)
			end
			task.wait(0.5)
			for _, obj in pairs(workspace:GetDescendants()) do
				pcall(function()
					if obj:IsA("BasePart") then
						if shouldSkipPotato(obj) then return end
						obj.Material = Enum.Material.SmoothPlastic
						obj.Color = Color3.fromRGB(200, 200, 200)
						obj.Reflectance = 0
						obj.Transparency = 0
					end
					if obj:IsA("Decal") or obj:IsA("Texture") then
						if shouldSkipPotato(obj.Parent) then return end
						obj:Destroy()
					end
					if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Smoke") then
						if shouldSkipPotato(obj.Parent) then return end
						obj.Enabled = false
					end
				end)
			end
			PotatoModeActive = true
		end)
	end
	
	workspace.DescendantAdded:Connect(function(obj)
		if CONFIG.PotatoMode then
			task.wait(0.1)
			pcall(function()
				if shouldSkipPotato(obj) then return end
				if obj:IsA("BasePart") then
					obj.Material = Enum.Material.SmoothPlastic
					obj.Color = Color3.fromRGB(200, 200, 200)
					obj.Reflectance = 0
					obj.Transparency = 0
				end
				if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
				if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Smoke") then
					obj.Enabled = false
				end
			end)
		end
	end)

	local function safeHttpGet(url)
		local success, result = pcall(function() return game:HttpGet(url) end)
		if success and result then return result end
		return nil
	end

	local function cachedHttpGet(cachePath, url)
		local hasFS = (writefile and readfile and isfile and isfolder and makefolder) and true or false
		if hasFS then
			pcall(function() if not isfolder("VeryEZ") then makefolder("VeryEZ") end end)
			local metaPath = cachePath .. ".time"
			local ok, cached = pcall(function()
				if isfile(cachePath) and isfile(metaPath) then
					local ts = tonumber(readfile(metaPath))
					if ts and (os.time() - ts) < 6 * 60 * 60 then
						return readfile(cachePath)
					end
				end
				return nil
			end)
			if ok and cached and #cached > 0 then return cached end
		end
		local result = safeHttpGet(url)
		if result and hasFS then
			pcall(function()
				writefile(cachePath, result)
				writefile(cachePath .. ".time", tostring(os.time()))
			end)
		end
		return result
	end

	local MeshMap = {}
	local NameMap = {}
	local CachedItems = {}
	local ESPReady = false
	
	local function FetchDatabases()
		local MAIN_DB_URL = "https://raw.githubusercontent.com/awaky1337/base/refs/heads/main/database.lua"
		local ACCS_URL = "https://raw.githubusercontent.com/awaky1337/base/refs/heads/main/accs_db"
		local mainRaw, accsRaw
		local mainDone, accsDone = false, false
		task.spawn(function() mainRaw = cachedHttpGet("VeryEZ/db_main.cache", MAIN_DB_URL) mainDone = true end)
		task.spawn(function() accsRaw = cachedHttpGet("VeryEZ/db_accs.cache", ACCS_URL) accsDone = true end)
		local t0 = os.clock()
		while (not mainDone or not accsDone) and (os.clock() - t0) < 15 do task.wait() end
		local db = {Items = {Shirt = {}, Pants = {}}}
		if mainRaw then
			local success, func = pcall(loadstring, mainRaw)
			if success and type(func) == "function" then
				local success2, result = pcall(func)
				if success2 and type(result) == "table" and type(result.Items) == "table" then
					db = result
				end
			end
		end
		local accessories = {}
		if accsRaw then
			accsRaw = string.gsub(accsRaw, '\\"', '"')
			local codeStr = "return {" .. accsRaw .. "}"
			local success, func = pcall(loadstring, codeStr)
			if success and type(func) == "function" then
				local success2, result = pcall(func)
				if success2 and type(result) == "table" and type(result.Accessory) == "table" then
					accessories = result.Accessory
				end
			end
		end
		
		-- ДОБАВЛЯЕМ iPhone В БАЗУ АКСЕССУАРОВ
		local iPhones = {
			{
				id = 126572492692446,
				name = "iPhone 16",
				meshId = "rbxassetid://126572492692446",
				accessoryType = "Shoulder",
				rarity = "Legendary",
				fairPrice = 95000,
				spawnChance = 2,
				economyProfile = "normal"
			},
			{
				id = 78488916364145,
				name = "iPhone 17 Pro Max Черный",
				meshId = "rbxassetid://78488916364145",
				accessoryType = "Shoulder",
				rarity = "Legendary",
				fairPrice = 165000,
				spawnChance = 2,
				economyProfile = "risky"
			},
			{
				id = 77996010468872,
				name = "iPhone 17 Pro Max Оранжевый",
				meshId = "rbxassetid://77996010468872",
				accessoryType = "Shoulder",
				rarity = "Legendary",
				fairPrice = 165000,
				spawnChance = 2,
				economyProfile = "risky"
			}
		}
		
		for _, phone in ipairs(iPhones) do
			table.insert(accessories, phone)
			if phone.meshId and phone.meshId ~= "" then				local mId = phone.meshId:lower():gsub("\\", "")
				if not MeshMap[mId] then MeshMap[mId] = {} end
				table.insert(MeshMap[mId], phone)
			end
			NameMap[phone.name:lower()] = phone
		end
		
		for _, item in ipairs(accessories) do
			if item.meshId and item.meshId ~= "" then
				local mId = item.meshId:lower():gsub("\\", "")
				if not MeshMap[mId] then MeshMap[mId] = {} end
				table.insert(MeshMap[mId], item)
			else
				NameMap[item.name:lower()] = item
			end
			if not item.spawnChance then item.spawnChance = 18 end
			if not item.economyProfile then item.economyProfile = "normal" end
			if not item.rarity then item.rarity = "Common" end
		end
		for _, category in ipairs({"Shirt", "Pants"}) do
			if db.Items[category] then
				for _, item in ipairs(db.Items[category]) do
					item.accessoryType = category
					local added = false
					for _, key in ipairs({"meshId", "templateId", "textureId"}) do
						if item[key] and item[key] ~= "" then
							local kId = item[key]:lower():gsub("\\", "")
							if not MeshMap[kId] then MeshMap[kId] = {} end
							table.insert(MeshMap[kId], item)
							added = true
						end
					end
					if not added then
						NameMap[item.name:lower()] = item
					end
					if not item.spawnChance then item.spawnChance = 18 end
					if not item.economyProfile then item.economyProfile = "normal" end
					if not item.rarity then item.rarity = "Common" end
				end
			end
		end
	end

	local function pColor(rarity)
		return RARITY_COLORS[rarity] or Color3.fromRGB(255, 255, 255)
	end
	
	local function fmtPrice(price, spawnChance, economyProfile)
		local priceStr = tostring(math.floor(price)):reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^ ", "")
		local typeStr = ""
		if economyProfile then
			local color = ECONOMY_COLORS[economyProfile] or Color3.fromRGB(255,255,255)
			local hex = string.format("#%02x%02x%02x", color.R*255, color.G*255, color.B*255)
			typeStr = '\n<font size="11" color="' .. hex .. '">[' .. string.upper(economyProfile) .. ']</font>'
		end
		if spawnChance then
			return '<font size="13"><b>$' .. priceStr .. '</b></font>\n<font size="10" color="#FFD700">Шанс: ' .. spawnChance .. '%</font>' .. typeStr
		end
		return '<font size="13"><b>$' .. priceStr .. '</b></font>' .. typeStr
	end
	
	local function getObjPosition(obj, posType)
		if posType == 1 then return obj.Position
		elseif posType == 2 then
			local pp = obj.PrimaryPart
			return pp and pp.Position or nil
		elseif posType == 3 then
			local success, result = pcall(function() return obj:GetPivot().Position end)
			return success and result or nil
		end
		return nil
	end

	local espScreenGui = Instance.new("ScreenGui")
	espScreenGui.Name = "TsumESP_Labels"
	espScreenGui.ResetOnSpawn = false
	espScreenGui.IgnoreGuiInset = true
	espScreenGui.Parent = PlayerGui

	local hlFolder = Instance.new("Folder")
	hlFolder.Name = "TsumHL"
	hlFolder.Parent = workspace

	local HighlightPool = {}
	for i = 1, 31 do
		local hl = Instance.new("Highlight")
		hl.Enabled = false
		hl.Parent = hlFolder
		table.insert(HighlightPool, hl)
	end
	
	local function AddItemToCache(obj)
		pcall(function()
			if not obj then return end
			local droppedFolder = workspace:FindFirstChild("DroppedItems")
			local isInDropped = false
			local inShopZone = false
			local ancestor = obj
			while ancestor and ancestor ~= workspace and ancestor ~= game do
				if ancestor:IsA("Model") and Players:GetPlayerFromCharacter(ancestor) then return end
				if droppedFolder and ancestor == droppedFolder then isInDropped = true end
				if string.find(ancestor.Name, "Shop_ShopZone") == 1 then inShopZone = true end
				ancestor = ancestor.Parent
			end
			if not isInDropped and not inShopZone then return end
			local possibleIds = {}
			local function addId(inst)
				if inst:IsA("MeshPart") or inst:IsA("SpecialMesh") then
					if inst.MeshId ~= "" then table.insert(possibleIds, inst.MeshId:lower()) end
				elseif inst:IsA("Shirt") then
					if inst.ShirtTemplate ~= "" then table.insert(possibleIds, inst.ShirtTemplate:lower()) end
				elseif inst:IsA("Pants") then
					if inst.PantsTemplate ~= "" then table.insert(possibleIds, inst.PantsTemplate:lower()) end
				elseif inst:IsA("Decal") then
					if inst.Texture ~= "" then table.insert(possibleIds, inst.Texture:lower()) end
				end
			end
			if obj:IsA("Model") then
				for _, child in ipairs(obj:GetDescendants()) do addId(child) end
			else addId(obj) end
			local detectedItem = nil
			for _, rawId in ipairs(possibleIds) do
				local mId = rawId:gsub("\\", "")
				local numberMatch = string.match(mId, "%d+")
				for key, items in pairs(MeshMap) do
					if key == mId or string.match(key, "%d+") == numberMatch then
						if #items == 1 then
							detectedItem = items[1]
						else
							local objName = obj.Name:lower()
							local parentName = obj.Parent and obj.Parent.Name:lower() or ""
							for _, item in ipairs(items) do
								local iName = item.name:lower()
								if objName == iName or parentName == iName or string.find(parentName, iName, 1, true) then
									detectedItem = item
									break
								end
							end
							if not detectedItem then detectedItem = items[1] end
						end
						break
					end
				end
				if detectedItem then break end
			end
			if not detectedItem then
				local n = obj.Name:lower()
				if NameMap[n] then detectedItem = NameMap[n] end
			end
			if not detectedItem then return end
			
			local rarity = detectedItem.rarity or "Common"
			if rarity == "Common" or rarity == "Uncommon" or rarity == "Rare" then
				return
			end
			
			local posType = 0
			local position = nil
			if obj:IsA("BasePart") then
				posType = 1
				position = obj.Position
			elseif obj:IsA("Model") then
				if obj.PrimaryPart then
					posType = 2
					position = obj.PrimaryPart.Position
				else
					posType = 3
					local success, result = pcall(function() return obj:GetPivot().Position end)
					if success then position = result end
				end
			end
			if not position then return end
			for _, cData in pairs(CachedItems) do
				if cData.Data and cData.Data.name == detectedItem.name and cData.Position then
					if (cData.Position - position).Magnitude < 5 then return end
				end
			end
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.Font = Enum.Font.GothamBold
			label.TextColor3 = Color3.new(1, 1, 1)
			label.RichText = true
			label.AnchorPoint = Vector2.new(0.5, 1)
			label.AutomaticSize = Enum.AutomaticSize.XY
			label.Visible = false
			label.Parent = espScreenGui
			local labelStroke = Instance.new("UIStroke")
			labelStroke.Thickness = 1
			labelStroke.Parent = label
			local gradient = Instance.new("UIGradient")
			gradient.Rotation = 0
			gradient.Parent = label
			local targetMesh = obj
			local mannequin = nil
			if obj.Name == "Mannequin" then mannequin = obj
			elseif obj:FindFirstChild("Mannequin") then mannequin = obj:FindFirstChild("Mannequin")
			elseif obj.Parent and obj.Parent:FindFirstChild("Mannequin") then mannequin = obj.Parent:FindFirstChild("Mannequin")
			end
			if mannequin then
				targetMesh = mannequin
			elseif obj:IsA("Model") then
				for _, child in ipairs(obj:GetDescendants()) do
					if child:IsA("MeshPart") or (child:IsA("Part") and child:FindFirstChildOfClass("SpecialMesh")) then
						targetMesh = child
						break
					end
				end
				if targetMesh == obj and obj.PrimaryPart then targetMesh = obj.PrimaryPart end
			end
			CachedItems[obj] = {
				Data = detectedItem,
				Label = label,
				Gradient = gradient,
				TargetMesh = targetMesh,
				PosType = posType,
				Position = position,
				IsDropped = isInDropped,
			}
		end)
	end

	local function RemoveItemFromCache(obj)
		pcall(function()
			if CachedItems[obj] then
				CachedItems[obj].Label:Destroy()
				CachedItems[obj] = nil
			end
		end)
	end

	task.spawn(function()
		FetchDatabases()
		ESPReady = true
		workspace.DescendantAdded:Connect(function(obj)
			task.spawn(function() AddItemToCache(obj) end)
		end)
		workspace.DescendantRemoving:Connect(function(obj)
			task.spawn(function() RemoveItemFromCache(obj) end)
		end)
		local toScan = {}
		for _, child in ipairs(workspace:GetChildren()) do
			if child.Name == "DroppedItems" or string.find(child.Name, "Shop_ShopZone") == 1 then
				table.insert(toScan, child)
				for _, desc in ipairs(child:GetDescendants()) do
					table.insert(toScan, desc)
				end
			end
		end
		local scanClock = os.clock()
		for i, obj in ipairs(toScan) do
			AddItemToCache(obj)
			if os.clock() - scanClock > 0.004 then
				task.wait()
				scanClock = os.clock()
			end
		end
	end)

	local function setESPVisible(visible)
		if not CachedItems then return end
		for obj, cData in pairs(CachedItems) do
			if cData.Label then cData.Label.Visible = visible end
		end
		for _, hl in ipairs(HighlightPool) do hl.Enabled = visible end
	end

	local gradientCache = {}
	local function getGradientSeq(col)
		local key = string.format("%d_%d_%d", math.floor(col.R * 255 + 0.5), math.floor(col.G * 255 + 0.5), math.floor(col.B * 255 + 0.5))
		local seq = gradientCache[key]
		if not seq then
			seq = ColorSequence.new({
				ColorSequenceKeypoint.new(0, col),
				ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, col),
			})
			gradientCache[key] = seq
		end
		return seq
	end
	
	local espAccum = 0
	RunService.RenderStepped:Connect(function(dt)
		espAccum = espAccum + (dt or 0)
		if espAccum < 0.05 then return end
		espAccum = 0
		pcall(function()
			if not CONFIG.Enabled or not ESPReady then
				for _, hl in ipairs(HighlightPool) do hl.Enabled = false end
				for _, data in pairs(CachedItems) do
					if data.Label then data.Label.Visible = false end
				end
				return
			end
			local camPos = Camera.CFrame.Position
			local hrp = getHRP()
			local activeHL = 0
			local MIN_PRICE = CONFIG.UseMinPrice and CONFIG.MinPrice or 0
			local MAX_CHANCE = CONFIG.UseMinChance and CONFIG.MaxChance or 100
			for _, hl in ipairs(HighlightPool) do hl.Enabled = false end
			for obj, cData in pairs(CachedItems) do
				if cData.Label then cData.Label.Visible = false end
				if not obj.Parent then
					RemoveItemFromCache(obj)
					continue
				end
				local itemData = cData.Data
				if not itemData then continue end
				if CONFIG.UseMinPrice and itemData.fairPrice and itemData.fairPrice < MIN_PRICE then continue end
				if CONFIG.UseMinChance and itemData.spawnChance and itemData.spawnChance > MAX_CHANCE then continue end
				local rarity = itemData.rarity or "Common"
				if not CONFIG.Filters.rarity[rarity] then continue end
				local economy = itemData.economyProfile or "normal"
				if not CONFIG.Filters.economy[economy] then continue end
				local itemName = itemData.name or ""
				local isHidden = false
				for _, hiddenName in ipairs(CONFIG.HiddenItems or {}) do
					if itemName == hiddenName then isHidden = true break end
				end
				if isHidden then continue end
				local position = getObjPosition(obj, cData.PosType)
				if not position then continue end
				cData.Position = position
				if (position - camPos).Magnitude > CONFIG.Range then continue end
				local col = pColor(itemData.rarity)
				local pos2d, onScreen = Camera:WorldToViewportPoint(position)
				if onScreen then
					local yOffset = 0
					if cData.TargetMesh:IsA("Model") then
						local success, size = pcall(function() return cData.TargetMesh:GetExtentsSize() end)
						if success then yOffset = size.Y / 2 end
					elseif cData.TargetMesh:IsA("BasePart") then
						yOffset = cData.TargetMesh.Size.Y / 2
					end
					local topPos = Camera:WorldToViewportPoint(position + Vector3.new(0, yOffset + 0.5, 0))
					local parts = {}
					if CONFIG.ShowPrice and itemData.fairPrice then
						local priceStr = fmtPrice(itemData.fairPrice, CONFIG.ShowChance and itemData.spawnChance or nil, CONFIG.ShowEconomy and itemData.economyProfile or nil)
						if priceStr ~= "" then table.insert(parts, priceStr) end
					end
					if CONFIG.ShowName then
						table.insert(parts, string.format('<font size="10">%s</font>', itemData.name or "?"))
					end
					if CONFIG.ShowDistance and hrp then
						local dist = math.floor((hrp.Position - position).Magnitude)
						table.insert(parts, string.format('<font size="9" color="#AAAAAA">[%d st]</font>', dist))
					end
					if CONFIG.ShowRarity and itemData.rarity then
						table.insert(parts, string.format('<font size="9" color="#CCCCCC">%s</font>', itemData.rarity))
					end
					cData.Label.Text = table.concat(parts, "\n")
					cData.Label.Position = UDim2.new(0, topPos.X, 0, topPos.Y)
					cData.Label.ZIndex = math.floor(10000 - pos2d.Z)
					local t = tick() % 2 / 2
					cData.Gradient.Color = getGradientSeq(col)
					cData.Gradient.Offset = Vector2.new(-1 + t * 2, 0)
					cData.Label.Visible = true
					if activeHL < 31 then
						activeHL = activeHL + 1
						local hl = HighlightPool[activeHL]
						hl.Adornee = cData.TargetMesh
						hl.FillColor = col
						hl.OutlineColor = Color3.new(1, 1, 1)
						hl.FillTransparency = 0.6
						hl.OutlineTransparency = 0.2
						hl.Enabled = true
					end
				end
			end
		end)
	end)
	
	local function enableTransparentGlass()
		RemovedGlassObjects = {}
		for _, obj in ipairs(workspace:GetDescendants()) do
			pcall(function()
				if obj:IsA("BasePart") and obj.Name == "Part" then
					if obj.Material == Enum.Material.Plastic then
						local color = obj.Color
						if math.floor(color.R * 255) == 241 and math.floor(color.G * 255) == 241 and math.floor(color.B * 255) == 241 then
							table.insert(RemovedGlassObjects, { Object = obj, Parent = obj.Parent, Transparency = obj.Transparency })
							obj.Parent = nil
						end
					end
				elseif obj:IsA("Decal") then
					if obj.Texture == "rbxassetid://110024542255576" then
						table.insert(RemovedGlassObjects, { Object = obj, Parent = obj.Parent })
						obj.Parent = nil
					end
				end
			end)
		end
	end
	
	local function disableTransparentGlass()
		for _, data in ipairs(RemovedGlassObjects) do
			pcall(function()
				if data.Object and data.Parent then
					data.Object.Parent = data.Parent
					if data.Transparency then data.Object.Transparency = data.Transparency end
				end
			end)
		end
		RemovedGlassObjects = {}
	end

	local function applySkybox(skyboxName)
		local skybox = SkyboxAssets[skyboxName]
		if skyboxName == "Classic" then
			if CurrentSkybox then CurrentSkybox:Destroy() CurrentSkybox = nil end
			if OriginalSky and OriginalSky.Parent == nil then OriginalSky.Parent = Lighting end
			return
		end
		if not skybox then return end
		if OriginalSky == nil then
			OriginalSky = Lighting:FindFirstChildOfClass("Sky")
			if OriginalSky then OriginalSky.Parent = nil end
		else
			OriginalSky.Parent = nil
		end
		if CurrentSkybox then CurrentSkybox:Destroy() end
		CurrentSkybox = Instance.new("Sky")
		CurrentSkybox.Name = "TsumSkybox"
		CurrentSkybox.SkyboxBk = skybox.Bk
		CurrentSkybox.SkyboxDn = skybox.Dn
		CurrentSkybox.SkyboxFt = skybox.Ft
		CurrentSkybox.SkyboxLf = skybox.Lf
		CurrentSkybox.SkyboxRt = skybox.Rt
		CurrentSkybox.SkyboxUp = skybox.Up
		CurrentSkybox.Parent = Lighting
	end

	local function applyMoneySpoof()
		pcall(function()
			if MONEY_SPOOF_ENABLED then
				local leaderstats = LP:FindFirstChild("leaderstats")
				if leaderstats then
					local money = leaderstats:FindFirstChild("Money")
					if money then money.Value = SPOOFED_MONEY_AMOUNT end
				end
			end
		end)
	end

	local function getNameTag()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return nil, nil end
		local bb = pg:FindFirstChild("LocalResellerNameTag")
		if not bb then return nil, nil end
		local nameLbl = bb:FindFirstChild("NameText", true)
		return bb, nameLbl
	end
	
	local function getRainbowColor()
		local hue = (tick() % 5) / 5
		return Color3.fromHSV(hue, 1, 1)
	end
	
	local function applyNickname()
		local bb, nameLbl = getNameTag()
		if not bb or not nameLbl then return end
		if originalNameText == nil then originalNameText = nameLbl.Text end
		if originalNamePos == nil then originalNamePos = nameLbl.Position end
		local displayName = (customNickname ~= "" and NICK_ENABLED) and customNickname or originalNameText
		nameLbl.Text = displayName
		if RAINBOW_NICK_ENABLED then
			nameLbl.TextColor3 = getRainbowColor()
		else
			nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		local container = nameLbl.Parent
		if PIN_ENABLED then
			if not pinIconsContainer or not pinIconsContainer.Parent then
				local iconFrame = Instance.new("Frame")
				iconFrame.Name = "TsumPinsContainer"
				iconFrame.BackgroundTransparency = 1
				iconFrame.ZIndex = (nameLbl.ZIndex or 1) + 1
				iconFrame.Parent = container
				pinIconsContainer = iconFrame
				local layout = Instance.new("UIListLayout")
				layout.FillDirection = Enum.FillDirection.Horizontal
				layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				layout.VerticalAlignment = Enum.VerticalAlignment.Center
				layout.Padding = UDim.new(0, 3)
				layout.Parent = iconFrame
			end
			for _, child in ipairs(pinIconsContainer:GetChildren()) do
				if child:IsA("ImageLabel") then child:Destroy() end
			end
			local selectedCount = 0
			for _, enabled in pairs(SELECTED_PINS) do
				if enabled then selectedCount = selectedCount + 1 end
			end
			local iconOrder = {"Developer", "YouTube", "TikTok", "Moderator", "Verify", "Star", "Premium", "VIP", "Admin", "Owner"}
			for _, pinName in ipairs(iconOrder) do
				if SELECTED_PINS[pinName] then
					local img = Instance.new("ImageLabel")
					img.Name = "Pin_" .. pinName
					img.BackgroundTransparency = 1
					img.ScaleType = Enum.ScaleType.Fit
					img.Image = PIN_TYPES[pinName]
					img.Size = UDim2.new(0, 18, 0, 18)
					img.ZIndex = (nameLbl.ZIndex or 1) + 1
					img.Parent = pinIconsContainer
				end
			end
			local frameWidth = (selectedCount * 18) + ((selectedCount - 1) * 3)
			pinIconsContainer.Size = UDim2.fromOffset(frameWidth, 18)
			pinIconsContainer.Position = UDim2.new(originalNamePos.X.Scale, originalNamePos.X.Offset, originalNamePos.Y.Scale, originalNamePos.Y.Offset - 22)
			pinIconsContainer.Visible = true
			nameLbl.Position = originalNamePos
		else
			if pinIconsContainer then pinIconsContainer.Visible = false end
			nameLbl.Position = originalNamePos
		end
	end
	
	local function revertNickname()
		local bb, nameLbl = getNameTag()
		if nameLbl and originalNameText ~= nil then
			nameLbl.Text = originalNameText
			nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		if nameLbl and originalNamePos ~= nil then nameLbl.Position = originalNamePos end
		if pinIconsContainer then pinIconsContainer.Visible = false end
	end

	UserInputService.JumpRequest:Connect(function()
		if not INF_JUMP_ENABLED then return end
		pcall(function()
			local char = LP.Character
			if not char then return end
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	end)

	local function teleportToRandomServer()
		pcall(function()
			local placeId = game.PlaceId
			local servers = {}
			local success, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", placeId)))
			end)
			if success and result and result.data then
				for _, server in ipairs(result.data) do
					if server.playing < server.maxPlayers and server.id ~= game.JobId then
						table.insert(servers, server.id)
					end
				end
				if #servers > 0 then
					local randomServer = servers[math.random(1, #servers)]
					TeleportService:TeleportToPlaceInstance(placeId, randomServer, LP)
				end
			end
		end)
	end
	VeryEZ_ServerHop = teleportToRandomServer

	local function autoSell()
	local BarigaRemotes = ReplicatedStorage:FindFirstChild("BarigaRemotes")
	if not BarigaRemotes then return end
	
	local GetBarigaInventory = BarigaRemotes:FindFirstChild("GetBarigaInventory")
	local GetBarigaOffer = BarigaRemotes:FindFirstChild("GetBarigaOffer")
	local ConfirmBarigaSale = BarigaRemotes:FindFirstChild("ConfirmBarigaSale")
	local TriggerBariga = BarigaRemotes:FindFirstChild("TriggerBariga")
	
	if not GetBarigaInventory or not GetBarigaOffer then return end
	
	local ApartmentRemotes = ReplicatedStorage:FindFirstChild("ApartmentRemotes")
	local ExitBuilding = nil
	if ApartmentRemotes then
		ExitBuilding = ApartmentRemotes:FindFirstChild("ExitBuilding")
	end
	
	local success, inventory = pcall(function() return GetBarigaInventory:InvokeServer() end)
	if not success or type(inventory) ~= "table" then return end
	
	local itemsToSell = {}
	for _, item in pairs(inventory) do
		if type(item) == "table" and item.uid and item.purchaseSource ~= "BERO" then
			local rarity = item.rarity or "Unknown"
			if CONFIG.Sell_Filters[rarity] then
				table.insert(itemsToSell, item.uid)
			end
		end
	end
	
	if #itemsToSell == 0 then return end
	
	local char = LP.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	local startPosition = hrp.CFrame
	
	if ExitBuilding then
		if ExitBuilding:IsA("RemoteEvent") then
			pcall(function() ExitBuilding:FireServer() end)
		elseif ExitBuilding:IsA("RemoteFunction") then
			pcall(function() ExitBuilding:InvokeServer() end)
		end
	end
	
	task.wait(0.15)
	
	local targetPos = CFrame.new(-5833.54, 4573.22, -2503.59)
	hrp.CFrame = targetPos
	hrp.Velocity = Vector3.new(0, 0, 0)
	
	task.wait(0.5)
	
	if TriggerBariga then 
		pcall(function() TriggerBariga:FireServer() end)
	end
	
	task.wait(0.5)
	
	local ok, result = pcall(function() return GetBarigaOffer:InvokeServer(itemsToSell) end)
	if ok and result and result.success then
		task.wait(0.5)
		if ConfirmBarigaSale then 
			pcall(function() ConfirmBarigaSale:FireServer(true) end)
		end
	else
		if ConfirmBarigaSale then 
			pcall(function() ConfirmBarigaSale:FireServer(false) end)
		end
	end
	
	task.wait(5)
	
	if ExitBuilding then
		if ExitBuilding:IsA("RemoteEvent") then
			pcall(function() ExitBuilding:FireServer() end)
		elseif ExitBuilding:IsA("RemoteFunction") then
			pcall(function() ExitBuilding:InvokeServer() end)
		end
		task.wait(0.15)
	end
	
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = startPosition
		hrp.Velocity = Vector3.new(0, 0, 0)
	end
end
	
	task.spawn(function()
		while true do
			if CONFIG.AutoSell_Enabled then autoSell() end
			task.wait(CONFIG.AutoSell_Delay)
		end
	end)

	local InstantTakeActive = false
	local function enableInstantTake()
		local ShopRemotes = ReplicatedStorage:FindFirstChild("ShopRemotes")
		if not ShopRemotes then return false end
		local TakeItem = ShopRemotes:FindFirstChild("TakeItem")
		if not TakeItem then return false end
		local function fixPrompts()
			for _, prompt in pairs(workspace:GetDescendants()) do
				if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end
			end
		end
		fixPrompts()
		workspace.DescendantAdded:Connect(function(obj)
			if obj:IsA("ProximityPrompt") and CONFIG.InstantTake then obj.HoldDuration = 0 end
		end)
		local SignalBehavior = ShopRemotes:FindFirstChild("SignalBehavior")
		if SignalBehavior and SignalBehavior:IsA("RemoteEvent") then
			SignalBehavior.OnServerEvent:Connect(function(player, action, ...)
				if CONFIG.InstantTake and action == "TakeItem" then
					local args = {...}
					task.spawn(function() TakeItem:FireServer(unpack(args)) end)
				end
			end)
		end
		return true
	end
	
	local function toggleInstantTake(enabled)
		CONFIG.InstantTake = enabled
		if enabled then
			if not InstantTakeActive then InstantTakeActive = enableInstantTake() end
		else
			InstantTakeActive = false
		end
	end

	local function syncConfig()
		CONFIG.Enabled = ItemsESP.Enabled
		CONFIG.Range = ItemsESP.Distance
		CONFIG.UseMinPrice = PriceFilters.UseMinPrice
		CONFIG.MinPrice = PriceFilters.MinPrice
		CONFIG.UseMinChance = PriceFilters.UseSpawnChance
		CONFIG.MaxChance = PriceFilters.MaxSpawnChance

		CONFIG.AutoSell_Enabled = AutoSell.Enabled
		CONFIG.AutoSell_Delay = AutoSell.Delay
		for k in pairs(CONFIG.Sell_Filters) do
			CONFIG.Sell_Filters[k] = AutoSell.Filters[k] and true or false
		end

		local anyRarity = anyTrue(PriceFilters.Rarity)
		for k in pairs(CONFIG.Filters.rarity) do
			if anyRarity then
				CONFIG.Filters.rarity[k] = PriceFilters.Rarity[k] and true or false
			else
				CONFIG.Filters.rarity[k] = true
			end
		end

		local ecoMap = { Safe="safe", Normal="normal", Risky="risky", Trap="trap", Jackpot="jackpot" }
		local anyEco = anyTrue(PriceFilters.Economy)
		for uiKey, engineKey in pairs(ecoMap) do
			if anyEco then
				CONFIG.Filters.economy[engineKey] = PriceFilters.Economy[uiKey] and true or false
			else
				CONFIG.Filters.economy[engineKey] = true
			end
		end

		TRANSPARENT_GLASS_ENABLED = WorldVisuals.TransparentGlass
		TIME_CHANGER_ENABLED = WorldVisuals.TimeChanger
		CURRENT_TIME = WorldVisuals.TimeOfDay

		MONEY_SPOOF_ENABLED = MoneySpoof.Enabled
		SPOOFED_MONEY_AMOUNT = MoneySpoof.Amount

		NICK_ENABLED = NicknamePins.CustomNickname
		customNickname = NicknamePins.Nickname
		RAINBOW_NICK_ENABLED = NicknamePins.RainbowNickname
		PIN_ENABLED = NicknamePins.PinsAboveName
		for k in pairs(SELECTED_PINS) do SELECTED_PINS[k] = nil end
		for shortKey, on in pairs(NicknamePins.Pins) do
			if on then
				local engineKey = PIN_KEYMAP[shortKey]
				if engineKey then SELECTED_PINS[engineKey] = true end
			end
		end

		CONFIG.PotatoMode = MiscOther.PotatoMode
		CONFIG.InstantTake = MiscOther.InstantTake
		SPEED_ENABLED = Movement.SpeedEnabled
		CURRENT_SPEED = Movement.WalkSpeed
		INF_JUMP_ENABLED = Movement.InfinityJump
	end

	local prevGlass = false
	local prevSky = WorldVisuals.Skybox
	local prevPotato = false
	local prevInstant = false

	local syncAccum = 0
	RunService.Heartbeat:Connect(function(dt)
		syncAccum = syncAccum + (dt or 0)
		if syncAccum < 0.1 then return end
		syncAccum = 0
		syncConfig()

		if TRANSPARENT_GLASS_ENABLED ~= prevGlass then
			prevGlass = TRANSPARENT_GLASS_ENABLED
			if TRANSPARENT_GLASS_ENABLED then enableTransparentGlass() else disableTransparentGlass() end
		end

		if WorldVisuals.Skybox ~= prevSky then
			prevSky = WorldVisuals.Skybox
			applySkybox(WorldVisuals.Skybox)
		end

		if CONFIG.PotatoMode and not prevPotato then
			prevPotato = true
			applyPotatoMode()
		end

		if CONFIG.InstantTake ~= prevInstant then
			prevInstant = CONFIG.InstantTake
			toggleInstantTake(CONFIG.InstantTake)
		end
	end)

	RunService.RenderStepped:Connect(function()
		if TIME_CHANGER_ENABLED then
			Lighting.ClockTime = CURRENT_TIME
		end
		if SPEED_ENABLED then
			local char = LP.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = CURRENT_SPEED end
		end
	end)

	task.spawn(function()
		while task.wait(0.5) do
			if MONEY_SPOOF_ENABLED then applyMoneySpoof() end
		end
	end)

	task.spawn(function()
		local nickActive = false
		while task.wait(0.1) do
			if NICK_ENABLED or PIN_ENABLED or RAINBOW_NICK_ENABLED then
				applyNickname()
				nickActive = true
			elseif nickActive then
				nickActive = false
				revertNickname()
			end
		end
	end)
end

-- ============== KEY SYSTEM ==============
do
	local CORRECT_KEY = "LEGKO"
	local KEY_FOLDER = "VeryEZ"
	local KEY_FILE = "VeryEZ/key.json"
	local KEY_TTL = 24 * 60 * 60
	local DISCORD_INVITE = "https://discord.gg/tCdbzsQsK"
	local hasFS = (writefile and readfile and isfile) and true or false

	MainFrame.Visible = false
	Background.Visible = false
	Blur.Enabled = false

	local function saveKey()
		if not hasFS then return end
		pcall(function()
			if isfolder and makefolder and not isfolder(KEY_FOLDER) then makefolder(KEY_FOLDER) end
			writefile(KEY_FILE, HttpService:JSONEncode({ key = CORRECT_KEY, time = os.time() }))
		end)
	end

	local function hasValidKey()
		if not hasFS or not isfile(KEY_FILE) then return false end
		local ok, data = pcall(function() return HttpService:JSONDecode(readfile(KEY_FILE)) end)
		if ok and type(data) == "table" and data.key == CORRECT_KEY and type(data.time) == "number" then
			return (os.time() - data.time) < KEY_TTL
		end
		return false
	end

	local function revealMenu()
		unlocked = true
		MainFrame.Position = UDim2.new(0.5, 0, 0, -300)
		MainFrame.Visible = true
		Background.BackgroundTransparency = 1
		Background.Visible = true
		Blur.Size = 0
		Blur.Enabled = true
		local ti = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		TweenService:Create(Blur, TweenInfo.new(0.35), {Size = 10}):Play()
		TweenService:Create(Background, TweenInfo.new(0.35), {BackgroundTransparency = 0.5}):Play()
		TweenService:Create(MainFrame, ti, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	end

	if hasValidKey() then
		revealMenu()
	else
		local KeyGui = Instance.new("ScreenGui")
		KeyGui.Name = "VeryEZ_Key"
		KeyGui.ResetOnSpawn = false
		KeyGui.IgnoreGuiInset = true
		KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		KeyGui.Parent = PlayerGui

		local KeyBg = Instance.new("Frame")
		KeyBg.Size = UDim2.new(1, 0, 1, 0)
		KeyBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		KeyBg.BackgroundTransparency = 0.45
		KeyBg.BorderSizePixel = 0
		KeyBg.Parent = KeyGui

		local KeyBlur = Instance.new("BlurEffect")
		KeyBlur.Size = 12
		KeyBlur.Parent = Lighting

		local Win = Instance.new("Frame")
		Win.AnchorPoint = Vector2.new(0.5, 0.5)
		Win.Position = UDim2.new(0.5, 0, 0.5, 0)
		Win.Size = UDim2.new(0, 340, 0, 0)
		Win.AutomaticSize = Enum.AutomaticSize.Y
		Win.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		Win.BackgroundTransparency = 0.05
		Win.BorderSizePixel = 0
		Win.Parent = KeyGui

		local winCorner = Instance.new("UICorner") winCorner.CornerRadius = UDim.new(0, 12) winCorner.Parent = Win
		local winStroke = Instance.new("UIStroke") winStroke.Color = Color3.fromRGB(255, 255, 255) winStroke.Transparency = 0.9 winStroke.Parent = Win

		local winPad = Instance.new("UIPadding")
		winPad.PaddingTop = UDim.new(0, 22) winPad.PaddingBottom = UDim.new(0, 22)
		winPad.PaddingLeft = UDim.new(0, 22) winPad.PaddingRight = UDim.new(0, 22)
		winPad.Parent = Win

		local winLayout = Instance.new("UIListLayout")
		winLayout.Padding = UDim.new(0, 12)
		winLayout.SortOrder = Enum.SortOrder.LayoutOrder
		winLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		winLayout.Parent = Win

		local heading = Instance.new("TextLabel")
		heading.LayoutOrder = 0
		heading.BackgroundTransparency = 1
		heading.Size = UDim2.new(1, 0, 0, 28)
		heading.Text = "Enter Key"
		heading.TextColor3 = Color3.fromRGB(255, 255, 255)
		heading.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		heading.TextSize = 22
		heading.Parent = Win

		local sub = Instance.new("TextLabel")
		sub.LayoutOrder = 1
		sub.BackgroundTransparency = 1
		sub.Size = UDim2.new(1, 0, 0, 18)
		sub.AutomaticSize = Enum.AutomaticSize.Y
		sub.Text = "Join our Discord server to get the key"
		sub.TextColor3 = Color3.fromRGB(180, 180, 195)
		sub.TextWrapped = true
		sub.FontFace = Font.new("rbxassetid://12187365364")
		sub.TextSize = 13
		sub.Parent = Win

		local boxFrame = Instance.new("Frame")
		boxFrame.LayoutOrder = 2
		boxFrame.Size = UDim2.new(1, 0, 0, 38)
		boxFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
		boxFrame.BorderSizePixel = 0
		boxFrame.Parent = Win
		local bfCorner = Instance.new("UICorner") bfCorner.CornerRadius = UDim.new(0, 8) bfCorner.Parent = boxFrame
		local bfStroke = Instance.new("UIStroke") bfStroke.Color = Color3.fromRGB(255, 255, 255) bfStroke.Transparency = 0.85 bfStroke.Parent = boxFrame
		local bfPad = Instance.new("UIPadding") bfPad.PaddingLeft = UDim.new(0, 12) bfPad.PaddingRight = UDim.new(0, 12) bfPad.Parent = boxFrame

		local keyBox = Instance.new("TextBox")
		keyBox.BackgroundTransparency = 1
		keyBox.Size = UDim2.new(1, 0, 1, 0)
		keyBox.Text = ""
		keyBox.PlaceholderText = "Key..."
		keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
		keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		keyBox.TextXAlignment = Enum.TextXAlignment.Center
		keyBox.FontFace = Font.new("rbxassetid://12187365364")
		keyBox.TextSize = 15
		keyBox.ClearTextOnFocus = false
		keyBox.Parent = boxFrame

		local status = Instance.new("TextLabel")
		status.LayoutOrder = 3
		status.BackgroundTransparency = 1
		status.Size = UDim2.new(1, 0, 0, 16)
		status.Text = ""
		status.TextColor3 = Color3.fromRGB(250, 93, 86)
		status.FontFace = Font.new("rbxassetid://12187365364")
		status.TextSize = 12
		status.Parent = Win

		local function makeBtn(order, text, bg, fg)
			local b = Instance.new("TextButton")
			b.LayoutOrder = order
			b.Size = UDim2.new(1, 0, 0, 40)
			b.BackgroundColor3 = bg
			b.TextColor3 = fg
			b.AutoButtonColor = false
			b.Text = text
			b.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			b.TextSize = 14
			b.Parent = Win
			local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = b
			return b
		end

		local submitBtn = makeBtn(4, "Submit Key", Color3.fromRGB(252, 190, 57), Color3.fromRGB(15, 15, 15))
		local discordBtn = makeBtn(5, "Join Discord (copy invite)", Color3.fromRGB(88, 101, 242), Color3.fromRGB(255, 255, 255))

		local function closeAndReveal()
			saveKey()
			local fade = TweenInfo.new(0.25)
			TweenService:Create(KeyBg, fade, {BackgroundTransparency = 1}):Play()
			TweenService:Create(KeyBlur, fade, {Size = 0}):Play()
			task.delay(0.26, function()
				pcall(function() KeyBlur:Destroy() end)
				KeyGui:Destroy()
			end)
			revealMenu()
		end

		local function trySubmit()
			local entered = keyBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
			if entered == CORRECT_KEY then
				status.TextColor3 = Color3.fromRGB(139, 195, 74)
				status.Text = "Key accepted!"
				closeAndReveal()
			else
				status.TextColor3 = Color3.fromRGB(250, 93, 86)
				status.Text = "Invalid key. Try again."
			end
		end

		submitBtn.MouseButton1Click:Connect(trySubmit)
		keyBox.FocusLost:Connect(function(enter) if enter then trySubmit() end end)

		discordBtn.MouseButton1Click:Connect(function()
			local cb = setclipboard or toclipboard or setrbxclipboard or (syn and syn.write_clipboard)
			if cb then
				pcall(cb, DISCORD_INVITE)
				status.TextColor3 = Color3.fromRGB(139, 195, 74)
				status.Text = "Invite copied!"
			else
				status.TextColor3 = Color3.fromRGB(252, 190, 57)
				status.Text = DISCORD_INVITE
			end
		end)
	end
end

print("GUI Ready!")
