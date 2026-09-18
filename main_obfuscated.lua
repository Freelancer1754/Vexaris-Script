-- ════════════════
-- ══  Services  ══
-- ════════════════

local Username        = _G.Username      or "Developer"
local UserRole        = _G.Role          or "user"
local UserId          = _G.UserId        or "DEV"
local Erweiterungen   = _G.Erweiterungen or {--[["germanrail", "rivals"]] "Murder_Mystery_2", "Jailbird"}
local UpdateVersion   = _G.UpdateVersion or "v1.0.0"
local UpdateDate      = _G.UpdateDate    or "01.01.2020"
local UpdateAdded     = _G.UpdateAdded   or {"• Kein Added-Update gefunden"}
local UpdateChanged   = _G.UpdateChanged or {"• Kein Changed-Update gefunden"}
local UpdateRemoved   = _G.UpdateRemoved or {"• Kein Remove-Update gefunden"}

local SCRIPT_KILLED = false

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService       = game:GetService("GuiService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local Camera           = workspace.CurrentCamera
local Players
for _, service in ipairs(game:GetChildren()) do
    if service.ClassName == "Players" then
        Players = service
        break
    end
end
local LocalPlayer      = Players.LocalPlayer
local BASE_FOLDER      = "Vexaris"
local CONFIG_FOLDER    = "Vexaris/Configs"
local SERVER_BASE_URL  = "https://vexaris-menu.vercel.app"
if not isfolder(BASE_FOLDER) then
    makefolder(BASE_FOLDER)
end
if not isfolder(CONFIG_FOLDER) then
    makefolder(CONFIG_FOLDER)
end

local function ListConfigs()
    local result = {}
    local ok, files = pcall(listfiles, CONFIG_FOLDER)
    if not ok then return result end
    for _, path in ipairs(files) do
        local name = path:match("([^/\\]+)%.json$")
        if name then
            table.insert(result, name)
        end
    end
    return result
end

local DeleteGui
DeleteGui = game:GetService("CoreGui"):FindFirstChild("VexarisGui") or LocalPlayer.PlayerGui:FindFirstChild("VexarisGui")
local DeleteBlur = game:GetService("Lighting"):FindFirstChild("VexarisBlur")
if DeleteGui and DeleteBlur then
    DeleteGui:Destroy()
    DeleteBlur:Destroy()
end


local Gui = {}

local function BuildGui1()
	Gui.VexarisGui = Instance.new("ScreenGui")
	Gui.VexarisGui.Name = "VexarisGui"
	Gui.VexarisGui.Enabled = true
	Gui.VexarisGui.DisplayOrder = 0
	Gui.VexarisGui.IgnoreGuiInset = false
	Gui.VexarisGui.ResetOnSpawn = true
	Gui.VexarisGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension
	Gui.VexarisGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	Gui.VexarisGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Gui.VexarisGui.Archivable = true

	Gui.MAIN_FRAME = Instance.new("Frame")
	Gui.MAIN_FRAME.Name = "MAIN_FRAME"
	Gui.MAIN_FRAME.Active = false
	Gui.MAIN_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.MAIN_FRAME.BackgroundTransparency = 0
	Gui.MAIN_FRAME.BorderColor3 = Color3.fromRGB(42, 92, 170)
	Gui.MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.MAIN_FRAME.BorderSizePixel = 0
	Gui.MAIN_FRAME.ClipsDescendants = false
	Gui.MAIN_FRAME.Draggable = false
	Gui.MAIN_FRAME.LayoutOrder = 0
	Gui.MAIN_FRAME.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.MAIN_FRAME.Rotation = 0
	Gui.MAIN_FRAME.Selectable = false
	Gui.MAIN_FRAME.Size = UDim2.new(0.339, 0, 0.453, 0)
	Gui.MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MAIN_FRAME.Visible = true
	Gui.MAIN_FRAME.ZIndex = 999
	Gui.MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.MAIN_FRAME.Archivable = true
	Gui.MAIN_FRAME.Parent = Gui.VexarisGui

	Gui.UICorner = Instance.new("UICorner")
	Gui.UICorner.Name = "UICorner"
	Gui.UICorner.CornerRadius = UDim.new(0.03, 0)
	Gui.UICorner.Archivable = true
	Gui.UICorner.Parent = Gui.MAIN_FRAME

	Gui.HEADER_MAINFRAME = Instance.new("Frame")
	Gui.HEADER_MAINFRAME.Name = "HEADER_MAINFRAME"
	Gui.HEADER_MAINFRAME.Active = false
	Gui.HEADER_MAINFRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.HEADER_MAINFRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.HEADER_MAINFRAME.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.HEADER_MAINFRAME.BackgroundTransparency = 0
	Gui.HEADER_MAINFRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HEADER_MAINFRAME.BorderMode = Enum.BorderMode.Outline
	Gui.HEADER_MAINFRAME.BorderSizePixel = 0
	Gui.HEADER_MAINFRAME.ClipsDescendants = false
	Gui.HEADER_MAINFRAME.Draggable = false
	Gui.HEADER_MAINFRAME.LayoutOrder = 0
	Gui.HEADER_MAINFRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.HEADER_MAINFRAME.Rotation = 0
	Gui.HEADER_MAINFRAME.Selectable = false
	Gui.HEADER_MAINFRAME.Size = UDim2.new(1, 0, 0.165, 0)
	Gui.HEADER_MAINFRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HEADER_MAINFRAME.Visible = true
	Gui.HEADER_MAINFRAME.ZIndex = 2
	Gui.HEADER_MAINFRAME.Style = Enum.FrameStyle.Custom
	Gui.HEADER_MAINFRAME.Archivable = true
	Gui.HEADER_MAINFRAME.Parent = Gui.MAIN_FRAME

	Gui.UICorner_1 = Instance.new("UICorner")
	Gui.UICorner_1.Name = "UICorner"
	Gui.UICorner_1.CornerRadius = UDim.new(0.14, 0)
	Gui.UICorner_1.Archivable = true
	Gui.UICorner_1.Parent = Gui.HEADER_MAINFRAME

	Gui.HIDE_CORNER = Instance.new("Frame")
	Gui.HIDE_CORNER.Name = "HIDE_CORNER"
	Gui.HIDE_CORNER.Active = false
	Gui.HIDE_CORNER.AnchorPoint = Vector2.new(0, 0)
	Gui.HIDE_CORNER.AutomaticSize = Enum.AutomaticSize.None
	Gui.HIDE_CORNER.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.HIDE_CORNER.BackgroundTransparency = 0
	Gui.HIDE_CORNER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HIDE_CORNER.BorderMode = Enum.BorderMode.Outline
	Gui.HIDE_CORNER.BorderSizePixel = 0
	Gui.HIDE_CORNER.ClipsDescendants = false
	Gui.HIDE_CORNER.Draggable = false
	Gui.HIDE_CORNER.LayoutOrder = 0
	Gui.HIDE_CORNER.Position = UDim2.new(0, 0, 0.775, 0)
	Gui.HIDE_CORNER.Rotation = 0
	Gui.HIDE_CORNER.Selectable = false
	Gui.HIDE_CORNER.Size = UDim2.new(1, 0, 0.224, 0)
	Gui.HIDE_CORNER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HIDE_CORNER.Visible = true
	Gui.HIDE_CORNER.ZIndex = 1
	Gui.HIDE_CORNER.Style = Enum.FrameStyle.Custom
	Gui.HIDE_CORNER.Archivable = true
	Gui.HIDE_CORNER.Parent = Gui.HEADER_MAINFRAME

	Gui.LOGO_LABEL = Instance.new("ImageLabel")
	Gui.LOGO_LABEL.Name = "LOGO_LABEL"
	Gui.LOGO_LABEL.Active = false
	Gui.LOGO_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.LOGO_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.LOGO_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL.BackgroundTransparency = 1
	Gui.LOGO_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LOGO_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.LOGO_LABEL.BorderSizePixel = 0
	Gui.LOGO_LABEL.ClipsDescendants = false
	Gui.LOGO_LABEL.Draggable = false
	Gui.LOGO_LABEL.LayoutOrder = 0
	Gui.LOGO_LABEL.Position = UDim2.new(0.012, 0, 0.231, 0)
	Gui.LOGO_LABEL.Rotation = 0
	Gui.LOGO_LABEL.Selectable = false
	Gui.LOGO_LABEL.Size = UDim2.new(0.223, 0, 0.501, 0)
	Gui.LOGO_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LOGO_LABEL.Visible = true
	Gui.LOGO_LABEL.ZIndex = 1
	Gui.LOGO_LABEL.Image = "rbxassetid://73763802551746"
	Gui.LOGO_LABEL.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL.ImageRectOffset = Vector2.new(0, 0)
	Gui.LOGO_LABEL.ImageRectSize = Vector2.new(0, 0)
	Gui.LOGO_LABEL.ImageTransparency = 0
	Gui.LOGO_LABEL.ResampleMode = Enum.ResamplerMode.Default
	Gui.LOGO_LABEL.ScaleType = Enum.ScaleType.Stretch
	Gui.LOGO_LABEL.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.LOGO_LABEL.SliceScale = 1
	Gui.LOGO_LABEL.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.LOGO_LABEL.Archivable = true
	Gui.LOGO_LABEL.Parent = Gui.HEADER_MAINFRAME

	Gui.SIDEBAR_MAINFRAME = Instance.new("Frame")
	Gui.SIDEBAR_MAINFRAME.Name = "SIDEBAR_MAINFRAME"
	Gui.SIDEBAR_MAINFRAME.Active = false
	Gui.SIDEBAR_MAINFRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.SIDEBAR_MAINFRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.SIDEBAR_MAINFRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.SIDEBAR_MAINFRAME.BackgroundTransparency = 0
	Gui.SIDEBAR_MAINFRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SIDEBAR_MAINFRAME.BorderMode = Enum.BorderMode.Outline
	Gui.SIDEBAR_MAINFRAME.BorderSizePixel = 0
	Gui.SIDEBAR_MAINFRAME.ClipsDescendants = false
	Gui.SIDEBAR_MAINFRAME.Draggable = false
	Gui.SIDEBAR_MAINFRAME.LayoutOrder = 0
	Gui.SIDEBAR_MAINFRAME.Position = UDim2.new(0, 0, 0.098, 0)
	Gui.SIDEBAR_MAINFRAME.Rotation = 0
	Gui.SIDEBAR_MAINFRAME.Selectable = false
	Gui.SIDEBAR_MAINFRAME.Size = UDim2.new(0.238, 0, 0.902, 0)
	Gui.SIDEBAR_MAINFRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SIDEBAR_MAINFRAME.Visible = true
	Gui.SIDEBAR_MAINFRAME.ZIndex = 1
	Gui.SIDEBAR_MAINFRAME.Style = Enum.FrameStyle.Custom
	Gui.SIDEBAR_MAINFRAME.Archivable = true
	Gui.SIDEBAR_MAINFRAME.Parent = Gui.MAIN_FRAME

	Gui.ScrollingFrame = Instance.new("ScrollingFrame")
	Gui.ScrollingFrame.Name = "ScrollingFrame"
	Gui.ScrollingFrame.Active = true
	Gui.ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
	Gui.ScrollingFrame.AutomaticSize = Enum.AutomaticSize.None
	Gui.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.ScrollingFrame.BackgroundTransparency = 1
	Gui.ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ScrollingFrame.BorderMode = Enum.BorderMode.Outline
	Gui.ScrollingFrame.BorderSizePixel = 0
	Gui.ScrollingFrame.ClipsDescendants = true
	Gui.ScrollingFrame.Draggable = false
	Gui.ScrollingFrame.LayoutOrder = 0
	Gui.ScrollingFrame.Position = UDim2.new(0.061, 0, 0.11, 0)
	Gui.ScrollingFrame.Rotation = 0
	Gui.ScrollingFrame.Selectable = true
	Gui.ScrollingFrame.Size = UDim2.new(0.878, 0, 0.798, 0)
	Gui.ScrollingFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ScrollingFrame.Visible = true
	Gui.ScrollingFrame.ZIndex = 1
	Gui.ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Gui.ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Gui.ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
	Gui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
	Gui.ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Gui.ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Gui.ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Gui.ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ScrollingFrame.ScrollBarImageTransparency = 0
	Gui.ScrollingFrame.ScrollBarThickness = 0
	Gui.ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.XY
	Gui.ScrollingFrame.ScrollingEnabled = true
	Gui.ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Gui.ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Gui.ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	Gui.ScrollingFrame.Archivable = true
	Gui.ScrollingFrame.Parent = Gui.SIDEBAR_MAINFRAME

	Gui.UIListLayout = Instance.new("UIListLayout")
	Gui.UIListLayout.Name = "UIListLayout"
	Gui.UIListLayout.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout.Padding = UDim.new(0.01, 0)
	Gui.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout.Wraps = false
	Gui.UIListLayout.Archivable = true
	Gui.UIListLayout.Parent = Gui.ScrollingFrame

	Gui.UICorner_2 = Instance.new("UICorner")
	Gui.UICorner_2.Name = "UICorner"
	Gui.UICorner_2.CornerRadius = UDim.new(0.08, 0)
	Gui.UICorner_2.Archivable = true
	Gui.UICorner_2.Parent = Gui.SIDEBAR_MAINFRAME

	Gui.SIDEBAR_MAINFRAME_1 = Instance.new("Frame")
	Gui.SIDEBAR_MAINFRAME_1.Name = "SIDEBAR_MAINFRAME"
	Gui.SIDEBAR_MAINFRAME_1.Active = false
	Gui.SIDEBAR_MAINFRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.SIDEBAR_MAINFRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.SIDEBAR_MAINFRAME_1.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.SIDEBAR_MAINFRAME_1.BackgroundTransparency = 0
	Gui.SIDEBAR_MAINFRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SIDEBAR_MAINFRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.SIDEBAR_MAINFRAME_1.BorderSizePixel = 0
	Gui.SIDEBAR_MAINFRAME_1.ClipsDescendants = false
	Gui.SIDEBAR_MAINFRAME_1.Draggable = false
	Gui.SIDEBAR_MAINFRAME_1.LayoutOrder = 0
	Gui.SIDEBAR_MAINFRAME_1.Position = UDim2.new(0.914, 0, 0, 0)
	Gui.SIDEBAR_MAINFRAME_1.Rotation = 0
	Gui.SIDEBAR_MAINFRAME_1.Selectable = false
	Gui.SIDEBAR_MAINFRAME_1.Size = UDim2.new(0.086, 0, 1, 0)
	Gui.SIDEBAR_MAINFRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SIDEBAR_MAINFRAME_1.Visible = true
	Gui.SIDEBAR_MAINFRAME_1.ZIndex = 0
	Gui.SIDEBAR_MAINFRAME_1.Style = Enum.FrameStyle.Custom
	Gui.SIDEBAR_MAINFRAME_1.Archivable = true
	Gui.SIDEBAR_MAINFRAME_1.Parent = Gui.SIDEBAR_MAINFRAME

	Gui.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint.AspectRatio = 1.543
	Gui.UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint.Archivable = true
	Gui.UIAspectRatioConstraint.Parent = Gui.MAIN_FRAME

	Gui.DRAG_FRAME = Instance.new("Frame")
	Gui.DRAG_FRAME.Name = "DRAG_FRAME"
	Gui.DRAG_FRAME.Active = false
	Gui.DRAG_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.DRAG_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.DRAG_FRAME.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.DRAG_FRAME.BackgroundTransparency = 1
	Gui.DRAG_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.DRAG_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.DRAG_FRAME.BorderSizePixel = 0
	Gui.DRAG_FRAME.ClipsDescendants = false
	Gui.DRAG_FRAME.Draggable = false
	Gui.DRAG_FRAME.LayoutOrder = 0
	Gui.DRAG_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.DRAG_FRAME.Rotation = 0
	Gui.DRAG_FRAME.Selectable = false
	Gui.DRAG_FRAME.Size = UDim2.new(1, 0, 0.098, 0)
	Gui.DRAG_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.DRAG_FRAME.Visible = true
	Gui.DRAG_FRAME.ZIndex = 1
	Gui.DRAG_FRAME.Style = Enum.FrameStyle.Custom
	Gui.DRAG_FRAME.Archivable = true
	Gui.DRAG_FRAME.Parent = Gui.MAIN_FRAME

	Gui.MenuDragDetector = Instance.new("UIDragDetector")
	Gui.MenuDragDetector.Name = "MenuDragDetector"
	Gui.MenuDragDetector.Enabled = true
	Gui.MenuDragDetector.Archivable = true
	Gui.MenuDragDetector.Parent = Gui.DRAG_FRAME

	Gui.MAIN_CONTENT_FRAME = Instance.new("Frame")
	Gui.MAIN_CONTENT_FRAME.Name = "MAIN_CONTENT_FRAME"
	Gui.MAIN_CONTENT_FRAME.Active = false
	Gui.MAIN_CONTENT_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.MAIN_CONTENT_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.MAIN_CONTENT_FRAME.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.MAIN_CONTENT_FRAME.BackgroundTransparency = 1
	Gui.MAIN_CONTENT_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MAIN_CONTENT_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.MAIN_CONTENT_FRAME.BorderSizePixel = 0
	Gui.MAIN_CONTENT_FRAME.ClipsDescendants = false
	Gui.MAIN_CONTENT_FRAME.Draggable = false
	Gui.MAIN_CONTENT_FRAME.LayoutOrder = 0
	Gui.MAIN_CONTENT_FRAME.Position = UDim2.new(0.242, 0, 0.171, 0)
	Gui.MAIN_CONTENT_FRAME.Rotation = 0
	Gui.MAIN_CONTENT_FRAME.Selectable = false
	Gui.MAIN_CONTENT_FRAME.Size = UDim2.new(0.758, 0, 0.827, 0)
	Gui.MAIN_CONTENT_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MAIN_CONTENT_FRAME.Visible = true
	Gui.MAIN_CONTENT_FRAME.ZIndex = 1
	Gui.MAIN_CONTENT_FRAME.Style = Enum.FrameStyle.Custom
	Gui.MAIN_CONTENT_FRAME.Archivable = true
	Gui.MAIN_CONTENT_FRAME.Parent = Gui.MAIN_FRAME

	Gui.KEYBIND_FRAME = Instance.new("Frame")
	Gui.KEYBIND_FRAME.Name = "KEYBIND_FRAME"
	Gui.KEYBIND_FRAME.Active = false
	Gui.KEYBIND_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.KEYBIND_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEYBIND_FRAME.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.KEYBIND_FRAME.BackgroundTransparency = 0
	Gui.KEYBIND_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_FRAME.BorderSizePixel = 0
	Gui.KEYBIND_FRAME.ClipsDescendants = false
	Gui.KEYBIND_FRAME.Draggable = false
	Gui.KEYBIND_FRAME.LayoutOrder = 0
	Gui.KEYBIND_FRAME.Position = UDim2.new(0.5, 0, 0.824, 0)
	Gui.KEYBIND_FRAME.Rotation = 0
	Gui.KEYBIND_FRAME.Selectable = false
	Gui.KEYBIND_FRAME.Size = UDim2.new(0.201, 0, 0.165, 0)
	Gui.KEYBIND_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_FRAME.Visible = false
	Gui.KEYBIND_FRAME.ZIndex = 100
	Gui.KEYBIND_FRAME.Style = Enum.FrameStyle.Custom
	Gui.KEYBIND_FRAME.Archivable = true
	Gui.KEYBIND_FRAME.Parent = Gui.VexarisGui

	Gui.UICorner_3 = Instance.new("UICorner")
	Gui.UICorner_3.Name = "UICorner"
	Gui.UICorner_3.CornerRadius = UDim.new(0.075, 0)
	Gui.UICorner_3.Archivable = true
	Gui.UICorner_3.Parent = Gui.KEYBIND_FRAME

	Gui.Frame = Instance.new("Frame")
	Gui.Frame.Name = "Frame"
	Gui.Frame.Active = false
	Gui.Frame.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.Frame.BackgroundTransparency = 0
	Gui.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame.BorderMode = Enum.BorderMode.Outline
	Gui.Frame.BorderSizePixel = 0
	Gui.Frame.ClipsDescendants = false
	Gui.Frame.Draggable = false
	Gui.Frame.LayoutOrder = 0
	Gui.Frame.Position = UDim2.new(0, 0, 0, 0)
	Gui.Frame.Rotation = 0
	Gui.Frame.Selectable = false
	Gui.Frame.Size = UDim2.new(1, 0, 0.275, 0)
	Gui.Frame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame.Visible = true
	Gui.Frame.ZIndex = 1
	Gui.Frame.Style = Enum.FrameStyle.Custom
	Gui.Frame.Archivable = true
	Gui.Frame.Parent = Gui.KEYBIND_FRAME

	Gui.UICorner_4 = Instance.new("UICorner")
	Gui.UICorner_4.Name = "UICorner"
	Gui.UICorner_4.CornerRadius = UDim.new(0.19, 0)
	Gui.UICorner_4.Archivable = true
	Gui.UICorner_4.Parent = Gui.Frame

	Gui.Frame_1 = Instance.new("Frame")
	Gui.Frame_1.Name = "Frame"
	Gui.Frame_1.Active = false
	Gui.Frame_1.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_1.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.Frame_1.BackgroundTransparency = 0
	Gui.Frame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_1.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_1.BorderSizePixel = 0
	Gui.Frame_1.ClipsDescendants = false
	Gui.Frame_1.Draggable = false
	Gui.Frame_1.LayoutOrder = 0
	Gui.Frame_1.Position = UDim2.new(0, 0, 0.446, 0)
	Gui.Frame_1.Rotation = 0
	Gui.Frame_1.Selectable = false
	Gui.Frame_1.Size = UDim2.new(1, 0, 0.554, 0)
	Gui.Frame_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_1.Visible = true
	Gui.Frame_1.ZIndex = 1
	Gui.Frame_1.Style = Enum.FrameStyle.Custom
	Gui.Frame_1.Archivable = true
	Gui.Frame_1.Parent = Gui.Frame

	Gui.LOGO_LABEL_1 = Instance.new("ImageLabel")
	Gui.LOGO_LABEL_1.Name = "LOGO_LABEL"
	Gui.LOGO_LABEL_1.Active = false
	Gui.LOGO_LABEL_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LOGO_LABEL_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.LOGO_LABEL_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_1.BackgroundTransparency = 1
	Gui.LOGO_LABEL_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LOGO_LABEL_1.BorderMode = Enum.BorderMode.Outline
	Gui.LOGO_LABEL_1.BorderSizePixel = 0
	Gui.LOGO_LABEL_1.ClipsDescendants = false
	Gui.LOGO_LABEL_1.Draggable = false
	Gui.LOGO_LABEL_1.LayoutOrder = 0
	Gui.LOGO_LABEL_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.LOGO_LABEL_1.Rotation = 0
	Gui.LOGO_LABEL_1.Selectable = false
	Gui.LOGO_LABEL_1.Size = UDim2.new(0.364, 0, 0.828, 0)
	Gui.LOGO_LABEL_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LOGO_LABEL_1.Visible = true
	Gui.LOGO_LABEL_1.ZIndex = 1
	Gui.LOGO_LABEL_1.Image = "rbxassetid://73763802551746"
	Gui.LOGO_LABEL_1.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_1.ImageRectOffset = Vector2.new(0, 0)
	Gui.LOGO_LABEL_1.ImageRectSize = Vector2.new(0, 0)
	Gui.LOGO_LABEL_1.ImageTransparency = 0
	Gui.LOGO_LABEL_1.ResampleMode = Enum.ResamplerMode.Default
	Gui.LOGO_LABEL_1.ScaleType = Enum.ScaleType.Stretch
	Gui.LOGO_LABEL_1.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.LOGO_LABEL_1.SliceScale = 1
	Gui.LOGO_LABEL_1.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.LOGO_LABEL_1.Archivable = true
	Gui.LOGO_LABEL_1.Parent = Gui.Frame

	Gui.Frame_2 = Instance.new("Frame")
	Gui.Frame_2.Name = "Frame"
	Gui.Frame_2.Active = false
	Gui.Frame_2.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_2.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.Frame_2.BackgroundTransparency = 1
	Gui.Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_2.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_2.BorderSizePixel = 0
	Gui.Frame_2.ClipsDescendants = false
	Gui.Frame_2.Draggable = false
	Gui.Frame_2.LayoutOrder = 0
	Gui.Frame_2.Position = UDim2.new(0, 0, 0.275, 0)
	Gui.Frame_2.Rotation = 0
	Gui.Frame_2.Selectable = false
	Gui.Frame_2.Size = UDim2.new(1, 0, 0.725, 0)
	Gui.Frame_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_2.Visible = true
	Gui.Frame_2.ZIndex = 1
	Gui.Frame_2.Style = Enum.FrameStyle.Custom
	Gui.Frame_2.Archivable = true
	Gui.Frame_2.Parent = Gui.KEYBIND_FRAME

	Gui.KEYBIND_INFOLABEL = Instance.new("TextLabel")
	Gui.KEYBIND_INFOLABEL.Name = "KEYBIND_INFOLABEL"
	Gui.KEYBIND_INFOLABEL.Active = false
	Gui.KEYBIND_INFOLABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_INFOLABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEYBIND_INFOLABEL.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
	Gui.KEYBIND_INFOLABEL.BackgroundTransparency = 1
	Gui.KEYBIND_INFOLABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_INFOLABEL.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_INFOLABEL.BorderSizePixel = 0
	Gui.KEYBIND_INFOLABEL.ClipsDescendants = false
	Gui.KEYBIND_INFOLABEL.Draggable = false
	Gui.KEYBIND_INFOLABEL.LayoutOrder = 0
	Gui.KEYBIND_INFOLABEL.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_INFOLABEL.Rotation = 0
	Gui.KEYBIND_INFOLABEL.Selectable = false
	Gui.KEYBIND_INFOLABEL.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_INFOLABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_INFOLABEL.Visible = true
	Gui.KEYBIND_INFOLABEL.ZIndex = 1
	Gui.KEYBIND_INFOLABEL.Font = Enum.Font.Unknown
	Gui.KEYBIND_INFOLABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_INFOLABEL.LineHeight = 1
	Gui.KEYBIND_INFOLABEL.MaxVisibleGraphemes = -1
	Gui.KEYBIND_INFOLABEL.RichText = false
	Gui.KEYBIND_INFOLABEL.Text = "Wähle eine Taste um das Menü zu öffnen!"
	Gui.KEYBIND_INFOLABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.KEYBIND_INFOLABEL.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_INFOLABEL.TextScaled = true
	Gui.KEYBIND_INFOLABEL.TextSize = 42
	Gui.KEYBIND_INFOLABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_INFOLABEL.TextStrokeTransparency = 1
	Gui.KEYBIND_INFOLABEL.TextTransparency = 0
	Gui.KEYBIND_INFOLABEL.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_INFOLABEL.TextWrapped = true
	Gui.KEYBIND_INFOLABEL.TextXAlignment = Enum.TextXAlignment.Center
	Gui.KEYBIND_INFOLABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_INFOLABEL.Archivable = true
	Gui.KEYBIND_INFOLABEL.Parent = Gui.Frame_2

	Gui.UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint.MaxTextSize = 42
	Gui.UITextSizeConstraint.MinTextSize = 1
	Gui.UITextSizeConstraint.Archivable = true
	Gui.UITextSizeConstraint.Parent = Gui.KEYBIND_INFOLABEL

	Gui.COLOR_FRAME = Instance.new("Frame")
	Gui.COLOR_FRAME.Name = "COLOR_FRAME"
	Gui.COLOR_FRAME.Active = false
	Gui.COLOR_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COLOR_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_FRAME.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.COLOR_FRAME.BackgroundTransparency = 0
	Gui.COLOR_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_FRAME.BorderSizePixel = 0
	Gui.COLOR_FRAME.ClipsDescendants = false
	Gui.COLOR_FRAME.Draggable = false
	Gui.COLOR_FRAME.LayoutOrder = 0
	Gui.COLOR_FRAME.Position = UDim2.new(0.8, 0, 0.5, 0)
	Gui.COLOR_FRAME.Rotation = 0
	Gui.COLOR_FRAME.Selectable = false
	Gui.COLOR_FRAME.Size = UDim2.new(0.211, 0, 0.482, 0)
	Gui.COLOR_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_FRAME.Visible = false
	Gui.COLOR_FRAME.ZIndex = 1000
	Gui.COLOR_FRAME.Style = Enum.FrameStyle.Custom
	Gui.COLOR_FRAME.Archivable = true
	Gui.COLOR_FRAME.Parent = Gui.VexarisGui

	Gui.ColorTestHandler = Instance.new("LocalScript")
	Gui.ColorTestHandler.Name = "ColorTestHandler"
	Gui.ColorTestHandler.Enabled = true
	Gui.ColorTestHandler.Archivable = true
	Gui.ColorTestHandler.Parent = Gui.COLOR_FRAME

	Gui.COLOR_DRAGGER_FRAME = Instance.new("Frame")
	Gui.COLOR_DRAGGER_FRAME.Name = "COLOR_DRAGGER_FRAME"
	Gui.COLOR_DRAGGER_FRAME.Active = false
	Gui.COLOR_DRAGGER_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_DRAGGER_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_DRAGGER_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_DRAGGER_FRAME.BackgroundTransparency = 0
	Gui.COLOR_DRAGGER_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_DRAGGER_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_DRAGGER_FRAME.BorderSizePixel = 0
	Gui.COLOR_DRAGGER_FRAME.ClipsDescendants = false
	Gui.COLOR_DRAGGER_FRAME.Draggable = false
	Gui.COLOR_DRAGGER_FRAME.LayoutOrder = 0
	Gui.COLOR_DRAGGER_FRAME.Position = UDim2.new(0.094, 0, 0.752, 0)
	Gui.COLOR_DRAGGER_FRAME.Rotation = 0
	Gui.COLOR_DRAGGER_FRAME.Selectable = false
	Gui.COLOR_DRAGGER_FRAME.Size = UDim2.new(0.81, 0, 0.013, 0)
	Gui.COLOR_DRAGGER_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_DRAGGER_FRAME.Visible = true
	Gui.COLOR_DRAGGER_FRAME.ZIndex = 1
	Gui.COLOR_DRAGGER_FRAME.Style = Enum.FrameStyle.Custom
	Gui.COLOR_DRAGGER_FRAME.Archivable = true
	Gui.COLOR_DRAGGER_FRAME.Parent = Gui.COLOR_FRAME

	Gui.UIGradient = Instance.new("UIGradient")
	Gui.UIGradient.Name = "UIGradient"
	Gui.UIGradient.Rotation = 0
	Gui.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.16599999368190765, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.3330000042915344, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.6660000085830688, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.8330000042915344, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))})
	Gui.UIGradient.Enabled = true
	Gui.UIGradient.Offset = Vector2.new(0, 0)
	Gui.UIGradient.Scale = 1
	Gui.UIGradient.Archivable = true
	Gui.UIGradient.Parent = Gui.COLOR_DRAGGER_FRAME

	Gui.Begrenzung = Instance.new("Frame")
	Gui.Begrenzung.Name = "Begrenzung"
	Gui.Begrenzung.Active = false
	Gui.Begrenzung.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.Begrenzung.AutomaticSize = Enum.AutomaticSize.None
	Gui.Begrenzung.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Begrenzung.BackgroundTransparency = 1
	Gui.Begrenzung.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Begrenzung.BorderMode = Enum.BorderMode.Outline
	Gui.Begrenzung.BorderSizePixel = 0
	Gui.Begrenzung.ClipsDescendants = false
	Gui.Begrenzung.Draggable = false
	Gui.Begrenzung.LayoutOrder = 0
	Gui.Begrenzung.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.Begrenzung.Rotation = 0
	Gui.Begrenzung.Selectable = false
	Gui.Begrenzung.Size = UDim2.new(1, 0, 2.278, 0)
	Gui.Begrenzung.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Begrenzung.Visible = true
	Gui.Begrenzung.ZIndex = 1
	Gui.Begrenzung.Style = Enum.FrameStyle.Custom
	Gui.Begrenzung.Archivable = true
	Gui.Begrenzung.Parent = Gui.COLOR_DRAGGER_FRAME

	Gui.UICorner_5 = Instance.new("UICorner")
	Gui.UICorner_5.Name = "UICorner"
	Gui.UICorner_5.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_5.Archivable = true
	Gui.UICorner_5.Parent = Gui.COLOR_DRAGGER_FRAME

	Gui.DRAGGER = Instance.new("ImageLabel")
	Gui.DRAGGER.Name = "DRAGGER"
	Gui.DRAGGER.Active = false
	Gui.DRAGGER.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.DRAGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.DRAGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.DRAGGER.BackgroundTransparency = 1
	Gui.DRAGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.DRAGGER.BorderMode = Enum.BorderMode.Outline
	Gui.DRAGGER.BorderSizePixel = 0
	Gui.DRAGGER.ClipsDescendants = false
	Gui.DRAGGER.Draggable = false
	Gui.DRAGGER.LayoutOrder = 0
	Gui.DRAGGER.Position = UDim2.new(0, 0, 0.5, 0)
	Gui.DRAGGER.Rotation = 0
	Gui.DRAGGER.Selectable = false
	Gui.DRAGGER.Size = UDim2.new(0.042, 0, 2.278, 0)
	Gui.DRAGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.DRAGGER.Visible = true
	Gui.DRAGGER.ZIndex = 1
	Gui.DRAGGER.Image = "rbxassetid://71369027911692"
	Gui.DRAGGER.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.DRAGGER.ImageRectOffset = Vector2.new(0, 0)
	Gui.DRAGGER.ImageRectSize = Vector2.new(0, 0)
	Gui.DRAGGER.ImageTransparency = 0
	Gui.DRAGGER.ResampleMode = Enum.ResamplerMode.Default
	Gui.DRAGGER.ScaleType = Enum.ScaleType.Stretch
	Gui.DRAGGER.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.DRAGGER.SliceScale = 1
	Gui.DRAGGER.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.DRAGGER.Archivable = true
	Gui.DRAGGER.Parent = Gui.COLOR_DRAGGER_FRAME

	Gui.UICorner_6 = Instance.new("UICorner")
	Gui.UICorner_6.Name = "UICorner"
	Gui.UICorner_6.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_6.Archivable = true
	Gui.UICorner_6.Parent = Gui.DRAGGER

	Gui.COLOR_PREVIEW = Instance.new("Frame")
	Gui.COLOR_PREVIEW.Name = "COLOR_PREVIEW"
	Gui.COLOR_PREVIEW.Active = false
	Gui.COLOR_PREVIEW.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_PREVIEW.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_PREVIEW.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_PREVIEW.BackgroundTransparency = 0
	Gui.COLOR_PREVIEW.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_PREVIEW.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_PREVIEW.BorderSizePixel = 0
	Gui.COLOR_PREVIEW.ClipsDescendants = false
	Gui.COLOR_PREVIEW.Draggable = false
	Gui.COLOR_PREVIEW.LayoutOrder = 0
	Gui.COLOR_PREVIEW.Position = UDim2.new(0.094, 0, 0.8, 0)
	Gui.COLOR_PREVIEW.Rotation = 0
	Gui.COLOR_PREVIEW.Selectable = false
	Gui.COLOR_PREVIEW.Size = UDim2.new(0.183, 0, 0.166, 0)
	Gui.COLOR_PREVIEW.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_PREVIEW.Visible = true
	Gui.COLOR_PREVIEW.ZIndex = 1
	Gui.COLOR_PREVIEW.Style = Enum.FrameStyle.Custom
	Gui.COLOR_PREVIEW.Archivable = true
	Gui.COLOR_PREVIEW.Parent = Gui.COLOR_FRAME

	Gui.UICorner_7 = Instance.new("UICorner")
	Gui.UICorner_7.Name = "UICorner"
	Gui.UICorner_7.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_7.Archivable = true
	Gui.UICorner_7.Parent = Gui.COLOR_PREVIEW

	Gui.MAIN_COLOR_FIELD = Instance.new("Frame")
	Gui.MAIN_COLOR_FIELD.Name = "MAIN_COLOR_FIELD"
	Gui.MAIN_COLOR_FIELD.Active = false
	Gui.MAIN_COLOR_FIELD.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.MAIN_COLOR_FIELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.MAIN_COLOR_FIELD.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
	Gui.MAIN_COLOR_FIELD.BackgroundTransparency = 0
	Gui.MAIN_COLOR_FIELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MAIN_COLOR_FIELD.BorderMode = Enum.BorderMode.Outline
	Gui.MAIN_COLOR_FIELD.BorderSizePixel = 0
	Gui.MAIN_COLOR_FIELD.ClipsDescendants = false
	Gui.MAIN_COLOR_FIELD.Draggable = false
	Gui.MAIN_COLOR_FIELD.LayoutOrder = 0
	Gui.MAIN_COLOR_FIELD.Position = UDim2.new(0.5, 0, 0.421, 0)
	Gui.MAIN_COLOR_FIELD.Rotation = 0
	Gui.MAIN_COLOR_FIELD.Selectable = false
	Gui.MAIN_COLOR_FIELD.Size = UDim2.new(0.809, 0, 0.601, 0)
	Gui.MAIN_COLOR_FIELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MAIN_COLOR_FIELD.Visible = true
	Gui.MAIN_COLOR_FIELD.ZIndex = 2
	Gui.MAIN_COLOR_FIELD.Style = Enum.FrameStyle.Custom
	Gui.MAIN_COLOR_FIELD.Archivable = true
	Gui.MAIN_COLOR_FIELD.Parent = Gui.COLOR_FRAME

	Gui.Frame_3 = Instance.new("Frame")
	Gui.Frame_3.Name = "Frame"
	Gui.Frame_3.Active = false
	Gui.Frame_3.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Frame_3.BackgroundTransparency = 0
	Gui.Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_3.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_3.BorderSizePixel = 0
	Gui.Frame_3.ClipsDescendants = false
	Gui.Frame_3.Draggable = false
	Gui.Frame_3.LayoutOrder = 0
	Gui.Frame_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.Frame_3.Rotation = 0
	Gui.Frame_3.Selectable = false
	Gui.Frame_3.Size = UDim2.new(1, 0, 1, 0)
	Gui.Frame_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_3.Visible = true
	Gui.Frame_3.ZIndex = 1
	Gui.Frame_3.Style = Enum.FrameStyle.Custom
	Gui.Frame_3.Archivable = true
	Gui.Frame_3.Parent = Gui.MAIN_COLOR_FIELD

	Gui.UIGradient_1 = Instance.new("UIGradient")
	Gui.UIGradient_1.Name = "UIGradient"
	Gui.UIGradient_1.Rotation = 0
	Gui.UIGradient_1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
	Gui.UIGradient_1.Enabled = true
	Gui.UIGradient_1.Offset = Vector2.new(0, 0)
	Gui.UIGradient_1.Scale = 1
	Gui.UIGradient_1.Archivable = true
	Gui.UIGradient_1.Parent = Gui.Frame_3

	Gui.UICorner_8 = Instance.new("UICorner")
	Gui.UICorner_8.Name = "UICorner"
	Gui.UICorner_8.CornerRadius = UDim.new(0.03, 0)
	Gui.UICorner_8.Archivable = true
	Gui.UICorner_8.Parent = Gui.Frame_3

	Gui.Frame_4 = Instance.new("Frame")
	Gui.Frame_4.Name = "Frame"
	Gui.Frame_4.Active = false
	Gui.Frame_4.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_4.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Frame_4.BackgroundTransparency = 0
	Gui.Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_4.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_4.BorderSizePixel = 0
	Gui.Frame_4.ClipsDescendants = false
	Gui.Frame_4.Draggable = false
	Gui.Frame_4.LayoutOrder = 0
	Gui.Frame_4.Position = UDim2.new(0, 0, 0, 0)
	Gui.Frame_4.Rotation = 0
	Gui.Frame_4.Selectable = false
	Gui.Frame_4.Size = UDim2.new(1, 0, 1, 0)
	Gui.Frame_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_4.Visible = true
	Gui.Frame_4.ZIndex = 1
	Gui.Frame_4.Style = Enum.FrameStyle.Custom
	Gui.Frame_4.Archivable = true
	Gui.Frame_4.Parent = Gui.MAIN_COLOR_FIELD

	Gui.UIGradient_2 = Instance.new("UIGradient")
	Gui.UIGradient_2.Name = "UIGradient"
	Gui.UIGradient_2.Rotation = 90
	Gui.UIGradient_2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))})
	Gui.UIGradient_2.Enabled = true
	Gui.UIGradient_2.Offset = Vector2.new(0, 0)
	Gui.UIGradient_2.Scale = 1
	Gui.UIGradient_2.Archivable = true
	Gui.UIGradient_2.Parent = Gui.Frame_4

	Gui.UICorner_9 = Instance.new("UICorner")
	Gui.UICorner_9.Name = "UICorner"
	Gui.UICorner_9.CornerRadius = UDim.new(0.03, 0)
	Gui.UICorner_9.Archivable = true
	Gui.UICorner_9.Parent = Gui.Frame_4

	Gui.Main_Dragger = Instance.new("ImageLabel")
	Gui.Main_Dragger.Name = "Main_Dragger"
	Gui.Main_Dragger.Active = false
	Gui.Main_Dragger.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.Main_Dragger.AutomaticSize = Enum.AutomaticSize.None
	Gui.Main_Dragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Main_Dragger.BackgroundTransparency = 1
	Gui.Main_Dragger.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Main_Dragger.BorderMode = Enum.BorderMode.Outline
	Gui.Main_Dragger.BorderSizePixel = 0
	Gui.Main_Dragger.ClipsDescendants = false
	Gui.Main_Dragger.Draggable = false
	Gui.Main_Dragger.LayoutOrder = 0
	Gui.Main_Dragger.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.Main_Dragger.Rotation = 0
	Gui.Main_Dragger.Selectable = false
	Gui.Main_Dragger.Size = UDim2.new(0.042, 0, 0.05, 0)
	Gui.Main_Dragger.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Main_Dragger.Visible = true
	Gui.Main_Dragger.ZIndex = 1
	Gui.Main_Dragger.Image = "rbxassetid://71369027911692"
	Gui.Main_Dragger.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Main_Dragger.ImageRectOffset = Vector2.new(0, 0)
	Gui.Main_Dragger.ImageRectSize = Vector2.new(0, 0)
	Gui.Main_Dragger.ImageTransparency = 0
	Gui.Main_Dragger.ResampleMode = Enum.ResamplerMode.Default
	Gui.Main_Dragger.ScaleType = Enum.ScaleType.Stretch
	Gui.Main_Dragger.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.Main_Dragger.SliceScale = 1
	Gui.Main_Dragger.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.Main_Dragger.Archivable = true
	Gui.Main_Dragger.Parent = Gui.MAIN_COLOR_FIELD

	Gui.UIDragDetector = Instance.new("UIDragDetector")
	Gui.UIDragDetector.Name = "UIDragDetector"
	Gui.UIDragDetector.Enabled = false
	Gui.UIDragDetector.Archivable = true
	Gui.UIDragDetector.Parent = Gui.Main_Dragger

	Gui.UICorner_10 = Instance.new("UICorner")
	Gui.UICorner_10.Name = "UICorner"
	Gui.UICorner_10.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_10.Archivable = true
	Gui.UICorner_10.Parent = Gui.Main_Dragger

	Gui.UICorner_11 = Instance.new("UICorner")
	Gui.UICorner_11.Name = "UICorner"
	Gui.UICorner_11.CornerRadius = UDim.new(0.03, 0)
	Gui.UICorner_11.Archivable = true
	Gui.UICorner_11.Parent = Gui.MAIN_COLOR_FIELD

	Gui.Frame_5 = Instance.new("Frame")
	Gui.Frame_5.Name = "Frame"
	Gui.Frame_5.Active = false
	Gui.Frame_5.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_5.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_5.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.Frame_5.BackgroundTransparency = 0
	Gui.Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_5.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_5.BorderSizePixel = 0
	Gui.Frame_5.ClipsDescendants = false
	Gui.Frame_5.Draggable = false
	Gui.Frame_5.LayoutOrder = 0
	Gui.Frame_5.Position = UDim2.new(0, 0, 0.001, 0)
	Gui.Frame_5.Rotation = 0
	Gui.Frame_5.Selectable = false
	Gui.Frame_5.Size = UDim2.new(1, 0, 0.078, 0)
	Gui.Frame_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_5.Visible = true
	Gui.Frame_5.ZIndex = 1
	Gui.Frame_5.Style = Enum.FrameStyle.Custom
	Gui.Frame_5.Archivable = true
	Gui.Frame_5.Parent = Gui.COLOR_FRAME

	Gui.UICorner_12 = Instance.new("UICorner")
	Gui.UICorner_12.Name = "UICorner"
	Gui.UICorner_12.CornerRadius = UDim.new(0.3, 0)
	Gui.UICorner_12.Archivable = true
	Gui.UICorner_12.Parent = Gui.Frame_5

	Gui.Frame_6 = Instance.new("Frame")
	Gui.Frame_6.Name = "Frame"
	Gui.Frame_6.Active = false
	Gui.Frame_6.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_6.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_6.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Gui.Frame_6.BackgroundTransparency = 0
	Gui.Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_6.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_6.BorderSizePixel = 0
	Gui.Frame_6.ClipsDescendants = false
	Gui.Frame_6.Draggable = false
	Gui.Frame_6.LayoutOrder = 0
	Gui.Frame_6.Position = UDim2.new(0, 0, 0.446, 0)
	Gui.Frame_6.Rotation = 0
	Gui.Frame_6.Selectable = false
	Gui.Frame_6.Size = UDim2.new(1, 0, 0.554, 0)
	Gui.Frame_6.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_6.Visible = true
	Gui.Frame_6.ZIndex = 1
	Gui.Frame_6.Style = Enum.FrameStyle.Custom
	Gui.Frame_6.Archivable = true
	Gui.Frame_6.Parent = Gui.Frame_5

	Gui.LOGO_LABEL_2 = Instance.new("ImageLabel")
	Gui.LOGO_LABEL_2.Name = "LOGO_LABEL"
	Gui.LOGO_LABEL_2.Active = false
	Gui.LOGO_LABEL_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LOGO_LABEL_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.LOGO_LABEL_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_2.BackgroundTransparency = 1
	Gui.LOGO_LABEL_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LOGO_LABEL_2.BorderMode = Enum.BorderMode.Outline
	Gui.LOGO_LABEL_2.BorderSizePixel = 0
	Gui.LOGO_LABEL_2.ClipsDescendants = false
	Gui.LOGO_LABEL_2.Draggable = false
	Gui.LOGO_LABEL_2.LayoutOrder = 0
	Gui.LOGO_LABEL_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.LOGO_LABEL_2.Rotation = 0
	Gui.LOGO_LABEL_2.Selectable = false
	Gui.LOGO_LABEL_2.Size = UDim2.new(0.314, 0, 0.862, 0)
	Gui.LOGO_LABEL_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LOGO_LABEL_2.Visible = true
	Gui.LOGO_LABEL_2.ZIndex = 1
	Gui.LOGO_LABEL_2.Image = "rbxassetid://73763802551746"
	Gui.LOGO_LABEL_2.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_2.ImageRectOffset = Vector2.new(0, 0)
	Gui.LOGO_LABEL_2.ImageRectSize = Vector2.new(0, 0)
	Gui.LOGO_LABEL_2.ImageTransparency = 0
	Gui.LOGO_LABEL_2.ResampleMode = Enum.ResamplerMode.Default
	Gui.LOGO_LABEL_2.ScaleType = Enum.ScaleType.Stretch
	Gui.LOGO_LABEL_2.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.LOGO_LABEL_2.SliceScale = 1
	Gui.LOGO_LABEL_2.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.LOGO_LABEL_2.Archivable = true
	Gui.LOGO_LABEL_2.Parent = Gui.Frame_5

	Gui.UICorner_13 = Instance.new("UICorner")
	Gui.UICorner_13.Name = "UICorner"
	Gui.UICorner_13.CornerRadius = UDim.new(0.03, 0)
	Gui.UICorner_13.Archivable = true
	Gui.UICorner_13.Parent = Gui.COLOR_FRAME

	Gui.Color_HSV = Instance.new("StringValue")
	Gui.Color_HSV.Name = "Color_HSV"
	Gui.Color_HSV.Archivable = true
	Gui.Color_HSV.Parent = Gui.COLOR_FRAME

	Gui.UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_1.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_1.AspectRatio = 0.901
	Gui.UIAspectRatioConstraint_1.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_1.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_1.Archivable = true
	Gui.UIAspectRatioConstraint_1.Parent = Gui.COLOR_FRAME

	Gui.RGB_FIELDS = Instance.new("Frame")
	Gui.RGB_FIELDS.Name = "RGB_FIELDS"
	Gui.RGB_FIELDS.Active = false
	Gui.RGB_FIELDS.AnchorPoint = Vector2.new(0, 0)
	Gui.RGB_FIELDS.AutomaticSize = Enum.AutomaticSize.None
	Gui.RGB_FIELDS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RGB_FIELDS.BackgroundTransparency = 1
	Gui.RGB_FIELDS.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RGB_FIELDS.BorderMode = Enum.BorderMode.Outline
	Gui.RGB_FIELDS.BorderSizePixel = 0
	Gui.RGB_FIELDS.ClipsDescendants = false
	Gui.RGB_FIELDS.Draggable = false
	Gui.RGB_FIELDS.LayoutOrder = 0
	Gui.RGB_FIELDS.Position = UDim2.new(0.301, 0, 0.801, 0)
	Gui.RGB_FIELDS.Rotation = 0
	Gui.RGB_FIELDS.Selectable = false
	Gui.RGB_FIELDS.Size = UDim2.new(0, 324, 0, 41)
	Gui.RGB_FIELDS.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RGB_FIELDS.Visible = true
	Gui.RGB_FIELDS.ZIndex = 1
	Gui.RGB_FIELDS.Style = Enum.FrameStyle.Custom
	Gui.RGB_FIELDS.Archivable = true
	Gui.RGB_FIELDS.Parent = Gui.COLOR_FRAME

	Gui.R_FELD_FRAME = Instance.new("Frame")
	Gui.R_FELD_FRAME.Name = "R_FELD_FRAME"
	Gui.R_FELD_FRAME.Active = false
	Gui.R_FELD_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.R_FELD_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.R_FELD_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.R_FELD_FRAME.BackgroundTransparency = 0
	Gui.R_FELD_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.R_FELD_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.R_FELD_FRAME.BorderSizePixel = 0
	Gui.R_FELD_FRAME.ClipsDescendants = false
	Gui.R_FELD_FRAME.Draggable = false
	Gui.R_FELD_FRAME.LayoutOrder = 0
	Gui.R_FELD_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.R_FELD_FRAME.Rotation = 0
	Gui.R_FELD_FRAME.Selectable = false
	Gui.R_FELD_FRAME.Size = UDim2.new(0.302, 0, 1, 0)
	Gui.R_FELD_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.R_FELD_FRAME.Visible = true
	Gui.R_FELD_FRAME.ZIndex = 1
	Gui.R_FELD_FRAME.Style = Enum.FrameStyle.Custom
	Gui.R_FELD_FRAME.Archivable = true
	Gui.R_FELD_FRAME.Parent = Gui.RGB_FIELDS

	Gui.R_FELD = Instance.new("TextBox")
	Gui.R_FELD.Name = "R_FELD"
	Gui.R_FELD.Active = true
	Gui.R_FELD.AnchorPoint = Vector2.new(0, 0)
	Gui.R_FELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.R_FELD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.R_FELD.BackgroundTransparency = 1
	Gui.R_FELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.R_FELD.BorderMode = Enum.BorderMode.Outline
	Gui.R_FELD.BorderSizePixel = 0
	Gui.R_FELD.ClipsDescendants = false
	Gui.R_FELD.Draggable = false
	Gui.R_FELD.LayoutOrder = 0
	Gui.R_FELD.Position = UDim2.new(0.358, 0, 0, 0)
	Gui.R_FELD.Rotation = 0
	Gui.R_FELD.Selectable = true
	Gui.R_FELD.Size = UDim2.new(0.637, 0, 1, 0)
	Gui.R_FELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.R_FELD.Visible = true
	Gui.R_FELD.ZIndex = 1
	Gui.R_FELD.Font = Enum.Font.Unknown
	Gui.R_FELD.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.R_FELD.LineHeight = 1
	Gui.R_FELD.MaxVisibleGraphemes = -1
	Gui.R_FELD.RichText = false
	Gui.R_FELD.Text = ""
	Gui.R_FELD.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.R_FELD.TextDirection = Enum.TextDirection.Auto
	Gui.R_FELD.TextScaled = false
	Gui.R_FELD.TextSize = 34
	Gui.R_FELD.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.R_FELD.TextStrokeTransparency = 1
	Gui.R_FELD.TextTransparency = 0
	Gui.R_FELD.TextTruncate = Enum.TextTruncate.None
	Gui.R_FELD.TextWrapped = false
	Gui.R_FELD.TextXAlignment = Enum.TextXAlignment.Center
	Gui.R_FELD.TextYAlignment = Enum.TextYAlignment.Center
	Gui.R_FELD.PlaceholderColor3 = Color3.fromRGB(220, 220, 225)
	Gui.R_FELD.PlaceholderText = ""
	Gui.R_FELD.ClearTextOnFocus = true
	Gui.R_FELD.MultiLine = false
	Gui.R_FELD.ShowNativeInput = true
	Gui.R_FELD.Archivable = true
	Gui.R_FELD.Parent = Gui.R_FELD_FRAME

	Gui.TextLabel = Instance.new("TextLabel")
	Gui.TextLabel.Name = "TextLabel"
	Gui.TextLabel.Active = false
	Gui.TextLabel.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel.BackgroundTransparency = 1
	Gui.TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel.BorderSizePixel = 0
	Gui.TextLabel.ClipsDescendants = false
	Gui.TextLabel.Draggable = false
	Gui.TextLabel.LayoutOrder = 0
	Gui.TextLabel.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel.Rotation = 0
	Gui.TextLabel.Selectable = false
	Gui.TextLabel.Size = UDim2.new(0.407, 0, 0.951, 0)
	Gui.TextLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel.Visible = true
	Gui.TextLabel.ZIndex = 1
	Gui.TextLabel.Font = Enum.Font.Unknown
	Gui.TextLabel.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel.LineHeight = 1
	Gui.TextLabel.MaxVisibleGraphemes = -1
	Gui.TextLabel.RichText = false
	Gui.TextLabel.Text = "R"
	Gui.TextLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel.TextScaled = false
	Gui.TextLabel.TextSize = 34
	Gui.TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel.TextStrokeTransparency = 1
	Gui.TextLabel.TextTransparency = 0
	Gui.TextLabel.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel.TextWrapped = false
	Gui.TextLabel.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel.Archivable = true
	Gui.TextLabel.Parent = Gui.R_FELD_FRAME

	Gui.UICorner_14 = Instance.new("UICorner")
	Gui.UICorner_14.Name = "UICorner"
	Gui.UICorner_14.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_14.Archivable = true
	Gui.UICorner_14.Parent = Gui.R_FELD_FRAME

	Gui.UIListLayout_1 = Instance.new("UIListLayout")
	Gui.UIListLayout_1.Name = "UIListLayout"
	Gui.UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_1.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_1.Wraps = false
	Gui.UIListLayout_1.Archivable = true
	Gui.UIListLayout_1.Parent = Gui.RGB_FIELDS

	Gui.G_FELD_FRAME = Instance.new("Frame")
	Gui.G_FELD_FRAME.Name = "G_FELD_FRAME"
	Gui.G_FELD_FRAME.Active = false
	Gui.G_FELD_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.G_FELD_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.G_FELD_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.G_FELD_FRAME.BackgroundTransparency = 0
	Gui.G_FELD_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.G_FELD_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.G_FELD_FRAME.BorderSizePixel = 0
	Gui.G_FELD_FRAME.ClipsDescendants = false
	Gui.G_FELD_FRAME.Draggable = false
	Gui.G_FELD_FRAME.LayoutOrder = 0
	Gui.G_FELD_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.G_FELD_FRAME.Rotation = 0
	Gui.G_FELD_FRAME.Selectable = false
	Gui.G_FELD_FRAME.Size = UDim2.new(0.302, 0, 1, 0)
	Gui.G_FELD_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.G_FELD_FRAME.Visible = true
	Gui.G_FELD_FRAME.ZIndex = 1
	Gui.G_FELD_FRAME.Style = Enum.FrameStyle.Custom
	Gui.G_FELD_FRAME.Archivable = true
	Gui.G_FELD_FRAME.Parent = Gui.RGB_FIELDS

	Gui.G_FELD = Instance.new("TextBox")
	Gui.G_FELD.Name = "G_FELD"
	Gui.G_FELD.Active = true
	Gui.G_FELD.AnchorPoint = Vector2.new(0, 0)
	Gui.G_FELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.G_FELD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.G_FELD.BackgroundTransparency = 1
	Gui.G_FELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.G_FELD.BorderMode = Enum.BorderMode.Outline
	Gui.G_FELD.BorderSizePixel = 0
	Gui.G_FELD.ClipsDescendants = false
	Gui.G_FELD.Draggable = false
	Gui.G_FELD.LayoutOrder = 0
	Gui.G_FELD.Position = UDim2.new(0.358, 0, 0, 0)
	Gui.G_FELD.Rotation = 0
	Gui.G_FELD.Selectable = true
	Gui.G_FELD.Size = UDim2.new(0.637, 0, 1, 0)
	Gui.G_FELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.G_FELD.Visible = true
	Gui.G_FELD.ZIndex = 1
	Gui.G_FELD.Font = Enum.Font.Unknown
	Gui.G_FELD.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.G_FELD.LineHeight = 1
	Gui.G_FELD.MaxVisibleGraphemes = -1
	Gui.G_FELD.RichText = false
	Gui.G_FELD.Text = ""
	Gui.G_FELD.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.G_FELD.TextDirection = Enum.TextDirection.Auto
	Gui.G_FELD.TextScaled = false
	Gui.G_FELD.TextSize = 34
	Gui.G_FELD.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.G_FELD.TextStrokeTransparency = 1
	Gui.G_FELD.TextTransparency = 0
	Gui.G_FELD.TextTruncate = Enum.TextTruncate.None
	Gui.G_FELD.TextWrapped = false
	Gui.G_FELD.TextXAlignment = Enum.TextXAlignment.Center
	Gui.G_FELD.TextYAlignment = Enum.TextYAlignment.Center
	Gui.G_FELD.PlaceholderColor3 = Color3.fromRGB(220, 220, 225)
	Gui.G_FELD.PlaceholderText = ""
	Gui.G_FELD.ClearTextOnFocus = true
	Gui.G_FELD.MultiLine = false
	Gui.G_FELD.ShowNativeInput = true
	Gui.G_FELD.Archivable = true
	Gui.G_FELD.Parent = Gui.G_FELD_FRAME

	Gui.TextLabel_1 = Instance.new("TextLabel")
	Gui.TextLabel_1.Name = "TextLabel"
	Gui.TextLabel_1.Active = false
	Gui.TextLabel_1.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_1.BackgroundTransparency = 1
	Gui.TextLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_1.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_1.BorderSizePixel = 0
	Gui.TextLabel_1.ClipsDescendants = false
	Gui.TextLabel_1.Draggable = false
	Gui.TextLabel_1.LayoutOrder = 0
	Gui.TextLabel_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel_1.Rotation = 0
	Gui.TextLabel_1.Selectable = false
	Gui.TextLabel_1.Size = UDim2.new(0.407, 0, 0.951, 0)
	Gui.TextLabel_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_1.Visible = true
	Gui.TextLabel_1.ZIndex = 1
	Gui.TextLabel_1.Font = Enum.Font.Unknown
	Gui.TextLabel_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_1.LineHeight = 1
	Gui.TextLabel_1.MaxVisibleGraphemes = -1
	Gui.TextLabel_1.RichText = false
	Gui.TextLabel_1.Text = "G"
	Gui.TextLabel_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel_1.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_1.TextScaled = false
	Gui.TextLabel_1.TextSize = 34
	Gui.TextLabel_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_1.TextStrokeTransparency = 1
	Gui.TextLabel_1.TextTransparency = 0
	Gui.TextLabel_1.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_1.TextWrapped = false
	Gui.TextLabel_1.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_1.Archivable = true
	Gui.TextLabel_1.Parent = Gui.G_FELD_FRAME

	Gui.UICorner_15 = Instance.new("UICorner")
	Gui.UICorner_15.Name = "UICorner"
	Gui.UICorner_15.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_15.Archivable = true
	Gui.UICorner_15.Parent = Gui.G_FELD_FRAME

	Gui.B_FELD_FRAME = Instance.new("Frame")
	Gui.B_FELD_FRAME.Name = "B_FELD_FRAME"
	Gui.B_FELD_FRAME.Active = false
	Gui.B_FELD_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.B_FELD_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.B_FELD_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.B_FELD_FRAME.BackgroundTransparency = 0
	Gui.B_FELD_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.B_FELD_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.B_FELD_FRAME.BorderSizePixel = 0
	Gui.B_FELD_FRAME.ClipsDescendants = false
	Gui.B_FELD_FRAME.Draggable = false
	Gui.B_FELD_FRAME.LayoutOrder = 0
	Gui.B_FELD_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.B_FELD_FRAME.Rotation = 0
	Gui.B_FELD_FRAME.Selectable = false
	Gui.B_FELD_FRAME.Size = UDim2.new(0.302, 0, 1, 0)
	Gui.B_FELD_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.B_FELD_FRAME.Visible = true
	Gui.B_FELD_FRAME.ZIndex = 1
	Gui.B_FELD_FRAME.Style = Enum.FrameStyle.Custom
	Gui.B_FELD_FRAME.Archivable = true
	Gui.B_FELD_FRAME.Parent = Gui.RGB_FIELDS

	Gui.B_FELD = Instance.new("TextBox")
	Gui.B_FELD.Name = "B_FELD"
	Gui.B_FELD.Active = true
	Gui.B_FELD.AnchorPoint = Vector2.new(0, 0)
	Gui.B_FELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.B_FELD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.B_FELD.BackgroundTransparency = 1
	Gui.B_FELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.B_FELD.BorderMode = Enum.BorderMode.Outline
	Gui.B_FELD.BorderSizePixel = 0
	Gui.B_FELD.ClipsDescendants = false
	Gui.B_FELD.Draggable = false
	Gui.B_FELD.LayoutOrder = 0
	Gui.B_FELD.Position = UDim2.new(0.358, 0, 0, 0)
	Gui.B_FELD.Rotation = 0
	Gui.B_FELD.Selectable = true
	Gui.B_FELD.Size = UDim2.new(0.637, 0, 1, 0)
	Gui.B_FELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.B_FELD.Visible = true
	Gui.B_FELD.ZIndex = 1
	Gui.B_FELD.Font = Enum.Font.Unknown
	Gui.B_FELD.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.B_FELD.LineHeight = 1
	Gui.B_FELD.MaxVisibleGraphemes = -1
	Gui.B_FELD.RichText = false
	Gui.B_FELD.Text = ""
	Gui.B_FELD.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.B_FELD.TextDirection = Enum.TextDirection.Auto
	Gui.B_FELD.TextScaled = false
	Gui.B_FELD.TextSize = 34
	Gui.B_FELD.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.B_FELD.TextStrokeTransparency = 1
	Gui.B_FELD.TextTransparency = 0
	Gui.B_FELD.TextTruncate = Enum.TextTruncate.None
	Gui.B_FELD.TextWrapped = false
	Gui.B_FELD.TextXAlignment = Enum.TextXAlignment.Center
	Gui.B_FELD.TextYAlignment = Enum.TextYAlignment.Center
	Gui.B_FELD.PlaceholderColor3 = Color3.fromRGB(220, 220, 225)
	Gui.B_FELD.PlaceholderText = ""
	Gui.B_FELD.ClearTextOnFocus = true
	Gui.B_FELD.MultiLine = false
	Gui.B_FELD.ShowNativeInput = true
	Gui.B_FELD.Archivable = true
	Gui.B_FELD.Parent = Gui.B_FELD_FRAME

	Gui.TextLabel_2 = Instance.new("TextLabel")
	Gui.TextLabel_2.Name = "TextLabel"
	Gui.TextLabel_2.Active = false
	Gui.TextLabel_2.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_2.BackgroundTransparency = 1
	Gui.TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_2.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_2.BorderSizePixel = 0
	Gui.TextLabel_2.ClipsDescendants = false
	Gui.TextLabel_2.Draggable = false
	Gui.TextLabel_2.LayoutOrder = 0
	Gui.TextLabel_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel_2.Rotation = 0
	Gui.TextLabel_2.Selectable = false
	Gui.TextLabel_2.Size = UDim2.new(0.407, 0, 0.951, 0)
	Gui.TextLabel_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_2.Visible = true
	Gui.TextLabel_2.ZIndex = 1
	Gui.TextLabel_2.Font = Enum.Font.Unknown
	Gui.TextLabel_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_2.LineHeight = 1
	Gui.TextLabel_2.MaxVisibleGraphemes = -1
	Gui.TextLabel_2.RichText = false
	Gui.TextLabel_2.Text = "B"
	Gui.TextLabel_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel_2.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_2.TextScaled = false
	Gui.TextLabel_2.TextSize = 34
	Gui.TextLabel_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_2.TextStrokeTransparency = 1
	Gui.TextLabel_2.TextTransparency = 0
	Gui.TextLabel_2.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_2.TextWrapped = false
	Gui.TextLabel_2.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_2.Archivable = true
	Gui.TextLabel_2.Parent = Gui.B_FELD_FRAME

	Gui.UICorner_16 = Instance.new("UICorner")
	Gui.UICorner_16.Name = "UICorner"
	Gui.UICorner_16.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_16.Archivable = true
	Gui.UICorner_16.Parent = Gui.B_FELD_FRAME

	Gui.HEX_FIELD = Instance.new("Frame")
	Gui.HEX_FIELD.Name = "HEX_FIELD"
	Gui.HEX_FIELD.Active = false
	Gui.HEX_FIELD.AnchorPoint = Vector2.new(0, 0)
	Gui.HEX_FIELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.HEX_FIELD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HEX_FIELD.BackgroundTransparency = 1
	Gui.HEX_FIELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HEX_FIELD.BorderMode = Enum.BorderMode.Outline
	Gui.HEX_FIELD.BorderSizePixel = 0
	Gui.HEX_FIELD.ClipsDescendants = false
	Gui.HEX_FIELD.Draggable = false
	Gui.HEX_FIELD.LayoutOrder = 0
	Gui.HEX_FIELD.Position = UDim2.new(0.301, 0, 0.894, 0)
	Gui.HEX_FIELD.Rotation = 0
	Gui.HEX_FIELD.Selectable = false
	Gui.HEX_FIELD.Size = UDim2.new(0, 324, 0, 41)
	Gui.HEX_FIELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HEX_FIELD.Visible = true
	Gui.HEX_FIELD.ZIndex = 1
	Gui.HEX_FIELD.Style = Enum.FrameStyle.Custom
	Gui.HEX_FIELD.Archivable = true
	Gui.HEX_FIELD.Parent = Gui.COLOR_FRAME

	Gui.UIListLayout_2 = Instance.new("UIListLayout")
	Gui.UIListLayout_2.Name = "UIListLayout"
	Gui.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_2.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_2.Wraps = false
	Gui.UIListLayout_2.Archivable = true
	Gui.UIListLayout_2.Parent = Gui.HEX_FIELD

	Gui.HEX_FELD_FRAME = Instance.new("Frame")
	Gui.HEX_FELD_FRAME.Name = "HEX_FELD_FRAME"
	Gui.HEX_FELD_FRAME.Active = false
	Gui.HEX_FELD_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.HEX_FELD_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.HEX_FELD_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.HEX_FELD_FRAME.BackgroundTransparency = 0
	Gui.HEX_FELD_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HEX_FELD_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.HEX_FELD_FRAME.BorderSizePixel = 0
	Gui.HEX_FELD_FRAME.ClipsDescendants = false
	Gui.HEX_FELD_FRAME.Draggable = false
	Gui.HEX_FELD_FRAME.LayoutOrder = 0
	Gui.HEX_FELD_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.HEX_FELD_FRAME.Rotation = 0
	Gui.HEX_FELD_FRAME.Selectable = false
	Gui.HEX_FELD_FRAME.Size = UDim2.new(0.946, 0, 1, 0)
	Gui.HEX_FELD_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HEX_FELD_FRAME.Visible = true
	Gui.HEX_FELD_FRAME.ZIndex = 1
	Gui.HEX_FELD_FRAME.Style = Enum.FrameStyle.Custom
	Gui.HEX_FELD_FRAME.Archivable = true
	Gui.HEX_FELD_FRAME.Parent = Gui.HEX_FIELD

	Gui.HEX_FELD = Instance.new("TextBox")
	Gui.HEX_FELD.Name = "HEX_FELD"
	Gui.HEX_FELD.Active = true
	Gui.HEX_FELD.AnchorPoint = Vector2.new(0, 0)
	Gui.HEX_FELD.AutomaticSize = Enum.AutomaticSize.None
	Gui.HEX_FELD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HEX_FELD.BackgroundTransparency = 1
	Gui.HEX_FELD.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HEX_FELD.BorderMode = Enum.BorderMode.Outline
	Gui.HEX_FELD.BorderSizePixel = 0
	Gui.HEX_FELD.ClipsDescendants = false
	Gui.HEX_FELD.Draggable = false
	Gui.HEX_FELD.LayoutOrder = 0
	Gui.HEX_FELD.Position = UDim2.new(0.264, 0, 0, 0)
	Gui.HEX_FELD.Rotation = 0
	Gui.HEX_FELD.Selectable = true
	Gui.HEX_FELD.Size = UDim2.new(0.731, 0, 1, 0)
	Gui.HEX_FELD.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HEX_FELD.Visible = true
	Gui.HEX_FELD.ZIndex = 1
	Gui.HEX_FELD.Font = Enum.Font.Unknown
	Gui.HEX_FELD.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.HEX_FELD.LineHeight = 1
	Gui.HEX_FELD.MaxVisibleGraphemes = -1
	Gui.HEX_FELD.RichText = false
	Gui.HEX_FELD.Text = ""
	Gui.HEX_FELD.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HEX_FELD.TextDirection = Enum.TextDirection.Auto
	Gui.HEX_FELD.TextScaled = false
	Gui.HEX_FELD.TextSize = 34
	Gui.HEX_FELD.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HEX_FELD.TextStrokeTransparency = 1
	Gui.HEX_FELD.TextTransparency = 0
	Gui.HEX_FELD.TextTruncate = Enum.TextTruncate.None
	Gui.HEX_FELD.TextWrapped = false
	Gui.HEX_FELD.TextXAlignment = Enum.TextXAlignment.Center
	Gui.HEX_FELD.TextYAlignment = Enum.TextYAlignment.Center
	Gui.HEX_FELD.PlaceholderColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HEX_FELD.PlaceholderText = ""
	Gui.HEX_FELD.ClearTextOnFocus = true
	Gui.HEX_FELD.MultiLine = false
	Gui.HEX_FELD.ShowNativeInput = true
	Gui.HEX_FELD.Archivable = true
	Gui.HEX_FELD.Parent = Gui.HEX_FELD_FRAME

	Gui.TextLabel_3 = Instance.new("TextLabel")
	Gui.TextLabel_3.Name = "TextLabel"
	Gui.TextLabel_3.Active = false
	Gui.TextLabel_3.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_3.BackgroundTransparency = 1
	Gui.TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_3.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_3.BorderSizePixel = 0
	Gui.TextLabel_3.ClipsDescendants = false
	Gui.TextLabel_3.Draggable = false
	Gui.TextLabel_3.LayoutOrder = 0
	Gui.TextLabel_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel_3.Rotation = 0
	Gui.TextLabel_3.Selectable = false
	Gui.TextLabel_3.Size = UDim2.new(0.264, 0, 0.951, 0)
	Gui.TextLabel_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_3.Visible = true
	Gui.TextLabel_3.ZIndex = 1
	Gui.TextLabel_3.Font = Enum.Font.Unknown
	Gui.TextLabel_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_3.LineHeight = 1
	Gui.TextLabel_3.MaxVisibleGraphemes = -1
	Gui.TextLabel_3.RichText = false
	Gui.TextLabel_3.Text = "HEX"
	Gui.TextLabel_3.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel_3.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_3.TextScaled = false
	Gui.TextLabel_3.TextSize = 34
	Gui.TextLabel_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_3.TextStrokeTransparency = 1
	Gui.TextLabel_3.TextTransparency = 0
	Gui.TextLabel_3.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_3.TextWrapped = false
	Gui.TextLabel_3.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_3.Archivable = true
	Gui.TextLabel_3.Parent = Gui.HEX_FELD_FRAME

	Gui.UICorner_17 = Instance.new("UICorner")
	Gui.UICorner_17.Name = "UICorner"
	Gui.UICorner_17.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_17.Archivable = true
	Gui.UICorner_17.Parent = Gui.HEX_FELD_FRAME

	Gui.CloseButton = Instance.new("ImageButton")
	Gui.CloseButton.Name = "CloseButton"
	Gui.CloseButton.Active = true
	Gui.CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.CloseButton.AutomaticSize = Enum.AutomaticSize.None
	Gui.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CloseButton.BackgroundTransparency = 1
	Gui.CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CloseButton.BorderMode = Enum.BorderMode.Outline
	Gui.CloseButton.BorderSizePixel = 0
	Gui.CloseButton.ClipsDescendants = false
	Gui.CloseButton.Draggable = false
	Gui.CloseButton.LayoutOrder = 0
	Gui.CloseButton.Position = UDim2.new(0.95, 0, 0.04, 0)
	Gui.CloseButton.Rotation = 0
	Gui.CloseButton.Selectable = true
	Gui.CloseButton.Size = UDim2.new(0, 34, 0, 34)
	Gui.CloseButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CloseButton.Visible = true
	Gui.CloseButton.ZIndex = 1
	Gui.CloseButton.Image = "rbxassetid://75118306600987"
	Gui.CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CloseButton.ImageRectOffset = Vector2.new(0, 0)
	Gui.CloseButton.ImageRectSize = Vector2.new(0, 0)
	Gui.CloseButton.ImageTransparency = 0
	Gui.CloseButton.ResampleMode = Enum.ResamplerMode.Default
	Gui.CloseButton.ScaleType = Enum.ScaleType.Stretch
	Gui.CloseButton.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CloseButton.SliceScale = 1
	Gui.CloseButton.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CloseButton.Style = Enum.ButtonStyle.Custom
	Gui.CloseButton.AutoButtonColor = true
	Gui.CloseButton.Modal = false
	Gui.CloseButton.Selected = false
	Gui.CloseButton.HoverImage = ""
	Gui.CloseButton.PressedImage = ""
	Gui.CloseButton.Archivable = true
	Gui.CloseButton.Parent = Gui.COLOR_FRAME

	Gui.COLOR_DRAG_FRAME = Instance.new("Frame")
	Gui.COLOR_DRAG_FRAME.Name = "COLOR_DRAG_FRAME"
	Gui.COLOR_DRAG_FRAME.Active = false
	Gui.COLOR_DRAG_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_DRAG_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_DRAG_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_DRAG_FRAME.BackgroundTransparency = 1
	Gui.COLOR_DRAG_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_DRAG_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_DRAG_FRAME.BorderSizePixel = 0
	Gui.COLOR_DRAG_FRAME.ClipsDescendants = false
	Gui.COLOR_DRAG_FRAME.Draggable = false
	Gui.COLOR_DRAG_FRAME.LayoutOrder = 0
	Gui.COLOR_DRAG_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.COLOR_DRAG_FRAME.Rotation = 0
	Gui.COLOR_DRAG_FRAME.Selectable = false
	Gui.COLOR_DRAG_FRAME.Size = UDim2.new(0.903, 0, 0.079, 0)
	Gui.COLOR_DRAG_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_DRAG_FRAME.Visible = true
	Gui.COLOR_DRAG_FRAME.ZIndex = 1
	Gui.COLOR_DRAG_FRAME.Style = Enum.FrameStyle.Custom
	Gui.COLOR_DRAG_FRAME.Archivable = true
	Gui.COLOR_DRAG_FRAME.Parent = Gui.COLOR_FRAME

	Gui.ColorDragDetector = Instance.new("UIDragDetector")
	Gui.ColorDragDetector.Name = "ColorDragDetector"
	Gui.ColorDragDetector.Enabled = true
	Gui.ColorDragDetector.Archivable = true
	Gui.ColorDragDetector.Parent = Gui.COLOR_DRAG_FRAME

	Gui.ABDECKUNG = Instance.new("TextButton")
	Gui.ABDECKUNG.Name = "ABDECKUNG"
	Gui.ABDECKUNG.Active = true
	Gui.ABDECKUNG.AnchorPoint = Vector2.new(0, 0)
	Gui.ABDECKUNG.AutomaticSize = Enum.AutomaticSize.None
	Gui.ABDECKUNG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ABDECKUNG.BackgroundTransparency = 1
	Gui.ABDECKUNG.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ABDECKUNG.BorderMode = Enum.BorderMode.Outline
	Gui.ABDECKUNG.BorderSizePixel = 0
	Gui.ABDECKUNG.ClipsDescendants = false
	Gui.ABDECKUNG.Draggable = false
	Gui.ABDECKUNG.LayoutOrder = 0
	Gui.ABDECKUNG.Position = UDim2.new(0.331, 0, 0.274, 0)
	Gui.ABDECKUNG.Rotation = 0
	Gui.ABDECKUNG.Selectable = true
	Gui.ABDECKUNG.Size = UDim2.new(0.339, 0, 0.453, 0)
	Gui.ABDECKUNG.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ABDECKUNG.Visible = false
	Gui.ABDECKUNG.ZIndex = 500
	Gui.ABDECKUNG.Font = Enum.Font.Unknown
	Gui.ABDECKUNG.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ABDECKUNG.LineHeight = 1
	Gui.ABDECKUNG.MaxVisibleGraphemes = -1
	Gui.ABDECKUNG.RichText = false
	Gui.ABDECKUNG.Text = ""
	Gui.ABDECKUNG.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ABDECKUNG.TextDirection = Enum.TextDirection.Auto
	Gui.ABDECKUNG.TextScaled = true
	Gui.ABDECKUNG.TextSize = 14
	Gui.ABDECKUNG.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ABDECKUNG.TextStrokeTransparency = 1
	Gui.ABDECKUNG.TextTransparency = 0
	Gui.ABDECKUNG.TextTruncate = Enum.TextTruncate.None
	Gui.ABDECKUNG.TextWrapped = true
	Gui.ABDECKUNG.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ABDECKUNG.TextYAlignment = Enum.TextYAlignment.Center
	Gui.ABDECKUNG.Style = Enum.ButtonStyle.Custom
	Gui.ABDECKUNG.AutoButtonColor = false
	Gui.ABDECKUNG.Modal = false
	Gui.ABDECKUNG.Selected = false
	Gui.ABDECKUNG.Archivable = true
	Gui.ABDECKUNG.Parent = Gui.VexarisGui

	Gui.Examples = Instance.new("Folder")
	Gui.Examples.Name = "Examples"
	Gui.Examples.Archivable = true
	Gui.Examples.Parent = Gui.VexarisGui

	Gui.SUBMENU_BUTTON_EXAMPLE = Instance.new("TextButton")
	Gui.SUBMENU_BUTTON_EXAMPLE.Name = "SUBMENU_BUTTON_EXAMPLE"
	Gui.SUBMENU_BUTTON_EXAMPLE.Active = true
	Gui.SUBMENU_BUTTON_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.SUBMENU_BUTTON_EXAMPLE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.BackgroundTransparency = 0.7
	Gui.SUBMENU_BUTTON_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.SUBMENU_BUTTON_EXAMPLE.BorderSizePixel = 0
	Gui.SUBMENU_BUTTON_EXAMPLE.ClipsDescendants = false
	Gui.SUBMENU_BUTTON_EXAMPLE.Draggable = false
	Gui.SUBMENU_BUTTON_EXAMPLE.LayoutOrder = 1
	Gui.SUBMENU_BUTTON_EXAMPLE.Position = UDim2.new(0, 0, -0.003, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.Rotation = 0
	Gui.SUBMENU_BUTTON_EXAMPLE.Selectable = true
	Gui.SUBMENU_BUTTON_EXAMPLE.Size = UDim2.new(0.278, 0, 1.019, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SUBMENU_BUTTON_EXAMPLE.Visible = false
	Gui.SUBMENU_BUTTON_EXAMPLE.ZIndex = 1
	Gui.SUBMENU_BUTTON_EXAMPLE.Font = Enum.Font.Unknown
	Gui.SUBMENU_BUTTON_EXAMPLE.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.SUBMENU_BUTTON_EXAMPLE.LineHeight = 1
	Gui.SUBMENU_BUTTON_EXAMPLE.MaxVisibleGraphemes = -1
	Gui.SUBMENU_BUTTON_EXAMPLE.RichText = false
	Gui.SUBMENU_BUTTON_EXAMPLE.Text = "Aimbot"
	Gui.SUBMENU_BUTTON_EXAMPLE.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.SUBMENU_BUTTON_EXAMPLE.TextDirection = Enum.TextDirection.Auto
	Gui.SUBMENU_BUTTON_EXAMPLE.TextScaled = false
	Gui.SUBMENU_BUTTON_EXAMPLE.TextSize = 27
	Gui.SUBMENU_BUTTON_EXAMPLE.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_BUTTON_EXAMPLE.TextStrokeTransparency = 1
	Gui.SUBMENU_BUTTON_EXAMPLE.TextTransparency = 0
	Gui.SUBMENU_BUTTON_EXAMPLE.TextTruncate = Enum.TextTruncate.None
	Gui.SUBMENU_BUTTON_EXAMPLE.TextWrapped = true
	Gui.SUBMENU_BUTTON_EXAMPLE.TextXAlignment = Enum.TextXAlignment.Center
	Gui.SUBMENU_BUTTON_EXAMPLE.TextYAlignment = Enum.TextYAlignment.Center
	Gui.SUBMENU_BUTTON_EXAMPLE.Style = Enum.ButtonStyle.Custom
	Gui.SUBMENU_BUTTON_EXAMPLE.AutoButtonColor = true
	Gui.SUBMENU_BUTTON_EXAMPLE.Modal = false
	Gui.SUBMENU_BUTTON_EXAMPLE.Selected = false
	Gui.SUBMENU_BUTTON_EXAMPLE.Archivable = true
	Gui.SUBMENU_BUTTON_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_18 = Instance.new("UICorner")
	Gui.UICorner_18.Name = "UICorner"
	Gui.UICorner_18.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_18.Archivable = true
	Gui.UICorner_18.Parent = Gui.SUBMENU_BUTTON_EXAMPLE

	Gui.UITextSizeConstraint_1 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_1.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_1.MaxTextSize = 27
	Gui.UITextSizeConstraint_1.MinTextSize = 1
	Gui.UITextSizeConstraint_1.Archivable = true
	Gui.UITextSizeConstraint_1.Parent = Gui.SUBMENU_BUTTON_EXAMPLE

	Gui.TAB_BUTTON_EXAMPLE = Instance.new("TextButton")
	Gui.TAB_BUTTON_EXAMPLE.Name = "TAB_BUTTON_EXAMPLE"
	Gui.TAB_BUTTON_EXAMPLE.Active = true
	Gui.TAB_BUTTON_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.TAB_BUTTON_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.TAB_BUTTON_EXAMPLE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TAB_BUTTON_EXAMPLE.BackgroundTransparency = 0.7
	Gui.TAB_BUTTON_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TAB_BUTTON_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.TAB_BUTTON_EXAMPLE.BorderSizePixel = 0
	Gui.TAB_BUTTON_EXAMPLE.ClipsDescendants = false
	Gui.TAB_BUTTON_EXAMPLE.Draggable = false
	Gui.TAB_BUTTON_EXAMPLE.LayoutOrder = 2
	Gui.TAB_BUTTON_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.TAB_BUTTON_EXAMPLE.Rotation = 0
	Gui.TAB_BUTTON_EXAMPLE.Selectable = true
	Gui.TAB_BUTTON_EXAMPLE.Size = UDim2.new(1, 0, 0.085, 0)
	Gui.TAB_BUTTON_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TAB_BUTTON_EXAMPLE.Visible = false
	Gui.TAB_BUTTON_EXAMPLE.ZIndex = 1
	Gui.TAB_BUTTON_EXAMPLE.Font = Enum.Font.Unknown
	Gui.TAB_BUTTON_EXAMPLE.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TAB_BUTTON_EXAMPLE.LineHeight = 1
	Gui.TAB_BUTTON_EXAMPLE.MaxVisibleGraphemes = -1
	Gui.TAB_BUTTON_EXAMPLE.RichText = false
	Gui.TAB_BUTTON_EXAMPLE.Text = "..."
	Gui.TAB_BUTTON_EXAMPLE.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TAB_BUTTON_EXAMPLE.TextDirection = Enum.TextDirection.Auto
	Gui.TAB_BUTTON_EXAMPLE.TextScaled = true
	Gui.TAB_BUTTON_EXAMPLE.TextSize = 27
	Gui.TAB_BUTTON_EXAMPLE.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TAB_BUTTON_EXAMPLE.TextStrokeTransparency = 1
	Gui.TAB_BUTTON_EXAMPLE.TextTransparency = 0
	Gui.TAB_BUTTON_EXAMPLE.TextTruncate = Enum.TextTruncate.None
	Gui.TAB_BUTTON_EXAMPLE.TextWrapped = true
	Gui.TAB_BUTTON_EXAMPLE.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TAB_BUTTON_EXAMPLE.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TAB_BUTTON_EXAMPLE.Style = Enum.ButtonStyle.Custom
	Gui.TAB_BUTTON_EXAMPLE.AutoButtonColor = true
	Gui.TAB_BUTTON_EXAMPLE.Modal = false
	Gui.TAB_BUTTON_EXAMPLE.Selected = false
	Gui.TAB_BUTTON_EXAMPLE.Archivable = true
	Gui.TAB_BUTTON_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_19 = Instance.new("UICorner")
	Gui.UICorner_19.Name = "UICorner"
	Gui.UICorner_19.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_19.Archivable = true
	Gui.UICorner_19.Parent = Gui.TAB_BUTTON_EXAMPLE

	Gui.UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_2.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_2.MaxTextSize = 34
	Gui.UITextSizeConstraint_2.MinTextSize = 1
	Gui.UITextSizeConstraint_2.Archivable = true
	Gui.UITextSizeConstraint_2.Parent = Gui.TAB_BUTTON_EXAMPLE

	Gui.TAB_EXAMPLE = Instance.new("Frame")
	Gui.TAB_EXAMPLE.Name = "TAB_EXAMPLE"
	Gui.TAB_EXAMPLE.Active = false
	Gui.TAB_EXAMPLE.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.TAB_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.TAB_EXAMPLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TAB_EXAMPLE.BackgroundTransparency = 1
	Gui.TAB_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TAB_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.TAB_EXAMPLE.BorderSizePixel = 0
	Gui.TAB_EXAMPLE.ClipsDescendants = false
	Gui.TAB_EXAMPLE.Draggable = false
	Gui.TAB_EXAMPLE.LayoutOrder = 0
	Gui.TAB_EXAMPLE.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.TAB_EXAMPLE.Rotation = 0
	Gui.TAB_EXAMPLE.Selectable = false
	Gui.TAB_EXAMPLE.Size = UDim2.new(0.888, 0, 0.888, 0)
	Gui.TAB_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TAB_EXAMPLE.Visible = false
	Gui.TAB_EXAMPLE.ZIndex = 1
	Gui.TAB_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.TAB_EXAMPLE.Archivable = true
	Gui.TAB_EXAMPLE.Parent = Gui.Examples

	Gui.DRAG_EXAMPLE = Instance.new("Frame")
	Gui.DRAG_EXAMPLE.Name = "DRAG_EXAMPLE"
	Gui.DRAG_EXAMPLE.Active = false
	Gui.DRAG_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.DRAG_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.DRAG_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.DRAG_EXAMPLE.BackgroundTransparency = 0
	Gui.DRAG_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.DRAG_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.DRAG_EXAMPLE.BorderSizePixel = 0
	Gui.DRAG_EXAMPLE.ClipsDescendants = false
	Gui.DRAG_EXAMPLE.Draggable = false
	Gui.DRAG_EXAMPLE.LayoutOrder = 0
	Gui.DRAG_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.DRAG_EXAMPLE.Rotation = 0
	Gui.DRAG_EXAMPLE.Selectable = false
	Gui.DRAG_EXAMPLE.Size = UDim2.new(1, 0, 0.128, 0)
	Gui.DRAG_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.DRAG_EXAMPLE.Visible = false
	Gui.DRAG_EXAMPLE.ZIndex = 1
	Gui.DRAG_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.DRAG_EXAMPLE.Archivable = true
	Gui.DRAG_EXAMPLE.Parent = Gui.Examples

	Gui.MainLabel = Instance.new("TextLabel")
	Gui.MainLabel.Name = "MainLabel"
	Gui.MainLabel.Active = false
	Gui.MainLabel.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel.BackgroundTransparency = 1
	Gui.MainLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel.BorderSizePixel = 0
	Gui.MainLabel.ClipsDescendants = false
	Gui.MainLabel.Draggable = false
	Gui.MainLabel.LayoutOrder = 0
	Gui.MainLabel.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel.Rotation = 0
	Gui.MainLabel.Selectable = false
	Gui.MainLabel.Size = UDim2.new(0.433, 0, 0.479, 0)
	Gui.MainLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel.Visible = true
	Gui.MainLabel.ZIndex = 1
	Gui.MainLabel.Font = Enum.Font.Unknown
	Gui.MainLabel.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel.LineHeight = 1
	Gui.MainLabel.MaxVisibleGraphemes = -1
	Gui.MainLabel.RichText = false
	Gui.MainLabel.Text = "Das ist der Name des Drags"
	Gui.MainLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel.TextScaled = true
	Gui.MainLabel.TextSize = 23
	Gui.MainLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel.TextStrokeTransparency = 1
	Gui.MainLabel.TextTransparency = 0
	Gui.MainLabel.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel.TextWrapped = true
	Gui.MainLabel.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel.Archivable = true
	Gui.MainLabel.Parent = Gui.DRAG_EXAMPLE

	Gui.UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_3.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_3.MaxTextSize = 23
	Gui.UITextSizeConstraint_3.MinTextSize = 1
	Gui.UITextSizeConstraint_3.Archivable = true
	Gui.UITextSizeConstraint_3.Parent = Gui.MainLabel

	Gui.DragBackground = Instance.new("Frame")
	Gui.DragBackground.Name = "DragBackground"
	Gui.DragBackground.Active = false
	Gui.DragBackground.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.DragBackground.AutomaticSize = Enum.AutomaticSize.None
	Gui.DragBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	Gui.DragBackground.BackgroundTransparency = 0
	Gui.DragBackground.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.DragBackground.BorderMode = Enum.BorderMode.Outline
	Gui.DragBackground.BorderSizePixel = 0
	Gui.DragBackground.ClipsDescendants = false
	Gui.DragBackground.Draggable = false
	Gui.DragBackground.LayoutOrder = 0
	Gui.DragBackground.Position = UDim2.new(0.429, 0, 0.7, 0)
	Gui.DragBackground.Rotation = 0
	Gui.DragBackground.Selectable = false
	Gui.DragBackground.Size = UDim2.new(0.793, 0, 0.063, 0)
	Gui.DragBackground.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.DragBackground.Visible = true
	Gui.DragBackground.ZIndex = 1
	Gui.DragBackground.Style = Enum.FrameStyle.Custom
	Gui.DragBackground.Archivable = true
	Gui.DragBackground.Parent = Gui.DRAG_EXAMPLE

	Gui.UICorner_20 = Instance.new("UICorner")
	Gui.UICorner_20.Name = "UICorner"
	Gui.UICorner_20.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_20.Archivable = true
	Gui.UICorner_20.Parent = Gui.DragBackground

	Gui.DragBegrenzung = Instance.new("Frame")
	Gui.DragBegrenzung.Name = "DragBegrenzung"
	Gui.DragBegrenzung.Active = false
	Gui.DragBegrenzung.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.DragBegrenzung.AutomaticSize = Enum.AutomaticSize.None
	Gui.DragBegrenzung.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	Gui.DragBegrenzung.BackgroundTransparency = 1
	Gui.DragBegrenzung.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.DragBegrenzung.BorderMode = Enum.BorderMode.Outline
	Gui.DragBegrenzung.BorderSizePixel = 0
	Gui.DragBegrenzung.ClipsDescendants = false
	Gui.DragBegrenzung.Draggable = false
	Gui.DragBegrenzung.LayoutOrder = 0
	Gui.DragBegrenzung.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.DragBegrenzung.Rotation = 0
	Gui.DragBegrenzung.Selectable = false
	Gui.DragBegrenzung.Size = UDim2.new(1, 0, 5.554, 0)
	Gui.DragBegrenzung.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.DragBegrenzung.Visible = true
	Gui.DragBegrenzung.ZIndex = 1
	Gui.DragBegrenzung.Style = Enum.FrameStyle.Custom
	Gui.DragBegrenzung.Archivable = true
	Gui.DragBegrenzung.Parent = Gui.DragBackground

	Gui.Frame_7 = Instance.new("Frame")
	Gui.Frame_7.Name = "Frame"
	Gui.Frame_7.Active = false
	Gui.Frame_7.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.Frame_7.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_7.BackgroundColor3 = Color3.fromRGB(48, 48, 50)
	Gui.Frame_7.BackgroundTransparency = 0
	Gui.Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_7.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_7.BorderSizePixel = 2
	Gui.Frame_7.ClipsDescendants = false
	Gui.Frame_7.Draggable = false
	Gui.Frame_7.LayoutOrder = 0
	Gui.Frame_7.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.Frame_7.Rotation = 0
	Gui.Frame_7.Selectable = false
	Gui.Frame_7.Size = UDim2.new(0.038, 0, 5.332, 0)
	Gui.Frame_7.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_7.Visible = true
	Gui.Frame_7.ZIndex = 1
	Gui.Frame_7.Style = Enum.FrameStyle.Custom
	Gui.Frame_7.Archivable = true
	Gui.Frame_7.Parent = Gui.DragBackground

	Gui.UIDragDetector123 = Instance.new("UIDragDetector")
	Gui.UIDragDetector123.Name = "UIDragDetector123"
	Gui.UIDragDetector123.Enabled = true
	Gui.UIDragDetector123.Archivable = true
	Gui.UIDragDetector123.Parent = Gui.Frame_7

	Gui.UICorner_21 = Instance.new("UICorner")
	Gui.UICorner_21.Name = "UICorner"
	Gui.UICorner_21.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_21.Archivable = true
	Gui.UICorner_21.Parent = Gui.Frame_7

	Gui.PercentLabel = Instance.new("TextLabel")
	Gui.PercentLabel.Name = "PercentLabel"
	Gui.PercentLabel.Active = false
	Gui.PercentLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.PercentLabel.AutomaticSize = Enum.AutomaticSize.None
	Gui.PercentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.PercentLabel.BackgroundTransparency = 1
	Gui.PercentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.PercentLabel.BorderMode = Enum.BorderMode.Outline
	Gui.PercentLabel.BorderSizePixel = 0
	Gui.PercentLabel.ClipsDescendants = false
	Gui.PercentLabel.Draggable = false
	Gui.PercentLabel.LayoutOrder = 0
	Gui.PercentLabel.Position = UDim2.new(0.923, 0, 0.693, 0)
	Gui.PercentLabel.Rotation = 0
	Gui.PercentLabel.Selectable = false
	Gui.PercentLabel.Size = UDim2.new(0, 97, 0, 38)
	Gui.PercentLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.PercentLabel.Visible = true
	Gui.PercentLabel.ZIndex = 1
	Gui.PercentLabel.Font = Enum.Font.Unknown
	Gui.PercentLabel.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.PercentLabel.LineHeight = 1
	Gui.PercentLabel.MaxVisibleGraphemes = -1
	Gui.PercentLabel.RichText = false
	Gui.PercentLabel.Text = "0.00"
	Gui.PercentLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
	Gui.PercentLabel.TextDirection = Enum.TextDirection.Auto
	Gui.PercentLabel.TextScaled = true
	Gui.PercentLabel.TextSize = 27
	Gui.PercentLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.PercentLabel.TextStrokeTransparency = 1
	Gui.PercentLabel.TextTransparency = 0
	Gui.PercentLabel.TextTruncate = Enum.TextTruncate.None
	Gui.PercentLabel.TextWrapped = true
	Gui.PercentLabel.TextXAlignment = Enum.TextXAlignment.Center
	Gui.PercentLabel.TextYAlignment = Enum.TextYAlignment.Center
	Gui.PercentLabel.Archivable = true
	Gui.PercentLabel.Parent = Gui.DRAG_EXAMPLE

	Gui.UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_4.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_4.MaxTextSize = 27
	Gui.UITextSizeConstraint_4.MinTextSize = 1
	Gui.UITextSizeConstraint_4.Archivable = true
	Gui.UITextSizeConstraint_4.Parent = Gui.PercentLabel

	Gui.FUNCTION_NAME = Instance.new("StringValue")
	Gui.FUNCTION_NAME.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME.Archivable = true
	Gui.FUNCTION_NAME.Parent = Gui.DRAG_EXAMPLE

	Gui.UICorner_22 = Instance.new("UICorner")
	Gui.UICorner_22.Name = "UICorner"
	Gui.UICorner_22.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_22.Archivable = true
	Gui.UICorner_22.Parent = Gui.DRAG_EXAMPLE

	Gui.Description = Instance.new("TextLabel")
	Gui.Description.Name = "Description"
	Gui.Description.Active = false
	Gui.Description.AnchorPoint = Vector2.new(0, 0)
	Gui.Description.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description.BackgroundTransparency = 1
	Gui.Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description.BorderMode = Enum.BorderMode.Outline
	Gui.Description.BorderSizePixel = 0
	Gui.Description.ClipsDescendants = false
	Gui.Description.Draggable = false
	Gui.Description.LayoutOrder = 0
	Gui.Description.Position = UDim2.new(0.492, 0, 0, 0)
	Gui.Description.Rotation = 0
	Gui.Description.Selectable = false
	Gui.Description.Size = UDim2.new(0.496, 0, 0.479, 0)
	Gui.Description.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description.Visible = true
	Gui.Description.ZIndex = 1
	Gui.Description.Font = Enum.Font.Unknown
	Gui.Description.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description.LineHeight = 1
	Gui.Description.MaxVisibleGraphemes = -1
	Gui.Description.RichText = false
	Gui.Description.Text = "Das ist die Beschreibung des Drags"
	Gui.Description.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description.TextDirection = Enum.TextDirection.Auto
	Gui.Description.TextScaled = true
	Gui.Description.TextSize = 17
	Gui.Description.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description.TextStrokeTransparency = 1
	Gui.Description.TextTransparency = 0
	Gui.Description.TextTruncate = Enum.TextTruncate.None
	Gui.Description.TextWrapped = true
	Gui.Description.TextXAlignment = Enum.TextXAlignment.Right
	Gui.Description.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description.Archivable = true
	Gui.Description.Parent = Gui.DRAG_EXAMPLE

	Gui.UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_5.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_5.MaxTextSize = 17
	Gui.UITextSizeConstraint_5.MinTextSize = 1
	Gui.UITextSizeConstraint_5.Archivable = true
	Gui.UITextSizeConstraint_5.Parent = Gui.Description

end

local function BuildGui2()
	Gui.SUBMENU_FRAME_EXAMPLE = Instance.new("ScrollingFrame")
	Gui.SUBMENU_FRAME_EXAMPLE.Name = "SUBMENU_FRAME_EXAMPLE"
	Gui.SUBMENU_FRAME_EXAMPLE.Active = true
	Gui.SUBMENU_FRAME_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.SUBMENU_FRAME_EXAMPLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SUBMENU_FRAME_EXAMPLE.BackgroundTransparency = 1
	Gui.SUBMENU_FRAME_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.SUBMENU_FRAME_EXAMPLE.BorderSizePixel = 0
	Gui.SUBMENU_FRAME_EXAMPLE.ClipsDescendants = true
	Gui.SUBMENU_FRAME_EXAMPLE.Draggable = false
	Gui.SUBMENU_FRAME_EXAMPLE.LayoutOrder = 0
	Gui.SUBMENU_FRAME_EXAMPLE.Position = UDim2.new(0.259, 0, 0.594, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.Rotation = 0
	Gui.SUBMENU_FRAME_EXAMPLE.Selectable = true
	Gui.SUBMENU_FRAME_EXAMPLE.Size = UDim2.new(0.68, 0, 0.314, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SUBMENU_FRAME_EXAMPLE.Visible = false
	Gui.SUBMENU_FRAME_EXAMPLE.ZIndex = 1
	Gui.SUBMENU_FRAME_EXAMPLE.AutomaticCanvasSize = Enum.AutomaticSize.XY
	Gui.SUBMENU_FRAME_EXAMPLE.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Gui.SUBMENU_FRAME_EXAMPLE.CanvasPosition = Vector2.new(0, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.CanvasSize = UDim2.new(0, 0, 2, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Gui.SUBMENU_FRAME_EXAMPLE.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Gui.SUBMENU_FRAME_EXAMPLE.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Gui.SUBMENU_FRAME_EXAMPLE.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_FRAME_EXAMPLE.ScrollBarImageTransparency = 0
	Gui.SUBMENU_FRAME_EXAMPLE.ScrollBarThickness = 0
	Gui.SUBMENU_FRAME_EXAMPLE.ScrollingDirection = Enum.ScrollingDirection.X
	Gui.SUBMENU_FRAME_EXAMPLE.ScrollingEnabled = true
	Gui.SUBMENU_FRAME_EXAMPLE.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Gui.SUBMENU_FRAME_EXAMPLE.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Gui.SUBMENU_FRAME_EXAMPLE.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	Gui.SUBMENU_FRAME_EXAMPLE.Archivable = true
	Gui.SUBMENU_FRAME_EXAMPLE.Parent = Gui.Examples

	Gui.UIListLayout_3 = Instance.new("UIListLayout")
	Gui.UIListLayout_3.Name = "UIListLayout"
	Gui.UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_3.Padding = UDim.new(0.01, 0)
	Gui.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_3.Wraps = false
	Gui.UIListLayout_3.Archivable = true
	Gui.UIListLayout_3.Parent = Gui.SUBMENU_FRAME_EXAMPLE

	Gui.SUBMENU_EXAMPLE = Instance.new("ScrollingFrame")
	Gui.SUBMENU_EXAMPLE.Name = "SUBMENU_EXAMPLE"
	Gui.SUBMENU_EXAMPLE.Active = true
	Gui.SUBMENU_EXAMPLE.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SUBMENU_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.SUBMENU_EXAMPLE.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Gui.SUBMENU_EXAMPLE.BackgroundTransparency = 0
	Gui.SUBMENU_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.SUBMENU_EXAMPLE.BorderSizePixel = 0
	Gui.SUBMENU_EXAMPLE.ClipsDescendants = true
	Gui.SUBMENU_EXAMPLE.Draggable = false
	Gui.SUBMENU_EXAMPLE.LayoutOrder = 0
	Gui.SUBMENU_EXAMPLE.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SUBMENU_EXAMPLE.Rotation = 0
	Gui.SUBMENU_EXAMPLE.Selectable = true
	Gui.SUBMENU_EXAMPLE.Size = UDim2.new(1, 0, 1, 0)
	Gui.SUBMENU_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SUBMENU_EXAMPLE.Visible = false
	Gui.SUBMENU_EXAMPLE.ZIndex = 0
	Gui.SUBMENU_EXAMPLE.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Gui.SUBMENU_EXAMPLE.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Gui.SUBMENU_EXAMPLE.CanvasPosition = Vector2.new(0, 0)
	Gui.SUBMENU_EXAMPLE.CanvasSize = UDim2.new(0, 0, 2, 0)
	Gui.SUBMENU_EXAMPLE.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Gui.SUBMENU_EXAMPLE.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Gui.SUBMENU_EXAMPLE.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Gui.SUBMENU_EXAMPLE.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SUBMENU_EXAMPLE.ScrollBarImageTransparency = 0
	Gui.SUBMENU_EXAMPLE.ScrollBarThickness = 0
	Gui.SUBMENU_EXAMPLE.ScrollingDirection = Enum.ScrollingDirection.XY
	Gui.SUBMENU_EXAMPLE.ScrollingEnabled = true
	Gui.SUBMENU_EXAMPLE.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Gui.SUBMENU_EXAMPLE.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Gui.SUBMENU_EXAMPLE.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	Gui.SUBMENU_EXAMPLE.Archivable = true
	Gui.SUBMENU_EXAMPLE.Parent = Gui.Examples

	Gui.UIListLayout_4 = Instance.new("UIListLayout")
	Gui.UIListLayout_4.Name = "UIListLayout"
	Gui.UIListLayout_4.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_4.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_4.Wraps = false
	Gui.UIListLayout_4.Archivable = true
	Gui.UIListLayout_4.Parent = Gui.SUBMENU_EXAMPLE

	Gui.HOMEPAGE_ITEMS = Instance.new("Folder")
	Gui.HOMEPAGE_ITEMS.Name = "HOMEPAGE_ITEMS"
	Gui.HOMEPAGE_ITEMS.Archivable = true
	Gui.HOMEPAGE_ITEMS.Parent = Gui.Examples

	Gui.WILLKOMMEN_LABEL_EXAMPLE = Instance.new("Frame")
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Name = "WILLKOMMEN_LABEL_EXAMPLE"
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Active = false
	Gui.WILLKOMMEN_LABEL_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.WILLKOMMEN_LABEL_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.WILLKOMMEN_LABEL_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.WILLKOMMEN_LABEL_EXAMPLE.BackgroundTransparency = 0
	Gui.WILLKOMMEN_LABEL_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WILLKOMMEN_LABEL_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.WILLKOMMEN_LABEL_EXAMPLE.BorderSizePixel = 0
	Gui.WILLKOMMEN_LABEL_EXAMPLE.ClipsDescendants = false
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Draggable = false
	Gui.WILLKOMMEN_LABEL_EXAMPLE.LayoutOrder = 0
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Rotation = 0
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Selectable = false
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Size = UDim2.new(1, 0, 0.116, 0)
	Gui.WILLKOMMEN_LABEL_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Visible = false
	Gui.WILLKOMMEN_LABEL_EXAMPLE.ZIndex = 3
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Archivable = true
	Gui.WILLKOMMEN_LABEL_EXAMPLE.Parent = Gui.HOMEPAGE_ITEMS

	Gui.UICorner_23 = Instance.new("UICorner")
	Gui.UICorner_23.Name = "UICorner"
	Gui.UICorner_23.CornerRadius = UDim.new(0.225, 0)
	Gui.UICorner_23.Archivable = true
	Gui.UICorner_23.Parent = Gui.WILLKOMMEN_LABEL_EXAMPLE

	Gui.FUNCTION_NAME_1 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_1.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_1.Archivable = true
	Gui.FUNCTION_NAME_1.Parent = Gui.WILLKOMMEN_LABEL_EXAMPLE

	Gui.MainLabel_1 = Instance.new("TextLabel")
	Gui.MainLabel_1.Name = "MainLabel"
	Gui.MainLabel_1.Active = false
	Gui.MainLabel_1.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_1.BackgroundTransparency = 1
	Gui.MainLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_1.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_1.BorderSizePixel = 0
	Gui.MainLabel_1.ClipsDescendants = false
	Gui.MainLabel_1.Draggable = false
	Gui.MainLabel_1.LayoutOrder = 0
	Gui.MainLabel_1.Position = UDim2.new(0.011, 0, 0.178, 0)
	Gui.MainLabel_1.Rotation = 0
	Gui.MainLabel_1.Selectable = false
	Gui.MainLabel_1.Size = UDim2.new(0.92, 0, 0.639, 0)
	Gui.MainLabel_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_1.Visible = true
	Gui.MainLabel_1.ZIndex = 1
	Gui.MainLabel_1.Font = Enum.Font.Unknown
	Gui.MainLabel_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_1.LineHeight = 1
	Gui.MainLabel_1.MaxVisibleGraphemes = -1
	Gui.MainLabel_1.RichText = false
	Gui.MainLabel_1.Text = "Willkommen zurück Freelancer1754!"
	Gui.MainLabel_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_1.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_1.TextScaled = true
	Gui.MainLabel_1.TextSize = 23
	Gui.MainLabel_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_1.TextStrokeTransparency = 1
	Gui.MainLabel_1.TextTransparency = 0
	Gui.MainLabel_1.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_1.TextWrapped = true
	Gui.MainLabel_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_1.Archivable = true
	Gui.MainLabel_1.Parent = Gui.WILLKOMMEN_LABEL_EXAMPLE

	Gui.UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_6.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_6.MaxTextSize = 23
	Gui.UITextSizeConstraint_6.MinTextSize = 1
	Gui.UITextSizeConstraint_6.Archivable = true
	Gui.UITextSizeConstraint_6.Parent = Gui.MainLabel_1

	Gui.COPY_DISCORD_LINK = Instance.new("Frame")
	Gui.COPY_DISCORD_LINK.Name = "COPY_DISCORD_LINK"
	Gui.COPY_DISCORD_LINK.Active = false
	Gui.COPY_DISCORD_LINK.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_DISCORD_LINK.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_DISCORD_LINK.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.COPY_DISCORD_LINK.BackgroundTransparency = 0
	Gui.COPY_DISCORD_LINK.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_DISCORD_LINK.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_DISCORD_LINK.BorderSizePixel = 0
	Gui.COPY_DISCORD_LINK.ClipsDescendants = false
	Gui.COPY_DISCORD_LINK.Draggable = false
	Gui.COPY_DISCORD_LINK.LayoutOrder = 0
	Gui.COPY_DISCORD_LINK.Position = UDim2.new(0, 0, 0.319, 0)
	Gui.COPY_DISCORD_LINK.Rotation = 0
	Gui.COPY_DISCORD_LINK.Selectable = false
	Gui.COPY_DISCORD_LINK.Size = UDim2.new(1, 0, 0.148, 0)
	Gui.COPY_DISCORD_LINK.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_DISCORD_LINK.Visible = false
	Gui.COPY_DISCORD_LINK.ZIndex = 3
	Gui.COPY_DISCORD_LINK.Style = Enum.FrameStyle.Custom
	Gui.COPY_DISCORD_LINK.Archivable = true
	Gui.COPY_DISCORD_LINK.Parent = Gui.HOMEPAGE_ITEMS

	Gui.UICorner_24 = Instance.new("UICorner")
	Gui.UICorner_24.Name = "UICorner"
	Gui.UICorner_24.CornerRadius = UDim.new(0.225, 0)
	Gui.UICorner_24.Archivable = true
	Gui.UICorner_24.Parent = Gui.COPY_DISCORD_LINK

	Gui.FUNCTION_NAME_2 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_2.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_2.Archivable = true
	Gui.FUNCTION_NAME_2.Parent = Gui.COPY_DISCORD_LINK

	Gui.MainLabel_2 = Instance.new("TextLabel")
	Gui.MainLabel_2.Name = "MainLabel"
	Gui.MainLabel_2.Active = false
	Gui.MainLabel_2.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_2.BackgroundTransparency = 1
	Gui.MainLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_2.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_2.BorderSizePixel = 0
	Gui.MainLabel_2.ClipsDescendants = false
	Gui.MainLabel_2.Draggable = false
	Gui.MainLabel_2.LayoutOrder = 0
	Gui.MainLabel_2.Position = UDim2.new(0.011, 0, 0.062, 0)
	Gui.MainLabel_2.Rotation = 0
	Gui.MainLabel_2.Selectable = false
	Gui.MainLabel_2.Size = UDim2.new(0.92, 0, 0.639, 0)
	Gui.MainLabel_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_2.Visible = true
	Gui.MainLabel_2.ZIndex = 1
	Gui.MainLabel_2.Font = Enum.Font.Unknown
	Gui.MainLabel_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_2.LineHeight = 1
	Gui.MainLabel_2.MaxVisibleGraphemes = -1
	Gui.MainLabel_2.RichText = false
	Gui.MainLabel_2.Text = "Discord Link kopieren"
	Gui.MainLabel_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_2.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_2.TextScaled = false
	Gui.MainLabel_2.TextSize = 23
	Gui.MainLabel_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_2.TextStrokeTransparency = 1
	Gui.MainLabel_2.TextTransparency = 0
	Gui.MainLabel_2.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_2.TextWrapped = true
	Gui.MainLabel_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_2.Archivable = true
	Gui.MainLabel_2.Parent = Gui.COPY_DISCORD_LINK

	Gui.UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_7.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_7.MaxTextSize = 23
	Gui.UITextSizeConstraint_7.MinTextSize = 1
	Gui.UITextSizeConstraint_7.Archivable = true
	Gui.UITextSizeConstraint_7.Parent = Gui.MainLabel_2

	Gui.COPY_DISCORD_INFO_LABEL = Instance.new("TextLabel")
	Gui.COPY_DISCORD_INFO_LABEL.Name = "COPY_DISCORD_INFO_LABEL"
	Gui.COPY_DISCORD_INFO_LABEL.Active = false
	Gui.COPY_DISCORD_INFO_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_DISCORD_INFO_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_DISCORD_INFO_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COPY_DISCORD_INFO_LABEL.BackgroundTransparency = 1
	Gui.COPY_DISCORD_INFO_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_DISCORD_INFO_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_DISCORD_INFO_LABEL.BorderSizePixel = 0
	Gui.COPY_DISCORD_INFO_LABEL.ClipsDescendants = false
	Gui.COPY_DISCORD_INFO_LABEL.Draggable = false
	Gui.COPY_DISCORD_INFO_LABEL.LayoutOrder = 0
	Gui.COPY_DISCORD_INFO_LABEL.Position = UDim2.new(0.011, 0, 0.522, 0)
	Gui.COPY_DISCORD_INFO_LABEL.Rotation = 0
	Gui.COPY_DISCORD_INFO_LABEL.Selectable = false
	Gui.COPY_DISCORD_INFO_LABEL.Size = UDim2.new(0.427, 0, 0.353, 0)
	Gui.COPY_DISCORD_INFO_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_DISCORD_INFO_LABEL.Visible = true
	Gui.COPY_DISCORD_INFO_LABEL.ZIndex = 1
	Gui.COPY_DISCORD_INFO_LABEL.Font = Enum.Font.Unknown
	Gui.COPY_DISCORD_INFO_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COPY_DISCORD_INFO_LABEL.LineHeight = 1
	Gui.COPY_DISCORD_INFO_LABEL.MaxVisibleGraphemes = -1
	Gui.COPY_DISCORD_INFO_LABEL.RichText = false
	Gui.COPY_DISCORD_INFO_LABEL.Text = "discord.gg/NVbNPRVtPa"
	Gui.COPY_DISCORD_INFO_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.COPY_DISCORD_INFO_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.COPY_DISCORD_INFO_LABEL.TextScaled = false
	Gui.COPY_DISCORD_INFO_LABEL.TextSize = 17
	Gui.COPY_DISCORD_INFO_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_DISCORD_INFO_LABEL.TextStrokeTransparency = 1
	Gui.COPY_DISCORD_INFO_LABEL.TextTransparency = 0
	Gui.COPY_DISCORD_INFO_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.COPY_DISCORD_INFO_LABEL.TextWrapped = true
	Gui.COPY_DISCORD_INFO_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COPY_DISCORD_INFO_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COPY_DISCORD_INFO_LABEL.Archivable = true
	Gui.COPY_DISCORD_INFO_LABEL.Parent = Gui.COPY_DISCORD_LINK

	Gui.COPY_DISCORD_LINK_TRIGGER = Instance.new("TextButton")
	Gui.COPY_DISCORD_LINK_TRIGGER.Name = "COPY_DISCORD_LINK_TRIGGER"
	Gui.COPY_DISCORD_LINK_TRIGGER.Active = true
	Gui.COPY_DISCORD_LINK_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_DISCORD_LINK_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_DISCORD_LINK_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COPY_DISCORD_LINK_TRIGGER.BackgroundTransparency = 1
	Gui.COPY_DISCORD_LINK_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_DISCORD_LINK_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_DISCORD_LINK_TRIGGER.BorderSizePixel = 0
	Gui.COPY_DISCORD_LINK_TRIGGER.ClipsDescendants = false
	Gui.COPY_DISCORD_LINK_TRIGGER.Draggable = false
	Gui.COPY_DISCORD_LINK_TRIGGER.LayoutOrder = 0
	Gui.COPY_DISCORD_LINK_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.COPY_DISCORD_LINK_TRIGGER.Rotation = 0
	Gui.COPY_DISCORD_LINK_TRIGGER.Selectable = true
	Gui.COPY_DISCORD_LINK_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.COPY_DISCORD_LINK_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_DISCORD_LINK_TRIGGER.Visible = true
	Gui.COPY_DISCORD_LINK_TRIGGER.ZIndex = 1
	Gui.COPY_DISCORD_LINK_TRIGGER.Font = Enum.Font.Unknown
	Gui.COPY_DISCORD_LINK_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COPY_DISCORD_LINK_TRIGGER.LineHeight = 1
	Gui.COPY_DISCORD_LINK_TRIGGER.MaxVisibleGraphemes = -1
	Gui.COPY_DISCORD_LINK_TRIGGER.RichText = false
	Gui.COPY_DISCORD_LINK_TRIGGER.Text = ""
	Gui.COPY_DISCORD_LINK_TRIGGER.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.COPY_DISCORD_LINK_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.COPY_DISCORD_LINK_TRIGGER.TextScaled = true
	Gui.COPY_DISCORD_LINK_TRIGGER.TextSize = 14
	Gui.COPY_DISCORD_LINK_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_DISCORD_LINK_TRIGGER.TextStrokeTransparency = 1
	Gui.COPY_DISCORD_LINK_TRIGGER.TextTransparency = 0
	Gui.COPY_DISCORD_LINK_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.COPY_DISCORD_LINK_TRIGGER.TextWrapped = true
	Gui.COPY_DISCORD_LINK_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.COPY_DISCORD_LINK_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COPY_DISCORD_LINK_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.COPY_DISCORD_LINK_TRIGGER.AutoButtonColor = true
	Gui.COPY_DISCORD_LINK_TRIGGER.Modal = false
	Gui.COPY_DISCORD_LINK_TRIGGER.Selected = false
	Gui.COPY_DISCORD_LINK_TRIGGER.Archivable = true
	Gui.COPY_DISCORD_LINK_TRIGGER.Parent = Gui.COPY_DISCORD_LINK

	Gui.COPY_WEBSITE_LINK = Instance.new("Frame")
	Gui.COPY_WEBSITE_LINK.Name = "COPY_WEBSITE_LINK"
	Gui.COPY_WEBSITE_LINK.Active = false
	Gui.COPY_WEBSITE_LINK.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_WEBSITE_LINK.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_WEBSITE_LINK.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.COPY_WEBSITE_LINK.BackgroundTransparency = 0
	Gui.COPY_WEBSITE_LINK.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_WEBSITE_LINK.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_WEBSITE_LINK.BorderSizePixel = 0
	Gui.COPY_WEBSITE_LINK.ClipsDescendants = false
	Gui.COPY_WEBSITE_LINK.Draggable = false
	Gui.COPY_WEBSITE_LINK.LayoutOrder = 0
	Gui.COPY_WEBSITE_LINK.Position = UDim2.new(0, 0, 0.402, 0)
	Gui.COPY_WEBSITE_LINK.Rotation = 0
	Gui.COPY_WEBSITE_LINK.Selectable = false
	Gui.COPY_WEBSITE_LINK.Size = UDim2.new(1, 0, 0.148, 0)
	Gui.COPY_WEBSITE_LINK.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_WEBSITE_LINK.Visible = false
	Gui.COPY_WEBSITE_LINK.ZIndex = 3
	Gui.COPY_WEBSITE_LINK.Style = Enum.FrameStyle.Custom
	Gui.COPY_WEBSITE_LINK.Archivable = true
	Gui.COPY_WEBSITE_LINK.Parent = Gui.HOMEPAGE_ITEMS

	Gui.UICorner_25 = Instance.new("UICorner")
	Gui.UICorner_25.Name = "UICorner"
	Gui.UICorner_25.CornerRadius = UDim.new(0.225, 0)
	Gui.UICorner_25.Archivable = true
	Gui.UICorner_25.Parent = Gui.COPY_WEBSITE_LINK

	Gui.FUNCTION_NAME_3 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_3.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_3.Archivable = true
	Gui.FUNCTION_NAME_3.Parent = Gui.COPY_WEBSITE_LINK

	Gui.MainLabel_3 = Instance.new("TextLabel")
	Gui.MainLabel_3.Name = "MainLabel"
	Gui.MainLabel_3.Active = false
	Gui.MainLabel_3.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_3.BackgroundTransparency = 1
	Gui.MainLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_3.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_3.BorderSizePixel = 0
	Gui.MainLabel_3.ClipsDescendants = false
	Gui.MainLabel_3.Draggable = false
	Gui.MainLabel_3.LayoutOrder = 0
	Gui.MainLabel_3.Position = UDim2.new(0.011, 0, 0.062, 0)
	Gui.MainLabel_3.Rotation = 0
	Gui.MainLabel_3.Selectable = false
	Gui.MainLabel_3.Size = UDim2.new(0.92, 0, 0.639, 0)
	Gui.MainLabel_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_3.Visible = true
	Gui.MainLabel_3.ZIndex = 1
	Gui.MainLabel_3.Font = Enum.Font.Unknown
	Gui.MainLabel_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_3.LineHeight = 1
	Gui.MainLabel_3.MaxVisibleGraphemes = -1
	Gui.MainLabel_3.RichText = false
	Gui.MainLabel_3.Text = "Website Link kopieren"
	Gui.MainLabel_3.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_3.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_3.TextScaled = false
	Gui.MainLabel_3.TextSize = 23
	Gui.MainLabel_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_3.TextStrokeTransparency = 1
	Gui.MainLabel_3.TextTransparency = 0
	Gui.MainLabel_3.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_3.TextWrapped = true
	Gui.MainLabel_3.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_3.Archivable = true
	Gui.MainLabel_3.Parent = Gui.COPY_WEBSITE_LINK

	Gui.UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_8.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_8.MaxTextSize = 23
	Gui.UITextSizeConstraint_8.MinTextSize = 1
	Gui.UITextSizeConstraint_8.Archivable = true
	Gui.UITextSizeConstraint_8.Parent = Gui.MainLabel_3

	Gui.COPY_WEBSITE_INFO_LABEL = Instance.new("TextLabel")
	Gui.COPY_WEBSITE_INFO_LABEL.Name = "COPY_WEBSITE_INFO_LABEL"
	Gui.COPY_WEBSITE_INFO_LABEL.Active = false
	Gui.COPY_WEBSITE_INFO_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_WEBSITE_INFO_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_WEBSITE_INFO_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COPY_WEBSITE_INFO_LABEL.BackgroundTransparency = 1
	Gui.COPY_WEBSITE_INFO_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_WEBSITE_INFO_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_WEBSITE_INFO_LABEL.BorderSizePixel = 0
	Gui.COPY_WEBSITE_INFO_LABEL.ClipsDescendants = false
	Gui.COPY_WEBSITE_INFO_LABEL.Draggable = false
	Gui.COPY_WEBSITE_INFO_LABEL.LayoutOrder = 0
	Gui.COPY_WEBSITE_INFO_LABEL.Position = UDim2.new(0.011, 0, 0.522, 0)
	Gui.COPY_WEBSITE_INFO_LABEL.Rotation = 0
	Gui.COPY_WEBSITE_INFO_LABEL.Selectable = false
	Gui.COPY_WEBSITE_INFO_LABEL.Size = UDim2.new(0.427, 0, 0.353, 0)
	Gui.COPY_WEBSITE_INFO_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_WEBSITE_INFO_LABEL.Visible = true
	Gui.COPY_WEBSITE_INFO_LABEL.ZIndex = 1
	Gui.COPY_WEBSITE_INFO_LABEL.Font = Enum.Font.Unknown
	Gui.COPY_WEBSITE_INFO_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COPY_WEBSITE_INFO_LABEL.LineHeight = 1
	Gui.COPY_WEBSITE_INFO_LABEL.MaxVisibleGraphemes = -1
	Gui.COPY_WEBSITE_INFO_LABEL.RichText = false
	Gui.COPY_WEBSITE_INFO_LABEL.Text = "https://lynxware.onrender.com"
	Gui.COPY_WEBSITE_INFO_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.COPY_WEBSITE_INFO_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.COPY_WEBSITE_INFO_LABEL.TextScaled = false
	Gui.COPY_WEBSITE_INFO_LABEL.TextSize = 17
	Gui.COPY_WEBSITE_INFO_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_WEBSITE_INFO_LABEL.TextStrokeTransparency = 1
	Gui.COPY_WEBSITE_INFO_LABEL.TextTransparency = 0
	Gui.COPY_WEBSITE_INFO_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.COPY_WEBSITE_INFO_LABEL.TextWrapped = true
	Gui.COPY_WEBSITE_INFO_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COPY_WEBSITE_INFO_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COPY_WEBSITE_INFO_LABEL.Archivable = true
	Gui.COPY_WEBSITE_INFO_LABEL.Parent = Gui.COPY_WEBSITE_LINK

	Gui.COPY_WEBSITE_LINK_TRIGGER = Instance.new("TextButton")
	Gui.COPY_WEBSITE_LINK_TRIGGER.Name = "COPY_WEBSITE_LINK_TRIGGER"
	Gui.COPY_WEBSITE_LINK_TRIGGER.Active = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.COPY_WEBSITE_LINK_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.COPY_WEBSITE_LINK_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COPY_WEBSITE_LINK_TRIGGER.BackgroundTransparency = 1
	Gui.COPY_WEBSITE_LINK_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_WEBSITE_LINK_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.COPY_WEBSITE_LINK_TRIGGER.BorderSizePixel = 0
	Gui.COPY_WEBSITE_LINK_TRIGGER.ClipsDescendants = false
	Gui.COPY_WEBSITE_LINK_TRIGGER.Draggable = false
	Gui.COPY_WEBSITE_LINK_TRIGGER.LayoutOrder = 0
	Gui.COPY_WEBSITE_LINK_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.COPY_WEBSITE_LINK_TRIGGER.Rotation = 0
	Gui.COPY_WEBSITE_LINK_TRIGGER.Selectable = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.COPY_WEBSITE_LINK_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COPY_WEBSITE_LINK_TRIGGER.Visible = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.ZIndex = 1
	Gui.COPY_WEBSITE_LINK_TRIGGER.Font = Enum.Font.Unknown
	Gui.COPY_WEBSITE_LINK_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COPY_WEBSITE_LINK_TRIGGER.LineHeight = 1
	Gui.COPY_WEBSITE_LINK_TRIGGER.MaxVisibleGraphemes = -1
	Gui.COPY_WEBSITE_LINK_TRIGGER.RichText = false
	Gui.COPY_WEBSITE_LINK_TRIGGER.Text = ""
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextScaled = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextSize = 14
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextStrokeTransparency = 1
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextTransparency = 0
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextWrapped = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.COPY_WEBSITE_LINK_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COPY_WEBSITE_LINK_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.COPY_WEBSITE_LINK_TRIGGER.AutoButtonColor = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.Modal = false
	Gui.COPY_WEBSITE_LINK_TRIGGER.Selected = false
	Gui.COPY_WEBSITE_LINK_TRIGGER.Archivable = true
	Gui.COPY_WEBSITE_LINK_TRIGGER.Parent = Gui.COPY_WEBSITE_LINK

	Gui.UPDATE_EXAMPLE = Instance.new("Frame")
	Gui.UPDATE_EXAMPLE.Name = "UPDATE_EXAMPLE"
	Gui.UPDATE_EXAMPLE.Active = false
	Gui.UPDATE_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.UPDATE_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.UPDATE_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.UPDATE_EXAMPLE.BackgroundTransparency = 0
	Gui.UPDATE_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.UPDATE_EXAMPLE.BorderSizePixel = 0
	Gui.UPDATE_EXAMPLE.ClipsDescendants = false
	Gui.UPDATE_EXAMPLE.Draggable = false
	Gui.UPDATE_EXAMPLE.LayoutOrder = 0
	Gui.UPDATE_EXAMPLE.Position = UDim2.new(0.009, 0, 0.057, 0)
	Gui.UPDATE_EXAMPLE.Rotation = 0
	Gui.UPDATE_EXAMPLE.Selectable = false
	Gui.UPDATE_EXAMPLE.Size = UDim2.new(1, 0, 0.816, 0)
	Gui.UPDATE_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.UPDATE_EXAMPLE.Visible = false
	Gui.UPDATE_EXAMPLE.ZIndex = 3
	Gui.UPDATE_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.UPDATE_EXAMPLE.Archivable = true
	Gui.UPDATE_EXAMPLE.Parent = Gui.HOMEPAGE_ITEMS

	Gui.UICorner_26 = Instance.new("UICorner")
	Gui.UICorner_26.Name = "UICorner"
	Gui.UICorner_26.CornerRadius = UDim.new(0.035, 0)
	Gui.UICorner_26.Archivable = true
	Gui.UICorner_26.Parent = Gui.UPDATE_EXAMPLE

	Gui.MainLabel_4 = Instance.new("TextLabel")
	Gui.MainLabel_4.Name = "MainLabel"
	Gui.MainLabel_4.Active = false
	Gui.MainLabel_4.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_4.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_4.BackgroundTransparency = 1
	Gui.MainLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_4.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_4.BorderSizePixel = 0
	Gui.MainLabel_4.ClipsDescendants = false
	Gui.MainLabel_4.Draggable = false
	Gui.MainLabel_4.LayoutOrder = 0
	Gui.MainLabel_4.Position = UDim2.new(0.037, 0, -0.002, 0)
	Gui.MainLabel_4.Rotation = 0
	Gui.MainLabel_4.Selectable = false
	Gui.MainLabel_4.Size = UDim2.new(0.241, 0, 0.137, 0)
	Gui.MainLabel_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_4.Visible = true
	Gui.MainLabel_4.ZIndex = 1
	Gui.MainLabel_4.Font = Enum.Font.Unknown
	Gui.MainLabel_4.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_4.LineHeight = 1
	Gui.MainLabel_4.MaxVisibleGraphemes = -1
	Gui.MainLabel_4.RichText = false
	Gui.MainLabel_4.Text = "Letztes Update"
	Gui.MainLabel_4.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_4.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_4.TextScaled = true
	Gui.MainLabel_4.TextSize = 23
	Gui.MainLabel_4.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_4.TextStrokeTransparency = 1
	Gui.MainLabel_4.TextTransparency = 0
	Gui.MainLabel_4.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_4.TextWrapped = true
	Gui.MainLabel_4.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_4.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_4.Archivable = true
	Gui.MainLabel_4.Parent = Gui.UPDATE_EXAMPLE

	Gui.UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_9.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_9.MaxTextSize = 23
	Gui.UITextSizeConstraint_9.MinTextSize = 1
	Gui.UITextSizeConstraint_9.Archivable = true
	Gui.UITextSizeConstraint_9.Parent = Gui.MainLabel_4

	Gui.UPDATE_VERSION_LABEL = Instance.new("TextLabel")
	Gui.UPDATE_VERSION_LABEL.Name = "UPDATE_VERSION_LABEL"
	Gui.UPDATE_VERSION_LABEL.Active = false
	Gui.UPDATE_VERSION_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.UPDATE_VERSION_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.UPDATE_VERSION_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.UPDATE_VERSION_LABEL.BackgroundTransparency = 1
	Gui.UPDATE_VERSION_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_VERSION_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.UPDATE_VERSION_LABEL.BorderSizePixel = 0
	Gui.UPDATE_VERSION_LABEL.ClipsDescendants = false
	Gui.UPDATE_VERSION_LABEL.Draggable = false
	Gui.UPDATE_VERSION_LABEL.LayoutOrder = 0
	Gui.UPDATE_VERSION_LABEL.Position = UDim2.new(0.296, 0, -0.002, 0)
	Gui.UPDATE_VERSION_LABEL.Rotation = 0
	Gui.UPDATE_VERSION_LABEL.Selectable = false
	Gui.UPDATE_VERSION_LABEL.Size = UDim2.new(0.081, 0, 0.137, 0)
	Gui.UPDATE_VERSION_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.UPDATE_VERSION_LABEL.Visible = true
	Gui.UPDATE_VERSION_LABEL.ZIndex = 1
	Gui.UPDATE_VERSION_LABEL.Font = Enum.Font.Unknown
	Gui.UPDATE_VERSION_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.UPDATE_VERSION_LABEL.LineHeight = 1
	Gui.UPDATE_VERSION_LABEL.MaxVisibleGraphemes = -1
	Gui.UPDATE_VERSION_LABEL.RichText = false
	Gui.UPDATE_VERSION_LABEL.Text = "v.0.1.0"
	Gui.UPDATE_VERSION_LABEL.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.UPDATE_VERSION_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.UPDATE_VERSION_LABEL.TextScaled = false
	Gui.UPDATE_VERSION_LABEL.TextSize = 17
	Gui.UPDATE_VERSION_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_VERSION_LABEL.TextStrokeTransparency = 1
	Gui.UPDATE_VERSION_LABEL.TextTransparency = 0
	Gui.UPDATE_VERSION_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.UPDATE_VERSION_LABEL.TextWrapped = true
	Gui.UPDATE_VERSION_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.UPDATE_VERSION_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.UPDATE_VERSION_LABEL.Archivable = true
	Gui.UPDATE_VERSION_LABEL.Parent = Gui.UPDATE_EXAMPLE

	Gui.UPDATE_INHALT_FRAME = Instance.new("ScrollingFrame")
	Gui.UPDATE_INHALT_FRAME.Name = "UPDATE_INHALT_FRAME"
	Gui.UPDATE_INHALT_FRAME.Active = true
	Gui.UPDATE_INHALT_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.UPDATE_INHALT_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.UPDATE_INHALT_FRAME.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.UPDATE_INHALT_FRAME.BackgroundTransparency = 0
	Gui.UPDATE_INHALT_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_INHALT_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.UPDATE_INHALT_FRAME.BorderSizePixel = 0
	Gui.UPDATE_INHALT_FRAME.ClipsDescendants = true
	Gui.UPDATE_INHALT_FRAME.Draggable = false
	Gui.UPDATE_INHALT_FRAME.LayoutOrder = 0
	Gui.UPDATE_INHALT_FRAME.Position = UDim2.new(0.04, 0, 0.135, 0)
	Gui.UPDATE_INHALT_FRAME.Rotation = 0
	Gui.UPDATE_INHALT_FRAME.Selectable = true
	Gui.UPDATE_INHALT_FRAME.Size = UDim2.new(0.917, 0, 0.815, 0)
	Gui.UPDATE_INHALT_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.UPDATE_INHALT_FRAME.Visible = true
	Gui.UPDATE_INHALT_FRAME.ZIndex = 1
	Gui.UPDATE_INHALT_FRAME.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Gui.UPDATE_INHALT_FRAME.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Gui.UPDATE_INHALT_FRAME.CanvasPosition = Vector2.new(0, 0)
	Gui.UPDATE_INHALT_FRAME.CanvasSize = UDim2.new(0, 0, 2, 0)
	Gui.UPDATE_INHALT_FRAME.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Gui.UPDATE_INHALT_FRAME.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Gui.UPDATE_INHALT_FRAME.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Gui.UPDATE_INHALT_FRAME.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_INHALT_FRAME.ScrollBarImageTransparency = 0
	Gui.UPDATE_INHALT_FRAME.ScrollBarThickness = 0
	Gui.UPDATE_INHALT_FRAME.ScrollingDirection = Enum.ScrollingDirection.XY
	Gui.UPDATE_INHALT_FRAME.ScrollingEnabled = true
	Gui.UPDATE_INHALT_FRAME.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Gui.UPDATE_INHALT_FRAME.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Gui.UPDATE_INHALT_FRAME.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	Gui.UPDATE_INHALT_FRAME.Archivable = true
	Gui.UPDATE_INHALT_FRAME.Parent = Gui.UPDATE_EXAMPLE

	Gui.UIListLayout_5 = Instance.new("UIListLayout")
	Gui.UIListLayout_5.Name = "UIListLayout"
	Gui.UIListLayout_5.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_5.Padding = UDim.new(0, 0)
	Gui.UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_5.Wraps = false
	Gui.UIListLayout_5.Archivable = true
	Gui.UIListLayout_5.Parent = Gui.UPDATE_INHALT_FRAME

	Gui.UICorner_27 = Instance.new("UICorner")
	Gui.UICorner_27.Name = "UICorner"
	Gui.UICorner_27.CornerRadius = UDim.new(0.05, 0)
	Gui.UICorner_27.Archivable = true
	Gui.UICorner_27.Parent = Gui.UPDATE_INHALT_FRAME

	Gui.UPDATE_DATE_LABEL = Instance.new("TextLabel")
	Gui.UPDATE_DATE_LABEL.Name = "UPDATE_DATE_LABEL"
	Gui.UPDATE_DATE_LABEL.Active = false
	Gui.UPDATE_DATE_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.UPDATE_DATE_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.UPDATE_DATE_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.UPDATE_DATE_LABEL.BackgroundTransparency = 1
	Gui.UPDATE_DATE_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_DATE_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.UPDATE_DATE_LABEL.BorderSizePixel = 0
	Gui.UPDATE_DATE_LABEL.ClipsDescendants = false
	Gui.UPDATE_DATE_LABEL.Draggable = false
	Gui.UPDATE_DATE_LABEL.LayoutOrder = 0
	Gui.UPDATE_DATE_LABEL.Position = UDim2.new(0.41, 0, -0.002, 0)
	Gui.UPDATE_DATE_LABEL.Rotation = 0
	Gui.UPDATE_DATE_LABEL.Selectable = false
	Gui.UPDATE_DATE_LABEL.Size = UDim2.new(0.468, 0, 0.137, 0)
	Gui.UPDATE_DATE_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.UPDATE_DATE_LABEL.Visible = true
	Gui.UPDATE_DATE_LABEL.ZIndex = 1
	Gui.UPDATE_DATE_LABEL.Font = Enum.Font.Unknown
	Gui.UPDATE_DATE_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.UPDATE_DATE_LABEL.LineHeight = 1
	Gui.UPDATE_DATE_LABEL.MaxVisibleGraphemes = -1
	Gui.UPDATE_DATE_LABEL.RichText = false
	Gui.UPDATE_DATE_LABEL.Text = "01.01.2026"
	Gui.UPDATE_DATE_LABEL.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.UPDATE_DATE_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.UPDATE_DATE_LABEL.TextScaled = false
	Gui.UPDATE_DATE_LABEL.TextSize = 17
	Gui.UPDATE_DATE_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_DATE_LABEL.TextStrokeTransparency = 1
	Gui.UPDATE_DATE_LABEL.TextTransparency = 0
	Gui.UPDATE_DATE_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.UPDATE_DATE_LABEL.TextWrapped = true
	Gui.UPDATE_DATE_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.UPDATE_DATE_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.UPDATE_DATE_LABEL.Archivable = true
	Gui.UPDATE_DATE_LABEL.Parent = Gui.UPDATE_EXAMPLE

	Gui.UPDATE_FEATURE_EXAMPLE = Instance.new("TextLabel")
	Gui.UPDATE_FEATURE_EXAMPLE.Name = "UPDATE_FEATURE_EXAMPLE"
	Gui.UPDATE_FEATURE_EXAMPLE.Active = false
	Gui.UPDATE_FEATURE_EXAMPLE.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.UPDATE_FEATURE_EXAMPLE.AutomaticSize = Enum.AutomaticSize.Y
	Gui.UPDATE_FEATURE_EXAMPLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.UPDATE_FEATURE_EXAMPLE.BackgroundTransparency = 1
	Gui.UPDATE_FEATURE_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_FEATURE_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.UPDATE_FEATURE_EXAMPLE.BorderSizePixel = 0
	Gui.UPDATE_FEATURE_EXAMPLE.ClipsDescendants = false
	Gui.UPDATE_FEATURE_EXAMPLE.Draggable = false
	Gui.UPDATE_FEATURE_EXAMPLE.LayoutOrder = 0
	Gui.UPDATE_FEATURE_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.UPDATE_FEATURE_EXAMPLE.Rotation = 0
	Gui.UPDATE_FEATURE_EXAMPLE.Selectable = false
	Gui.UPDATE_FEATURE_EXAMPLE.Size = UDim2.new(1, 0, 0.245, 0)
	Gui.UPDATE_FEATURE_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.UPDATE_FEATURE_EXAMPLE.Visible = false
	Gui.UPDATE_FEATURE_EXAMPLE.ZIndex = 1
	Gui.UPDATE_FEATURE_EXAMPLE.Font = Enum.Font.Unknown
	Gui.UPDATE_FEATURE_EXAMPLE.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.UPDATE_FEATURE_EXAMPLE.LineHeight = 1
	Gui.UPDATE_FEATURE_EXAMPLE.MaxVisibleGraphemes = -1
	Gui.UPDATE_FEATURE_EXAMPLE.RichText = false
	Gui.UPDATE_FEATURE_EXAMPLE.Text = "[ / ] Aimbot Smoothnes überarbeitet"
	Gui.UPDATE_FEATURE_EXAMPLE.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.UPDATE_FEATURE_EXAMPLE.TextDirection = Enum.TextDirection.Auto
	Gui.UPDATE_FEATURE_EXAMPLE.TextScaled = true
	Gui.UPDATE_FEATURE_EXAMPLE.TextSize = 20
	Gui.UPDATE_FEATURE_EXAMPLE.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.UPDATE_FEATURE_EXAMPLE.TextStrokeTransparency = 1
	Gui.UPDATE_FEATURE_EXAMPLE.TextTransparency = 0
	Gui.UPDATE_FEATURE_EXAMPLE.TextTruncate = Enum.TextTruncate.None
	Gui.UPDATE_FEATURE_EXAMPLE.TextWrapped = true
	Gui.UPDATE_FEATURE_EXAMPLE.TextXAlignment = Enum.TextXAlignment.Left
	Gui.UPDATE_FEATURE_EXAMPLE.TextYAlignment = Enum.TextYAlignment.Center
	Gui.UPDATE_FEATURE_EXAMPLE.Archivable = true
	Gui.UPDATE_FEATURE_EXAMPLE.Parent = Gui.UPDATE_EXAMPLE

	Gui.UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_10.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_10.MaxTextSize = 20
	Gui.UITextSizeConstraint_10.MinTextSize = 1
	Gui.UITextSizeConstraint_10.Archivable = true
	Gui.UITextSizeConstraint_10.Parent = Gui.UPDATE_FEATURE_EXAMPLE

	Gui.BUTTON_EXAMPLE = Instance.new("Frame")
	Gui.BUTTON_EXAMPLE.Name = "BUTTON_EXAMPLE"
	Gui.BUTTON_EXAMPLE.Active = false
	Gui.BUTTON_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.BUTTON_EXAMPLE.BackgroundTransparency = 0
	Gui.BUTTON_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_EXAMPLE.BorderSizePixel = 0
	Gui.BUTTON_EXAMPLE.ClipsDescendants = false
	Gui.BUTTON_EXAMPLE.Draggable = false
	Gui.BUTTON_EXAMPLE.LayoutOrder = 0
	Gui.BUTTON_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.BUTTON_EXAMPLE.Rotation = 0
	Gui.BUTTON_EXAMPLE.Selectable = false
	Gui.BUTTON_EXAMPLE.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.BUTTON_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_EXAMPLE.Visible = false
	Gui.BUTTON_EXAMPLE.ZIndex = 3
	Gui.BUTTON_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_EXAMPLE.Archivable = true
	Gui.BUTTON_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_28 = Instance.new("UICorner")
	Gui.UICorner_28.Name = "UICorner"
	Gui.UICorner_28.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_28.Archivable = true
	Gui.UICorner_28.Parent = Gui.BUTTON_EXAMPLE

	Gui.FUNCTION_NAME_4 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_4.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_4.Archivable = true
	Gui.FUNCTION_NAME_4.Parent = Gui.BUTTON_EXAMPLE

	Gui.MainLabel_5 = Instance.new("TextLabel")
	Gui.MainLabel_5.Name = "MainLabel"
	Gui.MainLabel_5.Active = false
	Gui.MainLabel_5.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_5.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_5.BackgroundTransparency = 1
	Gui.MainLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_5.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_5.BorderSizePixel = 0
	Gui.MainLabel_5.ClipsDescendants = false
	Gui.MainLabel_5.Draggable = false
	Gui.MainLabel_5.LayoutOrder = 0
	Gui.MainLabel_5.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_5.Rotation = 0
	Gui.MainLabel_5.Selectable = false
	Gui.MainLabel_5.Size = UDim2.new(0.468, 0, 0.479, 0)
	Gui.MainLabel_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_5.Visible = true
	Gui.MainLabel_5.ZIndex = 1
	Gui.MainLabel_5.Font = Enum.Font.Unknown
	Gui.MainLabel_5.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_5.LineHeight = 1
	Gui.MainLabel_5.MaxVisibleGraphemes = -1
	Gui.MainLabel_5.RichText = false
	Gui.MainLabel_5.Text = "Das ist der Name des Buttons"
	Gui.MainLabel_5.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_5.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_5.TextScaled = true
	Gui.MainLabel_5.TextSize = 23
	Gui.MainLabel_5.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_5.TextStrokeTransparency = 1
	Gui.MainLabel_5.TextTransparency = 0
	Gui.MainLabel_5.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_5.TextWrapped = true
	Gui.MainLabel_5.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_5.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_5.Archivable = true
	Gui.MainLabel_5.Parent = Gui.BUTTON_EXAMPLE

	Gui.UITextSizeConstraint_11 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_11.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_11.MaxTextSize = 23
	Gui.UITextSizeConstraint_11.MinTextSize = 1
	Gui.UITextSizeConstraint_11.Archivable = true
	Gui.UITextSizeConstraint_11.Parent = Gui.MainLabel_5

	Gui.Description_1 = Instance.new("TextLabel")
	Gui.Description_1.Name = "Description"
	Gui.Description_1.Active = false
	Gui.Description_1.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_1.BackgroundTransparency = 1
	Gui.Description_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_1.BorderMode = Enum.BorderMode.Outline
	Gui.Description_1.BorderSizePixel = 0
	Gui.Description_1.ClipsDescendants = false
	Gui.Description_1.Draggable = false
	Gui.Description_1.LayoutOrder = 0
	Gui.Description_1.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_1.Rotation = 0
	Gui.Description_1.Selectable = false
	Gui.Description_1.Size = UDim2.new(0.466, 0, 0.479, 0)
	Gui.Description_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_1.Visible = true
	Gui.Description_1.ZIndex = 1
	Gui.Description_1.Font = Enum.Font.Unknown
	Gui.Description_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_1.LineHeight = 1
	Gui.Description_1.MaxVisibleGraphemes = -1
	Gui.Description_1.RichText = false
	Gui.Description_1.Text = "Das ist die Beschreibung des Buttons"
	Gui.Description_1.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description_1.TextDirection = Enum.TextDirection.Auto
	Gui.Description_1.TextScaled = true
	Gui.Description_1.TextSize = 17
	Gui.Description_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_1.TextStrokeTransparency = 1
	Gui.Description_1.TextTransparency = 0
	Gui.Description_1.TextTruncate = Enum.TextTruncate.None
	Gui.Description_1.TextWrapped = true
	Gui.Description_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_1.Archivable = true
	Gui.Description_1.Parent = Gui.BUTTON_EXAMPLE

	Gui.UITextSizeConstraint_12 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_12.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_12.MaxTextSize = 17
	Gui.UITextSizeConstraint_12.MinTextSize = 1
	Gui.UITextSizeConstraint_12.Archivable = true
	Gui.UITextSizeConstraint_12.Parent = Gui.Description_1

	Gui.KEEPING_FRAME = Instance.new("Frame")
	Gui.KEEPING_FRAME.Name = "KEEPING_FRAME"
	Gui.KEEPING_FRAME.Active = false
	Gui.KEEPING_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.KEEPING_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEEPING_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEEPING_FRAME.BackgroundTransparency = 1
	Gui.KEEPING_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEEPING_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.KEEPING_FRAME.BorderSizePixel = 0
	Gui.KEEPING_FRAME.ClipsDescendants = false
	Gui.KEEPING_FRAME.Draggable = false
	Gui.KEEPING_FRAME.LayoutOrder = 0
	Gui.KEEPING_FRAME.Position = UDim2.new(0.735, 0, 0.481, 0)
	Gui.KEEPING_FRAME.Rotation = 0
	Gui.KEEPING_FRAME.Selectable = false
	Gui.KEEPING_FRAME.Size = UDim2.new(0.502, 0, 0.747, 0)
	Gui.KEEPING_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEEPING_FRAME.Visible = true
	Gui.KEEPING_FRAME.ZIndex = 1
	Gui.KEEPING_FRAME.Style = Enum.FrameStyle.Custom
	Gui.KEEPING_FRAME.Archivable = true
	Gui.KEEPING_FRAME.Parent = Gui.BUTTON_EXAMPLE

	Gui.SEARCHBAR_MAIN_FRAME = Instance.new("Frame")
	Gui.SEARCHBAR_MAIN_FRAME.Name = "SEARCHBAR_MAIN_FRAME"
	Gui.SEARCHBAR_MAIN_FRAME.Active = false
	Gui.SEARCHBAR_MAIN_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.SEARCHBAR_MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.SEARCHBAR_MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SEARCHBAR_MAIN_FRAME.BackgroundTransparency = 1
	Gui.SEARCHBAR_MAIN_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SEARCHBAR_MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.SEARCHBAR_MAIN_FRAME.BorderSizePixel = 0
	Gui.SEARCHBAR_MAIN_FRAME.ClipsDescendants = false
	Gui.SEARCHBAR_MAIN_FRAME.Draggable = false
	Gui.SEARCHBAR_MAIN_FRAME.LayoutOrder = 1
	Gui.SEARCHBAR_MAIN_FRAME.Position = UDim2.new(0.015, 0, 0, 0)
	Gui.SEARCHBAR_MAIN_FRAME.Rotation = 0
	Gui.SEARCHBAR_MAIN_FRAME.Selectable = false
	Gui.SEARCHBAR_MAIN_FRAME.Size = UDim2.new(0.672, 0, 1.008, 0)
	Gui.SEARCHBAR_MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SEARCHBAR_MAIN_FRAME.Visible = true
	Gui.SEARCHBAR_MAIN_FRAME.ZIndex = 1
	Gui.SEARCHBAR_MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.SEARCHBAR_MAIN_FRAME.Archivable = true
	Gui.SEARCHBAR_MAIN_FRAME.Parent = Gui.KEEPING_FRAME

	Gui.SEARCHBAR_BACKGROUND = Instance.new("Frame")
	Gui.SEARCHBAR_BACKGROUND.Name = "SEARCHBAR_BACKGROUND"
	Gui.SEARCHBAR_BACKGROUND.Active = false
	Gui.SEARCHBAR_BACKGROUND.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SEARCHBAR_BACKGROUND.AutomaticSize = Enum.AutomaticSize.None
	Gui.SEARCHBAR_BACKGROUND.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.SEARCHBAR_BACKGROUND.BackgroundTransparency = 0
	Gui.SEARCHBAR_BACKGROUND.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SEARCHBAR_BACKGROUND.BorderMode = Enum.BorderMode.Outline
	Gui.SEARCHBAR_BACKGROUND.BorderSizePixel = 0
	Gui.SEARCHBAR_BACKGROUND.ClipsDescendants = false
	Gui.SEARCHBAR_BACKGROUND.Draggable = false
	Gui.SEARCHBAR_BACKGROUND.LayoutOrder = 2
	Gui.SEARCHBAR_BACKGROUND.Position = UDim2.new(0.498, 0, 0.5, 0)
	Gui.SEARCHBAR_BACKGROUND.Rotation = 0
	Gui.SEARCHBAR_BACKGROUND.Selectable = false
	Gui.SEARCHBAR_BACKGROUND.Size = UDim2.new(1, 0, 1, 0)
	Gui.SEARCHBAR_BACKGROUND.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SEARCHBAR_BACKGROUND.Visible = true
	Gui.SEARCHBAR_BACKGROUND.ZIndex = 1
	Gui.SEARCHBAR_BACKGROUND.Style = Enum.FrameStyle.Custom
	Gui.SEARCHBAR_BACKGROUND.Archivable = true
	Gui.SEARCHBAR_BACKGROUND.Parent = Gui.SEARCHBAR_MAIN_FRAME

	Gui.UICorner_29 = Instance.new("UICorner")
	Gui.UICorner_29.Name = "UICorner"
	Gui.UICorner_29.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_29.Archivable = true
	Gui.UICorner_29.Parent = Gui.SEARCHBAR_BACKGROUND

	Gui.SEARCHBAR_TEXTBOX = Instance.new("TextBox")
	Gui.SEARCHBAR_TEXTBOX.Name = "SEARCHBAR_TEXTBOX"
	Gui.SEARCHBAR_TEXTBOX.Active = true
	Gui.SEARCHBAR_TEXTBOX.AnchorPoint = Vector2.new(0, 0)
	Gui.SEARCHBAR_TEXTBOX.AutomaticSize = Enum.AutomaticSize.None
	Gui.SEARCHBAR_TEXTBOX.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SEARCHBAR_TEXTBOX.BackgroundTransparency = 1
	Gui.SEARCHBAR_TEXTBOX.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SEARCHBAR_TEXTBOX.BorderMode = Enum.BorderMode.Outline
	Gui.SEARCHBAR_TEXTBOX.BorderSizePixel = 0
	Gui.SEARCHBAR_TEXTBOX.ClipsDescendants = false
	Gui.SEARCHBAR_TEXTBOX.Draggable = false
	Gui.SEARCHBAR_TEXTBOX.LayoutOrder = 2
	Gui.SEARCHBAR_TEXTBOX.Position = UDim2.new(0, 0, 0, 0)
	Gui.SEARCHBAR_TEXTBOX.Rotation = 0
	Gui.SEARCHBAR_TEXTBOX.Selectable = true
	Gui.SEARCHBAR_TEXTBOX.Size = UDim2.new(1, 0, 1, 0)
	Gui.SEARCHBAR_TEXTBOX.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SEARCHBAR_TEXTBOX.Visible = true
	Gui.SEARCHBAR_TEXTBOX.ZIndex = 1
	Gui.SEARCHBAR_TEXTBOX.Font = Enum.Font.Unknown
	Gui.SEARCHBAR_TEXTBOX.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.SEARCHBAR_TEXTBOX.LineHeight = 1
	Gui.SEARCHBAR_TEXTBOX.MaxVisibleGraphemes = -1
	Gui.SEARCHBAR_TEXTBOX.RichText = false
	Gui.SEARCHBAR_TEXTBOX.Text = ""
	Gui.SEARCHBAR_TEXTBOX.TextColor3 = Color3.fromRGB(190, 190, 200)
	Gui.SEARCHBAR_TEXTBOX.TextDirection = Enum.TextDirection.Auto
	Gui.SEARCHBAR_TEXTBOX.TextScaled = true
	Gui.SEARCHBAR_TEXTBOX.TextSize = 18
	Gui.SEARCHBAR_TEXTBOX.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SEARCHBAR_TEXTBOX.TextStrokeTransparency = 1
	Gui.SEARCHBAR_TEXTBOX.TextTransparency = 0
	Gui.SEARCHBAR_TEXTBOX.TextTruncate = Enum.TextTruncate.None
	Gui.SEARCHBAR_TEXTBOX.TextWrapped = true
	Gui.SEARCHBAR_TEXTBOX.TextXAlignment = Enum.TextXAlignment.Center
	Gui.SEARCHBAR_TEXTBOX.TextYAlignment = Enum.TextYAlignment.Center
	Gui.SEARCHBAR_TEXTBOX.PlaceholderColor3 = Color3.fromRGB(38, 38, 45)
	Gui.SEARCHBAR_TEXTBOX.PlaceholderText = "Dies ist der Platzhalter"
	Gui.SEARCHBAR_TEXTBOX.ClearTextOnFocus = true
	Gui.SEARCHBAR_TEXTBOX.MultiLine = false
	Gui.SEARCHBAR_TEXTBOX.ShowNativeInput = true
	Gui.SEARCHBAR_TEXTBOX.Archivable = true
	Gui.SEARCHBAR_TEXTBOX.Parent = Gui.SEARCHBAR_MAIN_FRAME

	Gui.UITextSizeConstraint_13 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_13.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_13.MaxTextSize = 18
	Gui.UITextSizeConstraint_13.MinTextSize = 1
	Gui.UITextSizeConstraint_13.Archivable = true
	Gui.UITextSizeConstraint_13.Parent = Gui.SEARCHBAR_TEXTBOX

	Gui.UIListLayout_6 = Instance.new("UIListLayout")
	Gui.UIListLayout_6.Name = "UIListLayout"
	Gui.UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_6.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_6.Wraps = false
	Gui.UIListLayout_6.Archivable = true
	Gui.UIListLayout_6.Parent = Gui.KEEPING_FRAME

	Gui.EXECUTE_MAIN_FRAME = Instance.new("Frame")
	Gui.EXECUTE_MAIN_FRAME.Name = "EXECUTE_MAIN_FRAME"
	Gui.EXECUTE_MAIN_FRAME.Active = false
	Gui.EXECUTE_MAIN_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.EXECUTE_MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.EXECUTE_MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.EXECUTE_MAIN_FRAME.BackgroundTransparency = 1
	Gui.EXECUTE_MAIN_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.EXECUTE_MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.EXECUTE_MAIN_FRAME.BorderSizePixel = 0
	Gui.EXECUTE_MAIN_FRAME.ClipsDescendants = false
	Gui.EXECUTE_MAIN_FRAME.Draggable = false
	Gui.EXECUTE_MAIN_FRAME.LayoutOrder = 2
	Gui.EXECUTE_MAIN_FRAME.Position = UDim2.new(0.926, 0, 0, 0)
	Gui.EXECUTE_MAIN_FRAME.Rotation = 0
	Gui.EXECUTE_MAIN_FRAME.Selectable = false
	Gui.EXECUTE_MAIN_FRAME.Size = UDim2.new(0.074, 0, 1.008, 0)
	Gui.EXECUTE_MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.EXECUTE_MAIN_FRAME.Visible = true
	Gui.EXECUTE_MAIN_FRAME.ZIndex = 1
	Gui.EXECUTE_MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.EXECUTE_MAIN_FRAME.Archivable = true
	Gui.EXECUTE_MAIN_FRAME.Parent = Gui.KEEPING_FRAME

	Gui.EXECUTE_FRAME = Instance.new("Frame")
	Gui.EXECUTE_FRAME.Name = "EXECUTE_FRAME"
	Gui.EXECUTE_FRAME.Active = false
	Gui.EXECUTE_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.EXECUTE_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.EXECUTE_FRAME.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.EXECUTE_FRAME.BackgroundTransparency = 0
	Gui.EXECUTE_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.EXECUTE_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.EXECUTE_FRAME.BorderSizePixel = 0
	Gui.EXECUTE_FRAME.ClipsDescendants = false
	Gui.EXECUTE_FRAME.Draggable = false
	Gui.EXECUTE_FRAME.LayoutOrder = 0
	Gui.EXECUTE_FRAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.EXECUTE_FRAME.Rotation = 0
	Gui.EXECUTE_FRAME.Selectable = false
	Gui.EXECUTE_FRAME.Size = UDim2.new(0, 0, 1, 0)
	Gui.EXECUTE_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.EXECUTE_FRAME.Visible = true
	Gui.EXECUTE_FRAME.ZIndex = 1
	Gui.EXECUTE_FRAME.Style = Enum.FrameStyle.Custom
	Gui.EXECUTE_FRAME.Archivable = true
	Gui.EXECUTE_FRAME.Parent = Gui.EXECUTE_MAIN_FRAME

	Gui.UICorner_30 = Instance.new("UICorner")
	Gui.UICorner_30.Name = "UICorner"
	Gui.UICorner_30.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_30.Archivable = true
	Gui.UICorner_30.Parent = Gui.EXECUTE_FRAME

	Gui.TextLabel_4 = Instance.new("TextLabel")
	Gui.TextLabel_4.Name = "TextLabel"
	Gui.TextLabel_4.Active = false
	Gui.TextLabel_4.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_4.AutomaticSize = Enum.AutomaticSize.X
	Gui.TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_4.BackgroundTransparency = 1
	Gui.TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_4.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_4.BorderSizePixel = 0
	Gui.TextLabel_4.ClipsDescendants = false
	Gui.TextLabel_4.Draggable = false
	Gui.TextLabel_4.LayoutOrder = 0
	Gui.TextLabel_4.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel_4.Rotation = 0
	Gui.TextLabel_4.Selectable = false
	Gui.TextLabel_4.Size = UDim2.new(0, 0, 1, 0)
	Gui.TextLabel_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_4.Visible = true
	Gui.TextLabel_4.ZIndex = 1
	Gui.TextLabel_4.Font = Enum.Font.Unknown
	Gui.TextLabel_4.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_4.LineHeight = 1
	Gui.TextLabel_4.MaxVisibleGraphemes = -1
	Gui.TextLabel_4.RichText = false
	Gui.TextLabel_4.Text = " Test "
	Gui.TextLabel_4.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel_4.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_4.TextScaled = false
	Gui.TextLabel_4.TextSize = 24
	Gui.TextLabel_4.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_4.TextStrokeTransparency = 1
	Gui.TextLabel_4.TextTransparency = 0
	Gui.TextLabel_4.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_4.TextWrapped = false
	Gui.TextLabel_4.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel_4.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_4.Archivable = true
	Gui.TextLabel_4.Parent = Gui.EXECUTE_FRAME

	Gui.UITextSizeConstraint_14 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_14.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_14.MaxTextSize = 24
	Gui.UITextSizeConstraint_14.MinTextSize = 1
	Gui.UITextSizeConstraint_14.Archivable = true
	Gui.UITextSizeConstraint_14.Parent = Gui.TextLabel_4

	Gui.EXECUTE_TRIGGER = Instance.new("TextButton")
	Gui.EXECUTE_TRIGGER.Name = "EXECUTE_TRIGGER"
	Gui.EXECUTE_TRIGGER.Active = true
	Gui.EXECUTE_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.EXECUTE_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.EXECUTE_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.EXECUTE_TRIGGER.BackgroundTransparency = 1
	Gui.EXECUTE_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.EXECUTE_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.EXECUTE_TRIGGER.BorderSizePixel = 0
	Gui.EXECUTE_TRIGGER.ClipsDescendants = false
	Gui.EXECUTE_TRIGGER.Draggable = false
	Gui.EXECUTE_TRIGGER.LayoutOrder = 0
	Gui.EXECUTE_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.EXECUTE_TRIGGER.Rotation = 0
	Gui.EXECUTE_TRIGGER.Selectable = true
	Gui.EXECUTE_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.EXECUTE_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.EXECUTE_TRIGGER.Visible = true
	Gui.EXECUTE_TRIGGER.ZIndex = 1
	Gui.EXECUTE_TRIGGER.Font = Enum.Font.Unknown
	Gui.EXECUTE_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.EXECUTE_TRIGGER.LineHeight = 1
	Gui.EXECUTE_TRIGGER.MaxVisibleGraphemes = -1
	Gui.EXECUTE_TRIGGER.RichText = false
	Gui.EXECUTE_TRIGGER.Text = ""
	Gui.EXECUTE_TRIGGER.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.EXECUTE_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.EXECUTE_TRIGGER.TextScaled = true
	Gui.EXECUTE_TRIGGER.TextSize = 14
	Gui.EXECUTE_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.EXECUTE_TRIGGER.TextStrokeTransparency = 1
	Gui.EXECUTE_TRIGGER.TextTransparency = 0
	Gui.EXECUTE_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.EXECUTE_TRIGGER.TextWrapped = true
	Gui.EXECUTE_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.EXECUTE_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.EXECUTE_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.EXECUTE_TRIGGER.AutoButtonColor = true
	Gui.EXECUTE_TRIGGER.Modal = false
	Gui.EXECUTE_TRIGGER.Selected = false
	Gui.EXECUTE_TRIGGER.Archivable = true
	Gui.EXECUTE_TRIGGER.Parent = Gui.EXECUTE_FRAME

	Gui.MAIN_TEXT_TRENNER_EXAMPLE = Instance.new("Frame")
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Name = "MAIN_TEXT_TRENNER_EXAMPLE"
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Active = false
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.BackgroundTransparency = 1
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.BorderSizePixel = 0
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.ClipsDescendants = false
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Draggable = false
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.LayoutOrder = 0
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Position = UDim2.new(0, 0, 0.059, 0)
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Rotation = 0
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Selectable = false
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Size = UDim2.new(1, 0, 0.084, 0)
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Visible = false
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.ZIndex = 3
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Archivable = true
	Gui.MAIN_TEXT_TRENNER_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_31 = Instance.new("UICorner")
	Gui.UICorner_31.Name = "UICorner"
	Gui.UICorner_31.CornerRadius = UDim.new(0.225, 0)
	Gui.UICorner_31.Archivable = true
	Gui.UICorner_31.Parent = Gui.MAIN_TEXT_TRENNER_EXAMPLE

	Gui.FUNCTION_NAME_5 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_5.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_5.Archivable = true
	Gui.FUNCTION_NAME_5.Parent = Gui.MAIN_TEXT_TRENNER_EXAMPLE

	Gui.TEXT_TRENNER = Instance.new("Frame")
	Gui.TEXT_TRENNER.Name = "TEXT_TRENNER"
	Gui.TEXT_TRENNER.Active = false
	Gui.TEXT_TRENNER.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.TEXT_TRENNER.AutomaticSize = Enum.AutomaticSize.None
	Gui.TEXT_TRENNER.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.TEXT_TRENNER.BackgroundTransparency = 0
	Gui.TEXT_TRENNER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TEXT_TRENNER.BorderMode = Enum.BorderMode.Outline
	Gui.TEXT_TRENNER.BorderSizePixel = 0
	Gui.TEXT_TRENNER.ClipsDescendants = false
	Gui.TEXT_TRENNER.Draggable = false
	Gui.TEXT_TRENNER.LayoutOrder = 0
	Gui.TEXT_TRENNER.Position = UDim2.new(0.5, 0, 0.6, 0)
	Gui.TEXT_TRENNER.Rotation = 0
	Gui.TEXT_TRENNER.Selectable = false
	Gui.TEXT_TRENNER.Size = UDim2.new(1, 0, 0.712, 0)
	Gui.TEXT_TRENNER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TEXT_TRENNER.Visible = true
	Gui.TEXT_TRENNER.ZIndex = 3
	Gui.TEXT_TRENNER.Style = Enum.FrameStyle.Custom
	Gui.TEXT_TRENNER.Archivable = true
	Gui.TEXT_TRENNER.Parent = Gui.MAIN_TEXT_TRENNER_EXAMPLE

	Gui.UICorner_32 = Instance.new("UICorner")
	Gui.UICorner_32.Name = "UICorner"
	Gui.UICorner_32.CornerRadius = UDim.new(0.225, 0)
	Gui.UICorner_32.Archivable = true
	Gui.UICorner_32.Parent = Gui.TEXT_TRENNER

	Gui.FUNCTION_NAME_6 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_6.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_6.Archivable = true
	Gui.FUNCTION_NAME_6.Parent = Gui.TEXT_TRENNER

	Gui.TEXT_TRENNER_LABEL = Instance.new("TextLabel")
	Gui.TEXT_TRENNER_LABEL.Name = "TEXT_TRENNER_LABEL"
	Gui.TEXT_TRENNER_LABEL.Active = false
	Gui.TEXT_TRENNER_LABEL.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.TEXT_TRENNER_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.TEXT_TRENNER_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TEXT_TRENNER_LABEL.BackgroundTransparency = 1
	Gui.TEXT_TRENNER_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TEXT_TRENNER_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.TEXT_TRENNER_LABEL.BorderSizePixel = 0
	Gui.TEXT_TRENNER_LABEL.ClipsDescendants = false
	Gui.TEXT_TRENNER_LABEL.Draggable = false
	Gui.TEXT_TRENNER_LABEL.LayoutOrder = 0
	Gui.TEXT_TRENNER_LABEL.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.TEXT_TRENNER_LABEL.Rotation = 0
	Gui.TEXT_TRENNER_LABEL.Selectable = false
	Gui.TEXT_TRENNER_LABEL.Size = UDim2.new(1, 0, 1, 0)
	Gui.TEXT_TRENNER_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TEXT_TRENNER_LABEL.Visible = true
	Gui.TEXT_TRENNER_LABEL.ZIndex = 1
	Gui.TEXT_TRENNER_LABEL.Font = Enum.Font.Unknown
	Gui.TEXT_TRENNER_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TEXT_TRENNER_LABEL.LineHeight = 1
	Gui.TEXT_TRENNER_LABEL.MaxVisibleGraphemes = -1
	Gui.TEXT_TRENNER_LABEL.RichText = true
	Gui.TEXT_TRENNER_LABEL.Text = "─────────────────── VISUALS ───────────────────"
	Gui.TEXT_TRENNER_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TEXT_TRENNER_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.TEXT_TRENNER_LABEL.TextScaled = true
	Gui.TEXT_TRENNER_LABEL.TextSize = 23
	Gui.TEXT_TRENNER_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TEXT_TRENNER_LABEL.TextStrokeTransparency = 1
	Gui.TEXT_TRENNER_LABEL.TextTransparency = 0
	Gui.TEXT_TRENNER_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.TEXT_TRENNER_LABEL.TextWrapped = true
	Gui.TEXT_TRENNER_LABEL.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TEXT_TRENNER_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TEXT_TRENNER_LABEL.Archivable = true
	Gui.TEXT_TRENNER_LABEL.Parent = Gui.TEXT_TRENNER

	Gui.UITextSizeConstraint_15 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_15.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_15.MaxTextSize = 23
	Gui.UITextSizeConstraint_15.MinTextSize = 1
	Gui.UITextSizeConstraint_15.Archivable = true
	Gui.UITextSizeConstraint_15.Parent = Gui.TEXT_TRENNER_LABEL

	Gui.RADAR_EXAMPLES = Instance.new("Folder")
	Gui.RADAR_EXAMPLES.Name = "RADAR_EXAMPLES"
	Gui.RADAR_EXAMPLES.Archivable = true
	Gui.RADAR_EXAMPLES.Parent = Gui.Examples

	Gui.RADAR_EXAMPLE_POINT = Instance.new("ImageLabel")
	Gui.RADAR_EXAMPLE_POINT.Name = "RADAR_EXAMPLE_POINT"
	Gui.RADAR_EXAMPLE_POINT.Active = false
	Gui.RADAR_EXAMPLE_POINT.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.RADAR_EXAMPLE_POINT.AutomaticSize = Enum.AutomaticSize.None
	Gui.RADAR_EXAMPLE_POINT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_EXAMPLE_POINT.BackgroundTransparency = 1
	Gui.RADAR_EXAMPLE_POINT.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RADAR_EXAMPLE_POINT.BorderMode = Enum.BorderMode.Outline
	Gui.RADAR_EXAMPLE_POINT.BorderSizePixel = 0
	Gui.RADAR_EXAMPLE_POINT.ClipsDescendants = false
	Gui.RADAR_EXAMPLE_POINT.Draggable = false
	Gui.RADAR_EXAMPLE_POINT.LayoutOrder = 0
	Gui.RADAR_EXAMPLE_POINT.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.RADAR_EXAMPLE_POINT.Rotation = 0
	Gui.RADAR_EXAMPLE_POINT.Selectable = false
	Gui.RADAR_EXAMPLE_POINT.Size = UDim2.new(0.045, 0, 0.045, 0)
	Gui.RADAR_EXAMPLE_POINT.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RADAR_EXAMPLE_POINT.Visible = false
	Gui.RADAR_EXAMPLE_POINT.ZIndex = 1
	Gui.RADAR_EXAMPLE_POINT.Image = "rbxassetid://81389225118639"
	Gui.RADAR_EXAMPLE_POINT.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_EXAMPLE_POINT.ImageRectOffset = Vector2.new(0, 0)
	Gui.RADAR_EXAMPLE_POINT.ImageRectSize = Vector2.new(0, 0)
	Gui.RADAR_EXAMPLE_POINT.ImageTransparency = 0
	Gui.RADAR_EXAMPLE_POINT.ResampleMode = Enum.ResamplerMode.Default
	Gui.RADAR_EXAMPLE_POINT.ScaleType = Enum.ScaleType.Stretch
	Gui.RADAR_EXAMPLE_POINT.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.RADAR_EXAMPLE_POINT.SliceScale = 1
	Gui.RADAR_EXAMPLE_POINT.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.RADAR_EXAMPLE_POINT.Archivable = true
	Gui.RADAR_EXAMPLE_POINT.Parent = Gui.RADAR_EXAMPLES

	Gui.RADAR_EXAMPLE_ARROW = Instance.new("ImageLabel")
	Gui.RADAR_EXAMPLE_ARROW.Name = "RADAR_EXAMPLE_ARROW"
	Gui.RADAR_EXAMPLE_ARROW.Active = false
	Gui.RADAR_EXAMPLE_ARROW.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.RADAR_EXAMPLE_ARROW.AutomaticSize = Enum.AutomaticSize.None
	Gui.RADAR_EXAMPLE_ARROW.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_EXAMPLE_ARROW.BackgroundTransparency = 1
	Gui.RADAR_EXAMPLE_ARROW.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RADAR_EXAMPLE_ARROW.BorderMode = Enum.BorderMode.Outline
	Gui.RADAR_EXAMPLE_ARROW.BorderSizePixel = 0
	Gui.RADAR_EXAMPLE_ARROW.ClipsDescendants = false
	Gui.RADAR_EXAMPLE_ARROW.Draggable = false
	Gui.RADAR_EXAMPLE_ARROW.LayoutOrder = 0
	Gui.RADAR_EXAMPLE_ARROW.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.RADAR_EXAMPLE_ARROW.Rotation = 0
	Gui.RADAR_EXAMPLE_ARROW.Selectable = false
	Gui.RADAR_EXAMPLE_ARROW.Size = UDim2.new(0.045, 0, 0.045, 0)
	Gui.RADAR_EXAMPLE_ARROW.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RADAR_EXAMPLE_ARROW.Visible = false
	Gui.RADAR_EXAMPLE_ARROW.ZIndex = 1
	Gui.RADAR_EXAMPLE_ARROW.Image = "rbxassetid://117439729894365"
	Gui.RADAR_EXAMPLE_ARROW.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_EXAMPLE_ARROW.ImageRectOffset = Vector2.new(0, 0)
	Gui.RADAR_EXAMPLE_ARROW.ImageRectSize = Vector2.new(0, 0)
	Gui.RADAR_EXAMPLE_ARROW.ImageTransparency = 0
	Gui.RADAR_EXAMPLE_ARROW.ResampleMode = Enum.ResamplerMode.Default
	Gui.RADAR_EXAMPLE_ARROW.ScaleType = Enum.ScaleType.Stretch
	Gui.RADAR_EXAMPLE_ARROW.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.RADAR_EXAMPLE_ARROW.SliceScale = 1
	Gui.RADAR_EXAMPLE_ARROW.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.RADAR_EXAMPLE_ARROW.Archivable = true
	Gui.RADAR_EXAMPLE_ARROW.Parent = Gui.RADAR_EXAMPLES

	Gui.SWITCH_EXAMPLE_TESTING = Instance.new("Frame")
	Gui.SWITCH_EXAMPLE_TESTING.Name = "SWITCH_EXAMPLE_TESTING"
	Gui.SWITCH_EXAMPLE_TESTING.Active = false
	Gui.SWITCH_EXAMPLE_TESTING.AnchorPoint = Vector2.new(0, 0)
	Gui.SWITCH_EXAMPLE_TESTING.AutomaticSize = Enum.AutomaticSize.None
	Gui.SWITCH_EXAMPLE_TESTING.BackgroundColor3 = Color3.fromRGB(42, 40, 8)
	Gui.SWITCH_EXAMPLE_TESTING.BackgroundTransparency = 0
	Gui.SWITCH_EXAMPLE_TESTING.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SWITCH_EXAMPLE_TESTING.BorderMode = Enum.BorderMode.Outline
	Gui.SWITCH_EXAMPLE_TESTING.BorderSizePixel = 0
	Gui.SWITCH_EXAMPLE_TESTING.ClipsDescendants = false
	Gui.SWITCH_EXAMPLE_TESTING.Draggable = false
	Gui.SWITCH_EXAMPLE_TESTING.LayoutOrder = 0
	Gui.SWITCH_EXAMPLE_TESTING.Position = UDim2.new(0, 0, 0, 0)
	Gui.SWITCH_EXAMPLE_TESTING.Rotation = 0
	Gui.SWITCH_EXAMPLE_TESTING.Selectable = false
	Gui.SWITCH_EXAMPLE_TESTING.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.SWITCH_EXAMPLE_TESTING.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SWITCH_EXAMPLE_TESTING.Visible = false
	Gui.SWITCH_EXAMPLE_TESTING.ZIndex = 3
	Gui.SWITCH_EXAMPLE_TESTING.Style = Enum.FrameStyle.Custom
	Gui.SWITCH_EXAMPLE_TESTING.Archivable = true
	Gui.SWITCH_EXAMPLE_TESTING.Parent = Gui.Examples

	Gui.UICorner_33 = Instance.new("UICorner")
	Gui.UICorner_33.Name = "UICorner"
	Gui.UICorner_33.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_33.Archivable = true
	Gui.UICorner_33.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.FUNCTION_NAME_7 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_7.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_7.Archivable = true
	Gui.FUNCTION_NAME_7.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.MainLabel_6 = Instance.new("TextLabel")
	Gui.MainLabel_6.Name = "MainLabel"
	Gui.MainLabel_6.Active = false
	Gui.MainLabel_6.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_6.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_6.BackgroundTransparency = 1
	Gui.MainLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_6.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_6.BorderSizePixel = 0
	Gui.MainLabel_6.ClipsDescendants = false
	Gui.MainLabel_6.Draggable = false
	Gui.MainLabel_6.LayoutOrder = 0
	Gui.MainLabel_6.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_6.Rotation = 0
	Gui.MainLabel_6.Selectable = false
	Gui.MainLabel_6.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_6.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_6.Visible = true
	Gui.MainLabel_6.ZIndex = 1
	Gui.MainLabel_6.Font = Enum.Font.Unknown
	Gui.MainLabel_6.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_6.LineHeight = 1
	Gui.MainLabel_6.MaxVisibleGraphemes = -1
	Gui.MainLabel_6.RichText = false
	Gui.MainLabel_6.Text = "Das ist der Name des Switches"
	Gui.MainLabel_6.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_6.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_6.TextScaled = true
	Gui.MainLabel_6.TextSize = 23
	Gui.MainLabel_6.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_6.TextStrokeTransparency = 1
	Gui.MainLabel_6.TextTransparency = 0
	Gui.MainLabel_6.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_6.TextWrapped = true
	Gui.MainLabel_6.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_6.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_6.Archivable = true
	Gui.MainLabel_6.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.UITextSizeConstraint_16 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_16.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_16.MaxTextSize = 23
	Gui.UITextSizeConstraint_16.MinTextSize = 1
	Gui.UITextSizeConstraint_16.Archivable = true
	Gui.UITextSizeConstraint_16.Parent = Gui.MainLabel_6

	Gui.Description_2 = Instance.new("TextLabel")
	Gui.Description_2.Name = "Description"
	Gui.Description_2.Active = false
	Gui.Description_2.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_2.BackgroundTransparency = 1
	Gui.Description_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_2.BorderMode = Enum.BorderMode.Outline
	Gui.Description_2.BorderSizePixel = 0
	Gui.Description_2.ClipsDescendants = false
	Gui.Description_2.Draggable = false
	Gui.Description_2.LayoutOrder = 0
	Gui.Description_2.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_2.Rotation = 0
	Gui.Description_2.Selectable = false
	Gui.Description_2.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_2.Visible = true
	Gui.Description_2.ZIndex = 1
	Gui.Description_2.Font = Enum.Font.Unknown
	Gui.Description_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_2.LineHeight = 1
	Gui.Description_2.MaxVisibleGraphemes = -1
	Gui.Description_2.RichText = false
	Gui.Description_2.Text = "Das ist die Beschreibung des Switches"
	Gui.Description_2.TextColor3 = Color3.fromRGB(80, 75, 15)
	Gui.Description_2.TextDirection = Enum.TextDirection.Auto
	Gui.Description_2.TextScaled = true
	Gui.Description_2.TextSize = 17
	Gui.Description_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_2.TextStrokeTransparency = 1
	Gui.Description_2.TextTransparency = 0
	Gui.Description_2.TextTruncate = Enum.TextTruncate.None
	Gui.Description_2.TextWrapped = true
	Gui.Description_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_2.Archivable = true
	Gui.Description_2.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.UITextSizeConstraint_17 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_17.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_17.MaxTextSize = 17
	Gui.UITextSizeConstraint_17.MinTextSize = 1
	Gui.UITextSizeConstraint_17.Archivable = true
	Gui.UITextSizeConstraint_17.Parent = Gui.Description_2

	Gui.BUTTON_MAIN_FRAME = Instance.new("Frame")
	Gui.BUTTON_MAIN_FRAME.Name = "BUTTON_MAIN_FRAME"
	Gui.BUTTON_MAIN_FRAME.Active = false
	Gui.BUTTON_MAIN_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_MAIN_FRAME.BackgroundTransparency = 1
	Gui.BUTTON_MAIN_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MAIN_FRAME.BorderSizePixel = 0
	Gui.BUTTON_MAIN_FRAME.ClipsDescendants = false
	Gui.BUTTON_MAIN_FRAME.Draggable = false
	Gui.BUTTON_MAIN_FRAME.LayoutOrder = 0
	Gui.BUTTON_MAIN_FRAME.Position = UDim2.new(0.866, 0, 0, 0)
	Gui.BUTTON_MAIN_FRAME.Rotation = 0
	Gui.BUTTON_MAIN_FRAME.Selectable = false
	Gui.BUTTON_MAIN_FRAME.Size = UDim2.new(0.134, 0, 1, 0)
	Gui.BUTTON_MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MAIN_FRAME.Visible = true
	Gui.BUTTON_MAIN_FRAME.ZIndex = 1
	Gui.BUTTON_MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MAIN_FRAME.Archivable = true
	Gui.BUTTON_MAIN_FRAME.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.BUTTON_FRAME = Instance.new("Frame")
	Gui.BUTTON_FRAME.Name = "BUTTON_FRAME"
	Gui.BUTTON_FRAME.Active = false
	Gui.BUTTON_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_FRAME.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.BUTTON_FRAME.BackgroundTransparency = 0
	Gui.BUTTON_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_FRAME.BorderSizePixel = 0
	Gui.BUTTON_FRAME.ClipsDescendants = false
	Gui.BUTTON_FRAME.Draggable = false
	Gui.BUTTON_FRAME.LayoutOrder = 0
	Gui.BUTTON_FRAME.Position = UDim2.new(0.538, 0, 0.5, 0)
	Gui.BUTTON_FRAME.Rotation = 0
	Gui.BUTTON_FRAME.Selectable = false
	Gui.BUTTON_FRAME.Size = UDim2.new(0.525, 0, 0.6, 0)
	Gui.BUTTON_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_FRAME.Visible = true
	Gui.BUTTON_FRAME.ZIndex = 1
	Gui.BUTTON_FRAME.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_FRAME.Archivable = true
	Gui.BUTTON_FRAME.Parent = Gui.BUTTON_MAIN_FRAME

	Gui.UICorner_34 = Instance.new("UICorner")
	Gui.UICorner_34.Name = "UICorner"
	Gui.UICorner_34.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_34.Archivable = true
	Gui.UICorner_34.Parent = Gui.BUTTON_FRAME

	Gui.BUTTON_TRIGGER = Instance.new("TextButton")
	Gui.BUTTON_TRIGGER.Name = "BUTTON_TRIGGER"
	Gui.BUTTON_TRIGGER.Active = true
	Gui.BUTTON_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_TRIGGER.BackgroundTransparency = 1
	Gui.BUTTON_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_TRIGGER.BorderSizePixel = 0
	Gui.BUTTON_TRIGGER.ClipsDescendants = false
	Gui.BUTTON_TRIGGER.Draggable = false
	Gui.BUTTON_TRIGGER.LayoutOrder = 0
	Gui.BUTTON_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.BUTTON_TRIGGER.Rotation = 0
	Gui.BUTTON_TRIGGER.Selectable = true
	Gui.BUTTON_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.BUTTON_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_TRIGGER.Visible = true
	Gui.BUTTON_TRIGGER.ZIndex = 1
	Gui.BUTTON_TRIGGER.Font = Enum.Font.Unknown
	Gui.BUTTON_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.BUTTON_TRIGGER.LineHeight = 1
	Gui.BUTTON_TRIGGER.MaxVisibleGraphemes = -1
	Gui.BUTTON_TRIGGER.RichText = false
	Gui.BUTTON_TRIGGER.Text = ""
	Gui.BUTTON_TRIGGER.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.BUTTON_TRIGGER.TextScaled = true
	Gui.BUTTON_TRIGGER.TextSize = 14
	Gui.BUTTON_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER.TextStrokeTransparency = 1
	Gui.BUTTON_TRIGGER.TextTransparency = 0
	Gui.BUTTON_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.BUTTON_TRIGGER.TextWrapped = true
	Gui.BUTTON_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.BUTTON_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.BUTTON_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.BUTTON_TRIGGER.AutoButtonColor = true
	Gui.BUTTON_TRIGGER.Modal = false
	Gui.BUTTON_TRIGGER.Selected = false
	Gui.BUTTON_TRIGGER.Archivable = true
	Gui.BUTTON_TRIGGER.Parent = Gui.BUTTON_FRAME

	Gui.LocalScript = Instance.new("LocalScript")
	Gui.LocalScript.Name = "LocalScript"
	Gui.LocalScript.Enabled = true
	Gui.LocalScript.Archivable = true
	Gui.LocalScript.Parent = Gui.BUTTON_TRIGGER

	Gui.BUTTON_MOVING = Instance.new("Frame")
	Gui.BUTTON_MOVING.Name = "BUTTON_MOVING"
	Gui.BUTTON_MOVING.Active = false
	Gui.BUTTON_MOVING.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_MOVING.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MOVING.BackgroundColor3 = Color3.fromRGB(130, 120, 20)
	Gui.BUTTON_MOVING.BackgroundTransparency = 0
	Gui.BUTTON_MOVING.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MOVING.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MOVING.BorderSizePixel = 0
	Gui.BUTTON_MOVING.ClipsDescendants = false
	Gui.BUTTON_MOVING.Draggable = false
	Gui.BUTTON_MOVING.LayoutOrder = 0
	Gui.BUTTON_MOVING.Position = UDim2.new(0.3, 0, 0.5, 0)
	Gui.BUTTON_MOVING.Rotation = 0
	Gui.BUTTON_MOVING.Selectable = false
	Gui.BUTTON_MOVING.Size = UDim2.new(0.47, 0, 0.805, 0)
	Gui.BUTTON_MOVING.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MOVING.Visible = true
	Gui.BUTTON_MOVING.ZIndex = 1
	Gui.BUTTON_MOVING.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MOVING.Archivable = true
	Gui.BUTTON_MOVING.Parent = Gui.BUTTON_FRAME

	Gui.UICorner_35 = Instance.new("UICorner")
	Gui.UICorner_35.Name = "UICorner"
	Gui.UICorner_35.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_35.Archivable = true
	Gui.UICorner_35.Parent = Gui.BUTTON_MOVING

	Gui.SETTINGS_FRAME = Instance.new("CanvasGroup")
	Gui.SETTINGS_FRAME.Name = "SETTINGS_FRAME"
	Gui.SETTINGS_FRAME.Active = false
	Gui.SETTINGS_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.SETTINGS_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_FRAME.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.SETTINGS_FRAME.BackgroundTransparency = 0
	Gui.SETTINGS_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_FRAME.BorderSizePixel = 0
	Gui.SETTINGS_FRAME.ClipsDescendants = true
	Gui.SETTINGS_FRAME.Draggable = false
	Gui.SETTINGS_FRAME.LayoutOrder = 0
	Gui.SETTINGS_FRAME.Position = UDim2.new(0.618, 0, 1.025, 0)
	Gui.SETTINGS_FRAME.Rotation = 0
	Gui.SETTINGS_FRAME.Selectable = false
	Gui.SETTINGS_FRAME.Size = UDim2.new(0.246, 0, 2.092, 0)
	Gui.SETTINGS_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_FRAME.Visible = false
	Gui.SETTINGS_FRAME.ZIndex = 1
	Gui.SETTINGS_FRAME.Archivable = true
	Gui.SETTINGS_FRAME.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.SETTINGS_KEEPINGFRAME = Instance.new("Frame")
	Gui.SETTINGS_KEEPINGFRAME.Name = "SETTINGS_KEEPINGFRAME"
	Gui.SETTINGS_KEEPINGFRAME.Active = false
	Gui.SETTINGS_KEEPINGFRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_KEEPINGFRAME.AutomaticSize = Enum.AutomaticSize.XY
	Gui.SETTINGS_KEEPINGFRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SETTINGS_KEEPINGFRAME.BackgroundTransparency = 1
	Gui.SETTINGS_KEEPINGFRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_KEEPINGFRAME.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_KEEPINGFRAME.BorderSizePixel = 0
	Gui.SETTINGS_KEEPINGFRAME.ClipsDescendants = false
	Gui.SETTINGS_KEEPINGFRAME.Draggable = false
	Gui.SETTINGS_KEEPINGFRAME.LayoutOrder = 0
	Gui.SETTINGS_KEEPINGFRAME.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_KEEPINGFRAME.Rotation = 0
	Gui.SETTINGS_KEEPINGFRAME.Selectable = false
	Gui.SETTINGS_KEEPINGFRAME.Size = UDim2.new(0.881, 0, 0.881, 0)
	Gui.SETTINGS_KEEPINGFRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_KEEPINGFRAME.Visible = true
	Gui.SETTINGS_KEEPINGFRAME.ZIndex = 1
	Gui.SETTINGS_KEEPINGFRAME.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_KEEPINGFRAME.Archivable = true
	Gui.SETTINGS_KEEPINGFRAME.Parent = Gui.SETTINGS_FRAME

	Gui.UIListLayout_7 = Instance.new("UIListLayout")
	Gui.UIListLayout_7.Name = "UIListLayout"
	Gui.UIListLayout_7.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_7.Padding = UDim.new(0.05, 0)
	Gui.UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_7.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_7.Wraps = false
	Gui.UIListLayout_7.Archivable = true
	Gui.UIListLayout_7.Parent = Gui.SETTINGS_KEEPINGFRAME

	Gui.KeybindSetting = Instance.new("Frame")
	Gui.KeybindSetting.Name = "KeybindSetting"
	Gui.KeybindSetting.Active = false
	Gui.KeybindSetting.AnchorPoint = Vector2.new(0, 0)
	Gui.KeybindSetting.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KeybindSetting.BackgroundColor3 = Color3.fromRGB(32, 29, 5)
	Gui.KeybindSetting.BackgroundTransparency = 0
	Gui.KeybindSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KeybindSetting.BorderMode = Enum.BorderMode.Outline
	Gui.KeybindSetting.BorderSizePixel = 0
	Gui.KeybindSetting.ClipsDescendants = false
	Gui.KeybindSetting.Draggable = false
	Gui.KeybindSetting.LayoutOrder = 0
	Gui.KeybindSetting.Position = UDim2.new(0, 0, 0, 0)
	Gui.KeybindSetting.Rotation = 0
	Gui.KeybindSetting.Selectable = false
	Gui.KeybindSetting.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.KeybindSetting.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KeybindSetting.Visible = true
	Gui.KeybindSetting.ZIndex = 1
	Gui.KeybindSetting.Style = Enum.FrameStyle.Custom
	Gui.KeybindSetting.Archivable = true
	Gui.KeybindSetting.Parent = Gui.SETTINGS_KEEPINGFRAME

	Gui.KEYBIND_TRIGGER = Instance.new("TextButton")
	Gui.KEYBIND_TRIGGER.Name = "KEYBIND_TRIGGER"
	Gui.KEYBIND_TRIGGER.Active = true
	Gui.KEYBIND_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TRIGGER.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TRIGGER.BackgroundTransparency = 1
	Gui.KEYBIND_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TRIGGER.BorderSizePixel = 0
	Gui.KEYBIND_TRIGGER.ClipsDescendants = false
	Gui.KEYBIND_TRIGGER.Draggable = false
	Gui.KEYBIND_TRIGGER.LayoutOrder = 0
	Gui.KEYBIND_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TRIGGER.Rotation = 0
	Gui.KEYBIND_TRIGGER.Selectable = true
	Gui.KEYBIND_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TRIGGER.Visible = true
	Gui.KEYBIND_TRIGGER.ZIndex = 600
	Gui.KEYBIND_TRIGGER.Font = Enum.Font.Unknown
	Gui.KEYBIND_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TRIGGER.LineHeight = 1
	Gui.KEYBIND_TRIGGER.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TRIGGER.RichText = false
	Gui.KEYBIND_TRIGGER.Text = ""
	Gui.KEYBIND_TRIGGER.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TRIGGER.TextScaled = false
	Gui.KEYBIND_TRIGGER.TextSize = 25
	Gui.KEYBIND_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER.TextStrokeTransparency = 1
	Gui.KEYBIND_TRIGGER.TextTransparency = 0
	Gui.KEYBIND_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TRIGGER.TextWrapped = true
	Gui.KEYBIND_TRIGGER.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.KEYBIND_TRIGGER.AutoButtonColor = false
	Gui.KEYBIND_TRIGGER.Modal = false
	Gui.KEYBIND_TRIGGER.Selected = false
	Gui.KEYBIND_TRIGGER.Archivable = true
	Gui.KEYBIND_TRIGGER.Parent = Gui.KeybindSetting

	Gui.UICorner_36 = Instance.new("UICorner")
	Gui.UICorner_36.Name = "UICorner"
	Gui.UICorner_36.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_36.Archivable = true
	Gui.UICorner_36.Parent = Gui.KeybindSetting

	Gui.KEYBIND_LABEL = Instance.new("TextLabel")
	Gui.KEYBIND_LABEL.Name = "KEYBIND_LABEL"
	Gui.KEYBIND_LABEL.Active = false
	Gui.KEYBIND_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_LABEL.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_LABEL.BackgroundTransparency = 1
	Gui.KEYBIND_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_LABEL.BorderSizePixel = 0
	Gui.KEYBIND_LABEL.ClipsDescendants = false
	Gui.KEYBIND_LABEL.Draggable = false
	Gui.KEYBIND_LABEL.LayoutOrder = 0
	Gui.KEYBIND_LABEL.Position = UDim2.new(0.044, 0, 0, 0)
	Gui.KEYBIND_LABEL.Rotation = 0
	Gui.KEYBIND_LABEL.Selectable = false
	Gui.KEYBIND_LABEL.Size = UDim2.new(0.956, 0, 1, 0)
	Gui.KEYBIND_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_LABEL.Visible = true
	Gui.KEYBIND_LABEL.ZIndex = 5
	Gui.KEYBIND_LABEL.Font = Enum.Font.Unknown
	Gui.KEYBIND_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_LABEL.LineHeight = 1
	Gui.KEYBIND_LABEL.MaxVisibleGraphemes = -1
	Gui.KEYBIND_LABEL.RichText = false
	Gui.KEYBIND_LABEL.Text = "Keybind: V"
	Gui.KEYBIND_LABEL.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_LABEL.TextScaled = true
	Gui.KEYBIND_LABEL.TextSize = 25
	Gui.KEYBIND_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL.TextStrokeTransparency = 1
	Gui.KEYBIND_LABEL.TextTransparency = 0
	Gui.KEYBIND_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_LABEL.TextWrapped = true
	Gui.KEYBIND_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_LABEL.Archivable = true
	Gui.KEYBIND_LABEL.Parent = Gui.KeybindSetting

	Gui.UITextSizeConstraint_18 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_18.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_18.MaxTextSize = 25
	Gui.UITextSizeConstraint_18.MinTextSize = 1
	Gui.UITextSizeConstraint_18.Archivable = true
	Gui.UITextSizeConstraint_18.Parent = Gui.KEYBIND_LABEL

	Gui.ColorSetting = Instance.new("Frame")
	Gui.ColorSetting.Name = "ColorSetting"
	Gui.ColorSetting.Active = false
	Gui.ColorSetting.AnchorPoint = Vector2.new(0, 0)
	Gui.ColorSetting.AutomaticSize = Enum.AutomaticSize.XY
	Gui.ColorSetting.BackgroundColor3 = Color3.fromRGB(32, 29, 5)
	Gui.ColorSetting.BackgroundTransparency = 0
	Gui.ColorSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ColorSetting.BorderMode = Enum.BorderMode.Outline
	Gui.ColorSetting.BorderSizePixel = 0
	Gui.ColorSetting.ClipsDescendants = false
	Gui.ColorSetting.Draggable = false
	Gui.ColorSetting.LayoutOrder = 0
	Gui.ColorSetting.Position = UDim2.new(0, 0, 0.528, 0)
	Gui.ColorSetting.Rotation = 0
	Gui.ColorSetting.Selectable = false
	Gui.ColorSetting.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.ColorSetting.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ColorSetting.Visible = true
	Gui.ColorSetting.ZIndex = 1
	Gui.ColorSetting.Style = Enum.FrameStyle.Custom
	Gui.ColorSetting.Archivable = true
	Gui.ColorSetting.Parent = Gui.SETTINGS_KEEPINGFRAME

	Gui.UICorner_37 = Instance.new("UICorner")
	Gui.UICorner_37.Name = "UICorner"
	Gui.UICorner_37.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_37.Archivable = true
	Gui.UICorner_37.Parent = Gui.ColorSetting

	Gui.COLORPREVIEW = Instance.new("Frame")
	Gui.COLORPREVIEW.Name = "COLORPREVIEW"
	Gui.COLORPREVIEW.Active = false
	Gui.COLORPREVIEW.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COLORPREVIEW.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLORPREVIEW.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLORPREVIEW.BackgroundTransparency = 0
	Gui.COLORPREVIEW.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLORPREVIEW.BorderMode = Enum.BorderMode.Outline
	Gui.COLORPREVIEW.BorderSizePixel = 0
	Gui.COLORPREVIEW.ClipsDescendants = false
	Gui.COLORPREVIEW.Draggable = false
	Gui.COLORPREVIEW.LayoutOrder = 0
	Gui.COLORPREVIEW.Position = UDim2.new(0.141, 0, 0.5, 0)
	Gui.COLORPREVIEW.Rotation = 0
	Gui.COLORPREVIEW.Selectable = false
	Gui.COLORPREVIEW.Size = UDim2.new(0.198, 0, 0.715, 0)
	Gui.COLORPREVIEW.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLORPREVIEW.Visible = true
	Gui.COLORPREVIEW.ZIndex = 1
	Gui.COLORPREVIEW.Style = Enum.FrameStyle.Custom
	Gui.COLORPREVIEW.Archivable = true
	Gui.COLORPREVIEW.Parent = Gui.ColorSetting

	Gui.UICorner_38 = Instance.new("UICorner")
	Gui.UICorner_38.Name = "UICorner"
	Gui.UICorner_38.CornerRadius = UDim.new(0.25, 0)
	Gui.UICorner_38.Archivable = true
	Gui.UICorner_38.Parent = Gui.COLORPREVIEW

	Gui.HSV_LABEL = Instance.new("TextLabel")
	Gui.HSV_LABEL.Name = "HSV_LABEL"
	Gui.HSV_LABEL.Active = false
	Gui.HSV_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.HSV_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.HSV_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HSV_LABEL.BackgroundTransparency = 1
	Gui.HSV_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.HSV_LABEL.BorderSizePixel = 0
	Gui.HSV_LABEL.ClipsDescendants = false
	Gui.HSV_LABEL.Draggable = false
	Gui.HSV_LABEL.LayoutOrder = 0
	Gui.HSV_LABEL.Position = UDim2.new(0.336, 0, 0, 0)
	Gui.HSV_LABEL.Rotation = 0
	Gui.HSV_LABEL.Selectable = false
	Gui.HSV_LABEL.Size = UDim2.new(0.62, 0, 1, 0)
	Gui.HSV_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HSV_LABEL.Visible = true
	Gui.HSV_LABEL.ZIndex = 1
	Gui.HSV_LABEL.Font = Enum.Font.Unknown
	Gui.HSV_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.HSV_LABEL.LineHeight = 1
	Gui.HSV_LABEL.MaxVisibleGraphemes = -1
	Gui.HSV_LABEL.RichText = false
	Gui.HSV_LABEL.Text = "#FFFFFF"
	Gui.HSV_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HSV_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.HSV_LABEL.TextScaled = false
	Gui.HSV_LABEL.TextSize = 25
	Gui.HSV_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL.TextStrokeTransparency = 1
	Gui.HSV_LABEL.TextTransparency = 0
	Gui.HSV_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.HSV_LABEL.TextWrapped = false
	Gui.HSV_LABEL.TextXAlignment = Enum.TextXAlignment.Left
	Gui.HSV_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.HSV_LABEL.Archivable = true
	Gui.HSV_LABEL.Parent = Gui.ColorSetting

	Gui.COLOR_TRIGGER = Instance.new("TextButton")
	Gui.COLOR_TRIGGER.Name = "COLOR_TRIGGER"
	Gui.COLOR_TRIGGER.Active = true
	Gui.COLOR_TRIGGER.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_TRIGGER.BackgroundTransparency = 1
	Gui.COLOR_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_TRIGGER.BorderSizePixel = 0
	Gui.COLOR_TRIGGER.ClipsDescendants = false
	Gui.COLOR_TRIGGER.Draggable = false
	Gui.COLOR_TRIGGER.LayoutOrder = 0
	Gui.COLOR_TRIGGER.Position = UDim2.new(0, 0, 0, 0)
	Gui.COLOR_TRIGGER.Rotation = 0
	Gui.COLOR_TRIGGER.Selectable = true
	Gui.COLOR_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.COLOR_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_TRIGGER.Visible = true
	Gui.COLOR_TRIGGER.ZIndex = 1
	Gui.COLOR_TRIGGER.Font = Enum.Font.Unknown
	Gui.COLOR_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COLOR_TRIGGER.LineHeight = 1
	Gui.COLOR_TRIGGER.MaxVisibleGraphemes = -1
	Gui.COLOR_TRIGGER.RichText = false
	Gui.COLOR_TRIGGER.Text = ""
	Gui.COLOR_TRIGGER.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.COLOR_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.COLOR_TRIGGER.TextScaled = false
	Gui.COLOR_TRIGGER.TextSize = 25
	Gui.COLOR_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER.TextStrokeTransparency = 1
	Gui.COLOR_TRIGGER.TextTransparency = 0
	Gui.COLOR_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.COLOR_TRIGGER.TextWrapped = true
	Gui.COLOR_TRIGGER.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COLOR_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COLOR_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.COLOR_TRIGGER.AutoButtonColor = false
	Gui.COLOR_TRIGGER.Modal = false
	Gui.COLOR_TRIGGER.Selected = false
	Gui.COLOR_TRIGGER.Archivable = true
	Gui.COLOR_TRIGGER.Parent = Gui.ColorSetting

	Gui.UICorner_39 = Instance.new("UICorner")
	Gui.UICorner_39.Name = "UICorner"
	Gui.UICorner_39.CornerRadius = UDim.new(0.07, 0)
	Gui.UICorner_39.Archivable = true
	Gui.UICorner_39.Parent = Gui.SETTINGS_FRAME

	Gui.ADDITIONS_FRAME = Instance.new("Frame")
	Gui.ADDITIONS_FRAME.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME.Active = false
	Gui.ADDITIONS_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME.ClipsDescendants = false
	Gui.ADDITIONS_FRAME.Draggable = false
	Gui.ADDITIONS_FRAME.LayoutOrder = 0
	Gui.ADDITIONS_FRAME.Position = UDim2.new(0.707, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME.Rotation = 0
	Gui.ADDITIONS_FRAME.Selectable = false
	Gui.ADDITIONS_FRAME.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME.Visible = true
	Gui.ADDITIONS_FRAME.ZIndex = 1
	Gui.ADDITIONS_FRAME.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME.Archivable = true
	Gui.ADDITIONS_FRAME.Parent = Gui.SWITCH_EXAMPLE_TESTING

	Gui.UIListLayout_8 = Instance.new("UIListLayout")
	Gui.UIListLayout_8.Name = "UIListLayout"
	Gui.UIListLayout_8.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_8.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_8.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_8.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_8.Wraps = false
	Gui.UIListLayout_8.Archivable = true
	Gui.UIListLayout_8.Parent = Gui.ADDITIONS_FRAME

	Gui.FAVOURITE_BUTTON_FRAME = Instance.new("Frame")
	Gui.FAVOURITE_BUTTON_FRAME.Name = "FAVOURITE_BUTTON_FRAME"
	Gui.FAVOURITE_BUTTON_FRAME.Active = false
	Gui.FAVOURITE_BUTTON_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON_FRAME.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.FAVOURITE_BUTTON_FRAME.BackgroundTransparency = 0
	Gui.FAVOURITE_BUTTON_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON_FRAME.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON_FRAME.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON_FRAME.Draggable = false
	Gui.FAVOURITE_BUTTON_FRAME.LayoutOrder = 2
	Gui.FAVOURITE_BUTTON_FRAME.Position = UDim2.new(0.073, 0, 0.483, 0)
	Gui.FAVOURITE_BUTTON_FRAME.Rotation = 0
	Gui.FAVOURITE_BUTTON_FRAME.Selectable = false
	Gui.FAVOURITE_BUTTON_FRAME.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.FAVOURITE_BUTTON_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON_FRAME.Visible = true
	Gui.FAVOURITE_BUTTON_FRAME.ZIndex = 1
	Gui.FAVOURITE_BUTTON_FRAME.Style = Enum.FrameStyle.Custom
	Gui.FAVOURITE_BUTTON_FRAME.Archivable = true
	Gui.FAVOURITE_BUTTON_FRAME.Parent = Gui.ADDITIONS_FRAME

	Gui.FAVOURITE_BUTTON = Instance.new("ImageButton")
	Gui.FAVOURITE_BUTTON.Name = "FAVOURITE_BUTTON"
	Gui.FAVOURITE_BUTTON.Active = true
	Gui.FAVOURITE_BUTTON.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.FAVOURITE_BUTTON.BackgroundTransparency = 1
	Gui.FAVOURITE_BUTTON.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON.Draggable = false
	Gui.FAVOURITE_BUTTON.LayoutOrder = 0
	Gui.FAVOURITE_BUTTON.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.FAVOURITE_BUTTON.Rotation = 0
	Gui.FAVOURITE_BUTTON.Selectable = true
	Gui.FAVOURITE_BUTTON.Size = UDim2.new(0.8, 0, 0.8, 0)
	Gui.FAVOURITE_BUTTON.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON.Visible = true
	Gui.FAVOURITE_BUTTON.ZIndex = 1
	Gui.FAVOURITE_BUTTON.Image = "rbxassetid://90912994285683"
	Gui.FAVOURITE_BUTTON.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.FAVOURITE_BUTTON.ImageRectOffset = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON.ImageRectSize = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON.ImageTransparency = 0
	Gui.FAVOURITE_BUTTON.ResampleMode = Enum.ResamplerMode.Default
	Gui.FAVOURITE_BUTTON.ScaleType = Enum.ScaleType.Stretch
	Gui.FAVOURITE_BUTTON.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.FAVOURITE_BUTTON.SliceScale = 1
	Gui.FAVOURITE_BUTTON.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.FAVOURITE_BUTTON.Style = Enum.ButtonStyle.Custom
	Gui.FAVOURITE_BUTTON.AutoButtonColor = true
	Gui.FAVOURITE_BUTTON.Modal = false
	Gui.FAVOURITE_BUTTON.Selected = false
	Gui.FAVOURITE_BUTTON.HoverImage = ""
	Gui.FAVOURITE_BUTTON.PressedImage = ""
	Gui.FAVOURITE_BUTTON.Archivable = true
	Gui.FAVOURITE_BUTTON.Parent = Gui.FAVOURITE_BUTTON_FRAME

	Gui.UICorner_40 = Instance.new("UICorner")
	Gui.UICorner_40.Name = "UICorner"
	Gui.UICorner_40.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_40.Archivable = true
	Gui.UICorner_40.Parent = Gui.FAVOURITE_BUTTON_FRAME

end

local function BuildGui3()
	Gui.SETTINGS_BUTTON_FRAME = Instance.new("Frame")
	Gui.SETTINGS_BUTTON_FRAME.Name = "SETTINGS_BUTTON_FRAME"
	Gui.SETTINGS_BUTTON_FRAME.Active = false
	Gui.SETTINGS_BUTTON_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON_FRAME.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.SETTINGS_BUTTON_FRAME.BackgroundTransparency = 0
	Gui.SETTINGS_BUTTON_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON_FRAME.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON_FRAME.ClipsDescendants = false
	Gui.SETTINGS_BUTTON_FRAME.Draggable = false
	Gui.SETTINGS_BUTTON_FRAME.LayoutOrder = 3
	Gui.SETTINGS_BUTTON_FRAME.Position = UDim2.new(0.227, 0, 0.524, 0)
	Gui.SETTINGS_BUTTON_FRAME.Rotation = 0
	Gui.SETTINGS_BUTTON_FRAME.Selectable = false
	Gui.SETTINGS_BUTTON_FRAME.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.SETTINGS_BUTTON_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON_FRAME.Visible = true
	Gui.SETTINGS_BUTTON_FRAME.ZIndex = 1
	Gui.SETTINGS_BUTTON_FRAME.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_BUTTON_FRAME.Archivable = true
	Gui.SETTINGS_BUTTON_FRAME.Parent = Gui.ADDITIONS_FRAME

	Gui.SETTINGS_BUTTON = Instance.new("ImageButton")
	Gui.SETTINGS_BUTTON.Name = "SETTINGS_BUTTON"
	Gui.SETTINGS_BUTTON.Active = true
	Gui.SETTINGS_BUTTON.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.SETTINGS_BUTTON.BackgroundTransparency = 1
	Gui.SETTINGS_BUTTON.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON.ClipsDescendants = false
	Gui.SETTINGS_BUTTON.Draggable = false
	Gui.SETTINGS_BUTTON.LayoutOrder = 0
	Gui.SETTINGS_BUTTON.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_BUTTON.Rotation = 0
	Gui.SETTINGS_BUTTON.Selectable = true
	Gui.SETTINGS_BUTTON.Size = UDim2.new(0.81, 0, 0.81, 0)
	Gui.SETTINGS_BUTTON.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON.Visible = true
	Gui.SETTINGS_BUTTON.ZIndex = 1
	Gui.SETTINGS_BUTTON.Image = "rbxassetid://87999214752775"
	Gui.SETTINGS_BUTTON.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.SETTINGS_BUTTON.ImageRectOffset = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON.ImageRectSize = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON.ImageTransparency = 0
	Gui.SETTINGS_BUTTON.ResampleMode = Enum.ResamplerMode.Default
	Gui.SETTINGS_BUTTON.ScaleType = Enum.ScaleType.Stretch
	Gui.SETTINGS_BUTTON.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.SETTINGS_BUTTON.SliceScale = 1
	Gui.SETTINGS_BUTTON.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.SETTINGS_BUTTON.Style = Enum.ButtonStyle.Custom
	Gui.SETTINGS_BUTTON.AutoButtonColor = true
	Gui.SETTINGS_BUTTON.Modal = false
	Gui.SETTINGS_BUTTON.Selected = false
	Gui.SETTINGS_BUTTON.HoverImage = ""
	Gui.SETTINGS_BUTTON.PressedImage = ""
	Gui.SETTINGS_BUTTON.Archivable = true
	Gui.SETTINGS_BUTTON.Parent = Gui.SETTINGS_BUTTON_FRAME

	Gui.UICorner_41 = Instance.new("UICorner")
	Gui.UICorner_41.Name = "UICorner"
	Gui.UICorner_41.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_41.Archivable = true
	Gui.UICorner_41.Parent = Gui.SETTINGS_BUTTON_FRAME

	Gui.AUSWAHL_FRAME = Instance.new("Frame")
	Gui.AUSWAHL_FRAME.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME.Active = false
	Gui.AUSWAHL_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.AUSWAHL_FRAME.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME.ClipsDescendants = false
	Gui.AUSWAHL_FRAME.Draggable = false
	Gui.AUSWAHL_FRAME.LayoutOrder = 1
	Gui.AUSWAHL_FRAME.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME.Rotation = 0
	Gui.AUSWAHL_FRAME.Selectable = false
	Gui.AUSWAHL_FRAME.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME.Visible = true
	Gui.AUSWAHL_FRAME.ZIndex = 1
	Gui.AUSWAHL_FRAME.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME.Archivable = true
	Gui.AUSWAHL_FRAME.Parent = Gui.ADDITIONS_FRAME

	Gui.UICorner_42 = Instance.new("UICorner")
	Gui.UICorner_42.Name = "UICorner"
	Gui.UICorner_42.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_42.Archivable = true
	Gui.UICorner_42.Parent = Gui.AUSWAHL_FRAME

	Gui.ZAHL_AUSWAHL_FRAME = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME.Active = false
	Gui.ZAHL_AUSWAHL_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME.Parent = Gui.AUSWAHL_FRAME

	Gui.UITextSizeConstraint_19 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_19.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_19.MaxTextSize = 29
	Gui.UITextSizeConstraint_19.MinTextSize = 1
	Gui.UITextSizeConstraint_19.Archivable = true
	Gui.UITextSizeConstraint_19.Parent = Gui.ZAHL_AUSWAHL_FRAME

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME.Parent = Gui.AUSWAHL_FRAME

	Gui.UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_2.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_2.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_2.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_2.Archivable = true
	Gui.UIAspectRatioConstraint_2.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME.Parent = Gui.AUSWAHL_FRAME

	Gui.UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_3.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_3.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_3.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_3.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_3.Archivable = true
	Gui.UIAspectRatioConstraint_3.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME

	Gui.UIListLayout_9 = Instance.new("UIListLayout")
	Gui.UIListLayout_9.Name = "UIListLayout"
	Gui.UIListLayout_9.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_9.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_9.Padding = UDim.new(0, 0)
	Gui.UIListLayout_9.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_9.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_9.Wraps = false
	Gui.UIListLayout_9.Archivable = true
	Gui.UIListLayout_9.Parent = Gui.AUSWAHL_FRAME

	Gui.SWITCH_EXAMPLE_RISK = Instance.new("Frame")
	Gui.SWITCH_EXAMPLE_RISK.Name = "SWITCH_EXAMPLE_RISK"
	Gui.SWITCH_EXAMPLE_RISK.Active = false
	Gui.SWITCH_EXAMPLE_RISK.AnchorPoint = Vector2.new(0, 0)
	Gui.SWITCH_EXAMPLE_RISK.AutomaticSize = Enum.AutomaticSize.None
	Gui.SWITCH_EXAMPLE_RISK.BackgroundColor3 = Color3.fromRGB(60, 10, 20)
	Gui.SWITCH_EXAMPLE_RISK.BackgroundTransparency = 0
	Gui.SWITCH_EXAMPLE_RISK.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SWITCH_EXAMPLE_RISK.BorderMode = Enum.BorderMode.Outline
	Gui.SWITCH_EXAMPLE_RISK.BorderSizePixel = 0
	Gui.SWITCH_EXAMPLE_RISK.ClipsDescendants = false
	Gui.SWITCH_EXAMPLE_RISK.Draggable = false
	Gui.SWITCH_EXAMPLE_RISK.LayoutOrder = 0
	Gui.SWITCH_EXAMPLE_RISK.Position = UDim2.new(0, 0, 0, 0)
	Gui.SWITCH_EXAMPLE_RISK.Rotation = 0
	Gui.SWITCH_EXAMPLE_RISK.Selectable = false
	Gui.SWITCH_EXAMPLE_RISK.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.SWITCH_EXAMPLE_RISK.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SWITCH_EXAMPLE_RISK.Visible = false
	Gui.SWITCH_EXAMPLE_RISK.ZIndex = 3
	Gui.SWITCH_EXAMPLE_RISK.Style = Enum.FrameStyle.Custom
	Gui.SWITCH_EXAMPLE_RISK.Archivable = true
	Gui.SWITCH_EXAMPLE_RISK.Parent = Gui.Examples

	Gui.UICorner_43 = Instance.new("UICorner")
	Gui.UICorner_43.Name = "UICorner"
	Gui.UICorner_43.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_43.Archivable = true
	Gui.UICorner_43.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.FUNCTION_NAME_8 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_8.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_8.Archivable = true
	Gui.FUNCTION_NAME_8.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.MainLabel_7 = Instance.new("TextLabel")
	Gui.MainLabel_7.Name = "MainLabel"
	Gui.MainLabel_7.Active = false
	Gui.MainLabel_7.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_7.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_7.BackgroundTransparency = 1
	Gui.MainLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_7.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_7.BorderSizePixel = 0
	Gui.MainLabel_7.ClipsDescendants = false
	Gui.MainLabel_7.Draggable = false
	Gui.MainLabel_7.LayoutOrder = 0
	Gui.MainLabel_7.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_7.Rotation = 0
	Gui.MainLabel_7.Selectable = false
	Gui.MainLabel_7.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_7.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_7.Visible = true
	Gui.MainLabel_7.ZIndex = 1
	Gui.MainLabel_7.Font = Enum.Font.Unknown
	Gui.MainLabel_7.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_7.LineHeight = 1
	Gui.MainLabel_7.MaxVisibleGraphemes = -1
	Gui.MainLabel_7.RichText = false
	Gui.MainLabel_7.Text = "Das ist der Name des Switches"
	Gui.MainLabel_7.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_7.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_7.TextScaled = true
	Gui.MainLabel_7.TextSize = 23
	Gui.MainLabel_7.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_7.TextStrokeTransparency = 1
	Gui.MainLabel_7.TextTransparency = 0
	Gui.MainLabel_7.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_7.TextWrapped = true
	Gui.MainLabel_7.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_7.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_7.Archivable = true
	Gui.MainLabel_7.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.UITextSizeConstraint_20 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_20.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_20.MaxTextSize = 23
	Gui.UITextSizeConstraint_20.MinTextSize = 1
	Gui.UITextSizeConstraint_20.Archivable = true
	Gui.UITextSizeConstraint_20.Parent = Gui.MainLabel_7

	Gui.Description_3 = Instance.new("TextLabel")
	Gui.Description_3.Name = "Description"
	Gui.Description_3.Active = false
	Gui.Description_3.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_3.BackgroundTransparency = 1
	Gui.Description_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_3.BorderMode = Enum.BorderMode.Outline
	Gui.Description_3.BorderSizePixel = 0
	Gui.Description_3.ClipsDescendants = false
	Gui.Description_3.Draggable = false
	Gui.Description_3.LayoutOrder = 0
	Gui.Description_3.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_3.Rotation = 0
	Gui.Description_3.Selectable = false
	Gui.Description_3.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_3.Visible = true
	Gui.Description_3.ZIndex = 1
	Gui.Description_3.Font = Enum.Font.Unknown
	Gui.Description_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_3.LineHeight = 1
	Gui.Description_3.MaxVisibleGraphemes = -1
	Gui.Description_3.RichText = false
	Gui.Description_3.Text = "Das ist die Beschreibung des Switches"
	Gui.Description_3.TextColor3 = Color3.fromRGB(32, 10, 20)
	Gui.Description_3.TextDirection = Enum.TextDirection.Auto
	Gui.Description_3.TextScaled = true
	Gui.Description_3.TextSize = 17
	Gui.Description_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_3.TextStrokeTransparency = 1
	Gui.Description_3.TextTransparency = 0
	Gui.Description_3.TextTruncate = Enum.TextTruncate.None
	Gui.Description_3.TextWrapped = true
	Gui.Description_3.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_3.Archivable = true
	Gui.Description_3.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.UITextSizeConstraint_21 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_21.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_21.MaxTextSize = 17
	Gui.UITextSizeConstraint_21.MinTextSize = 1
	Gui.UITextSizeConstraint_21.Archivable = true
	Gui.UITextSizeConstraint_21.Parent = Gui.Description_3

	Gui.SETTINGS_FRAME_1 = Instance.new("CanvasGroup")
	Gui.SETTINGS_FRAME_1.Name = "SETTINGS_FRAME"
	Gui.SETTINGS_FRAME_1.Active = false
	Gui.SETTINGS_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.SETTINGS_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_FRAME_1.BackgroundColor3 = Color3.fromRGB(60, 15, 30)
	Gui.SETTINGS_FRAME_1.BackgroundTransparency = 0
	Gui.SETTINGS_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_FRAME_1.BorderSizePixel = 0
	Gui.SETTINGS_FRAME_1.ClipsDescendants = true
	Gui.SETTINGS_FRAME_1.Draggable = false
	Gui.SETTINGS_FRAME_1.LayoutOrder = 0
	Gui.SETTINGS_FRAME_1.Position = UDim2.new(0.618, 0, 1.025, 0)
	Gui.SETTINGS_FRAME_1.Rotation = 0
	Gui.SETTINGS_FRAME_1.Selectable = false
	Gui.SETTINGS_FRAME_1.Size = UDim2.new(0.246, 0, 2.092, 0)
	Gui.SETTINGS_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_FRAME_1.Visible = false
	Gui.SETTINGS_FRAME_1.ZIndex = 1
	Gui.SETTINGS_FRAME_1.Archivable = true
	Gui.SETTINGS_FRAME_1.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.UICorner_44 = Instance.new("UICorner")
	Gui.UICorner_44.Name = "UICorner"
	Gui.UICorner_44.CornerRadius = UDim.new(0.07, 0)
	Gui.UICorner_44.Archivable = true
	Gui.UICorner_44.Parent = Gui.SETTINGS_FRAME_1

	Gui.SETTINGS_KEEPINGFRAME_1 = Instance.new("Frame")
	Gui.SETTINGS_KEEPINGFRAME_1.Name = "SETTINGS_KEEPINGFRAME"
	Gui.SETTINGS_KEEPINGFRAME_1.Active = false
	Gui.SETTINGS_KEEPINGFRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_KEEPINGFRAME_1.AutomaticSize = Enum.AutomaticSize.XY
	Gui.SETTINGS_KEEPINGFRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SETTINGS_KEEPINGFRAME_1.BackgroundTransparency = 1
	Gui.SETTINGS_KEEPINGFRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_KEEPINGFRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_KEEPINGFRAME_1.BorderSizePixel = 0
	Gui.SETTINGS_KEEPINGFRAME_1.ClipsDescendants = false
	Gui.SETTINGS_KEEPINGFRAME_1.Draggable = false
	Gui.SETTINGS_KEEPINGFRAME_1.LayoutOrder = 0
	Gui.SETTINGS_KEEPINGFRAME_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_KEEPINGFRAME_1.Rotation = 0
	Gui.SETTINGS_KEEPINGFRAME_1.Selectable = false
	Gui.SETTINGS_KEEPINGFRAME_1.Size = UDim2.new(0.881, 0, 0.881, 0)
	Gui.SETTINGS_KEEPINGFRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_KEEPINGFRAME_1.Visible = true
	Gui.SETTINGS_KEEPINGFRAME_1.ZIndex = 1
	Gui.SETTINGS_KEEPINGFRAME_1.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_KEEPINGFRAME_1.Archivable = true
	Gui.SETTINGS_KEEPINGFRAME_1.Parent = Gui.SETTINGS_FRAME_1

	Gui.UIListLayout_10 = Instance.new("UIListLayout")
	Gui.UIListLayout_10.Name = "UIListLayout"
	Gui.UIListLayout_10.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_10.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_10.Padding = UDim.new(0.05, 0)
	Gui.UIListLayout_10.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_10.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_10.Wraps = false
	Gui.UIListLayout_10.Archivable = true
	Gui.UIListLayout_10.Parent = Gui.SETTINGS_KEEPINGFRAME_1

	Gui.KeybindSetting_1 = Instance.new("Frame")
	Gui.KeybindSetting_1.Name = "KeybindSetting"
	Gui.KeybindSetting_1.Active = false
	Gui.KeybindSetting_1.AnchorPoint = Vector2.new(0, 0)
	Gui.KeybindSetting_1.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KeybindSetting_1.BackgroundColor3 = Color3.fromRGB(32, 10, 20)
	Gui.KeybindSetting_1.BackgroundTransparency = 0
	Gui.KeybindSetting_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KeybindSetting_1.BorderMode = Enum.BorderMode.Outline
	Gui.KeybindSetting_1.BorderSizePixel = 0
	Gui.KeybindSetting_1.ClipsDescendants = false
	Gui.KeybindSetting_1.Draggable = false
	Gui.KeybindSetting_1.LayoutOrder = 0
	Gui.KeybindSetting_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.KeybindSetting_1.Rotation = 0
	Gui.KeybindSetting_1.Selectable = false
	Gui.KeybindSetting_1.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.KeybindSetting_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KeybindSetting_1.Visible = true
	Gui.KeybindSetting_1.ZIndex = 1
	Gui.KeybindSetting_1.Style = Enum.FrameStyle.Custom
	Gui.KeybindSetting_1.Archivable = true
	Gui.KeybindSetting_1.Parent = Gui.SETTINGS_KEEPINGFRAME_1

	Gui.KEYBIND_TRIGGER_1 = Instance.new("TextButton")
	Gui.KEYBIND_TRIGGER_1.Name = "KEYBIND_TRIGGER"
	Gui.KEYBIND_TRIGGER_1.Active = true
	Gui.KEYBIND_TRIGGER_1.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TRIGGER_1.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_TRIGGER_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TRIGGER_1.BackgroundTransparency = 1
	Gui.KEYBIND_TRIGGER_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_1.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TRIGGER_1.BorderSizePixel = 0
	Gui.KEYBIND_TRIGGER_1.ClipsDescendants = false
	Gui.KEYBIND_TRIGGER_1.Draggable = false
	Gui.KEYBIND_TRIGGER_1.LayoutOrder = 0
	Gui.KEYBIND_TRIGGER_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TRIGGER_1.Rotation = 0
	Gui.KEYBIND_TRIGGER_1.Selectable = true
	Gui.KEYBIND_TRIGGER_1.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_TRIGGER_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TRIGGER_1.Visible = true
	Gui.KEYBIND_TRIGGER_1.ZIndex = 600
	Gui.KEYBIND_TRIGGER_1.Font = Enum.Font.Unknown
	Gui.KEYBIND_TRIGGER_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TRIGGER_1.LineHeight = 1
	Gui.KEYBIND_TRIGGER_1.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TRIGGER_1.RichText = false
	Gui.KEYBIND_TRIGGER_1.Text = ""
	Gui.KEYBIND_TRIGGER_1.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_TRIGGER_1.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TRIGGER_1.TextScaled = false
	Gui.KEYBIND_TRIGGER_1.TextSize = 25
	Gui.KEYBIND_TRIGGER_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_1.TextStrokeTransparency = 1
	Gui.KEYBIND_TRIGGER_1.TextTransparency = 0
	Gui.KEYBIND_TRIGGER_1.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TRIGGER_1.TextWrapped = true
	Gui.KEYBIND_TRIGGER_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_TRIGGER_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TRIGGER_1.Style = Enum.ButtonStyle.Custom
	Gui.KEYBIND_TRIGGER_1.AutoButtonColor = false
	Gui.KEYBIND_TRIGGER_1.Modal = false
	Gui.KEYBIND_TRIGGER_1.Selected = false
	Gui.KEYBIND_TRIGGER_1.Archivable = true
	Gui.KEYBIND_TRIGGER_1.Parent = Gui.KeybindSetting_1

	Gui.UICorner_45 = Instance.new("UICorner")
	Gui.UICorner_45.Name = "UICorner"
	Gui.UICorner_45.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_45.Archivable = true
	Gui.UICorner_45.Parent = Gui.KeybindSetting_1

	Gui.KEYBIND_LABEL_1 = Instance.new("TextLabel")
	Gui.KEYBIND_LABEL_1.Name = "KEYBIND_LABEL"
	Gui.KEYBIND_LABEL_1.Active = false
	Gui.KEYBIND_LABEL_1.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_LABEL_1.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_LABEL_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_LABEL_1.BackgroundTransparency = 1
	Gui.KEYBIND_LABEL_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_1.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_LABEL_1.BorderSizePixel = 0
	Gui.KEYBIND_LABEL_1.ClipsDescendants = false
	Gui.KEYBIND_LABEL_1.Draggable = false
	Gui.KEYBIND_LABEL_1.LayoutOrder = 0
	Gui.KEYBIND_LABEL_1.Position = UDim2.new(0.044, 0, 0, 0)
	Gui.KEYBIND_LABEL_1.Rotation = 0
	Gui.KEYBIND_LABEL_1.Selectable = false
	Gui.KEYBIND_LABEL_1.Size = UDim2.new(0.956, 0, 1, 0)
	Gui.KEYBIND_LABEL_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_LABEL_1.Visible = true
	Gui.KEYBIND_LABEL_1.ZIndex = 5
	Gui.KEYBIND_LABEL_1.Font = Enum.Font.Unknown
	Gui.KEYBIND_LABEL_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_LABEL_1.LineHeight = 1
	Gui.KEYBIND_LABEL_1.MaxVisibleGraphemes = -1
	Gui.KEYBIND_LABEL_1.RichText = false
	Gui.KEYBIND_LABEL_1.Text = "Keybind: V"
	Gui.KEYBIND_LABEL_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.KEYBIND_LABEL_1.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_LABEL_1.TextScaled = true
	Gui.KEYBIND_LABEL_1.TextSize = 25
	Gui.KEYBIND_LABEL_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_1.TextStrokeTransparency = 1
	Gui.KEYBIND_LABEL_1.TextTransparency = 0
	Gui.KEYBIND_LABEL_1.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_LABEL_1.TextWrapped = true
	Gui.KEYBIND_LABEL_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_LABEL_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_LABEL_1.Archivable = true
	Gui.KEYBIND_LABEL_1.Parent = Gui.KeybindSetting_1

	Gui.UITextSizeConstraint_22 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_22.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_22.MaxTextSize = 25
	Gui.UITextSizeConstraint_22.MinTextSize = 1
	Gui.UITextSizeConstraint_22.Archivable = true
	Gui.UITextSizeConstraint_22.Parent = Gui.KEYBIND_LABEL_1

	Gui.ColorSetting_1 = Instance.new("Frame")
	Gui.ColorSetting_1.Name = "ColorSetting"
	Gui.ColorSetting_1.Active = false
	Gui.ColorSetting_1.AnchorPoint = Vector2.new(0, 0)
	Gui.ColorSetting_1.AutomaticSize = Enum.AutomaticSize.XY
	Gui.ColorSetting_1.BackgroundColor3 = Color3.fromRGB(32, 10, 20)
	Gui.ColorSetting_1.BackgroundTransparency = 0
	Gui.ColorSetting_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ColorSetting_1.BorderMode = Enum.BorderMode.Outline
	Gui.ColorSetting_1.BorderSizePixel = 0
	Gui.ColorSetting_1.ClipsDescendants = false
	Gui.ColorSetting_1.Draggable = false
	Gui.ColorSetting_1.LayoutOrder = 0
	Gui.ColorSetting_1.Position = UDim2.new(0, 0, 0.528, 0)
	Gui.ColorSetting_1.Rotation = 0
	Gui.ColorSetting_1.Selectable = false
	Gui.ColorSetting_1.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.ColorSetting_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ColorSetting_1.Visible = true
	Gui.ColorSetting_1.ZIndex = 1
	Gui.ColorSetting_1.Style = Enum.FrameStyle.Custom
	Gui.ColorSetting_1.Archivable = true
	Gui.ColorSetting_1.Parent = Gui.SETTINGS_KEEPINGFRAME_1

	Gui.UICorner_46 = Instance.new("UICorner")
	Gui.UICorner_46.Name = "UICorner"
	Gui.UICorner_46.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_46.Archivable = true
	Gui.UICorner_46.Parent = Gui.ColorSetting_1

	Gui.COLORPREVIEW_1 = Instance.new("Frame")
	Gui.COLORPREVIEW_1.Name = "COLORPREVIEW"
	Gui.COLORPREVIEW_1.Active = false
	Gui.COLORPREVIEW_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COLORPREVIEW_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLORPREVIEW_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLORPREVIEW_1.BackgroundTransparency = 0
	Gui.COLORPREVIEW_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLORPREVIEW_1.BorderMode = Enum.BorderMode.Outline
	Gui.COLORPREVIEW_1.BorderSizePixel = 0
	Gui.COLORPREVIEW_1.ClipsDescendants = false
	Gui.COLORPREVIEW_1.Draggable = false
	Gui.COLORPREVIEW_1.LayoutOrder = 0
	Gui.COLORPREVIEW_1.Position = UDim2.new(0.141, 0, 0.5, 0)
	Gui.COLORPREVIEW_1.Rotation = 0
	Gui.COLORPREVIEW_1.Selectable = false
	Gui.COLORPREVIEW_1.Size = UDim2.new(0.198, 0, 0.715, 0)
	Gui.COLORPREVIEW_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLORPREVIEW_1.Visible = true
	Gui.COLORPREVIEW_1.ZIndex = 1
	Gui.COLORPREVIEW_1.Style = Enum.FrameStyle.Custom
	Gui.COLORPREVIEW_1.Archivable = true
	Gui.COLORPREVIEW_1.Parent = Gui.ColorSetting_1

	Gui.UICorner_47 = Instance.new("UICorner")
	Gui.UICorner_47.Name = "UICorner"
	Gui.UICorner_47.CornerRadius = UDim.new(0.25, 0)
	Gui.UICorner_47.Archivable = true
	Gui.UICorner_47.Parent = Gui.COLORPREVIEW_1

	Gui.HSV_LABEL_1 = Instance.new("TextLabel")
	Gui.HSV_LABEL_1.Name = "HSV_LABEL"
	Gui.HSV_LABEL_1.Active = false
	Gui.HSV_LABEL_1.AnchorPoint = Vector2.new(0, 0)
	Gui.HSV_LABEL_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.HSV_LABEL_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HSV_LABEL_1.BackgroundTransparency = 1
	Gui.HSV_LABEL_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_1.BorderMode = Enum.BorderMode.Outline
	Gui.HSV_LABEL_1.BorderSizePixel = 0
	Gui.HSV_LABEL_1.ClipsDescendants = false
	Gui.HSV_LABEL_1.Draggable = false
	Gui.HSV_LABEL_1.LayoutOrder = 0
	Gui.HSV_LABEL_1.Position = UDim2.new(0.336, 0, 0, 0)
	Gui.HSV_LABEL_1.Rotation = 0
	Gui.HSV_LABEL_1.Selectable = false
	Gui.HSV_LABEL_1.Size = UDim2.new(0.62, 0, 1, 0)
	Gui.HSV_LABEL_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HSV_LABEL_1.Visible = true
	Gui.HSV_LABEL_1.ZIndex = 1
	Gui.HSV_LABEL_1.Font = Enum.Font.Unknown
	Gui.HSV_LABEL_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.HSV_LABEL_1.LineHeight = 1
	Gui.HSV_LABEL_1.MaxVisibleGraphemes = -1
	Gui.HSV_LABEL_1.RichText = false
	Gui.HSV_LABEL_1.Text = "#FFFFFF"
	Gui.HSV_LABEL_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HSV_LABEL_1.TextDirection = Enum.TextDirection.Auto
	Gui.HSV_LABEL_1.TextScaled = false
	Gui.HSV_LABEL_1.TextSize = 25
	Gui.HSV_LABEL_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_1.TextStrokeTransparency = 1
	Gui.HSV_LABEL_1.TextTransparency = 0
	Gui.HSV_LABEL_1.TextTruncate = Enum.TextTruncate.None
	Gui.HSV_LABEL_1.TextWrapped = false
	Gui.HSV_LABEL_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.HSV_LABEL_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.HSV_LABEL_1.Archivable = true
	Gui.HSV_LABEL_1.Parent = Gui.ColorSetting_1

	Gui.COLOR_TRIGGER_1 = Instance.new("TextButton")
	Gui.COLOR_TRIGGER_1.Name = "COLOR_TRIGGER"
	Gui.COLOR_TRIGGER_1.Active = true
	Gui.COLOR_TRIGGER_1.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_TRIGGER_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_TRIGGER_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_TRIGGER_1.BackgroundTransparency = 1
	Gui.COLOR_TRIGGER_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_1.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_TRIGGER_1.BorderSizePixel = 0
	Gui.COLOR_TRIGGER_1.ClipsDescendants = false
	Gui.COLOR_TRIGGER_1.Draggable = false
	Gui.COLOR_TRIGGER_1.LayoutOrder = 0
	Gui.COLOR_TRIGGER_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.COLOR_TRIGGER_1.Rotation = 0
	Gui.COLOR_TRIGGER_1.Selectable = true
	Gui.COLOR_TRIGGER_1.Size = UDim2.new(1, 0, 1, 0)
	Gui.COLOR_TRIGGER_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_TRIGGER_1.Visible = true
	Gui.COLOR_TRIGGER_1.ZIndex = 1
	Gui.COLOR_TRIGGER_1.Font = Enum.Font.Unknown
	Gui.COLOR_TRIGGER_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COLOR_TRIGGER_1.LineHeight = 1
	Gui.COLOR_TRIGGER_1.MaxVisibleGraphemes = -1
	Gui.COLOR_TRIGGER_1.RichText = false
	Gui.COLOR_TRIGGER_1.Text = ""
	Gui.COLOR_TRIGGER_1.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.COLOR_TRIGGER_1.TextDirection = Enum.TextDirection.Auto
	Gui.COLOR_TRIGGER_1.TextScaled = false
	Gui.COLOR_TRIGGER_1.TextSize = 25
	Gui.COLOR_TRIGGER_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_1.TextStrokeTransparency = 1
	Gui.COLOR_TRIGGER_1.TextTransparency = 0
	Gui.COLOR_TRIGGER_1.TextTruncate = Enum.TextTruncate.None
	Gui.COLOR_TRIGGER_1.TextWrapped = true
	Gui.COLOR_TRIGGER_1.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COLOR_TRIGGER_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COLOR_TRIGGER_1.Style = Enum.ButtonStyle.Custom
	Gui.COLOR_TRIGGER_1.AutoButtonColor = false
	Gui.COLOR_TRIGGER_1.Modal = false
	Gui.COLOR_TRIGGER_1.Selected = false
	Gui.COLOR_TRIGGER_1.Archivable = true
	Gui.COLOR_TRIGGER_1.Parent = Gui.ColorSetting_1

	Gui.BUTTON_MAIN_FRAME_1 = Instance.new("Frame")
	Gui.BUTTON_MAIN_FRAME_1.Name = "BUTTON_MAIN_FRAME"
	Gui.BUTTON_MAIN_FRAME_1.Active = false
	Gui.BUTTON_MAIN_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_MAIN_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MAIN_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_MAIN_FRAME_1.BackgroundTransparency = 1
	Gui.BUTTON_MAIN_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MAIN_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MAIN_FRAME_1.BorderSizePixel = 0
	Gui.BUTTON_MAIN_FRAME_1.ClipsDescendants = false
	Gui.BUTTON_MAIN_FRAME_1.Draggable = false
	Gui.BUTTON_MAIN_FRAME_1.LayoutOrder = 0
	Gui.BUTTON_MAIN_FRAME_1.Position = UDim2.new(0.866, 0, 0, 0)
	Gui.BUTTON_MAIN_FRAME_1.Rotation = 0
	Gui.BUTTON_MAIN_FRAME_1.Selectable = false
	Gui.BUTTON_MAIN_FRAME_1.Size = UDim2.new(0.134, 0, 1, 0)
	Gui.BUTTON_MAIN_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MAIN_FRAME_1.Visible = true
	Gui.BUTTON_MAIN_FRAME_1.ZIndex = 1
	Gui.BUTTON_MAIN_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MAIN_FRAME_1.Archivable = true
	Gui.BUTTON_MAIN_FRAME_1.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.BUTTON_FRAME_1 = Instance.new("Frame")
	Gui.BUTTON_FRAME_1.Name = "BUTTON_FRAME"
	Gui.BUTTON_FRAME_1.Active = false
	Gui.BUTTON_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_FRAME_1.BackgroundColor3 = Color3.fromRGB(20, 6, 15)
	Gui.BUTTON_FRAME_1.BackgroundTransparency = 0
	Gui.BUTTON_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_FRAME_1.BorderSizePixel = 0
	Gui.BUTTON_FRAME_1.ClipsDescendants = false
	Gui.BUTTON_FRAME_1.Draggable = false
	Gui.BUTTON_FRAME_1.LayoutOrder = 0
	Gui.BUTTON_FRAME_1.Position = UDim2.new(0.538, 0, 0.5, 0)
	Gui.BUTTON_FRAME_1.Rotation = 0
	Gui.BUTTON_FRAME_1.Selectable = false
	Gui.BUTTON_FRAME_1.Size = UDim2.new(0.525, 0, 0.6, 0)
	Gui.BUTTON_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_FRAME_1.Visible = true
	Gui.BUTTON_FRAME_1.ZIndex = 1
	Gui.BUTTON_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_FRAME_1.Archivable = true
	Gui.BUTTON_FRAME_1.Parent = Gui.BUTTON_MAIN_FRAME_1

	Gui.UICorner_48 = Instance.new("UICorner")
	Gui.UICorner_48.Name = "UICorner"
	Gui.UICorner_48.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_48.Archivable = true
	Gui.UICorner_48.Parent = Gui.BUTTON_FRAME_1

	Gui.BUTTON_TRIGGER_1 = Instance.new("TextButton")
	Gui.BUTTON_TRIGGER_1.Name = "BUTTON_TRIGGER"
	Gui.BUTTON_TRIGGER_1.Active = true
	Gui.BUTTON_TRIGGER_1.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_TRIGGER_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_TRIGGER_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_TRIGGER_1.BackgroundTransparency = 1
	Gui.BUTTON_TRIGGER_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_1.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_TRIGGER_1.BorderSizePixel = 0
	Gui.BUTTON_TRIGGER_1.ClipsDescendants = false
	Gui.BUTTON_TRIGGER_1.Draggable = false
	Gui.BUTTON_TRIGGER_1.LayoutOrder = 0
	Gui.BUTTON_TRIGGER_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.BUTTON_TRIGGER_1.Rotation = 0
	Gui.BUTTON_TRIGGER_1.Selectable = true
	Gui.BUTTON_TRIGGER_1.Size = UDim2.new(1, 0, 1, 0)
	Gui.BUTTON_TRIGGER_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_TRIGGER_1.Visible = true
	Gui.BUTTON_TRIGGER_1.ZIndex = 1
	Gui.BUTTON_TRIGGER_1.Font = Enum.Font.Unknown
	Gui.BUTTON_TRIGGER_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.BUTTON_TRIGGER_1.LineHeight = 1
	Gui.BUTTON_TRIGGER_1.MaxVisibleGraphemes = -1
	Gui.BUTTON_TRIGGER_1.RichText = false
	Gui.BUTTON_TRIGGER_1.Text = ""
	Gui.BUTTON_TRIGGER_1.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_1.TextDirection = Enum.TextDirection.Auto
	Gui.BUTTON_TRIGGER_1.TextScaled = true
	Gui.BUTTON_TRIGGER_1.TextSize = 14
	Gui.BUTTON_TRIGGER_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_1.TextStrokeTransparency = 1
	Gui.BUTTON_TRIGGER_1.TextTransparency = 0
	Gui.BUTTON_TRIGGER_1.TextTruncate = Enum.TextTruncate.None
	Gui.BUTTON_TRIGGER_1.TextWrapped = true
	Gui.BUTTON_TRIGGER_1.TextXAlignment = Enum.TextXAlignment.Center
	Gui.BUTTON_TRIGGER_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.BUTTON_TRIGGER_1.Style = Enum.ButtonStyle.Custom
	Gui.BUTTON_TRIGGER_1.AutoButtonColor = true
	Gui.BUTTON_TRIGGER_1.Modal = false
	Gui.BUTTON_TRIGGER_1.Selected = false
	Gui.BUTTON_TRIGGER_1.Archivable = true
	Gui.BUTTON_TRIGGER_1.Parent = Gui.BUTTON_FRAME_1

	Gui.LocalScript_1 = Instance.new("LocalScript")
	Gui.LocalScript_1.Name = "LocalScript"
	Gui.LocalScript_1.Enabled = true
	Gui.LocalScript_1.Archivable = true
	Gui.LocalScript_1.Parent = Gui.BUTTON_TRIGGER_1

	Gui.BUTTON_MOVING_1 = Instance.new("Frame")
	Gui.BUTTON_MOVING_1.Name = "BUTTON_MOVING"
	Gui.BUTTON_MOVING_1.Active = false
	Gui.BUTTON_MOVING_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_MOVING_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MOVING_1.BackgroundColor3 = Color3.fromRGB(60, 15, 30)
	Gui.BUTTON_MOVING_1.BackgroundTransparency = 0
	Gui.BUTTON_MOVING_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MOVING_1.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MOVING_1.BorderSizePixel = 0
	Gui.BUTTON_MOVING_1.ClipsDescendants = false
	Gui.BUTTON_MOVING_1.Draggable = false
	Gui.BUTTON_MOVING_1.LayoutOrder = 0
	Gui.BUTTON_MOVING_1.Position = UDim2.new(0.3, 0, 0.5, 0)
	Gui.BUTTON_MOVING_1.Rotation = 0
	Gui.BUTTON_MOVING_1.Selectable = false
	Gui.BUTTON_MOVING_1.Size = UDim2.new(0.47, 0, 0.805, 0)
	Gui.BUTTON_MOVING_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MOVING_1.Visible = true
	Gui.BUTTON_MOVING_1.ZIndex = 1
	Gui.BUTTON_MOVING_1.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MOVING_1.Archivable = true
	Gui.BUTTON_MOVING_1.Parent = Gui.BUTTON_FRAME_1

	Gui.UICorner_49 = Instance.new("UICorner")
	Gui.UICorner_49.Name = "UICorner"
	Gui.UICorner_49.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_49.Archivable = true
	Gui.UICorner_49.Parent = Gui.BUTTON_MOVING_1

	Gui.ADDITIONS_FRAME_1 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_1.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_1.Active = false
	Gui.ADDITIONS_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_1.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_1.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_1.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_1.Draggable = false
	Gui.ADDITIONS_FRAME_1.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_1.Position = UDim2.new(0.707, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_1.Rotation = 0
	Gui.ADDITIONS_FRAME_1.Selectable = false
	Gui.ADDITIONS_FRAME_1.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_1.Visible = true
	Gui.ADDITIONS_FRAME_1.ZIndex = 1
	Gui.ADDITIONS_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_1.Archivable = true
	Gui.ADDITIONS_FRAME_1.Parent = Gui.SWITCH_EXAMPLE_RISK

	Gui.UIListLayout_11 = Instance.new("UIListLayout")
	Gui.UIListLayout_11.Name = "UIListLayout"
	Gui.UIListLayout_11.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_11.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_11.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_11.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_11.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_11.Wraps = false
	Gui.UIListLayout_11.Archivable = true
	Gui.UIListLayout_11.Parent = Gui.ADDITIONS_FRAME_1

	Gui.FAVOURITE_BUTTON_FRAME_1 = Instance.new("Frame")
	Gui.FAVOURITE_BUTTON_FRAME_1.Name = "FAVOURITE_BUTTON_FRAME"
	Gui.FAVOURITE_BUTTON_FRAME_1.Active = false
	Gui.FAVOURITE_BUTTON_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON_FRAME_1.BackgroundColor3 = Color3.fromRGB(20, 6, 15)
	Gui.FAVOURITE_BUTTON_FRAME_1.BackgroundTransparency = 0
	Gui.FAVOURITE_BUTTON_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON_FRAME_1.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON_FRAME_1.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON_FRAME_1.Draggable = false
	Gui.FAVOURITE_BUTTON_FRAME_1.LayoutOrder = 2
	Gui.FAVOURITE_BUTTON_FRAME_1.Position = UDim2.new(0.073, 0, 0.483, 0)
	Gui.FAVOURITE_BUTTON_FRAME_1.Rotation = 0
	Gui.FAVOURITE_BUTTON_FRAME_1.Selectable = false
	Gui.FAVOURITE_BUTTON_FRAME_1.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.FAVOURITE_BUTTON_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON_FRAME_1.Visible = true
	Gui.FAVOURITE_BUTTON_FRAME_1.ZIndex = 1
	Gui.FAVOURITE_BUTTON_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.FAVOURITE_BUTTON_FRAME_1.Archivable = true
	Gui.FAVOURITE_BUTTON_FRAME_1.Parent = Gui.ADDITIONS_FRAME_1

	Gui.FAVOURITE_BUTTON_1 = Instance.new("ImageButton")
	Gui.FAVOURITE_BUTTON_1.Name = "FAVOURITE_BUTTON"
	Gui.FAVOURITE_BUTTON_1.Active = true
	Gui.FAVOURITE_BUTTON_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON_1.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.FAVOURITE_BUTTON_1.BackgroundTransparency = 1
	Gui.FAVOURITE_BUTTON_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON_1.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON_1.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON_1.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON_1.Draggable = false
	Gui.FAVOURITE_BUTTON_1.LayoutOrder = 0
	Gui.FAVOURITE_BUTTON_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.FAVOURITE_BUTTON_1.Rotation = 0
	Gui.FAVOURITE_BUTTON_1.Selectable = true
	Gui.FAVOURITE_BUTTON_1.Size = UDim2.new(0.8, 0, 0.8, 0)
	Gui.FAVOURITE_BUTTON_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON_1.Visible = true
	Gui.FAVOURITE_BUTTON_1.ZIndex = 1
	Gui.FAVOURITE_BUTTON_1.Image = "rbxassetid://90912994285683"
	Gui.FAVOURITE_BUTTON_1.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.FAVOURITE_BUTTON_1.ImageRectOffset = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON_1.ImageRectSize = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON_1.ImageTransparency = 0
	Gui.FAVOURITE_BUTTON_1.ResampleMode = Enum.ResamplerMode.Default
	Gui.FAVOURITE_BUTTON_1.ScaleType = Enum.ScaleType.Stretch
	Gui.FAVOURITE_BUTTON_1.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.FAVOURITE_BUTTON_1.SliceScale = 1
	Gui.FAVOURITE_BUTTON_1.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.FAVOURITE_BUTTON_1.Style = Enum.ButtonStyle.Custom
	Gui.FAVOURITE_BUTTON_1.AutoButtonColor = true
	Gui.FAVOURITE_BUTTON_1.Modal = false
	Gui.FAVOURITE_BUTTON_1.Selected = false
	Gui.FAVOURITE_BUTTON_1.HoverImage = ""
	Gui.FAVOURITE_BUTTON_1.PressedImage = ""
	Gui.FAVOURITE_BUTTON_1.Archivable = true
	Gui.FAVOURITE_BUTTON_1.Parent = Gui.FAVOURITE_BUTTON_FRAME_1

	Gui.UICorner_50 = Instance.new("UICorner")
	Gui.UICorner_50.Name = "UICorner"
	Gui.UICorner_50.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_50.Archivable = true
	Gui.UICorner_50.Parent = Gui.FAVOURITE_BUTTON_FRAME_1

	Gui.SETTINGS_BUTTON_FRAME_1 = Instance.new("Frame")
	Gui.SETTINGS_BUTTON_FRAME_1.Name = "SETTINGS_BUTTON_FRAME"
	Gui.SETTINGS_BUTTON_FRAME_1.Active = false
	Gui.SETTINGS_BUTTON_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON_FRAME_1.BackgroundColor3 = Color3.fromRGB(20, 6, 15)
	Gui.SETTINGS_BUTTON_FRAME_1.BackgroundTransparency = 0
	Gui.SETTINGS_BUTTON_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON_FRAME_1.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON_FRAME_1.ClipsDescendants = false
	Gui.SETTINGS_BUTTON_FRAME_1.Draggable = false
	Gui.SETTINGS_BUTTON_FRAME_1.LayoutOrder = 3
	Gui.SETTINGS_BUTTON_FRAME_1.Position = UDim2.new(0.227, 0, 0.524, 0)
	Gui.SETTINGS_BUTTON_FRAME_1.Rotation = 0
	Gui.SETTINGS_BUTTON_FRAME_1.Selectable = false
	Gui.SETTINGS_BUTTON_FRAME_1.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.SETTINGS_BUTTON_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON_FRAME_1.Visible = true
	Gui.SETTINGS_BUTTON_FRAME_1.ZIndex = 1
	Gui.SETTINGS_BUTTON_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_BUTTON_FRAME_1.Archivable = true
	Gui.SETTINGS_BUTTON_FRAME_1.Parent = Gui.ADDITIONS_FRAME_1

	Gui.SETTINGS_BUTTON_1 = Instance.new("ImageButton")
	Gui.SETTINGS_BUTTON_1.Name = "SETTINGS_BUTTON"
	Gui.SETTINGS_BUTTON_1.Active = true
	Gui.SETTINGS_BUTTON_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON_1.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.SETTINGS_BUTTON_1.BackgroundTransparency = 1
	Gui.SETTINGS_BUTTON_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON_1.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON_1.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON_1.ClipsDescendants = false
	Gui.SETTINGS_BUTTON_1.Draggable = false
	Gui.SETTINGS_BUTTON_1.LayoutOrder = 0
	Gui.SETTINGS_BUTTON_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_BUTTON_1.Rotation = 0
	Gui.SETTINGS_BUTTON_1.Selectable = true
	Gui.SETTINGS_BUTTON_1.Size = UDim2.new(0.81, 0, 0.81, 0)
	Gui.SETTINGS_BUTTON_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON_1.Visible = true
	Gui.SETTINGS_BUTTON_1.ZIndex = 1
	Gui.SETTINGS_BUTTON_1.Image = "rbxassetid://87999214752775"
	Gui.SETTINGS_BUTTON_1.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.SETTINGS_BUTTON_1.ImageRectOffset = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON_1.ImageRectSize = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON_1.ImageTransparency = 0
	Gui.SETTINGS_BUTTON_1.ResampleMode = Enum.ResamplerMode.Default
	Gui.SETTINGS_BUTTON_1.ScaleType = Enum.ScaleType.Stretch
	Gui.SETTINGS_BUTTON_1.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.SETTINGS_BUTTON_1.SliceScale = 1
	Gui.SETTINGS_BUTTON_1.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.SETTINGS_BUTTON_1.Style = Enum.ButtonStyle.Custom
	Gui.SETTINGS_BUTTON_1.AutoButtonColor = true
	Gui.SETTINGS_BUTTON_1.Modal = false
	Gui.SETTINGS_BUTTON_1.Selected = false
	Gui.SETTINGS_BUTTON_1.HoverImage = ""
	Gui.SETTINGS_BUTTON_1.PressedImage = ""
	Gui.SETTINGS_BUTTON_1.Archivable = true
	Gui.SETTINGS_BUTTON_1.Parent = Gui.SETTINGS_BUTTON_FRAME_1

	Gui.UICorner_51 = Instance.new("UICorner")
	Gui.UICorner_51.Name = "UICorner"
	Gui.UICorner_51.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_51.Archivable = true
	Gui.UICorner_51.Parent = Gui.SETTINGS_BUTTON_FRAME_1

	Gui.AUSWAHL_FRAME_1 = Instance.new("Frame")
	Gui.AUSWAHL_FRAME_1.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME_1.Active = false
	Gui.AUSWAHL_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME_1.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME_1.BackgroundColor3 = Color3.fromRGB(20, 6, 15)
	Gui.AUSWAHL_FRAME_1.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME_1.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME_1.ClipsDescendants = false
	Gui.AUSWAHL_FRAME_1.Draggable = false
	Gui.AUSWAHL_FRAME_1.LayoutOrder = 1
	Gui.AUSWAHL_FRAME_1.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME_1.Rotation = 0
	Gui.AUSWAHL_FRAME_1.Selectable = false
	Gui.AUSWAHL_FRAME_1.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME_1.Visible = true
	Gui.AUSWAHL_FRAME_1.ZIndex = 1
	Gui.AUSWAHL_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME_1.Archivable = true
	Gui.AUSWAHL_FRAME_1.Parent = Gui.ADDITIONS_FRAME_1

	Gui.UICorner_52 = Instance.new("UICorner")
	Gui.UICorner_52.Name = "UICorner"
	Gui.UICorner_52.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_52.Archivable = true
	Gui.UICorner_52.Parent = Gui.AUSWAHL_FRAME_1

	Gui.ZAHL_AUSWAHL_FRAME_1 = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME_1.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME_1.Active = false
	Gui.ZAHL_AUSWAHL_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME_1.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME_1.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME_1.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME_1.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME_1.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME_1.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME_1.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME_1.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME_1.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME_1.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME_1.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME_1.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME_1.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME_1.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME_1.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME_1.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME_1.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME_1.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME_1.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME_1.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_1.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_1.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME_1.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME_1.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME_1.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME_1.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME_1.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME_1.Parent = Gui.AUSWAHL_FRAME_1

	Gui.UITextSizeConstraint_23 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_23.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_23.MaxTextSize = 29
	Gui.UITextSizeConstraint_23.MinTextSize = 1
	Gui.UITextSizeConstraint_23.Archivable = true
	Gui.UITextSizeConstraint_23.Parent = Gui.ZAHL_AUSWAHL_FRAME_1

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1 = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1.Parent = Gui.AUSWAHL_FRAME_1

	Gui.UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_4.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_4.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_4.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_4.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_4.Archivable = true
	Gui.UIAspectRatioConstraint_4.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME_1

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1 = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1.Parent = Gui.AUSWAHL_FRAME_1

	Gui.UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_5.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_5.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_5.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_5.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_5.Archivable = true
	Gui.UIAspectRatioConstraint_5.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_1

	Gui.UIListLayout_12 = Instance.new("UIListLayout")
	Gui.UIListLayout_12.Name = "UIListLayout"
	Gui.UIListLayout_12.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_12.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_12.Padding = UDim.new(0, 0)
	Gui.UIListLayout_12.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_12.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_12.Wraps = false
	Gui.UIListLayout_12.Archivable = true
	Gui.UIListLayout_12.Parent = Gui.AUSWAHL_FRAME_1

	Gui.SWITCH_EXAMPLE = Instance.new("Frame")
	Gui.SWITCH_EXAMPLE.Name = "SWITCH_EXAMPLE"
	Gui.SWITCH_EXAMPLE.Active = false
	Gui.SWITCH_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.SWITCH_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.SWITCH_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.SWITCH_EXAMPLE.BackgroundTransparency = 0
	Gui.SWITCH_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SWITCH_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.SWITCH_EXAMPLE.BorderSizePixel = 0
	Gui.SWITCH_EXAMPLE.ClipsDescendants = false
	Gui.SWITCH_EXAMPLE.Draggable = false
	Gui.SWITCH_EXAMPLE.LayoutOrder = 0
	Gui.SWITCH_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.SWITCH_EXAMPLE.Rotation = 0
	Gui.SWITCH_EXAMPLE.Selectable = false
	Gui.SWITCH_EXAMPLE.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.SWITCH_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SWITCH_EXAMPLE.Visible = false
	Gui.SWITCH_EXAMPLE.ZIndex = 3
	Gui.SWITCH_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.SWITCH_EXAMPLE.Archivable = true
	Gui.SWITCH_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_53 = Instance.new("UICorner")
	Gui.UICorner_53.Name = "UICorner"
	Gui.UICorner_53.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_53.Archivable = true
	Gui.UICorner_53.Parent = Gui.SWITCH_EXAMPLE

	Gui.FUNCTION_NAME_9 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_9.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_9.Archivable = true
	Gui.FUNCTION_NAME_9.Parent = Gui.SWITCH_EXAMPLE

	Gui.MainLabel_8 = Instance.new("TextLabel")
	Gui.MainLabel_8.Name = "MainLabel"
	Gui.MainLabel_8.Active = false
	Gui.MainLabel_8.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_8.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_8.BackgroundTransparency = 1
	Gui.MainLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_8.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_8.BorderSizePixel = 0
	Gui.MainLabel_8.ClipsDescendants = false
	Gui.MainLabel_8.Draggable = false
	Gui.MainLabel_8.LayoutOrder = 0
	Gui.MainLabel_8.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_8.Rotation = 0
	Gui.MainLabel_8.Selectable = false
	Gui.MainLabel_8.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_8.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_8.Visible = true
	Gui.MainLabel_8.ZIndex = 1
	Gui.MainLabel_8.Font = Enum.Font.Unknown
	Gui.MainLabel_8.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_8.LineHeight = 1
	Gui.MainLabel_8.MaxVisibleGraphemes = -1
	Gui.MainLabel_8.RichText = false
	Gui.MainLabel_8.Text = "Das ist der Name des Switches"
	Gui.MainLabel_8.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_8.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_8.TextScaled = true
	Gui.MainLabel_8.TextSize = 23
	Gui.MainLabel_8.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_8.TextStrokeTransparency = 1
	Gui.MainLabel_8.TextTransparency = 0
	Gui.MainLabel_8.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_8.TextWrapped = true
	Gui.MainLabel_8.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_8.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_8.Archivable = true
	Gui.MainLabel_8.Parent = Gui.SWITCH_EXAMPLE

	Gui.UITextSizeConstraint_24 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_24.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_24.MaxTextSize = 23
	Gui.UITextSizeConstraint_24.MinTextSize = 1
	Gui.UITextSizeConstraint_24.Archivable = true
	Gui.UITextSizeConstraint_24.Parent = Gui.MainLabel_8

	Gui.Description_4 = Instance.new("TextLabel")
	Gui.Description_4.Name = "Description"
	Gui.Description_4.Active = false
	Gui.Description_4.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_4.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_4.BackgroundTransparency = 1
	Gui.Description_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_4.BorderMode = Enum.BorderMode.Outline
	Gui.Description_4.BorderSizePixel = 0
	Gui.Description_4.ClipsDescendants = false
	Gui.Description_4.Draggable = false
	Gui.Description_4.LayoutOrder = 0
	Gui.Description_4.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_4.Rotation = 0
	Gui.Description_4.Selectable = false
	Gui.Description_4.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_4.Visible = true
	Gui.Description_4.ZIndex = 1
	Gui.Description_4.Font = Enum.Font.Unknown
	Gui.Description_4.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_4.LineHeight = 1
	Gui.Description_4.MaxVisibleGraphemes = -1
	Gui.Description_4.RichText = false
	Gui.Description_4.Text = "Das ist die Beschreibung des Switches"
	Gui.Description_4.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description_4.TextDirection = Enum.TextDirection.Auto
	Gui.Description_4.TextScaled = true
	Gui.Description_4.TextSize = 17
	Gui.Description_4.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_4.TextStrokeTransparency = 1
	Gui.Description_4.TextTransparency = 0
	Gui.Description_4.TextTruncate = Enum.TextTruncate.None
	Gui.Description_4.TextWrapped = true
	Gui.Description_4.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_4.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_4.Archivable = true
	Gui.Description_4.Parent = Gui.SWITCH_EXAMPLE

	Gui.UITextSizeConstraint_25 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_25.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_25.MaxTextSize = 17
	Gui.UITextSizeConstraint_25.MinTextSize = 1
	Gui.UITextSizeConstraint_25.Archivable = true
	Gui.UITextSizeConstraint_25.Parent = Gui.Description_4

	Gui.BUTTON_MAIN_FRAME_2 = Instance.new("Frame")
	Gui.BUTTON_MAIN_FRAME_2.Name = "BUTTON_MAIN_FRAME"
	Gui.BUTTON_MAIN_FRAME_2.Active = false
	Gui.BUTTON_MAIN_FRAME_2.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_MAIN_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MAIN_FRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_MAIN_FRAME_2.BackgroundTransparency = 1
	Gui.BUTTON_MAIN_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MAIN_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MAIN_FRAME_2.BorderSizePixel = 0
	Gui.BUTTON_MAIN_FRAME_2.ClipsDescendants = false
	Gui.BUTTON_MAIN_FRAME_2.Draggable = false
	Gui.BUTTON_MAIN_FRAME_2.LayoutOrder = 0
	Gui.BUTTON_MAIN_FRAME_2.Position = UDim2.new(0.866, 0, 0, 0)
	Gui.BUTTON_MAIN_FRAME_2.Rotation = 0
	Gui.BUTTON_MAIN_FRAME_2.Selectable = false
	Gui.BUTTON_MAIN_FRAME_2.Size = UDim2.new(0.134, 0, 1, 0)
	Gui.BUTTON_MAIN_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MAIN_FRAME_2.Visible = true
	Gui.BUTTON_MAIN_FRAME_2.ZIndex = 1
	Gui.BUTTON_MAIN_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MAIN_FRAME_2.Archivable = true
	Gui.BUTTON_MAIN_FRAME_2.Parent = Gui.SWITCH_EXAMPLE

	Gui.BUTTON_FRAME_2 = Instance.new("Frame")
	Gui.BUTTON_FRAME_2.Name = "BUTTON_FRAME"
	Gui.BUTTON_FRAME_2.Active = false
	Gui.BUTTON_FRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_FRAME_2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.BUTTON_FRAME_2.BackgroundTransparency = 0
	Gui.BUTTON_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_FRAME_2.BorderSizePixel = 0
	Gui.BUTTON_FRAME_2.ClipsDescendants = false
	Gui.BUTTON_FRAME_2.Draggable = false
	Gui.BUTTON_FRAME_2.LayoutOrder = 0
	Gui.BUTTON_FRAME_2.Position = UDim2.new(0.538, 0, 0.5, 0)
	Gui.BUTTON_FRAME_2.Rotation = 0
	Gui.BUTTON_FRAME_2.Selectable = false
	Gui.BUTTON_FRAME_2.Size = UDim2.new(0.525, 0, 0.6, 0)
	Gui.BUTTON_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_FRAME_2.Visible = true
	Gui.BUTTON_FRAME_2.ZIndex = 1
	Gui.BUTTON_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_FRAME_2.Archivable = true
	Gui.BUTTON_FRAME_2.Parent = Gui.BUTTON_MAIN_FRAME_2

	Gui.UICorner_54 = Instance.new("UICorner")
	Gui.UICorner_54.Name = "UICorner"
	Gui.UICorner_54.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_54.Archivable = true
	Gui.UICorner_54.Parent = Gui.BUTTON_FRAME_2

	Gui.BUTTON_TRIGGER_2 = Instance.new("TextButton")
	Gui.BUTTON_TRIGGER_2.Name = "BUTTON_TRIGGER"
	Gui.BUTTON_TRIGGER_2.Active = true
	Gui.BUTTON_TRIGGER_2.AnchorPoint = Vector2.new(0, 0)
	Gui.BUTTON_TRIGGER_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_TRIGGER_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.BUTTON_TRIGGER_2.BackgroundTransparency = 1
	Gui.BUTTON_TRIGGER_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_2.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_TRIGGER_2.BorderSizePixel = 0
	Gui.BUTTON_TRIGGER_2.ClipsDescendants = false
	Gui.BUTTON_TRIGGER_2.Draggable = false
	Gui.BUTTON_TRIGGER_2.LayoutOrder = 0
	Gui.BUTTON_TRIGGER_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.BUTTON_TRIGGER_2.Rotation = 0
	Gui.BUTTON_TRIGGER_2.Selectable = true
	Gui.BUTTON_TRIGGER_2.Size = UDim2.new(1, 0, 1, 0)
	Gui.BUTTON_TRIGGER_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_TRIGGER_2.Visible = true
	Gui.BUTTON_TRIGGER_2.ZIndex = 1
	Gui.BUTTON_TRIGGER_2.Font = Enum.Font.Unknown
	Gui.BUTTON_TRIGGER_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.BUTTON_TRIGGER_2.LineHeight = 1
	Gui.BUTTON_TRIGGER_2.MaxVisibleGraphemes = -1
	Gui.BUTTON_TRIGGER_2.RichText = false
	Gui.BUTTON_TRIGGER_2.Text = ""
	Gui.BUTTON_TRIGGER_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_2.TextDirection = Enum.TextDirection.Auto
	Gui.BUTTON_TRIGGER_2.TextScaled = true
	Gui.BUTTON_TRIGGER_2.TextSize = 14
	Gui.BUTTON_TRIGGER_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_TRIGGER_2.TextStrokeTransparency = 1
	Gui.BUTTON_TRIGGER_2.TextTransparency = 0
	Gui.BUTTON_TRIGGER_2.TextTruncate = Enum.TextTruncate.None
	Gui.BUTTON_TRIGGER_2.TextWrapped = true
	Gui.BUTTON_TRIGGER_2.TextXAlignment = Enum.TextXAlignment.Center
	Gui.BUTTON_TRIGGER_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.BUTTON_TRIGGER_2.Style = Enum.ButtonStyle.Custom
	Gui.BUTTON_TRIGGER_2.AutoButtonColor = true
	Gui.BUTTON_TRIGGER_2.Modal = false
	Gui.BUTTON_TRIGGER_2.Selected = false
	Gui.BUTTON_TRIGGER_2.Archivable = true
	Gui.BUTTON_TRIGGER_2.Parent = Gui.BUTTON_FRAME_2

	Gui.LocalScript_2 = Instance.new("LocalScript")
	Gui.LocalScript_2.Name = "LocalScript"
	Gui.LocalScript_2.Enabled = true
	Gui.LocalScript_2.Archivable = true
	Gui.LocalScript_2.Parent = Gui.BUTTON_TRIGGER_2

	Gui.BUTTON_MOVING_2 = Instance.new("Frame")
	Gui.BUTTON_MOVING_2.Name = "BUTTON_MOVING"
	Gui.BUTTON_MOVING_2.Active = false
	Gui.BUTTON_MOVING_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.BUTTON_MOVING_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.BUTTON_MOVING_2.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	Gui.BUTTON_MOVING_2.BackgroundTransparency = 0
	Gui.BUTTON_MOVING_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.BUTTON_MOVING_2.BorderMode = Enum.BorderMode.Outline
	Gui.BUTTON_MOVING_2.BorderSizePixel = 0
	Gui.BUTTON_MOVING_2.ClipsDescendants = false
	Gui.BUTTON_MOVING_2.Draggable = false
	Gui.BUTTON_MOVING_2.LayoutOrder = 0
	Gui.BUTTON_MOVING_2.Position = UDim2.new(0.3, 0, 0.5, 0)
	Gui.BUTTON_MOVING_2.Rotation = 0
	Gui.BUTTON_MOVING_2.Selectable = false
	Gui.BUTTON_MOVING_2.Size = UDim2.new(0.47, 0, 0.805, 0)
	Gui.BUTTON_MOVING_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.BUTTON_MOVING_2.Visible = true
	Gui.BUTTON_MOVING_2.ZIndex = 1
	Gui.BUTTON_MOVING_2.Style = Enum.FrameStyle.Custom
	Gui.BUTTON_MOVING_2.Archivable = true
	Gui.BUTTON_MOVING_2.Parent = Gui.BUTTON_FRAME_2

	Gui.UICorner_55 = Instance.new("UICorner")
	Gui.UICorner_55.Name = "UICorner"
	Gui.UICorner_55.CornerRadius = UDim.new(1, 0)
	Gui.UICorner_55.Archivable = true
	Gui.UICorner_55.Parent = Gui.BUTTON_MOVING_2

	Gui.SETTINGS_FRAME_2 = Instance.new("CanvasGroup")
	Gui.SETTINGS_FRAME_2.Name = "SETTINGS_FRAME"
	Gui.SETTINGS_FRAME_2.Active = false
	Gui.SETTINGS_FRAME_2.AnchorPoint = Vector2.new(0, 0)
	Gui.SETTINGS_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_FRAME_2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.SETTINGS_FRAME_2.BackgroundTransparency = 0
	Gui.SETTINGS_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_FRAME_2.BorderSizePixel = 0
	Gui.SETTINGS_FRAME_2.ClipsDescendants = true
	Gui.SETTINGS_FRAME_2.Draggable = false
	Gui.SETTINGS_FRAME_2.LayoutOrder = 0
	Gui.SETTINGS_FRAME_2.Position = UDim2.new(0.642, 0, 1.025, 0)
	Gui.SETTINGS_FRAME_2.Rotation = 0
	Gui.SETTINGS_FRAME_2.Selectable = false
	Gui.SETTINGS_FRAME_2.Size = UDim2.new(0.237, 0, 0, 0)
	Gui.SETTINGS_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_FRAME_2.Visible = true
	Gui.SETTINGS_FRAME_2.ZIndex = 1
	Gui.SETTINGS_FRAME_2.Archivable = true
	Gui.SETTINGS_FRAME_2.Parent = Gui.SWITCH_EXAMPLE

	Gui.SETTINGS_KEEPINGFRAME_2 = Instance.new("Frame")
	Gui.SETTINGS_KEEPINGFRAME_2.Name = "SETTINGS_KEEPINGFRAME"
	Gui.SETTINGS_KEEPINGFRAME_2.Active = false
	Gui.SETTINGS_KEEPINGFRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_KEEPINGFRAME_2.AutomaticSize = Enum.AutomaticSize.XY
	Gui.SETTINGS_KEEPINGFRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SETTINGS_KEEPINGFRAME_2.BackgroundTransparency = 1
	Gui.SETTINGS_KEEPINGFRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_KEEPINGFRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_KEEPINGFRAME_2.BorderSizePixel = 0
	Gui.SETTINGS_KEEPINGFRAME_2.ClipsDescendants = false
	Gui.SETTINGS_KEEPINGFRAME_2.Draggable = false
	Gui.SETTINGS_KEEPINGFRAME_2.LayoutOrder = 0
	Gui.SETTINGS_KEEPINGFRAME_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_KEEPINGFRAME_2.Rotation = 0
	Gui.SETTINGS_KEEPINGFRAME_2.Selectable = false
	Gui.SETTINGS_KEEPINGFRAME_2.Size = UDim2.new(0.881, 0, 0.881, 0)
	Gui.SETTINGS_KEEPINGFRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_KEEPINGFRAME_2.Visible = true
	Gui.SETTINGS_KEEPINGFRAME_2.ZIndex = 1
	Gui.SETTINGS_KEEPINGFRAME_2.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_KEEPINGFRAME_2.Archivable = true
	Gui.SETTINGS_KEEPINGFRAME_2.Parent = Gui.SETTINGS_FRAME_2

	Gui.UIListLayout_13 = Instance.new("UIListLayout")
	Gui.UIListLayout_13.Name = "UIListLayout"
	Gui.UIListLayout_13.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_13.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_13.Padding = UDim.new(0.05, 0)
	Gui.UIListLayout_13.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_13.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_13.Wraps = false
	Gui.UIListLayout_13.Archivable = true
	Gui.UIListLayout_13.Parent = Gui.SETTINGS_KEEPINGFRAME_2

	Gui.KeybindSetting_2 = Instance.new("Frame")
	Gui.KeybindSetting_2.Name = "KeybindSetting"
	Gui.KeybindSetting_2.Active = false
	Gui.KeybindSetting_2.AnchorPoint = Vector2.new(0, 0)
	Gui.KeybindSetting_2.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KeybindSetting_2.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.KeybindSetting_2.BackgroundTransparency = 0
	Gui.KeybindSetting_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KeybindSetting_2.BorderMode = Enum.BorderMode.Outline
	Gui.KeybindSetting_2.BorderSizePixel = 0
	Gui.KeybindSetting_2.ClipsDescendants = false
	Gui.KeybindSetting_2.Draggable = false
	Gui.KeybindSetting_2.LayoutOrder = 0
	Gui.KeybindSetting_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.KeybindSetting_2.Rotation = 0
	Gui.KeybindSetting_2.Selectable = false
	Gui.KeybindSetting_2.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.KeybindSetting_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KeybindSetting_2.Visible = true
	Gui.KeybindSetting_2.ZIndex = 1
	Gui.KeybindSetting_2.Style = Enum.FrameStyle.Custom
	Gui.KeybindSetting_2.Archivable = true
	Gui.KeybindSetting_2.Parent = Gui.SETTINGS_KEEPINGFRAME_2

	Gui.KEYBIND_TRIGGER_2 = Instance.new("TextButton")
	Gui.KEYBIND_TRIGGER_2.Name = "KEYBIND_TRIGGER"
	Gui.KEYBIND_TRIGGER_2.Active = true
	Gui.KEYBIND_TRIGGER_2.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TRIGGER_2.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_TRIGGER_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TRIGGER_2.BackgroundTransparency = 1
	Gui.KEYBIND_TRIGGER_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_2.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TRIGGER_2.BorderSizePixel = 0
	Gui.KEYBIND_TRIGGER_2.ClipsDescendants = false
	Gui.KEYBIND_TRIGGER_2.Draggable = false
	Gui.KEYBIND_TRIGGER_2.LayoutOrder = 0
	Gui.KEYBIND_TRIGGER_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TRIGGER_2.Rotation = 0
	Gui.KEYBIND_TRIGGER_2.Selectable = true
	Gui.KEYBIND_TRIGGER_2.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_TRIGGER_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TRIGGER_2.Visible = true
	Gui.KEYBIND_TRIGGER_2.ZIndex = 600
	Gui.KEYBIND_TRIGGER_2.Font = Enum.Font.Unknown
	Gui.KEYBIND_TRIGGER_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TRIGGER_2.LineHeight = 1
	Gui.KEYBIND_TRIGGER_2.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TRIGGER_2.RichText = false
	Gui.KEYBIND_TRIGGER_2.Text = ""
	Gui.KEYBIND_TRIGGER_2.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_TRIGGER_2.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TRIGGER_2.TextScaled = false
	Gui.KEYBIND_TRIGGER_2.TextSize = 25
	Gui.KEYBIND_TRIGGER_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_2.TextStrokeTransparency = 1
	Gui.KEYBIND_TRIGGER_2.TextTransparency = 0
	Gui.KEYBIND_TRIGGER_2.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TRIGGER_2.TextWrapped = true
	Gui.KEYBIND_TRIGGER_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_TRIGGER_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TRIGGER_2.Style = Enum.ButtonStyle.Custom
	Gui.KEYBIND_TRIGGER_2.AutoButtonColor = false
	Gui.KEYBIND_TRIGGER_2.Modal = false
	Gui.KEYBIND_TRIGGER_2.Selected = false
	Gui.KEYBIND_TRIGGER_2.Archivable = true
	Gui.KEYBIND_TRIGGER_2.Parent = Gui.KeybindSetting_2

	Gui.UICorner_56 = Instance.new("UICorner")
	Gui.UICorner_56.Name = "UICorner"
	Gui.UICorner_56.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_56.Archivable = true
	Gui.UICorner_56.Parent = Gui.KeybindSetting_2

	Gui.KEYBIND_LABEL_2 = Instance.new("TextLabel")
	Gui.KEYBIND_LABEL_2.Name = "KEYBIND_LABEL"
	Gui.KEYBIND_LABEL_2.Active = false
	Gui.KEYBIND_LABEL_2.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_LABEL_2.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_LABEL_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_LABEL_2.BackgroundTransparency = 1
	Gui.KEYBIND_LABEL_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_2.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_LABEL_2.BorderSizePixel = 0
	Gui.KEYBIND_LABEL_2.ClipsDescendants = false
	Gui.KEYBIND_LABEL_2.Draggable = false
	Gui.KEYBIND_LABEL_2.LayoutOrder = 0
	Gui.KEYBIND_LABEL_2.Position = UDim2.new(0.044, 0, 0, 0)
	Gui.KEYBIND_LABEL_2.Rotation = 0
	Gui.KEYBIND_LABEL_2.Selectable = false
	Gui.KEYBIND_LABEL_2.Size = UDim2.new(0.956, 0, 1, 0)
	Gui.KEYBIND_LABEL_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_LABEL_2.Visible = true
	Gui.KEYBIND_LABEL_2.ZIndex = 5
	Gui.KEYBIND_LABEL_2.Font = Enum.Font.Unknown
	Gui.KEYBIND_LABEL_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_LABEL_2.LineHeight = 1
	Gui.KEYBIND_LABEL_2.MaxVisibleGraphemes = -1
	Gui.KEYBIND_LABEL_2.RichText = false
	Gui.KEYBIND_LABEL_2.Text = "Keybind: V"
	Gui.KEYBIND_LABEL_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.KEYBIND_LABEL_2.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_LABEL_2.TextScaled = true
	Gui.KEYBIND_LABEL_2.TextSize = 25
	Gui.KEYBIND_LABEL_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_2.TextStrokeTransparency = 1
	Gui.KEYBIND_LABEL_2.TextTransparency = 0
	Gui.KEYBIND_LABEL_2.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_LABEL_2.TextWrapped = true
	Gui.KEYBIND_LABEL_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_LABEL_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_LABEL_2.Archivable = true
	Gui.KEYBIND_LABEL_2.Parent = Gui.KeybindSetting_2

	Gui.UITextSizeConstraint_26 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_26.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_26.MaxTextSize = 25
	Gui.UITextSizeConstraint_26.MinTextSize = 1
	Gui.UITextSizeConstraint_26.Archivable = true
	Gui.UITextSizeConstraint_26.Parent = Gui.KEYBIND_LABEL_2

	Gui.ColorSetting_2 = Instance.new("Frame")
	Gui.ColorSetting_2.Name = "ColorSetting"
	Gui.ColorSetting_2.Active = false
	Gui.ColorSetting_2.AnchorPoint = Vector2.new(0, 0)
	Gui.ColorSetting_2.AutomaticSize = Enum.AutomaticSize.XY
	Gui.ColorSetting_2.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.ColorSetting_2.BackgroundTransparency = 0
	Gui.ColorSetting_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ColorSetting_2.BorderMode = Enum.BorderMode.Outline
	Gui.ColorSetting_2.BorderSizePixel = 0
	Gui.ColorSetting_2.ClipsDescendants = false
	Gui.ColorSetting_2.Draggable = false
	Gui.ColorSetting_2.LayoutOrder = 0
	Gui.ColorSetting_2.Position = UDim2.new(0, 0, 0.528, 0)
	Gui.ColorSetting_2.Rotation = 0
	Gui.ColorSetting_2.Selectable = false
	Gui.ColorSetting_2.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.ColorSetting_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ColorSetting_2.Visible = true
	Gui.ColorSetting_2.ZIndex = 1
	Gui.ColorSetting_2.Style = Enum.FrameStyle.Custom
	Gui.ColorSetting_2.Archivable = true
	Gui.ColorSetting_2.Parent = Gui.SETTINGS_KEEPINGFRAME_2

	Gui.UICorner_57 = Instance.new("UICorner")
	Gui.UICorner_57.Name = "UICorner"
	Gui.UICorner_57.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_57.Archivable = true
	Gui.UICorner_57.Parent = Gui.ColorSetting_2

	Gui.COLORPREVIEW_2 = Instance.new("Frame")
	Gui.COLORPREVIEW_2.Name = "COLORPREVIEW"
	Gui.COLORPREVIEW_2.Active = false
	Gui.COLORPREVIEW_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COLORPREVIEW_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLORPREVIEW_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLORPREVIEW_2.BackgroundTransparency = 0
	Gui.COLORPREVIEW_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLORPREVIEW_2.BorderMode = Enum.BorderMode.Outline
	Gui.COLORPREVIEW_2.BorderSizePixel = 0
	Gui.COLORPREVIEW_2.ClipsDescendants = false
	Gui.COLORPREVIEW_2.Draggable = false
	Gui.COLORPREVIEW_2.LayoutOrder = 0
	Gui.COLORPREVIEW_2.Position = UDim2.new(0.141, 0, 0.5, 0)
	Gui.COLORPREVIEW_2.Rotation = 0
	Gui.COLORPREVIEW_2.Selectable = false
	Gui.COLORPREVIEW_2.Size = UDim2.new(0.198, 0, 0.715, 0)
	Gui.COLORPREVIEW_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLORPREVIEW_2.Visible = true
	Gui.COLORPREVIEW_2.ZIndex = 1
	Gui.COLORPREVIEW_2.Style = Enum.FrameStyle.Custom
	Gui.COLORPREVIEW_2.Archivable = true
	Gui.COLORPREVIEW_2.Parent = Gui.ColorSetting_2

	Gui.UICorner_58 = Instance.new("UICorner")
	Gui.UICorner_58.Name = "UICorner"
	Gui.UICorner_58.CornerRadius = UDim.new(0.25, 0)
	Gui.UICorner_58.Archivable = true
	Gui.UICorner_58.Parent = Gui.COLORPREVIEW_2

	Gui.HSV_LABEL_2 = Instance.new("TextLabel")
	Gui.HSV_LABEL_2.Name = "HSV_LABEL"
	Gui.HSV_LABEL_2.Active = false
	Gui.HSV_LABEL_2.AnchorPoint = Vector2.new(0, 0)
	Gui.HSV_LABEL_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.HSV_LABEL_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HSV_LABEL_2.BackgroundTransparency = 1
	Gui.HSV_LABEL_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_2.BorderMode = Enum.BorderMode.Outline
	Gui.HSV_LABEL_2.BorderSizePixel = 0
	Gui.HSV_LABEL_2.ClipsDescendants = false
	Gui.HSV_LABEL_2.Draggable = false
	Gui.HSV_LABEL_2.LayoutOrder = 0
	Gui.HSV_LABEL_2.Position = UDim2.new(0.336, 0, 0, 0)
	Gui.HSV_LABEL_2.Rotation = 0
	Gui.HSV_LABEL_2.Selectable = false
	Gui.HSV_LABEL_2.Size = UDim2.new(0.62, 0, 1, 0)
	Gui.HSV_LABEL_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HSV_LABEL_2.Visible = true
	Gui.HSV_LABEL_2.ZIndex = 1
	Gui.HSV_LABEL_2.Font = Enum.Font.Unknown
	Gui.HSV_LABEL_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.HSV_LABEL_2.LineHeight = 1
	Gui.HSV_LABEL_2.MaxVisibleGraphemes = -1
	Gui.HSV_LABEL_2.RichText = false
	Gui.HSV_LABEL_2.Text = "#FFFFFF"
	Gui.HSV_LABEL_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HSV_LABEL_2.TextDirection = Enum.TextDirection.Auto
	Gui.HSV_LABEL_2.TextScaled = false
	Gui.HSV_LABEL_2.TextSize = 25
	Gui.HSV_LABEL_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_2.TextStrokeTransparency = 1
	Gui.HSV_LABEL_2.TextTransparency = 0
	Gui.HSV_LABEL_2.TextTruncate = Enum.TextTruncate.None
	Gui.HSV_LABEL_2.TextWrapped = false
	Gui.HSV_LABEL_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.HSV_LABEL_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.HSV_LABEL_2.Archivable = true
	Gui.HSV_LABEL_2.Parent = Gui.ColorSetting_2

	Gui.COLOR_TRIGGER_2 = Instance.new("TextButton")
	Gui.COLOR_TRIGGER_2.Name = "COLOR_TRIGGER"
	Gui.COLOR_TRIGGER_2.Active = true
	Gui.COLOR_TRIGGER_2.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_TRIGGER_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_TRIGGER_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_TRIGGER_2.BackgroundTransparency = 1
	Gui.COLOR_TRIGGER_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_2.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_TRIGGER_2.BorderSizePixel = 0
	Gui.COLOR_TRIGGER_2.ClipsDescendants = false
	Gui.COLOR_TRIGGER_2.Draggable = false
	Gui.COLOR_TRIGGER_2.LayoutOrder = 0
	Gui.COLOR_TRIGGER_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.COLOR_TRIGGER_2.Rotation = 0
	Gui.COLOR_TRIGGER_2.Selectable = true
	Gui.COLOR_TRIGGER_2.Size = UDim2.new(1, 0, 1, 0)
	Gui.COLOR_TRIGGER_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_TRIGGER_2.Visible = true
	Gui.COLOR_TRIGGER_2.ZIndex = 1
	Gui.COLOR_TRIGGER_2.Font = Enum.Font.Unknown
	Gui.COLOR_TRIGGER_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COLOR_TRIGGER_2.LineHeight = 1
	Gui.COLOR_TRIGGER_2.MaxVisibleGraphemes = -1
	Gui.COLOR_TRIGGER_2.RichText = false
	Gui.COLOR_TRIGGER_2.Text = ""
	Gui.COLOR_TRIGGER_2.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.COLOR_TRIGGER_2.TextDirection = Enum.TextDirection.Auto
	Gui.COLOR_TRIGGER_2.TextScaled = false
	Gui.COLOR_TRIGGER_2.TextSize = 25
	Gui.COLOR_TRIGGER_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_2.TextStrokeTransparency = 1
	Gui.COLOR_TRIGGER_2.TextTransparency = 0
	Gui.COLOR_TRIGGER_2.TextTruncate = Enum.TextTruncate.None
	Gui.COLOR_TRIGGER_2.TextWrapped = true
	Gui.COLOR_TRIGGER_2.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COLOR_TRIGGER_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COLOR_TRIGGER_2.Style = Enum.ButtonStyle.Custom
	Gui.COLOR_TRIGGER_2.AutoButtonColor = false
	Gui.COLOR_TRIGGER_2.Modal = false
	Gui.COLOR_TRIGGER_2.Selected = false
	Gui.COLOR_TRIGGER_2.Archivable = true
	Gui.COLOR_TRIGGER_2.Parent = Gui.ColorSetting_2

	Gui.UICorner_59 = Instance.new("UICorner")
	Gui.UICorner_59.Name = "UICorner"
	Gui.UICorner_59.CornerRadius = UDim.new(0.07, 0)
	Gui.UICorner_59.Archivable = true
	Gui.UICorner_59.Parent = Gui.SETTINGS_FRAME_2

	Gui.ADDITIONS_FRAME_2 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_2.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_2.Active = false
	Gui.ADDITIONS_FRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_2.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_2.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_2.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_2.Draggable = false
	Gui.ADDITIONS_FRAME_2.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_2.Position = UDim2.new(0.707, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_2.Rotation = 0
	Gui.ADDITIONS_FRAME_2.Selectable = false
	Gui.ADDITIONS_FRAME_2.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_2.Visible = true
	Gui.ADDITIONS_FRAME_2.ZIndex = 1
	Gui.ADDITIONS_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_2.Archivable = true
	Gui.ADDITIONS_FRAME_2.Parent = Gui.SWITCH_EXAMPLE

	Gui.UIListLayout_14 = Instance.new("UIListLayout")
	Gui.UIListLayout_14.Name = "UIListLayout"
	Gui.UIListLayout_14.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_14.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_14.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_14.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_14.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_14.Wraps = false
	Gui.UIListLayout_14.Archivable = true
	Gui.UIListLayout_14.Parent = Gui.ADDITIONS_FRAME_2

	Gui.FAVOURITE_BUTTON_FRAME_2 = Instance.new("Frame")
	Gui.FAVOURITE_BUTTON_FRAME_2.Name = "FAVOURITE_BUTTON_FRAME"
	Gui.FAVOURITE_BUTTON_FRAME_2.Active = false
	Gui.FAVOURITE_BUTTON_FRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON_FRAME_2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.FAVOURITE_BUTTON_FRAME_2.BackgroundTransparency = 0
	Gui.FAVOURITE_BUTTON_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON_FRAME_2.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON_FRAME_2.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON_FRAME_2.Draggable = false
	Gui.FAVOURITE_BUTTON_FRAME_2.LayoutOrder = 2
	Gui.FAVOURITE_BUTTON_FRAME_2.Position = UDim2.new(0.073, 0, 0.483, 0)
	Gui.FAVOURITE_BUTTON_FRAME_2.Rotation = 0
	Gui.FAVOURITE_BUTTON_FRAME_2.Selectable = false
	Gui.FAVOURITE_BUTTON_FRAME_2.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.FAVOURITE_BUTTON_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON_FRAME_2.Visible = true
	Gui.FAVOURITE_BUTTON_FRAME_2.ZIndex = 1
	Gui.FAVOURITE_BUTTON_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.FAVOURITE_BUTTON_FRAME_2.Archivable = true
	Gui.FAVOURITE_BUTTON_FRAME_2.Parent = Gui.ADDITIONS_FRAME_2

	Gui.FAVOURITE_BUTTON_2 = Instance.new("ImageButton")
	Gui.FAVOURITE_BUTTON_2.Name = "FAVOURITE_BUTTON"
	Gui.FAVOURITE_BUTTON_2.Active = true
	Gui.FAVOURITE_BUTTON_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.FAVOURITE_BUTTON_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.FAVOURITE_BUTTON_2.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.FAVOURITE_BUTTON_2.BackgroundTransparency = 1
	Gui.FAVOURITE_BUTTON_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.FAVOURITE_BUTTON_2.BorderMode = Enum.BorderMode.Outline
	Gui.FAVOURITE_BUTTON_2.BorderSizePixel = 0
	Gui.FAVOURITE_BUTTON_2.ClipsDescendants = false
	Gui.FAVOURITE_BUTTON_2.Draggable = false
	Gui.FAVOURITE_BUTTON_2.LayoutOrder = 0
	Gui.FAVOURITE_BUTTON_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.FAVOURITE_BUTTON_2.Rotation = 0
	Gui.FAVOURITE_BUTTON_2.Selectable = true
	Gui.FAVOURITE_BUTTON_2.Size = UDim2.new(0.8, 0, 0.8, 0)
	Gui.FAVOURITE_BUTTON_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.FAVOURITE_BUTTON_2.Visible = true
	Gui.FAVOURITE_BUTTON_2.ZIndex = 1
	Gui.FAVOURITE_BUTTON_2.Image = "rbxassetid://90912994285683"
	Gui.FAVOURITE_BUTTON_2.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.FAVOURITE_BUTTON_2.ImageRectOffset = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON_2.ImageRectSize = Vector2.new(0, 0)
	Gui.FAVOURITE_BUTTON_2.ImageTransparency = 0
	Gui.FAVOURITE_BUTTON_2.ResampleMode = Enum.ResamplerMode.Default
	Gui.FAVOURITE_BUTTON_2.ScaleType = Enum.ScaleType.Stretch
	Gui.FAVOURITE_BUTTON_2.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.FAVOURITE_BUTTON_2.SliceScale = 1
	Gui.FAVOURITE_BUTTON_2.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.FAVOURITE_BUTTON_2.Style = Enum.ButtonStyle.Custom
	Gui.FAVOURITE_BUTTON_2.AutoButtonColor = true
	Gui.FAVOURITE_BUTTON_2.Modal = false
	Gui.FAVOURITE_BUTTON_2.Selected = false
	Gui.FAVOURITE_BUTTON_2.HoverImage = ""
	Gui.FAVOURITE_BUTTON_2.PressedImage = ""
	Gui.FAVOURITE_BUTTON_2.Archivable = true
	Gui.FAVOURITE_BUTTON_2.Parent = Gui.FAVOURITE_BUTTON_FRAME_2

	Gui.UICorner_60 = Instance.new("UICorner")
	Gui.UICorner_60.Name = "UICorner"
	Gui.UICorner_60.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_60.Archivable = true
	Gui.UICorner_60.Parent = Gui.FAVOURITE_BUTTON_FRAME_2

	Gui.SETTINGS_BUTTON_FRAME_2 = Instance.new("Frame")
	Gui.SETTINGS_BUTTON_FRAME_2.Name = "SETTINGS_BUTTON_FRAME"
	Gui.SETTINGS_BUTTON_FRAME_2.Active = false
	Gui.SETTINGS_BUTTON_FRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON_FRAME_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON_FRAME_2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.SETTINGS_BUTTON_FRAME_2.BackgroundTransparency = 0
	Gui.SETTINGS_BUTTON_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON_FRAME_2.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON_FRAME_2.ClipsDescendants = false
	Gui.SETTINGS_BUTTON_FRAME_2.Draggable = false
	Gui.SETTINGS_BUTTON_FRAME_2.LayoutOrder = 3
	Gui.SETTINGS_BUTTON_FRAME_2.Position = UDim2.new(0.227, 0, 0.524, 0)
	Gui.SETTINGS_BUTTON_FRAME_2.Rotation = 0
	Gui.SETTINGS_BUTTON_FRAME_2.Selectable = false
	Gui.SETTINGS_BUTTON_FRAME_2.Size = UDim2.new(0.146, 0, 0.967, 0)
	Gui.SETTINGS_BUTTON_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON_FRAME_2.Visible = true
	Gui.SETTINGS_BUTTON_FRAME_2.ZIndex = 1
	Gui.SETTINGS_BUTTON_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_BUTTON_FRAME_2.Archivable = true
	Gui.SETTINGS_BUTTON_FRAME_2.Parent = Gui.ADDITIONS_FRAME_2

	Gui.SETTINGS_BUTTON_2 = Instance.new("ImageButton")
	Gui.SETTINGS_BUTTON_2.Name = "SETTINGS_BUTTON"
	Gui.SETTINGS_BUTTON_2.Active = true
	Gui.SETTINGS_BUTTON_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_BUTTON_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_BUTTON_2.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.SETTINGS_BUTTON_2.BackgroundTransparency = 1
	Gui.SETTINGS_BUTTON_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_BUTTON_2.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_BUTTON_2.BorderSizePixel = 0
	Gui.SETTINGS_BUTTON_2.ClipsDescendants = false
	Gui.SETTINGS_BUTTON_2.Draggable = false
	Gui.SETTINGS_BUTTON_2.LayoutOrder = 0
	Gui.SETTINGS_BUTTON_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_BUTTON_2.Rotation = 0
	Gui.SETTINGS_BUTTON_2.Selectable = true
	Gui.SETTINGS_BUTTON_2.Size = UDim2.new(0.81, 0, 0.81, 0)
	Gui.SETTINGS_BUTTON_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_BUTTON_2.Visible = true
	Gui.SETTINGS_BUTTON_2.ZIndex = 1
	Gui.SETTINGS_BUTTON_2.Image = "rbxassetid://87999214752775"
	Gui.SETTINGS_BUTTON_2.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.SETTINGS_BUTTON_2.ImageRectOffset = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON_2.ImageRectSize = Vector2.new(0, 0)
	Gui.SETTINGS_BUTTON_2.ImageTransparency = 0
	Gui.SETTINGS_BUTTON_2.ResampleMode = Enum.ResamplerMode.Default
	Gui.SETTINGS_BUTTON_2.ScaleType = Enum.ScaleType.Stretch
	Gui.SETTINGS_BUTTON_2.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.SETTINGS_BUTTON_2.SliceScale = 1
	Gui.SETTINGS_BUTTON_2.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.SETTINGS_BUTTON_2.Style = Enum.ButtonStyle.Custom
	Gui.SETTINGS_BUTTON_2.AutoButtonColor = true
	Gui.SETTINGS_BUTTON_2.Modal = false
	Gui.SETTINGS_BUTTON_2.Selected = false
	Gui.SETTINGS_BUTTON_2.HoverImage = ""
	Gui.SETTINGS_BUTTON_2.PressedImage = ""
	Gui.SETTINGS_BUTTON_2.Archivable = true
	Gui.SETTINGS_BUTTON_2.Parent = Gui.SETTINGS_BUTTON_FRAME_2

	Gui.UICorner_61 = Instance.new("UICorner")
	Gui.UICorner_61.Name = "UICorner"
	Gui.UICorner_61.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_61.Archivable = true
	Gui.UICorner_61.Parent = Gui.SETTINGS_BUTTON_FRAME_2

	Gui.AUSWAHL_FRAME_2 = Instance.new("Frame")
	Gui.AUSWAHL_FRAME_2.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME_2.Active = false
	Gui.AUSWAHL_FRAME_2.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME_2.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME_2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.AUSWAHL_FRAME_2.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME_2.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME_2.ClipsDescendants = false
	Gui.AUSWAHL_FRAME_2.Draggable = false
	Gui.AUSWAHL_FRAME_2.LayoutOrder = 1
	Gui.AUSWAHL_FRAME_2.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME_2.Rotation = 0
	Gui.AUSWAHL_FRAME_2.Selectable = false
	Gui.AUSWAHL_FRAME_2.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME_2.Visible = true
	Gui.AUSWAHL_FRAME_2.ZIndex = 1
	Gui.AUSWAHL_FRAME_2.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME_2.Archivable = true
	Gui.AUSWAHL_FRAME_2.Parent = Gui.ADDITIONS_FRAME_2

	Gui.UICorner_62 = Instance.new("UICorner")
	Gui.UICorner_62.Name = "UICorner"
	Gui.UICorner_62.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_62.Archivable = true
	Gui.UICorner_62.Parent = Gui.AUSWAHL_FRAME_2

	Gui.ZAHL_AUSWAHL_FRAME_2 = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME_2.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME_2.Active = false
	Gui.ZAHL_AUSWAHL_FRAME_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME_2.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME_2.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME_2.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME_2.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME_2.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME_2.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME_2.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME_2.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME_2.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME_2.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME_2.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME_2.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME_2.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME_2.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME_2.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME_2.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME_2.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME_2.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME_2.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME_2.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_2.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_2.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME_2.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME_2.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME_2.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME_2.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME_2.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME_2.Parent = Gui.AUSWAHL_FRAME_2

	Gui.UITextSizeConstraint_27 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_27.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_27.MaxTextSize = 29
	Gui.UITextSizeConstraint_27.MinTextSize = 1
	Gui.UITextSizeConstraint_27.Archivable = true
	Gui.UITextSizeConstraint_27.Parent = Gui.ZAHL_AUSWAHL_FRAME_2

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2 = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2.Parent = Gui.AUSWAHL_FRAME_2

end

local function BuildGui4()
	Gui.UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_6.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_6.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_6.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_6.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_6.Archivable = true
	Gui.UIAspectRatioConstraint_6.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME_2

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2 = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2.Parent = Gui.AUSWAHL_FRAME_2

	Gui.UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_7.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_7.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_7.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_7.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_7.Archivable = true
	Gui.UIAspectRatioConstraint_7.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_2

	Gui.UIListLayout_15 = Instance.new("UIListLayout")
	Gui.UIListLayout_15.Name = "UIListLayout"
	Gui.UIListLayout_15.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_15.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_15.Padding = UDim.new(0, 0)
	Gui.UIListLayout_15.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_15.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_15.Wraps = false
	Gui.UIListLayout_15.Archivable = true
	Gui.UIListLayout_15.Parent = Gui.AUSWAHL_FRAME_2

	Gui.CHOOSE_EXAMPLE_TESTING = Instance.new("Frame")
	Gui.CHOOSE_EXAMPLE_TESTING.Name = "CHOOSE_EXAMPLE_TESTING"
	Gui.CHOOSE_EXAMPLE_TESTING.Active = false
	Gui.CHOOSE_EXAMPLE_TESTING.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_EXAMPLE_TESTING.AutomaticSize = Enum.AutomaticSize.None
	Gui.CHOOSE_EXAMPLE_TESTING.BackgroundColor3 = Color3.fromRGB(42, 40, 8)
	Gui.CHOOSE_EXAMPLE_TESTING.BackgroundTransparency = 0
	Gui.CHOOSE_EXAMPLE_TESTING.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_EXAMPLE_TESTING.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_EXAMPLE_TESTING.BorderSizePixel = 0
	Gui.CHOOSE_EXAMPLE_TESTING.ClipsDescendants = false
	Gui.CHOOSE_EXAMPLE_TESTING.Draggable = false
	Gui.CHOOSE_EXAMPLE_TESTING.LayoutOrder = 0
	Gui.CHOOSE_EXAMPLE_TESTING.Position = UDim2.new(0, 0, 0, 0)
	Gui.CHOOSE_EXAMPLE_TESTING.Rotation = 0
	Gui.CHOOSE_EXAMPLE_TESTING.Selectable = false
	Gui.CHOOSE_EXAMPLE_TESTING.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.CHOOSE_EXAMPLE_TESTING.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_EXAMPLE_TESTING.Visible = false
	Gui.CHOOSE_EXAMPLE_TESTING.ZIndex = 3
	Gui.CHOOSE_EXAMPLE_TESTING.Style = Enum.FrameStyle.Custom
	Gui.CHOOSE_EXAMPLE_TESTING.Archivable = true
	Gui.CHOOSE_EXAMPLE_TESTING.Parent = Gui.Examples

	Gui.UICorner_63 = Instance.new("UICorner")
	Gui.UICorner_63.Name = "UICorner"
	Gui.UICorner_63.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_63.Archivable = true
	Gui.UICorner_63.Parent = Gui.CHOOSE_EXAMPLE_TESTING

	Gui.FUNCTION_NAME_10 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_10.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_10.Archivable = true
	Gui.FUNCTION_NAME_10.Parent = Gui.CHOOSE_EXAMPLE_TESTING

	Gui.MainLabel_9 = Instance.new("TextLabel")
	Gui.MainLabel_9.Name = "MainLabel"
	Gui.MainLabel_9.Active = false
	Gui.MainLabel_9.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_9.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_9.BackgroundTransparency = 1
	Gui.MainLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_9.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_9.BorderSizePixel = 0
	Gui.MainLabel_9.ClipsDescendants = false
	Gui.MainLabel_9.Draggable = false
	Gui.MainLabel_9.LayoutOrder = 0
	Gui.MainLabel_9.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_9.Rotation = 0
	Gui.MainLabel_9.Selectable = false
	Gui.MainLabel_9.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_9.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_9.Visible = true
	Gui.MainLabel_9.ZIndex = 1
	Gui.MainLabel_9.Font = Enum.Font.Unknown
	Gui.MainLabel_9.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_9.LineHeight = 1
	Gui.MainLabel_9.MaxVisibleGraphemes = -1
	Gui.MainLabel_9.RichText = false
	Gui.MainLabel_9.Text = "Das ist der Name der Auswahl"
	Gui.MainLabel_9.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_9.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_9.TextScaled = true
	Gui.MainLabel_9.TextSize = 23
	Gui.MainLabel_9.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_9.TextStrokeTransparency = 1
	Gui.MainLabel_9.TextTransparency = 0
	Gui.MainLabel_9.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_9.TextWrapped = true
	Gui.MainLabel_9.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_9.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_9.Archivable = true
	Gui.MainLabel_9.Parent = Gui.CHOOSE_EXAMPLE_TESTING

	Gui.UITextSizeConstraint_28 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_28.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_28.MaxTextSize = 23
	Gui.UITextSizeConstraint_28.MinTextSize = 1
	Gui.UITextSizeConstraint_28.Archivable = true
	Gui.UITextSizeConstraint_28.Parent = Gui.MainLabel_9

	Gui.Description_5 = Instance.new("TextLabel")
	Gui.Description_5.Name = "Description"
	Gui.Description_5.Active = false
	Gui.Description_5.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_5.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_5.BackgroundTransparency = 1
	Gui.Description_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_5.BorderMode = Enum.BorderMode.Outline
	Gui.Description_5.BorderSizePixel = 0
	Gui.Description_5.ClipsDescendants = false
	Gui.Description_5.Draggable = false
	Gui.Description_5.LayoutOrder = 0
	Gui.Description_5.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_5.Rotation = 0
	Gui.Description_5.Selectable = false
	Gui.Description_5.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_5.Visible = true
	Gui.Description_5.ZIndex = 1
	Gui.Description_5.Font = Enum.Font.Unknown
	Gui.Description_5.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_5.LineHeight = 1
	Gui.Description_5.MaxVisibleGraphemes = -1
	Gui.Description_5.RichText = false
	Gui.Description_5.Text = "Das ist die Beschreibung der Auswahl"
	Gui.Description_5.TextColor3 = Color3.fromRGB(80, 75, 15)
	Gui.Description_5.TextDirection = Enum.TextDirection.Auto
	Gui.Description_5.TextScaled = true
	Gui.Description_5.TextSize = 17
	Gui.Description_5.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_5.TextStrokeTransparency = 1
	Gui.Description_5.TextTransparency = 0
	Gui.Description_5.TextTruncate = Enum.TextTruncate.None
	Gui.Description_5.TextWrapped = true
	Gui.Description_5.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_5.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_5.Archivable = true
	Gui.Description_5.Parent = Gui.CHOOSE_EXAMPLE_TESTING

	Gui.UITextSizeConstraint_29 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_29.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_29.MaxTextSize = 17
	Gui.UITextSizeConstraint_29.MinTextSize = 1
	Gui.UITextSizeConstraint_29.Archivable = true
	Gui.UITextSizeConstraint_29.Parent = Gui.Description_5

	Gui.ADDITIONS_FRAME_3 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_3.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_3.Active = false
	Gui.ADDITIONS_FRAME_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_3.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_3.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_3.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_3.Draggable = false
	Gui.ADDITIONS_FRAME_3.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_3.Position = UDim2.new(0.806, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_3.Rotation = 0
	Gui.ADDITIONS_FRAME_3.Selectable = false
	Gui.ADDITIONS_FRAME_3.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_3.Visible = true
	Gui.ADDITIONS_FRAME_3.ZIndex = 1
	Gui.ADDITIONS_FRAME_3.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_3.Archivable = true
	Gui.ADDITIONS_FRAME_3.Parent = Gui.CHOOSE_EXAMPLE_TESTING

	Gui.UIListLayout_16 = Instance.new("UIListLayout")
	Gui.UIListLayout_16.Name = "UIListLayout"
	Gui.UIListLayout_16.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_16.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_16.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_16.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_16.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_16.Wraps = false
	Gui.UIListLayout_16.Archivable = true
	Gui.UIListLayout_16.Parent = Gui.ADDITIONS_FRAME_3

	Gui.AUSWAHL_FRAME_3 = Instance.new("Frame")
	Gui.AUSWAHL_FRAME_3.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME_3.Active = false
	Gui.AUSWAHL_FRAME_3.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME_3.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME_3.BackgroundColor3 = Color3.fromRGB(65, 60, 10)
	Gui.AUSWAHL_FRAME_3.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME_3.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME_3.ClipsDescendants = false
	Gui.AUSWAHL_FRAME_3.Draggable = false
	Gui.AUSWAHL_FRAME_3.LayoutOrder = 1
	Gui.AUSWAHL_FRAME_3.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME_3.Rotation = 0
	Gui.AUSWAHL_FRAME_3.Selectable = false
	Gui.AUSWAHL_FRAME_3.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME_3.Visible = true
	Gui.AUSWAHL_FRAME_3.ZIndex = 1
	Gui.AUSWAHL_FRAME_3.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME_3.Archivable = true
	Gui.AUSWAHL_FRAME_3.Parent = Gui.ADDITIONS_FRAME_3

	Gui.UICorner_64 = Instance.new("UICorner")
	Gui.UICorner_64.Name = "UICorner"
	Gui.UICorner_64.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_64.Archivable = true
	Gui.UICorner_64.Parent = Gui.AUSWAHL_FRAME_3

	Gui.ZAHL_AUSWAHL_FRAME_3 = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME_3.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME_3.Active = false
	Gui.ZAHL_AUSWAHL_FRAME_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME_3.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME_3.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME_3.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME_3.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME_3.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME_3.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME_3.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME_3.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME_3.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME_3.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME_3.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME_3.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME_3.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME_3.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME_3.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME_3.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME_3.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME_3.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME_3.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME_3.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_3.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_3.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME_3.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME_3.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME_3.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME_3.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME_3.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME_3.Parent = Gui.AUSWAHL_FRAME_3

	Gui.UITextSizeConstraint_30 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_30.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_30.MaxTextSize = 29
	Gui.UITextSizeConstraint_30.MinTextSize = 1
	Gui.UITextSizeConstraint_30.Archivable = true
	Gui.UITextSizeConstraint_30.Parent = Gui.ZAHL_AUSWAHL_FRAME_3

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3 = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3.Parent = Gui.AUSWAHL_FRAME_3

	Gui.UIAspectRatioConstraint_8 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_8.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_8.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_8.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_8.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_8.Archivable = true
	Gui.UIAspectRatioConstraint_8.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME_3

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3 = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3.Parent = Gui.AUSWAHL_FRAME_3

	Gui.UIAspectRatioConstraint_9 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_9.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_9.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_9.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_9.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_9.Archivable = true
	Gui.UIAspectRatioConstraint_9.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_3

	Gui.UIListLayout_17 = Instance.new("UIListLayout")
	Gui.UIListLayout_17.Name = "UIListLayout"
	Gui.UIListLayout_17.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_17.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_17.Padding = UDim.new(0, 0)
	Gui.UIListLayout_17.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_17.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_17.Wraps = false
	Gui.UIListLayout_17.Archivable = true
	Gui.UIListLayout_17.Parent = Gui.AUSWAHL_FRAME_3

	Gui.CHOOSE_EXAMPLE_RISK = Instance.new("Frame")
	Gui.CHOOSE_EXAMPLE_RISK.Name = "CHOOSE_EXAMPLE_RISK"
	Gui.CHOOSE_EXAMPLE_RISK.Active = false
	Gui.CHOOSE_EXAMPLE_RISK.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_EXAMPLE_RISK.AutomaticSize = Enum.AutomaticSize.None
	Gui.CHOOSE_EXAMPLE_RISK.BackgroundColor3 = Color3.fromRGB(60, 10, 20)
	Gui.CHOOSE_EXAMPLE_RISK.BackgroundTransparency = 0
	Gui.CHOOSE_EXAMPLE_RISK.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_EXAMPLE_RISK.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_EXAMPLE_RISK.BorderSizePixel = 0
	Gui.CHOOSE_EXAMPLE_RISK.ClipsDescendants = false
	Gui.CHOOSE_EXAMPLE_RISK.Draggable = false
	Gui.CHOOSE_EXAMPLE_RISK.LayoutOrder = 0
	Gui.CHOOSE_EXAMPLE_RISK.Position = UDim2.new(0, 0, 0, 0)
	Gui.CHOOSE_EXAMPLE_RISK.Rotation = 0
	Gui.CHOOSE_EXAMPLE_RISK.Selectable = false
	Gui.CHOOSE_EXAMPLE_RISK.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.CHOOSE_EXAMPLE_RISK.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_EXAMPLE_RISK.Visible = false
	Gui.CHOOSE_EXAMPLE_RISK.ZIndex = 3
	Gui.CHOOSE_EXAMPLE_RISK.Style = Enum.FrameStyle.Custom
	Gui.CHOOSE_EXAMPLE_RISK.Archivable = true
	Gui.CHOOSE_EXAMPLE_RISK.Parent = Gui.Examples

	Gui.UICorner_65 = Instance.new("UICorner")
	Gui.UICorner_65.Name = "UICorner"
	Gui.UICorner_65.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_65.Archivable = true
	Gui.UICorner_65.Parent = Gui.CHOOSE_EXAMPLE_RISK

	Gui.FUNCTION_NAME_11 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_11.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_11.Archivable = true
	Gui.FUNCTION_NAME_11.Parent = Gui.CHOOSE_EXAMPLE_RISK

	Gui.MainLabel_10 = Instance.new("TextLabel")
	Gui.MainLabel_10.Name = "MainLabel"
	Gui.MainLabel_10.Active = false
	Gui.MainLabel_10.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_10.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_10.BackgroundTransparency = 1
	Gui.MainLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_10.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_10.BorderSizePixel = 0
	Gui.MainLabel_10.ClipsDescendants = false
	Gui.MainLabel_10.Draggable = false
	Gui.MainLabel_10.LayoutOrder = 0
	Gui.MainLabel_10.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_10.Rotation = 0
	Gui.MainLabel_10.Selectable = false
	Gui.MainLabel_10.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_10.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_10.Visible = true
	Gui.MainLabel_10.ZIndex = 1
	Gui.MainLabel_10.Font = Enum.Font.Unknown
	Gui.MainLabel_10.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_10.LineHeight = 1
	Gui.MainLabel_10.MaxVisibleGraphemes = -1
	Gui.MainLabel_10.RichText = false
	Gui.MainLabel_10.Text = "Das ist der Name der Auswahl"
	Gui.MainLabel_10.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_10.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_10.TextScaled = true
	Gui.MainLabel_10.TextSize = 23
	Gui.MainLabel_10.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_10.TextStrokeTransparency = 1
	Gui.MainLabel_10.TextTransparency = 0
	Gui.MainLabel_10.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_10.TextWrapped = true
	Gui.MainLabel_10.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_10.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_10.Archivable = true
	Gui.MainLabel_10.Parent = Gui.CHOOSE_EXAMPLE_RISK

	Gui.UITextSizeConstraint_31 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_31.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_31.MaxTextSize = 23
	Gui.UITextSizeConstraint_31.MinTextSize = 1
	Gui.UITextSizeConstraint_31.Archivable = true
	Gui.UITextSizeConstraint_31.Parent = Gui.MainLabel_10

	Gui.Description_6 = Instance.new("TextLabel")
	Gui.Description_6.Name = "Description"
	Gui.Description_6.Active = false
	Gui.Description_6.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_6.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_6.BackgroundTransparency = 1
	Gui.Description_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_6.BorderMode = Enum.BorderMode.Outline
	Gui.Description_6.BorderSizePixel = 0
	Gui.Description_6.ClipsDescendants = false
	Gui.Description_6.Draggable = false
	Gui.Description_6.LayoutOrder = 0
	Gui.Description_6.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_6.Rotation = 0
	Gui.Description_6.Selectable = false
	Gui.Description_6.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_6.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_6.Visible = true
	Gui.Description_6.ZIndex = 1
	Gui.Description_6.Font = Enum.Font.Unknown
	Gui.Description_6.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_6.LineHeight = 1
	Gui.Description_6.MaxVisibleGraphemes = -1
	Gui.Description_6.RichText = false
	Gui.Description_6.Text = "Das ist die Beschreibung der Auswahl"
	Gui.Description_6.TextColor3 = Color3.fromRGB(32, 10, 20)
	Gui.Description_6.TextDirection = Enum.TextDirection.Auto
	Gui.Description_6.TextScaled = true
	Gui.Description_6.TextSize = 17
	Gui.Description_6.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_6.TextStrokeTransparency = 1
	Gui.Description_6.TextTransparency = 0
	Gui.Description_6.TextTruncate = Enum.TextTruncate.None
	Gui.Description_6.TextWrapped = true
	Gui.Description_6.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_6.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_6.Archivable = true
	Gui.Description_6.Parent = Gui.CHOOSE_EXAMPLE_RISK

	Gui.UITextSizeConstraint_32 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_32.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_32.MaxTextSize = 17
	Gui.UITextSizeConstraint_32.MinTextSize = 1
	Gui.UITextSizeConstraint_32.Archivable = true
	Gui.UITextSizeConstraint_32.Parent = Gui.Description_6

	Gui.ADDITIONS_FRAME_4 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_4.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_4.Active = false
	Gui.ADDITIONS_FRAME_4.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_4.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_4.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_4.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_4.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_4.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_4.Draggable = false
	Gui.ADDITIONS_FRAME_4.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_4.Position = UDim2.new(0.806, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_4.Rotation = 0
	Gui.ADDITIONS_FRAME_4.Selectable = false
	Gui.ADDITIONS_FRAME_4.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_4.Visible = true
	Gui.ADDITIONS_FRAME_4.ZIndex = 1
	Gui.ADDITIONS_FRAME_4.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_4.Archivable = true
	Gui.ADDITIONS_FRAME_4.Parent = Gui.CHOOSE_EXAMPLE_RISK

	Gui.UIListLayout_18 = Instance.new("UIListLayout")
	Gui.UIListLayout_18.Name = "UIListLayout"
	Gui.UIListLayout_18.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_18.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_18.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_18.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_18.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_18.Wraps = false
	Gui.UIListLayout_18.Archivable = true
	Gui.UIListLayout_18.Parent = Gui.ADDITIONS_FRAME_4

	Gui.AUSWAHL_FRAME_4 = Instance.new("Frame")
	Gui.AUSWAHL_FRAME_4.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME_4.Active = false
	Gui.AUSWAHL_FRAME_4.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME_4.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME_4.BackgroundColor3 = Color3.fromRGB(20, 6, 15)
	Gui.AUSWAHL_FRAME_4.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME_4.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME_4.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME_4.ClipsDescendants = false
	Gui.AUSWAHL_FRAME_4.Draggable = false
	Gui.AUSWAHL_FRAME_4.LayoutOrder = 1
	Gui.AUSWAHL_FRAME_4.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME_4.Rotation = 0
	Gui.AUSWAHL_FRAME_4.Selectable = false
	Gui.AUSWAHL_FRAME_4.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME_4.Visible = true
	Gui.AUSWAHL_FRAME_4.ZIndex = 1
	Gui.AUSWAHL_FRAME_4.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME_4.Archivable = true
	Gui.AUSWAHL_FRAME_4.Parent = Gui.ADDITIONS_FRAME_4

	Gui.UICorner_66 = Instance.new("UICorner")
	Gui.UICorner_66.Name = "UICorner"
	Gui.UICorner_66.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_66.Archivable = true
	Gui.UICorner_66.Parent = Gui.AUSWAHL_FRAME_4

	Gui.ZAHL_AUSWAHL_FRAME_4 = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME_4.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME_4.Active = false
	Gui.ZAHL_AUSWAHL_FRAME_4.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME_4.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME_4.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_4.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME_4.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME_4.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME_4.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME_4.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME_4.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME_4.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME_4.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME_4.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME_4.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME_4.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME_4.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME_4.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME_4.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME_4.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME_4.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME_4.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME_4.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME_4.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME_4.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME_4.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME_4.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_4.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_4.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME_4.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME_4.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME_4.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME_4.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME_4.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME_4.Parent = Gui.AUSWAHL_FRAME_4

	Gui.UITextSizeConstraint_33 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_33.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_33.MaxTextSize = 29
	Gui.UITextSizeConstraint_33.MinTextSize = 1
	Gui.UITextSizeConstraint_33.Archivable = true
	Gui.UITextSizeConstraint_33.Parent = Gui.ZAHL_AUSWAHL_FRAME_4

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4 = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4.Parent = Gui.AUSWAHL_FRAME_4

	Gui.UIAspectRatioConstraint_10 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_10.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_10.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_10.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_10.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_10.Archivable = true
	Gui.UIAspectRatioConstraint_10.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME_4

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4 = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4.Parent = Gui.AUSWAHL_FRAME_4

	Gui.UIAspectRatioConstraint_11 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_11.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_11.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_11.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_11.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_11.Archivable = true
	Gui.UIAspectRatioConstraint_11.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_4

	Gui.UIListLayout_19 = Instance.new("UIListLayout")
	Gui.UIListLayout_19.Name = "UIListLayout"
	Gui.UIListLayout_19.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_19.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_19.Padding = UDim.new(0, 0)
	Gui.UIListLayout_19.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_19.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_19.Wraps = false
	Gui.UIListLayout_19.Archivable = true
	Gui.UIListLayout_19.Parent = Gui.AUSWAHL_FRAME_4

	Gui.CHOOSE_EXAMPLE = Instance.new("Frame")
	Gui.CHOOSE_EXAMPLE.Name = "CHOOSE_EXAMPLE"
	Gui.CHOOSE_EXAMPLE.Active = false
	Gui.CHOOSE_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.CHOOSE_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.CHOOSE_EXAMPLE.BackgroundTransparency = 0
	Gui.CHOOSE_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_EXAMPLE.BorderSizePixel = 0
	Gui.CHOOSE_EXAMPLE.ClipsDescendants = false
	Gui.CHOOSE_EXAMPLE.Draggable = false
	Gui.CHOOSE_EXAMPLE.LayoutOrder = 0
	Gui.CHOOSE_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.CHOOSE_EXAMPLE.Rotation = 0
	Gui.CHOOSE_EXAMPLE.Selectable = false
	Gui.CHOOSE_EXAMPLE.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.CHOOSE_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_EXAMPLE.Visible = false
	Gui.CHOOSE_EXAMPLE.ZIndex = 3
	Gui.CHOOSE_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.CHOOSE_EXAMPLE.Archivable = true
	Gui.CHOOSE_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_67 = Instance.new("UICorner")
	Gui.UICorner_67.Name = "UICorner"
	Gui.UICorner_67.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_67.Archivable = true
	Gui.UICorner_67.Parent = Gui.CHOOSE_EXAMPLE

	Gui.FUNCTION_NAME_12 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_12.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_12.Archivable = true
	Gui.FUNCTION_NAME_12.Parent = Gui.CHOOSE_EXAMPLE

	Gui.MainLabel_11 = Instance.new("TextLabel")
	Gui.MainLabel_11.Name = "MainLabel"
	Gui.MainLabel_11.Active = false
	Gui.MainLabel_11.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_11.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_11.BackgroundTransparency = 1
	Gui.MainLabel_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_11.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_11.BorderSizePixel = 0
	Gui.MainLabel_11.ClipsDescendants = false
	Gui.MainLabel_11.Draggable = false
	Gui.MainLabel_11.LayoutOrder = 0
	Gui.MainLabel_11.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_11.Rotation = 0
	Gui.MainLabel_11.Selectable = false
	Gui.MainLabel_11.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_11.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_11.Visible = true
	Gui.MainLabel_11.ZIndex = 1
	Gui.MainLabel_11.Font = Enum.Font.Unknown
	Gui.MainLabel_11.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_11.LineHeight = 1
	Gui.MainLabel_11.MaxVisibleGraphemes = -1
	Gui.MainLabel_11.RichText = false
	Gui.MainLabel_11.Text = "Das ist der Name der Auswahl"
	Gui.MainLabel_11.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_11.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_11.TextScaled = true
	Gui.MainLabel_11.TextSize = 23
	Gui.MainLabel_11.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_11.TextStrokeTransparency = 1
	Gui.MainLabel_11.TextTransparency = 0
	Gui.MainLabel_11.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_11.TextWrapped = true
	Gui.MainLabel_11.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_11.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_11.Archivable = true
	Gui.MainLabel_11.Parent = Gui.CHOOSE_EXAMPLE

	Gui.UITextSizeConstraint_34 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_34.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_34.MaxTextSize = 23
	Gui.UITextSizeConstraint_34.MinTextSize = 1
	Gui.UITextSizeConstraint_34.Archivable = true
	Gui.UITextSizeConstraint_34.Parent = Gui.MainLabel_11

	Gui.Description_7 = Instance.new("TextLabel")
	Gui.Description_7.Name = "Description"
	Gui.Description_7.Active = false
	Gui.Description_7.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_7.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_7.BackgroundTransparency = 1
	Gui.Description_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_7.BorderMode = Enum.BorderMode.Outline
	Gui.Description_7.BorderSizePixel = 0
	Gui.Description_7.ClipsDescendants = false
	Gui.Description_7.Draggable = false
	Gui.Description_7.LayoutOrder = 0
	Gui.Description_7.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_7.Rotation = 0
	Gui.Description_7.Selectable = false
	Gui.Description_7.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_7.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_7.Visible = true
	Gui.Description_7.ZIndex = 1
	Gui.Description_7.Font = Enum.Font.Unknown
	Gui.Description_7.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_7.LineHeight = 1
	Gui.Description_7.MaxVisibleGraphemes = -1
	Gui.Description_7.RichText = false
	Gui.Description_7.Text = "Das ist die Beschreibung der Auswahl"
	Gui.Description_7.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description_7.TextDirection = Enum.TextDirection.Auto
	Gui.Description_7.TextScaled = true
	Gui.Description_7.TextSize = 17
	Gui.Description_7.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_7.TextStrokeTransparency = 1
	Gui.Description_7.TextTransparency = 0
	Gui.Description_7.TextTruncate = Enum.TextTruncate.None
	Gui.Description_7.TextWrapped = true
	Gui.Description_7.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_7.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_7.Archivable = true
	Gui.Description_7.Parent = Gui.CHOOSE_EXAMPLE

	Gui.UITextSizeConstraint_35 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_35.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_35.MaxTextSize = 17
	Gui.UITextSizeConstraint_35.MinTextSize = 1
	Gui.UITextSizeConstraint_35.Archivable = true
	Gui.UITextSizeConstraint_35.Parent = Gui.Description_7

	Gui.ADDITIONS_FRAME_5 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_5.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_5.Active = false
	Gui.ADDITIONS_FRAME_5.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_5.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_5.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_5.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_5.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_5.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_5.Draggable = false
	Gui.ADDITIONS_FRAME_5.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_5.Position = UDim2.new(0.806, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_5.Rotation = 0
	Gui.ADDITIONS_FRAME_5.Selectable = false
	Gui.ADDITIONS_FRAME_5.Size = UDim2.new(0.342, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_5.Visible = true
	Gui.ADDITIONS_FRAME_5.ZIndex = 1
	Gui.ADDITIONS_FRAME_5.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_5.Archivable = true
	Gui.ADDITIONS_FRAME_5.Parent = Gui.CHOOSE_EXAMPLE

	Gui.UIListLayout_20 = Instance.new("UIListLayout")
	Gui.UIListLayout_20.Name = "UIListLayout"
	Gui.UIListLayout_20.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_20.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_20.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_20.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_20.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_20.Wraps = false
	Gui.UIListLayout_20.Archivable = true
	Gui.UIListLayout_20.Parent = Gui.ADDITIONS_FRAME_5

	Gui.AUSWAHL_FRAME_5 = Instance.new("Frame")
	Gui.AUSWAHL_FRAME_5.Name = "AUSWAHL_FRAME"
	Gui.AUSWAHL_FRAME_5.Active = false
	Gui.AUSWAHL_FRAME_5.AnchorPoint = Vector2.new(0, 0)
	Gui.AUSWAHL_FRAME_5.AutomaticSize = Enum.AutomaticSize.X
	Gui.AUSWAHL_FRAME_5.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.AUSWAHL_FRAME_5.BackgroundTransparency = 0
	Gui.AUSWAHL_FRAME_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.AUSWAHL_FRAME_5.BorderMode = Enum.BorderMode.Outline
	Gui.AUSWAHL_FRAME_5.BorderSizePixel = 0
	Gui.AUSWAHL_FRAME_5.ClipsDescendants = false
	Gui.AUSWAHL_FRAME_5.Draggable = false
	Gui.AUSWAHL_FRAME_5.LayoutOrder = 1
	Gui.AUSWAHL_FRAME_5.Position = UDim2.new(0.279, 0, 0, 0)
	Gui.AUSWAHL_FRAME_5.Rotation = 0
	Gui.AUSWAHL_FRAME_5.Selectable = false
	Gui.AUSWAHL_FRAME_5.Size = UDim2.new(0.389, 0, 1, 0)
	Gui.AUSWAHL_FRAME_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.AUSWAHL_FRAME_5.Visible = true
	Gui.AUSWAHL_FRAME_5.ZIndex = 1
	Gui.AUSWAHL_FRAME_5.Style = Enum.FrameStyle.Custom
	Gui.AUSWAHL_FRAME_5.Archivable = true
	Gui.AUSWAHL_FRAME_5.Parent = Gui.ADDITIONS_FRAME_5

	Gui.UICorner_68 = Instance.new("UICorner")
	Gui.UICorner_68.Name = "UICorner"
	Gui.UICorner_68.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_68.Archivable = true
	Gui.UICorner_68.Parent = Gui.AUSWAHL_FRAME_5

	Gui.ZAHL_AUSWAHL_FRAME_5 = Instance.new("TextLabel")
	Gui.ZAHL_AUSWAHL_FRAME_5.Name = "ZAHL_AUSWAHL_FRAME"
	Gui.ZAHL_AUSWAHL_FRAME_5.Active = false
	Gui.ZAHL_AUSWAHL_FRAME_5.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ZAHL_AUSWAHL_FRAME_5.AutomaticSize = Enum.AutomaticSize.X
	Gui.ZAHL_AUSWAHL_FRAME_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ZAHL_AUSWAHL_FRAME_5.BackgroundTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_5.BorderMode = Enum.BorderMode.Outline
	Gui.ZAHL_AUSWAHL_FRAME_5.BorderSizePixel = 0
	Gui.ZAHL_AUSWAHL_FRAME_5.ClipsDescendants = false
	Gui.ZAHL_AUSWAHL_FRAME_5.Draggable = false
	Gui.ZAHL_AUSWAHL_FRAME_5.LayoutOrder = 2
	Gui.ZAHL_AUSWAHL_FRAME_5.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.ZAHL_AUSWAHL_FRAME_5.Rotation = 0
	Gui.ZAHL_AUSWAHL_FRAME_5.Selectable = false
	Gui.ZAHL_AUSWAHL_FRAME_5.Size = UDim2.new(0, 0, 1, 0)
	Gui.ZAHL_AUSWAHL_FRAME_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ZAHL_AUSWAHL_FRAME_5.Visible = true
	Gui.ZAHL_AUSWAHL_FRAME_5.ZIndex = 1
	Gui.ZAHL_AUSWAHL_FRAME_5.Font = Enum.Font.Unknown
	Gui.ZAHL_AUSWAHL_FRAME_5.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.ZAHL_AUSWAHL_FRAME_5.LineHeight = 1
	Gui.ZAHL_AUSWAHL_FRAME_5.MaxVisibleGraphemes = -1
	Gui.ZAHL_AUSWAHL_FRAME_5.RichText = false
	Gui.ZAHL_AUSWAHL_FRAME_5.Text = "Text"
	Gui.ZAHL_AUSWAHL_FRAME_5.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.ZAHL_AUSWAHL_FRAME_5.TextDirection = Enum.TextDirection.Auto
	Gui.ZAHL_AUSWAHL_FRAME_5.TextScaled = false
	Gui.ZAHL_AUSWAHL_FRAME_5.TextSize = 29
	Gui.ZAHL_AUSWAHL_FRAME_5.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ZAHL_AUSWAHL_FRAME_5.TextStrokeTransparency = 1
	Gui.ZAHL_AUSWAHL_FRAME_5.TextTransparency = 0
	Gui.ZAHL_AUSWAHL_FRAME_5.TextTruncate = Enum.TextTruncate.None
	Gui.ZAHL_AUSWAHL_FRAME_5.TextWrapped = false
	Gui.ZAHL_AUSWAHL_FRAME_5.TextXAlignment = Enum.TextXAlignment.Center
	Gui.ZAHL_AUSWAHL_FRAME_5.TextYAlignment = Enum.TextYAlignment.Top
	Gui.ZAHL_AUSWAHL_FRAME_5.Archivable = true
	Gui.ZAHL_AUSWAHL_FRAME_5.Parent = Gui.AUSWAHL_FRAME_5

	Gui.UITextSizeConstraint_36 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_36.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_36.MaxTextSize = 29
	Gui.UITextSizeConstraint_36.MinTextSize = 1
	Gui.UITextSizeConstraint_36.Archivable = true
	Gui.UITextSizeConstraint_36.Parent = Gui.ZAHL_AUSWAHL_FRAME_5

	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5 = Instance.new("ImageButton")
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Name = "CHOOSE_LEFT_AUSWAHL_FRAME"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Active = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.BackgroundTransparency = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.BorderSizePixel = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ClipsDescendants = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Draggable = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.LayoutOrder = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Position = UDim2.new(0.123, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Rotation = 180
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Selectable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Visible = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ZIndex = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Image = "rbxassetid://129565130776117"
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ImageTransparency = 0
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.SliceScale = 1
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.AutoButtonColor = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Modal = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Selected = false
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.HoverImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.PressedImage = ""
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Archivable = true
	Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5.Parent = Gui.AUSWAHL_FRAME_5

	Gui.UIAspectRatioConstraint_12 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_12.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_12.AspectRatio = 1.084
	Gui.UIAspectRatioConstraint_12.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_12.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_12.Archivable = true
	Gui.UIAspectRatioConstraint_12.Parent = Gui.CHOOSE_LEFT_AUSWAHL_FRAME_5

	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5 = Instance.new("ImageButton")
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Name = "CHOOSE_RIGHT_AUSWAHL_FRAME"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Active = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.AnchorPoint = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.AutomaticSize = Enum.AutomaticSize.X
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.BackgroundTransparency = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.BorderMode = Enum.BorderMode.Outline
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.BorderSizePixel = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ClipsDescendants = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Draggable = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.LayoutOrder = 3
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Position = UDim2.new(0.56, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Rotation = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Selectable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Size = UDim2.new(0.227, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Visible = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ZIndex = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Image = "rbxassetid://73168226958759"
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ImageColor3 = Color3.fromRGB(220, 220, 225)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ImageRectOffset = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ImageRectSize = Vector2.new(0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ImageTransparency = 0
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ResampleMode = Enum.ResamplerMode.Default
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.ScaleType = Enum.ScaleType.Stretch
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.SliceScale = 1
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Style = Enum.ButtonStyle.Custom
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.AutoButtonColor = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Modal = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Selected = false
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.HoverImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.PressedImage = ""
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Archivable = true
	Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5.Parent = Gui.AUSWAHL_FRAME_5

	Gui.UIAspectRatioConstraint_13 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_13.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_13.AspectRatio = 1.085
	Gui.UIAspectRatioConstraint_13.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_13.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_13.Archivable = true
	Gui.UIAspectRatioConstraint_13.Parent = Gui.CHOOSE_RIGHT_AUSWAHL_FRAME_5

	Gui.UIListLayout_21 = Instance.new("UIListLayout")
	Gui.UIListLayout_21.Name = "UIListLayout"
	Gui.UIListLayout_21.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_21.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_21.Padding = UDim.new(0, 0)
	Gui.UIListLayout_21.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_21.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_21.Wraps = false
	Gui.UIListLayout_21.Archivable = true
	Gui.UIListLayout_21.Parent = Gui.AUSWAHL_FRAME_5

	Gui.NOTIFY_EXAMPLE = Instance.new("Frame")
	Gui.NOTIFY_EXAMPLE.Name = "NOTIFY_EXAMPLE"
	Gui.NOTIFY_EXAMPLE.Active = false
	Gui.NOTIFY_EXAMPLE.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.NOTIFY_EXAMPLE.AutomaticSize = Enum.AutomaticSize.X
	Gui.NOTIFY_EXAMPLE.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.NOTIFY_EXAMPLE.BackgroundTransparency = 0
	Gui.NOTIFY_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.NOTIFY_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.NOTIFY_EXAMPLE.BorderSizePixel = 0
	Gui.NOTIFY_EXAMPLE.ClipsDescendants = false
	Gui.NOTIFY_EXAMPLE.Draggable = false
	Gui.NOTIFY_EXAMPLE.LayoutOrder = 0
	Gui.NOTIFY_EXAMPLE.Position = UDim2.new(0.5, 0, 0.102, 0)
	Gui.NOTIFY_EXAMPLE.Rotation = 0
	Gui.NOTIFY_EXAMPLE.Selectable = false
	Gui.NOTIFY_EXAMPLE.Size = UDim2.new(0.03, 0, 0.039, 0)
	Gui.NOTIFY_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.NOTIFY_EXAMPLE.Visible = false
	Gui.NOTIFY_EXAMPLE.ZIndex = 1
	Gui.NOTIFY_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.NOTIFY_EXAMPLE.Archivable = true
	Gui.NOTIFY_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_69 = Instance.new("UICorner")
	Gui.UICorner_69.Name = "UICorner"
	Gui.UICorner_69.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_69.Archivable = true
	Gui.UICorner_69.Parent = Gui.NOTIFY_EXAMPLE

	Gui.NOTIFY_MESSAGE_LABEL = Instance.new("TextLabel")
	Gui.NOTIFY_MESSAGE_LABEL.Name = "NOTIFY_MESSAGE_LABEL"
	Gui.NOTIFY_MESSAGE_LABEL.Active = false
	Gui.NOTIFY_MESSAGE_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.NOTIFY_MESSAGE_LABEL.AutomaticSize = Enum.AutomaticSize.X
	Gui.NOTIFY_MESSAGE_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.NOTIFY_MESSAGE_LABEL.BackgroundTransparency = 1
	Gui.NOTIFY_MESSAGE_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.NOTIFY_MESSAGE_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.NOTIFY_MESSAGE_LABEL.BorderSizePixel = 0
	Gui.NOTIFY_MESSAGE_LABEL.ClipsDescendants = false
	Gui.NOTIFY_MESSAGE_LABEL.Draggable = false
	Gui.NOTIFY_MESSAGE_LABEL.LayoutOrder = 0
	Gui.NOTIFY_MESSAGE_LABEL.Position = UDim2.new(0, 0, 0, 0)
	Gui.NOTIFY_MESSAGE_LABEL.Rotation = 0
	Gui.NOTIFY_MESSAGE_LABEL.Selectable = false
	Gui.NOTIFY_MESSAGE_LABEL.Size = UDim2.new(0, 0, 1, 0)
	Gui.NOTIFY_MESSAGE_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.NOTIFY_MESSAGE_LABEL.Visible = true
	Gui.NOTIFY_MESSAGE_LABEL.ZIndex = 1
	Gui.NOTIFY_MESSAGE_LABEL.Font = Enum.Font.Unknown
	Gui.NOTIFY_MESSAGE_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.NOTIFY_MESSAGE_LABEL.LineHeight = 1
	Gui.NOTIFY_MESSAGE_LABEL.MaxVisibleGraphemes = -1
	Gui.NOTIFY_MESSAGE_LABEL.RichText = false
	Gui.NOTIFY_MESSAGE_LABEL.Text = "Das ist die Test Benachrichtigung!"
	Gui.NOTIFY_MESSAGE_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.NOTIFY_MESSAGE_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.NOTIFY_MESSAGE_LABEL.TextScaled = false
	Gui.NOTIFY_MESSAGE_LABEL.TextSize = 19
	Gui.NOTIFY_MESSAGE_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.NOTIFY_MESSAGE_LABEL.TextStrokeTransparency = 1
	Gui.NOTIFY_MESSAGE_LABEL.TextTransparency = 0
	Gui.NOTIFY_MESSAGE_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.NOTIFY_MESSAGE_LABEL.TextWrapped = false
	Gui.NOTIFY_MESSAGE_LABEL.TextXAlignment = Enum.TextXAlignment.Center
	Gui.NOTIFY_MESSAGE_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.NOTIFY_MESSAGE_LABEL.Archivable = true
	Gui.NOTIFY_MESSAGE_LABEL.Parent = Gui.NOTIFY_EXAMPLE

	Gui.UIStroke = Instance.new("UIStroke")
	Gui.UIStroke.Name = "UIStroke"
	Gui.UIStroke.ZIndex = 1
	Gui.UIStroke.Color = Color3.fromRGB(9, 18, 41)
	Gui.UIStroke.Enabled = true
	Gui.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	Gui.UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	Gui.UIStroke.Thickness = 9
	Gui.UIStroke.Archivable = true
	Gui.UIStroke.Parent = Gui.NOTIFY_EXAMPLE

	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE = Instance.new("Frame")
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Name = "LIST_DROPDOWN_BUTTON_EXAMPLE"
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Active = false
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.BackgroundTransparency = 0
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.ClipsDescendants = false
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Draggable = false
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.LayoutOrder = 0
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Position = UDim2.new(0.025, 0, 0.064, 0)
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Rotation = 0
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Selectable = false
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Size = UDim2.new(1, 0, 0.119, 0)
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Visible = false
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.ZIndex = 1
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Archivable = true
	Gui.LIST_DROPDOWN_BUTTON_EXAMPLE.Parent = Gui.Examples

	Gui.LIST_DROPDOWN_BUTTON_TEXT = Instance.new("TextLabel")
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Name = "LIST_DROPDOWN_BUTTON_TEXT"
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Active = false
	Gui.LIST_DROPDOWN_BUTTON_TEXT.AnchorPoint = Vector2.new(0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_BUTTON_TEXT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.BackgroundTransparency = 1
	Gui.LIST_DROPDOWN_BUTTON_TEXT.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_BUTTON_TEXT.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_BUTTON_TEXT.ClipsDescendants = false
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Draggable = false
	Gui.LIST_DROPDOWN_BUTTON_TEXT.LayoutOrder = 0
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Position = UDim2.new(0, 0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Rotation = 0
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Selectable = false
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Size = UDim2.new(1, 0, 1, 0)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Visible = true
	Gui.LIST_DROPDOWN_BUTTON_TEXT.ZIndex = 1
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Font = Enum.Font.Unknown
	Gui.LIST_DROPDOWN_BUTTON_TEXT.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.LineHeight = 1
	Gui.LIST_DROPDOWN_BUTTON_TEXT.MaxVisibleGraphemes = -1
	Gui.LIST_DROPDOWN_BUTTON_TEXT.RichText = false
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Text = "Beispiel-Text <Username>"
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextDirection = Enum.TextDirection.Auto
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextScaled = true
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextSize = 21
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextStrokeTransparency = 1
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextTransparency = 0
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextTruncate = Enum.TextTruncate.None
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextWrapped = true
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextXAlignment = Enum.TextXAlignment.Center
	Gui.LIST_DROPDOWN_BUTTON_TEXT.TextYAlignment = Enum.TextYAlignment.Center
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Archivable = true
	Gui.LIST_DROPDOWN_BUTTON_TEXT.Parent = Gui.LIST_DROPDOWN_BUTTON_EXAMPLE

	Gui.UITextSizeConstraint_37 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_37.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_37.MaxTextSize = 21
	Gui.UITextSizeConstraint_37.MinTextSize = 1
	Gui.UITextSizeConstraint_37.Archivable = true
	Gui.UITextSizeConstraint_37.Parent = Gui.LIST_DROPDOWN_BUTTON_TEXT

	Gui.UICorner_70 = Instance.new("UICorner")
	Gui.UICorner_70.Name = "UICorner"
	Gui.UICorner_70.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_70.Archivable = true
	Gui.UICorner_70.Parent = Gui.LIST_DROPDOWN_BUTTON_EXAMPLE

	Gui.LIST_DROPDOWN_BUTTON_TRIGGER = Instance.new("TextButton")
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Name = "LIST_DROPDOWN_BUTTON_TRIGGER"
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Active = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.BackgroundTransparency = 1
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.ClipsDescendants = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Draggable = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.LayoutOrder = 0
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Rotation = 0
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Selectable = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Visible = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.ZIndex = 1
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Font = Enum.Font.Unknown
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.LineHeight = 1
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.MaxVisibleGraphemes = -1
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.RichText = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Text = ""
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextScaled = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextSize = 14
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextStrokeTransparency = 1
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextTransparency = 0
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextWrapped = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.AutoButtonColor = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Modal = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Selected = false
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Archivable = true
	Gui.LIST_DROPDOWN_BUTTON_TRIGGER.Parent = Gui.LIST_DROPDOWN_BUTTON_EXAMPLE

	Gui.LIST_DROPDOWN_EXAMPLE = Instance.new("Frame")
	Gui.LIST_DROPDOWN_EXAMPLE.Name = "LIST_DROPDOWN_EXAMPLE"
	Gui.LIST_DROPDOWN_EXAMPLE.Active = false
	Gui.LIST_DROPDOWN_EXAMPLE.AnchorPoint = Vector2.new(0.5, 0)
	Gui.LIST_DROPDOWN_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_EXAMPLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LIST_DROPDOWN_EXAMPLE.BackgroundTransparency = 1
	Gui.LIST_DROPDOWN_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_EXAMPLE.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_EXAMPLE.ClipsDescendants = false
	Gui.LIST_DROPDOWN_EXAMPLE.Draggable = false
	Gui.LIST_DROPDOWN_EXAMPLE.LayoutOrder = 0
	Gui.LIST_DROPDOWN_EXAMPLE.Position = UDim2.new(0, 0, 0.059, 0)
	Gui.LIST_DROPDOWN_EXAMPLE.Rotation = 0
	Gui.LIST_DROPDOWN_EXAMPLE.Selectable = false
	Gui.LIST_DROPDOWN_EXAMPLE.Size = UDim2.new(1, 0, 0.644, 0)
	Gui.LIST_DROPDOWN_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_EXAMPLE.Visible = false
	Gui.LIST_DROPDOWN_EXAMPLE.ZIndex = 1
	Gui.LIST_DROPDOWN_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.LIST_DROPDOWN_EXAMPLE.Archivable = true
	Gui.LIST_DROPDOWN_EXAMPLE.Parent = Gui.Examples

	Gui.LIST_DROPDOWN_MOVING = Instance.new("Frame")
	Gui.LIST_DROPDOWN_MOVING.Name = "LIST_DROPDOWN_MOVING"
	Gui.LIST_DROPDOWN_MOVING.Active = false
	Gui.LIST_DROPDOWN_MOVING.AnchorPoint = Vector2.new(0, 0)
	Gui.LIST_DROPDOWN_MOVING.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_MOVING.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.LIST_DROPDOWN_MOVING.BackgroundTransparency = 0
	Gui.LIST_DROPDOWN_MOVING.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_MOVING.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_MOVING.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_MOVING.ClipsDescendants = false
	Gui.LIST_DROPDOWN_MOVING.Draggable = false
	Gui.LIST_DROPDOWN_MOVING.LayoutOrder = 0
	Gui.LIST_DROPDOWN_MOVING.Position = UDim2.new(0.492, 0, -0.11, 0)
	Gui.LIST_DROPDOWN_MOVING.Rotation = 0
	Gui.LIST_DROPDOWN_MOVING.Selectable = false
	Gui.LIST_DROPDOWN_MOVING.Size = UDim2.new(0.508, 0, 1.11, 0)
	Gui.LIST_DROPDOWN_MOVING.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_MOVING.Visible = true
	Gui.LIST_DROPDOWN_MOVING.ZIndex = 1
	Gui.LIST_DROPDOWN_MOVING.Style = Enum.FrameStyle.Custom
	Gui.LIST_DROPDOWN_MOVING.Archivable = true
	Gui.LIST_DROPDOWN_MOVING.Parent = Gui.LIST_DROPDOWN_EXAMPLE

	Gui.UICorner_71 = Instance.new("UICorner")
	Gui.UICorner_71.Name = "UICorner"
	Gui.UICorner_71.CornerRadius = UDim.new(0.025, 0)
	Gui.UICorner_71.Archivable = true
	Gui.UICorner_71.Parent = Gui.LIST_DROPDOWN_MOVING

	Gui.LIST_DROPDOWN_BUTTONCONTAINER = Instance.new("ScrollingFrame")
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Name = "LIST_DROPDOWN_BUTTONCONTAINER"
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Active = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BackgroundTransparency = 1
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BorderSizePixel = 0
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ClipsDescendants = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Draggable = false
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.LayoutOrder = 0
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Position = UDim2.new(0.5, 0, 0.539, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Rotation = 0
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Selectable = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Size = UDim2.new(0.906, 0, 0.862, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Visible = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ZIndex = 3
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.CanvasPosition = Vector2.new(0, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.CanvasSize = UDim2.new(0, 0, 2, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ScrollBarImageTransparency = 0
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ScrollBarThickness = 0
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ScrollingDirection = Enum.ScrollingDirection.XY
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.ScrollingEnabled = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Archivable = true
	Gui.LIST_DROPDOWN_BUTTONCONTAINER.Parent = Gui.LIST_DROPDOWN_MOVING

	Gui.UIListLayout_22 = Instance.new("UIListLayout")
	Gui.UIListLayout_22.Name = "UIListLayout"
	Gui.UIListLayout_22.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_22.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Gui.UIListLayout_22.Padding = UDim.new(0.03, 0)
	Gui.UIListLayout_22.SortOrder = Enum.SortOrder.Name
	Gui.UIListLayout_22.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_22.Wraps = false
	Gui.UIListLayout_22.Archivable = true
	Gui.UIListLayout_22.Parent = Gui.LIST_DROPDOWN_BUTTONCONTAINER

	Gui.LIST_EXAMPLE = Instance.new("Frame")
	Gui.LIST_EXAMPLE.Name = "LIST_EXAMPLE"
	Gui.LIST_EXAMPLE.Active = false
	Gui.LIST_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.LIST_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.LIST_EXAMPLE.BackgroundTransparency = 0
	Gui.LIST_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_EXAMPLE.BorderSizePixel = 0
	Gui.LIST_EXAMPLE.ClipsDescendants = false
	Gui.LIST_EXAMPLE.Draggable = false
	Gui.LIST_EXAMPLE.LayoutOrder = 0
	Gui.LIST_EXAMPLE.Position = UDim2.new(0.009, 0, 0.008, 0)
	Gui.LIST_EXAMPLE.Rotation = 0
	Gui.LIST_EXAMPLE.Selectable = false
	Gui.LIST_EXAMPLE.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.LIST_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_EXAMPLE.Visible = false
	Gui.LIST_EXAMPLE.ZIndex = 3
	Gui.LIST_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.LIST_EXAMPLE.Archivable = true
	Gui.LIST_EXAMPLE.Parent = Gui.Examples

	Gui.MainLabel_12 = Instance.new("TextLabel")
	Gui.MainLabel_12.Name = "MainLabel"
	Gui.MainLabel_12.Active = false
	Gui.MainLabel_12.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_12.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_12.BackgroundTransparency = 1
	Gui.MainLabel_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_12.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_12.BorderSizePixel = 0
	Gui.MainLabel_12.ClipsDescendants = false
	Gui.MainLabel_12.Draggable = false
	Gui.MainLabel_12.LayoutOrder = 0
	Gui.MainLabel_12.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_12.Rotation = 0
	Gui.MainLabel_12.Selectable = false
	Gui.MainLabel_12.Size = UDim2.new(0.815, 0, 0.479, 0)
	Gui.MainLabel_12.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_12.Visible = true
	Gui.MainLabel_12.ZIndex = 1
	Gui.MainLabel_12.Font = Enum.Font.Unknown
	Gui.MainLabel_12.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_12.LineHeight = 1
	Gui.MainLabel_12.MaxVisibleGraphemes = -1
	Gui.MainLabel_12.RichText = false
	Gui.MainLabel_12.Text = "Das ist der Name der Auswahl"
	Gui.MainLabel_12.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_12.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_12.TextScaled = true
	Gui.MainLabel_12.TextSize = 23
	Gui.MainLabel_12.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_12.TextStrokeTransparency = 1
	Gui.MainLabel_12.TextTransparency = 0
	Gui.MainLabel_12.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_12.TextWrapped = true
	Gui.MainLabel_12.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_12.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_12.Archivable = true
	Gui.MainLabel_12.Parent = Gui.LIST_EXAMPLE

	Gui.UITextSizeConstraint_38 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_38.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_38.MaxTextSize = 23
	Gui.UITextSizeConstraint_38.MinTextSize = 1
	Gui.UITextSizeConstraint_38.Archivable = true
	Gui.UITextSizeConstraint_38.Parent = Gui.MainLabel_12

	Gui.Description_8 = Instance.new("TextLabel")
	Gui.Description_8.Name = "Description"
	Gui.Description_8.Active = false
	Gui.Description_8.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_8.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_8.BackgroundTransparency = 1
	Gui.Description_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_8.BorderMode = Enum.BorderMode.Outline
	Gui.Description_8.BorderSizePixel = 0
	Gui.Description_8.ClipsDescendants = false
	Gui.Description_8.Draggable = false
	Gui.Description_8.LayoutOrder = 0
	Gui.Description_8.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_8.Rotation = 0
	Gui.Description_8.Selectable = false
	Gui.Description_8.Size = UDim2.new(0.813, 0, 0.479, 0)
	Gui.Description_8.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_8.Visible = true
	Gui.Description_8.ZIndex = 1
	Gui.Description_8.Font = Enum.Font.Unknown
	Gui.Description_8.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_8.LineHeight = 1
	Gui.Description_8.MaxVisibleGraphemes = -1
	Gui.Description_8.RichText = false
	Gui.Description_8.Text = "Das ist die Beschreibung der Auswahl"
	Gui.Description_8.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description_8.TextDirection = Enum.TextDirection.Auto
	Gui.Description_8.TextScaled = true
	Gui.Description_8.TextSize = 17
	Gui.Description_8.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_8.TextStrokeTransparency = 1
	Gui.Description_8.TextTransparency = 0
	Gui.Description_8.TextTruncate = Enum.TextTruncate.None
	Gui.Description_8.TextWrapped = true
	Gui.Description_8.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_8.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_8.Archivable = true
	Gui.Description_8.Parent = Gui.LIST_EXAMPLE

	Gui.UITextSizeConstraint_39 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_39.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_39.MaxTextSize = 17
	Gui.UITextSizeConstraint_39.MinTextSize = 1
	Gui.UITextSizeConstraint_39.Archivable = true
	Gui.UITextSizeConstraint_39.Parent = Gui.Description_8

	Gui.ADDITIONS_FRAME_6 = Instance.new("Frame")
	Gui.ADDITIONS_FRAME_6.Name = "ADDITIONS_FRAME"
	Gui.ADDITIONS_FRAME_6.Active = false
	Gui.ADDITIONS_FRAME_6.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.ADDITIONS_FRAME_6.AutomaticSize = Enum.AutomaticSize.None
	Gui.ADDITIONS_FRAME_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.ADDITIONS_FRAME_6.BackgroundTransparency = 1
	Gui.ADDITIONS_FRAME_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ADDITIONS_FRAME_6.BorderMode = Enum.BorderMode.Outline
	Gui.ADDITIONS_FRAME_6.BorderSizePixel = 0
	Gui.ADDITIONS_FRAME_6.ClipsDescendants = false
	Gui.ADDITIONS_FRAME_6.Draggable = false
	Gui.ADDITIONS_FRAME_6.LayoutOrder = 0
	Gui.ADDITIONS_FRAME_6.Position = UDim2.new(0.744, 0, 0.481, 0)
	Gui.ADDITIONS_FRAME_6.Rotation = 0
	Gui.ADDITIONS_FRAME_6.Selectable = false
	Gui.ADDITIONS_FRAME_6.Size = UDim2.new(0.465, 0, 0.747, 0)
	Gui.ADDITIONS_FRAME_6.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ADDITIONS_FRAME_6.Visible = true
	Gui.ADDITIONS_FRAME_6.ZIndex = 1
	Gui.ADDITIONS_FRAME_6.Style = Enum.FrameStyle.Custom
	Gui.ADDITIONS_FRAME_6.Archivable = true
	Gui.ADDITIONS_FRAME_6.Parent = Gui.LIST_EXAMPLE

	Gui.LIST_FRAME = Instance.new("Frame")
	Gui.LIST_FRAME.Name = "LIST_FRAME"
	Gui.LIST_FRAME.Active = false
	Gui.LIST_FRAME.AnchorPoint = Vector2.new(1, 0)
	Gui.LIST_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.LIST_FRAME.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.LIST_FRAME.BackgroundTransparency = 0
	Gui.LIST_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_FRAME.BorderSizePixel = 0
	Gui.LIST_FRAME.ClipsDescendants = false
	Gui.LIST_FRAME.Draggable = false
	Gui.LIST_FRAME.LayoutOrder = 1
	Gui.LIST_FRAME.Position = UDim2.new(1, 0, 0, 0)
	Gui.LIST_FRAME.Rotation = 0
	Gui.LIST_FRAME.Selectable = false
	Gui.LIST_FRAME.Size = UDim2.new(1, 0, 1, 0)
	Gui.LIST_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_FRAME.Visible = true
	Gui.LIST_FRAME.ZIndex = 1
	Gui.LIST_FRAME.Style = Enum.FrameStyle.Custom
	Gui.LIST_FRAME.Archivable = true
	Gui.LIST_FRAME.Parent = Gui.ADDITIONS_FRAME_6

	Gui.LIST_FRAME_CURRENT = Instance.new("TextLabel")
	Gui.LIST_FRAME_CURRENT.Name = "LIST_FRAME_CURRENT"
	Gui.LIST_FRAME_CURRENT.Active = false
	Gui.LIST_FRAME_CURRENT.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LIST_FRAME_CURRENT.AutomaticSize = Enum.AutomaticSize.X
	Gui.LIST_FRAME_CURRENT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LIST_FRAME_CURRENT.BackgroundTransparency = 1
	Gui.LIST_FRAME_CURRENT.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME_CURRENT.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_FRAME_CURRENT.BorderSizePixel = 0
	Gui.LIST_FRAME_CURRENT.ClipsDescendants = false
	Gui.LIST_FRAME_CURRENT.Draggable = false
	Gui.LIST_FRAME_CURRENT.LayoutOrder = 2
	Gui.LIST_FRAME_CURRENT.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.LIST_FRAME_CURRENT.Rotation = 0
	Gui.LIST_FRAME_CURRENT.Selectable = false
	Gui.LIST_FRAME_CURRENT.Size = UDim2.new(0, 0, 1, 0)
	Gui.LIST_FRAME_CURRENT.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_FRAME_CURRENT.Visible = true
	Gui.LIST_FRAME_CURRENT.ZIndex = 1
	Gui.LIST_FRAME_CURRENT.Font = Enum.Font.Unknown
	Gui.LIST_FRAME_CURRENT.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.LIST_FRAME_CURRENT.LineHeight = 1
	Gui.LIST_FRAME_CURRENT.MaxVisibleGraphemes = -1
	Gui.LIST_FRAME_CURRENT.RichText = false
	Gui.LIST_FRAME_CURRENT.Text = "Freelancer2011"
	Gui.LIST_FRAME_CURRENT.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.LIST_FRAME_CURRENT.TextDirection = Enum.TextDirection.Auto
	Gui.LIST_FRAME_CURRENT.TextScaled = false
	Gui.LIST_FRAME_CURRENT.TextSize = 29
	Gui.LIST_FRAME_CURRENT.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME_CURRENT.TextStrokeTransparency = 1
	Gui.LIST_FRAME_CURRENT.TextTransparency = 0
	Gui.LIST_FRAME_CURRENT.TextTruncate = Enum.TextTruncate.None
	Gui.LIST_FRAME_CURRENT.TextWrapped = false
	Gui.LIST_FRAME_CURRENT.TextXAlignment = Enum.TextXAlignment.Center
	Gui.LIST_FRAME_CURRENT.TextYAlignment = Enum.TextYAlignment.Top
	Gui.LIST_FRAME_CURRENT.Archivable = true
	Gui.LIST_FRAME_CURRENT.Parent = Gui.LIST_FRAME

	Gui.UITextSizeConstraint_40 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_40.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_40.MaxTextSize = 29
	Gui.UITextSizeConstraint_40.MinTextSize = 1
	Gui.UITextSizeConstraint_40.Archivable = true
	Gui.UITextSizeConstraint_40.Parent = Gui.LIST_FRAME_CURRENT

	Gui.LIST_FRAME_TRIGGER = Instance.new("TextButton")
	Gui.LIST_FRAME_TRIGGER.Name = "LIST_FRAME_TRIGGER"
	Gui.LIST_FRAME_TRIGGER.Active = true
	Gui.LIST_FRAME_TRIGGER.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LIST_FRAME_TRIGGER.AutomaticSize = Enum.AutomaticSize.None
	Gui.LIST_FRAME_TRIGGER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LIST_FRAME_TRIGGER.BackgroundTransparency = 1
	Gui.LIST_FRAME_TRIGGER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME_TRIGGER.BorderMode = Enum.BorderMode.Outline
	Gui.LIST_FRAME_TRIGGER.BorderSizePixel = 0
	Gui.LIST_FRAME_TRIGGER.ClipsDescendants = false
	Gui.LIST_FRAME_TRIGGER.Draggable = false
	Gui.LIST_FRAME_TRIGGER.LayoutOrder = 0
	Gui.LIST_FRAME_TRIGGER.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.LIST_FRAME_TRIGGER.Rotation = 0
	Gui.LIST_FRAME_TRIGGER.Selectable = true
	Gui.LIST_FRAME_TRIGGER.Size = UDim2.new(1, 0, 1, 0)
	Gui.LIST_FRAME_TRIGGER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LIST_FRAME_TRIGGER.Visible = true
	Gui.LIST_FRAME_TRIGGER.ZIndex = 1
	Gui.LIST_FRAME_TRIGGER.Font = Enum.Font.Unknown
	Gui.LIST_FRAME_TRIGGER.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.LIST_FRAME_TRIGGER.LineHeight = 1
	Gui.LIST_FRAME_TRIGGER.MaxVisibleGraphemes = -1
	Gui.LIST_FRAME_TRIGGER.RichText = false
	Gui.LIST_FRAME_TRIGGER.Text = ""
	Gui.LIST_FRAME_TRIGGER.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME_TRIGGER.TextDirection = Enum.TextDirection.Auto
	Gui.LIST_FRAME_TRIGGER.TextScaled = true
	Gui.LIST_FRAME_TRIGGER.TextSize = 14
	Gui.LIST_FRAME_TRIGGER.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LIST_FRAME_TRIGGER.TextStrokeTransparency = 1
	Gui.LIST_FRAME_TRIGGER.TextTransparency = 0
	Gui.LIST_FRAME_TRIGGER.TextTruncate = Enum.TextTruncate.None
	Gui.LIST_FRAME_TRIGGER.TextWrapped = true
	Gui.LIST_FRAME_TRIGGER.TextXAlignment = Enum.TextXAlignment.Center
	Gui.LIST_FRAME_TRIGGER.TextYAlignment = Enum.TextYAlignment.Center
	Gui.LIST_FRAME_TRIGGER.Style = Enum.ButtonStyle.Custom
	Gui.LIST_FRAME_TRIGGER.AutoButtonColor = true
	Gui.LIST_FRAME_TRIGGER.Modal = false
	Gui.LIST_FRAME_TRIGGER.Selected = false
	Gui.LIST_FRAME_TRIGGER.Archivable = true
	Gui.LIST_FRAME_TRIGGER.Parent = Gui.LIST_FRAME

	Gui.UICorner_72 = Instance.new("UICorner")
	Gui.UICorner_72.Name = "UICorner"
	Gui.UICorner_72.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_72.Archivable = true
	Gui.UICorner_72.Parent = Gui.LIST_FRAME

	Gui.FUNCTION_NAME_13 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_13.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_13.Archivable = true
	Gui.FUNCTION_NAME_13.Parent = Gui.LIST_EXAMPLE

	Gui.UICorner_73 = Instance.new("UICorner")
	Gui.UICorner_73.Name = "UICorner"
	Gui.UICorner_73.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_73.Archivable = true
	Gui.UICorner_73.Parent = Gui.LIST_EXAMPLE

	Gui.KEYBIND_EXAMPLE = Instance.new("Frame")
	Gui.KEYBIND_EXAMPLE.Name = "KEYBIND_EXAMPLE"
	Gui.KEYBIND_EXAMPLE.Active = false
	Gui.KEYBIND_EXAMPLE.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_EXAMPLE.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEYBIND_EXAMPLE.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Gui.KEYBIND_EXAMPLE.BackgroundTransparency = 0
	Gui.KEYBIND_EXAMPLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_EXAMPLE.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_EXAMPLE.BorderSizePixel = 0
	Gui.KEYBIND_EXAMPLE.ClipsDescendants = false
	Gui.KEYBIND_EXAMPLE.Draggable = false
	Gui.KEYBIND_EXAMPLE.LayoutOrder = 0
	Gui.KEYBIND_EXAMPLE.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_EXAMPLE.Rotation = 0
	Gui.KEYBIND_EXAMPLE.Selectable = false
	Gui.KEYBIND_EXAMPLE.Size = UDim2.new(1, 0, 0.097, 0)
	Gui.KEYBIND_EXAMPLE.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_EXAMPLE.Visible = false
	Gui.KEYBIND_EXAMPLE.ZIndex = 3
	Gui.KEYBIND_EXAMPLE.Style = Enum.FrameStyle.Custom
	Gui.KEYBIND_EXAMPLE.Archivable = true
	Gui.KEYBIND_EXAMPLE.Parent = Gui.Examples

	Gui.UICorner_74 = Instance.new("UICorner")
	Gui.UICorner_74.Name = "UICorner"
	Gui.UICorner_74.CornerRadius = UDim.new(0.15, 0)
	Gui.UICorner_74.Archivable = true
	Gui.UICorner_74.Parent = Gui.KEYBIND_EXAMPLE

	Gui.FUNCTION_NAME_14 = Instance.new("StringValue")
	Gui.FUNCTION_NAME_14.Name = "FUNCTION_NAME"
	Gui.FUNCTION_NAME_14.Archivable = true
	Gui.FUNCTION_NAME_14.Parent = Gui.KEYBIND_EXAMPLE

	Gui.MainLabel_13 = Instance.new("TextLabel")
	Gui.MainLabel_13.Name = "MainLabel"
	Gui.MainLabel_13.Active = false
	Gui.MainLabel_13.AnchorPoint = Vector2.new(0, 0)
	Gui.MainLabel_13.AutomaticSize = Enum.AutomaticSize.None
	Gui.MainLabel_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.MainLabel_13.BackgroundTransparency = 1
	Gui.MainLabel_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_13.BorderMode = Enum.BorderMode.Outline
	Gui.MainLabel_13.BorderSizePixel = 0
	Gui.MainLabel_13.ClipsDescendants = false
	Gui.MainLabel_13.Draggable = false
	Gui.MainLabel_13.LayoutOrder = 0
	Gui.MainLabel_13.Position = UDim2.new(0.011, 0, 0, 0)
	Gui.MainLabel_13.Rotation = 0
	Gui.MainLabel_13.Selectable = false
	Gui.MainLabel_13.Size = UDim2.new(0.468, 0, 0.479, 0)
	Gui.MainLabel_13.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.MainLabel_13.Visible = true
	Gui.MainLabel_13.ZIndex = 1
	Gui.MainLabel_13.Font = Enum.Font.Unknown
	Gui.MainLabel_13.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.MainLabel_13.LineHeight = 1
	Gui.MainLabel_13.MaxVisibleGraphemes = -1
	Gui.MainLabel_13.RichText = false
	Gui.MainLabel_13.Text = "Das ist der Name des Keybinds"
	Gui.MainLabel_13.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.MainLabel_13.TextDirection = Enum.TextDirection.Auto
	Gui.MainLabel_13.TextScaled = true
	Gui.MainLabel_13.TextSize = 23
	Gui.MainLabel_13.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.MainLabel_13.TextStrokeTransparency = 1
	Gui.MainLabel_13.TextTransparency = 0
	Gui.MainLabel_13.TextTruncate = Enum.TextTruncate.None
	Gui.MainLabel_13.TextWrapped = true
	Gui.MainLabel_13.TextXAlignment = Enum.TextXAlignment.Left
	Gui.MainLabel_13.TextYAlignment = Enum.TextYAlignment.Center
	Gui.MainLabel_13.Archivable = true
	Gui.MainLabel_13.Parent = Gui.KEYBIND_EXAMPLE

	Gui.UITextSizeConstraint_41 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_41.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_41.MaxTextSize = 23
	Gui.UITextSizeConstraint_41.MinTextSize = 1
	Gui.UITextSizeConstraint_41.Archivable = true
	Gui.UITextSizeConstraint_41.Parent = Gui.MainLabel_13

	Gui.Description_9 = Instance.new("TextLabel")
	Gui.Description_9.Name = "Description"
	Gui.Description_9.Active = false
	Gui.Description_9.AnchorPoint = Vector2.new(0, 0)
	Gui.Description_9.AutomaticSize = Enum.AutomaticSize.None
	Gui.Description_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Description_9.BackgroundTransparency = 1
	Gui.Description_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_9.BorderMode = Enum.BorderMode.Outline
	Gui.Description_9.BorderSizePixel = 0
	Gui.Description_9.ClipsDescendants = false
	Gui.Description_9.Draggable = false
	Gui.Description_9.LayoutOrder = 0
	Gui.Description_9.Position = UDim2.new(0.013, 0, 0.471, 0)
	Gui.Description_9.Rotation = 0
	Gui.Description_9.Selectable = false
	Gui.Description_9.Size = UDim2.new(0.466, 0, 0.479, 0)
	Gui.Description_9.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Description_9.Visible = true
	Gui.Description_9.ZIndex = 1
	Gui.Description_9.Font = Enum.Font.Unknown
	Gui.Description_9.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.Description_9.LineHeight = 1
	Gui.Description_9.MaxVisibleGraphemes = -1
	Gui.Description_9.RichText = false
	Gui.Description_9.Text = "Das ist die Beschreibung des Keybinds"
	Gui.Description_9.TextColor3 = Color3.fromRGB(38, 38, 45)
	Gui.Description_9.TextDirection = Enum.TextDirection.Auto
	Gui.Description_9.TextScaled = true
	Gui.Description_9.TextSize = 17
	Gui.Description_9.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Description_9.TextStrokeTransparency = 1
	Gui.Description_9.TextTransparency = 0
	Gui.Description_9.TextTruncate = Enum.TextTruncate.None
	Gui.Description_9.TextWrapped = true
	Gui.Description_9.TextXAlignment = Enum.TextXAlignment.Left
	Gui.Description_9.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Description_9.Archivable = true
	Gui.Description_9.Parent = Gui.KEYBIND_EXAMPLE

	Gui.UITextSizeConstraint_42 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_42.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_42.MaxTextSize = 17
	Gui.UITextSizeConstraint_42.MinTextSize = 1
	Gui.UITextSizeConstraint_42.Archivable = true
	Gui.UITextSizeConstraint_42.Parent = Gui.Description_9

	Gui.KEEPING_FRAME_1 = Instance.new("Frame")
	Gui.KEEPING_FRAME_1.Name = "KEEPING_FRAME"
	Gui.KEEPING_FRAME_1.Active = false
	Gui.KEEPING_FRAME_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.KEEPING_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEEPING_FRAME_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEEPING_FRAME_1.BackgroundTransparency = 1
	Gui.KEEPING_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEEPING_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.KEEPING_FRAME_1.BorderSizePixel = 0
	Gui.KEEPING_FRAME_1.ClipsDescendants = false
	Gui.KEEPING_FRAME_1.Draggable = false
	Gui.KEEPING_FRAME_1.LayoutOrder = 0
	Gui.KEEPING_FRAME_1.Position = UDim2.new(0.735, 0, 0.481, 0)
	Gui.KEEPING_FRAME_1.Rotation = 0
	Gui.KEEPING_FRAME_1.Selectable = false
	Gui.KEEPING_FRAME_1.Size = UDim2.new(0.502, 0, 0.747, 0)
	Gui.KEEPING_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEEPING_FRAME_1.Visible = true
	Gui.KEEPING_FRAME_1.ZIndex = 1
	Gui.KEEPING_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.KEEPING_FRAME_1.Archivable = true
	Gui.KEEPING_FRAME_1.Parent = Gui.KEYBIND_EXAMPLE

	Gui.UIListLayout_23 = Instance.new("UIListLayout")
	Gui.UIListLayout_23.Name = "UIListLayout"
	Gui.UIListLayout_23.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_23.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Gui.UIListLayout_23.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_23.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_23.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_23.Wraps = false
	Gui.UIListLayout_23.Archivable = true
	Gui.UIListLayout_23.Parent = Gui.KEEPING_FRAME_1

	Gui.KEYBIND_MAIN_FRAME = Instance.new("Frame")
	Gui.KEYBIND_MAIN_FRAME.Name = "KEYBIND_MAIN_FRAME"
	Gui.KEYBIND_MAIN_FRAME.Active = false
	Gui.KEYBIND_MAIN_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.KEYBIND_MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_MAIN_FRAME.BackgroundTransparency = 1
	Gui.KEYBIND_MAIN_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_MAIN_FRAME.BorderSizePixel = 0
	Gui.KEYBIND_MAIN_FRAME.ClipsDescendants = false
	Gui.KEYBIND_MAIN_FRAME.Draggable = false
	Gui.KEYBIND_MAIN_FRAME.LayoutOrder = 2
	Gui.KEYBIND_MAIN_FRAME.Position = UDim2.new(0.635, 0, 0, 0)
	Gui.KEYBIND_MAIN_FRAME.Rotation = 0
	Gui.KEYBIND_MAIN_FRAME.Selectable = false
	Gui.KEYBIND_MAIN_FRAME.Size = UDim2.new(0, 0, 1.008, 0)
	Gui.KEYBIND_MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_MAIN_FRAME.Visible = true
	Gui.KEYBIND_MAIN_FRAME.ZIndex = 1
	Gui.KEYBIND_MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.KEYBIND_MAIN_FRAME.Archivable = true
	Gui.KEYBIND_MAIN_FRAME.Parent = Gui.KEEPING_FRAME_1

	Gui.KEYBIND_FRAME_1 = Instance.new("Frame")
	Gui.KEYBIND_FRAME_1.Name = "KEYBIND_FRAME"
	Gui.KEYBIND_FRAME_1.Active = false
	Gui.KEYBIND_FRAME_1.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_FRAME_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEYBIND_FRAME_1.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Gui.KEYBIND_FRAME_1.BackgroundTransparency = 0
	Gui.KEYBIND_FRAME_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_FRAME_1.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_FRAME_1.BorderSizePixel = 0
	Gui.KEYBIND_FRAME_1.ClipsDescendants = false
	Gui.KEYBIND_FRAME_1.Draggable = false
	Gui.KEYBIND_FRAME_1.LayoutOrder = 0
	Gui.KEYBIND_FRAME_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_FRAME_1.Rotation = 0
	Gui.KEYBIND_FRAME_1.Selectable = false
	Gui.KEYBIND_FRAME_1.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_FRAME_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_FRAME_1.Visible = true
	Gui.KEYBIND_FRAME_1.ZIndex = 1
	Gui.KEYBIND_FRAME_1.Style = Enum.FrameStyle.Custom
	Gui.KEYBIND_FRAME_1.Archivable = true
	Gui.KEYBIND_FRAME_1.Parent = Gui.KEYBIND_MAIN_FRAME

	Gui.UICorner_75 = Instance.new("UICorner")
	Gui.UICorner_75.Name = "UICorner"
	Gui.UICorner_75.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_75.Archivable = true
	Gui.UICorner_75.Parent = Gui.KEYBIND_FRAME_1

	Gui.KEYBIND_TEXTLABEL = Instance.new("TextLabel")
	Gui.KEYBIND_TEXTLABEL.Name = "KEYBIND_TEXTLABEL"
	Gui.KEYBIND_TEXTLABEL.Active = false
	Gui.KEYBIND_TEXTLABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TEXTLABEL.AutomaticSize = Enum.AutomaticSize.X
	Gui.KEYBIND_TEXTLABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TEXTLABEL.BackgroundTransparency = 1
	Gui.KEYBIND_TEXTLABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TEXTLABEL.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TEXTLABEL.BorderSizePixel = 0
	Gui.KEYBIND_TEXTLABEL.ClipsDescendants = false
	Gui.KEYBIND_TEXTLABEL.Draggable = false
	Gui.KEYBIND_TEXTLABEL.LayoutOrder = 0
	Gui.KEYBIND_TEXTLABEL.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TEXTLABEL.Rotation = 0
	Gui.KEYBIND_TEXTLABEL.Selectable = false
	Gui.KEYBIND_TEXTLABEL.Size = UDim2.new(0, 0, 1, 0)
	Gui.KEYBIND_TEXTLABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TEXTLABEL.Visible = true
	Gui.KEYBIND_TEXTLABEL.ZIndex = 1
	Gui.KEYBIND_TEXTLABEL.Font = Enum.Font.Unknown
	Gui.KEYBIND_TEXTLABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TEXTLABEL.LineHeight = 1
	Gui.KEYBIND_TEXTLABEL.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TEXTLABEL.RichText = false
	Gui.KEYBIND_TEXTLABEL.Text = " Kein Keybind gesetzt "
	Gui.KEYBIND_TEXTLABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.KEYBIND_TEXTLABEL.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TEXTLABEL.TextScaled = false
	Gui.KEYBIND_TEXTLABEL.TextSize = 24
	Gui.KEYBIND_TEXTLABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TEXTLABEL.TextStrokeTransparency = 1
	Gui.KEYBIND_TEXTLABEL.TextTransparency = 0
	Gui.KEYBIND_TEXTLABEL.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TEXTLABEL.TextWrapped = false
	Gui.KEYBIND_TEXTLABEL.TextXAlignment = Enum.TextXAlignment.Center
	Gui.KEYBIND_TEXTLABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TEXTLABEL.Archivable = true
	Gui.KEYBIND_TEXTLABEL.Parent = Gui.KEYBIND_FRAME_1

	Gui.UITextSizeConstraint_43 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_43.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_43.MaxTextSize = 24
	Gui.UITextSizeConstraint_43.MinTextSize = 1
	Gui.UITextSizeConstraint_43.Archivable = true
	Gui.UITextSizeConstraint_43.Parent = Gui.KEYBIND_TEXTLABEL

	Gui.KEYBIND_TRIGGER_3 = Instance.new("TextButton")
	Gui.KEYBIND_TRIGGER_3.Name = "KEYBIND_TRIGGER"
	Gui.KEYBIND_TRIGGER_3.Active = true
	Gui.KEYBIND_TRIGGER_3.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TRIGGER_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.KEYBIND_TRIGGER_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TRIGGER_3.BackgroundTransparency = 1
	Gui.KEYBIND_TRIGGER_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_3.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TRIGGER_3.BorderSizePixel = 0
	Gui.KEYBIND_TRIGGER_3.ClipsDescendants = false
	Gui.KEYBIND_TRIGGER_3.Draggable = false
	Gui.KEYBIND_TRIGGER_3.LayoutOrder = 0
	Gui.KEYBIND_TRIGGER_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TRIGGER_3.Rotation = 0
	Gui.KEYBIND_TRIGGER_3.Selectable = true
	Gui.KEYBIND_TRIGGER_3.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_TRIGGER_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TRIGGER_3.Visible = true
	Gui.KEYBIND_TRIGGER_3.ZIndex = 1
	Gui.KEYBIND_TRIGGER_3.Font = Enum.Font.Unknown
	Gui.KEYBIND_TRIGGER_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TRIGGER_3.LineHeight = 1
	Gui.KEYBIND_TRIGGER_3.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TRIGGER_3.RichText = false
	Gui.KEYBIND_TRIGGER_3.Text = ""
	Gui.KEYBIND_TRIGGER_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_3.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TRIGGER_3.TextScaled = true
	Gui.KEYBIND_TRIGGER_3.TextSize = 14
	Gui.KEYBIND_TRIGGER_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_3.TextStrokeTransparency = 1
	Gui.KEYBIND_TRIGGER_3.TextTransparency = 0
	Gui.KEYBIND_TRIGGER_3.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TRIGGER_3.TextWrapped = true
	Gui.KEYBIND_TRIGGER_3.TextXAlignment = Enum.TextXAlignment.Center
	Gui.KEYBIND_TRIGGER_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TRIGGER_3.Style = Enum.ButtonStyle.Custom
	Gui.KEYBIND_TRIGGER_3.AutoButtonColor = true
	Gui.KEYBIND_TRIGGER_3.Modal = false
	Gui.KEYBIND_TRIGGER_3.Selected = false
	Gui.KEYBIND_TRIGGER_3.Archivable = true
	Gui.KEYBIND_TRIGGER_3.Parent = Gui.KEYBIND_TEXTLABEL

end

local function BuildGui5()
	Gui.SETTINGS_FRAME_3 = Instance.new("CanvasGroup")
	Gui.SETTINGS_FRAME_3.Name = "SETTINGS_FRAME"
	Gui.SETTINGS_FRAME_3.Active = false
	Gui.SETTINGS_FRAME_3.AnchorPoint = Vector2.new(0, 0)
	Gui.SETTINGS_FRAME_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.SETTINGS_FRAME_3.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.SETTINGS_FRAME_3.BackgroundTransparency = 0
	Gui.SETTINGS_FRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_FRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_FRAME_3.BorderSizePixel = 0
	Gui.SETTINGS_FRAME_3.ClipsDescendants = true
	Gui.SETTINGS_FRAME_3.Draggable = false
	Gui.SETTINGS_FRAME_3.LayoutOrder = 0
	Gui.SETTINGS_FRAME_3.Position = UDim2.new(0.642, 0, 1.025, 0)
	Gui.SETTINGS_FRAME_3.Rotation = 0
	Gui.SETTINGS_FRAME_3.Selectable = false
	Gui.SETTINGS_FRAME_3.Size = UDim2.new(0.237, 0, 0, 0)
	Gui.SETTINGS_FRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_FRAME_3.Visible = true
	Gui.SETTINGS_FRAME_3.ZIndex = 1
	Gui.SETTINGS_FRAME_3.Archivable = true
	Gui.SETTINGS_FRAME_3.Parent = Gui.KEYBIND_EXAMPLE

	Gui.SETTINGS_KEEPINGFRAME_3 = Instance.new("Frame")
	Gui.SETTINGS_KEEPINGFRAME_3.Name = "SETTINGS_KEEPINGFRAME"
	Gui.SETTINGS_KEEPINGFRAME_3.Active = false
	Gui.SETTINGS_KEEPINGFRAME_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.SETTINGS_KEEPINGFRAME_3.AutomaticSize = Enum.AutomaticSize.XY
	Gui.SETTINGS_KEEPINGFRAME_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.SETTINGS_KEEPINGFRAME_3.BackgroundTransparency = 1
	Gui.SETTINGS_KEEPINGFRAME_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.SETTINGS_KEEPINGFRAME_3.BorderMode = Enum.BorderMode.Outline
	Gui.SETTINGS_KEEPINGFRAME_3.BorderSizePixel = 0
	Gui.SETTINGS_KEEPINGFRAME_3.ClipsDescendants = false
	Gui.SETTINGS_KEEPINGFRAME_3.Draggable = false
	Gui.SETTINGS_KEEPINGFRAME_3.LayoutOrder = 0
	Gui.SETTINGS_KEEPINGFRAME_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.SETTINGS_KEEPINGFRAME_3.Rotation = 0
	Gui.SETTINGS_KEEPINGFRAME_3.Selectable = false
	Gui.SETTINGS_KEEPINGFRAME_3.Size = UDim2.new(0.881, 0, 0.881, 0)
	Gui.SETTINGS_KEEPINGFRAME_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.SETTINGS_KEEPINGFRAME_3.Visible = true
	Gui.SETTINGS_KEEPINGFRAME_3.ZIndex = 1
	Gui.SETTINGS_KEEPINGFRAME_3.Style = Enum.FrameStyle.Custom
	Gui.SETTINGS_KEEPINGFRAME_3.Archivable = true
	Gui.SETTINGS_KEEPINGFRAME_3.Parent = Gui.SETTINGS_FRAME_3

	Gui.UIListLayout_24 = Instance.new("UIListLayout")
	Gui.UIListLayout_24.Name = "UIListLayout"
	Gui.UIListLayout_24.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_24.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_24.Padding = UDim.new(0.05, 0)
	Gui.UIListLayout_24.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_24.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_24.Wraps = false
	Gui.UIListLayout_24.Archivable = true
	Gui.UIListLayout_24.Parent = Gui.SETTINGS_KEEPINGFRAME_3

	Gui.KeybindSetting_3 = Instance.new("Frame")
	Gui.KeybindSetting_3.Name = "KeybindSetting"
	Gui.KeybindSetting_3.Active = false
	Gui.KeybindSetting_3.AnchorPoint = Vector2.new(0, 0)
	Gui.KeybindSetting_3.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KeybindSetting_3.BackgroundColor3 = Color3.fromRGB(12, 20, 42)
	Gui.KeybindSetting_3.BackgroundTransparency = 0
	Gui.KeybindSetting_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KeybindSetting_3.BorderMode = Enum.BorderMode.Outline
	Gui.KeybindSetting_3.BorderSizePixel = 0
	Gui.KeybindSetting_3.ClipsDescendants = false
	Gui.KeybindSetting_3.Draggable = false
	Gui.KeybindSetting_3.LayoutOrder = 0
	Gui.KeybindSetting_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.KeybindSetting_3.Rotation = 0
	Gui.KeybindSetting_3.Selectable = false
	Gui.KeybindSetting_3.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.KeybindSetting_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KeybindSetting_3.Visible = true
	Gui.KeybindSetting_3.ZIndex = 1
	Gui.KeybindSetting_3.Style = Enum.FrameStyle.Custom
	Gui.KeybindSetting_3.Archivable = true
	Gui.KeybindSetting_3.Parent = Gui.SETTINGS_KEEPINGFRAME_3

	Gui.KEYBIND_TRIGGER_4 = Instance.new("TextButton")
	Gui.KEYBIND_TRIGGER_4.Name = "KEYBIND_TRIGGER"
	Gui.KEYBIND_TRIGGER_4.Active = true
	Gui.KEYBIND_TRIGGER_4.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_TRIGGER_4.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_TRIGGER_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_TRIGGER_4.BackgroundTransparency = 1
	Gui.KEYBIND_TRIGGER_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_4.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_TRIGGER_4.BorderSizePixel = 0
	Gui.KEYBIND_TRIGGER_4.ClipsDescendants = false
	Gui.KEYBIND_TRIGGER_4.Draggable = false
	Gui.KEYBIND_TRIGGER_4.LayoutOrder = 0
	Gui.KEYBIND_TRIGGER_4.Position = UDim2.new(0, 0, 0, 0)
	Gui.KEYBIND_TRIGGER_4.Rotation = 0
	Gui.KEYBIND_TRIGGER_4.Selectable = true
	Gui.KEYBIND_TRIGGER_4.Size = UDim2.new(1, 0, 1, 0)
	Gui.KEYBIND_TRIGGER_4.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_TRIGGER_4.Visible = true
	Gui.KEYBIND_TRIGGER_4.ZIndex = 600
	Gui.KEYBIND_TRIGGER_4.Font = Enum.Font.Unknown
	Gui.KEYBIND_TRIGGER_4.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_TRIGGER_4.LineHeight = 1
	Gui.KEYBIND_TRIGGER_4.MaxVisibleGraphemes = -1
	Gui.KEYBIND_TRIGGER_4.RichText = false
	Gui.KEYBIND_TRIGGER_4.Text = ""
	Gui.KEYBIND_TRIGGER_4.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_TRIGGER_4.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_TRIGGER_4.TextScaled = false
	Gui.KEYBIND_TRIGGER_4.TextSize = 25
	Gui.KEYBIND_TRIGGER_4.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_TRIGGER_4.TextStrokeTransparency = 1
	Gui.KEYBIND_TRIGGER_4.TextTransparency = 0
	Gui.KEYBIND_TRIGGER_4.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_TRIGGER_4.TextWrapped = true
	Gui.KEYBIND_TRIGGER_4.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_TRIGGER_4.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_TRIGGER_4.Style = Enum.ButtonStyle.Custom
	Gui.KEYBIND_TRIGGER_4.AutoButtonColor = false
	Gui.KEYBIND_TRIGGER_4.Modal = false
	Gui.KEYBIND_TRIGGER_4.Selected = false
	Gui.KEYBIND_TRIGGER_4.Archivable = true
	Gui.KEYBIND_TRIGGER_4.Parent = Gui.KeybindSetting_3

	Gui.UICorner_76 = Instance.new("UICorner")
	Gui.UICorner_76.Name = "UICorner"
	Gui.UICorner_76.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_76.Archivable = true
	Gui.UICorner_76.Parent = Gui.KeybindSetting_3

	Gui.KEYBIND_LABEL_3 = Instance.new("TextLabel")
	Gui.KEYBIND_LABEL_3.Name = "KEYBIND_LABEL"
	Gui.KEYBIND_LABEL_3.Active = false
	Gui.KEYBIND_LABEL_3.AnchorPoint = Vector2.new(0, 0)
	Gui.KEYBIND_LABEL_3.AutomaticSize = Enum.AutomaticSize.XY
	Gui.KEYBIND_LABEL_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.KEYBIND_LABEL_3.BackgroundTransparency = 1
	Gui.KEYBIND_LABEL_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_3.BorderMode = Enum.BorderMode.Outline
	Gui.KEYBIND_LABEL_3.BorderSizePixel = 0
	Gui.KEYBIND_LABEL_3.ClipsDescendants = false
	Gui.KEYBIND_LABEL_3.Draggable = false
	Gui.KEYBIND_LABEL_3.LayoutOrder = 0
	Gui.KEYBIND_LABEL_3.Position = UDim2.new(0.044, 0, 0, 0)
	Gui.KEYBIND_LABEL_3.Rotation = 0
	Gui.KEYBIND_LABEL_3.Selectable = false
	Gui.KEYBIND_LABEL_3.Size = UDim2.new(0.956, 0, 1, 0)
	Gui.KEYBIND_LABEL_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.KEYBIND_LABEL_3.Visible = true
	Gui.KEYBIND_LABEL_3.ZIndex = 5
	Gui.KEYBIND_LABEL_3.Font = Enum.Font.Unknown
	Gui.KEYBIND_LABEL_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.KEYBIND_LABEL_3.LineHeight = 1
	Gui.KEYBIND_LABEL_3.MaxVisibleGraphemes = -1
	Gui.KEYBIND_LABEL_3.RichText = false
	Gui.KEYBIND_LABEL_3.Text = "Keybind: V"
	Gui.KEYBIND_LABEL_3.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.KEYBIND_LABEL_3.TextDirection = Enum.TextDirection.Auto
	Gui.KEYBIND_LABEL_3.TextScaled = true
	Gui.KEYBIND_LABEL_3.TextSize = 25
	Gui.KEYBIND_LABEL_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.KEYBIND_LABEL_3.TextStrokeTransparency = 1
	Gui.KEYBIND_LABEL_3.TextTransparency = 0
	Gui.KEYBIND_LABEL_3.TextTruncate = Enum.TextTruncate.None
	Gui.KEYBIND_LABEL_3.TextWrapped = true
	Gui.KEYBIND_LABEL_3.TextXAlignment = Enum.TextXAlignment.Left
	Gui.KEYBIND_LABEL_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.KEYBIND_LABEL_3.Archivable = true
	Gui.KEYBIND_LABEL_3.Parent = Gui.KeybindSetting_3

	Gui.UITextSizeConstraint_44 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_44.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_44.MaxTextSize = 25
	Gui.UITextSizeConstraint_44.MinTextSize = 1
	Gui.UITextSizeConstraint_44.Archivable = true
	Gui.UITextSizeConstraint_44.Parent = Gui.KEYBIND_LABEL_3

	Gui.ColorSetting_3 = Instance.new("Frame")
	Gui.ColorSetting_3.Name = "ColorSetting"
	Gui.ColorSetting_3.Active = false
	Gui.ColorSetting_3.AnchorPoint = Vector2.new(0, 0)
	Gui.ColorSetting_3.AutomaticSize = Enum.AutomaticSize.XY
	Gui.ColorSetting_3.BackgroundColor3 = Color3.fromRGB(12, 20, 42)
	Gui.ColorSetting_3.BackgroundTransparency = 0
	Gui.ColorSetting_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.ColorSetting_3.BorderMode = Enum.BorderMode.Outline
	Gui.ColorSetting_3.BorderSizePixel = 0
	Gui.ColorSetting_3.ClipsDescendants = false
	Gui.ColorSetting_3.Draggable = false
	Gui.ColorSetting_3.LayoutOrder = 0
	Gui.ColorSetting_3.Position = UDim2.new(0, 0, 0.528, 0)
	Gui.ColorSetting_3.Rotation = 0
	Gui.ColorSetting_3.Selectable = false
	Gui.ColorSetting_3.Size = UDim2.new(1, 0, 0.472, 0)
	Gui.ColorSetting_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.ColorSetting_3.Visible = true
	Gui.ColorSetting_3.ZIndex = 1
	Gui.ColorSetting_3.Style = Enum.FrameStyle.Custom
	Gui.ColorSetting_3.Archivable = true
	Gui.ColorSetting_3.Parent = Gui.SETTINGS_KEEPINGFRAME_3

	Gui.UICorner_77 = Instance.new("UICorner")
	Gui.UICorner_77.Name = "UICorner"
	Gui.UICorner_77.CornerRadius = UDim.new(0.2, 0)
	Gui.UICorner_77.Archivable = true
	Gui.UICorner_77.Parent = Gui.ColorSetting_3

	Gui.COLORPREVIEW_3 = Instance.new("Frame")
	Gui.COLORPREVIEW_3.Name = "COLORPREVIEW"
	Gui.COLORPREVIEW_3.Active = false
	Gui.COLORPREVIEW_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COLORPREVIEW_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLORPREVIEW_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLORPREVIEW_3.BackgroundTransparency = 0
	Gui.COLORPREVIEW_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLORPREVIEW_3.BorderMode = Enum.BorderMode.Outline
	Gui.COLORPREVIEW_3.BorderSizePixel = 0
	Gui.COLORPREVIEW_3.ClipsDescendants = false
	Gui.COLORPREVIEW_3.Draggable = false
	Gui.COLORPREVIEW_3.LayoutOrder = 0
	Gui.COLORPREVIEW_3.Position = UDim2.new(0.141, 0, 0.5, 0)
	Gui.COLORPREVIEW_3.Rotation = 0
	Gui.COLORPREVIEW_3.Selectable = false
	Gui.COLORPREVIEW_3.Size = UDim2.new(0.198, 0, 0.715, 0)
	Gui.COLORPREVIEW_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLORPREVIEW_3.Visible = true
	Gui.COLORPREVIEW_3.ZIndex = 1
	Gui.COLORPREVIEW_3.Style = Enum.FrameStyle.Custom
	Gui.COLORPREVIEW_3.Archivable = true
	Gui.COLORPREVIEW_3.Parent = Gui.ColorSetting_3

	Gui.UICorner_78 = Instance.new("UICorner")
	Gui.UICorner_78.Name = "UICorner"
	Gui.UICorner_78.CornerRadius = UDim.new(0.25, 0)
	Gui.UICorner_78.Archivable = true
	Gui.UICorner_78.Parent = Gui.COLORPREVIEW_3

	Gui.HSV_LABEL_3 = Instance.new("TextLabel")
	Gui.HSV_LABEL_3.Name = "HSV_LABEL"
	Gui.HSV_LABEL_3.Active = false
	Gui.HSV_LABEL_3.AnchorPoint = Vector2.new(0, 0)
	Gui.HSV_LABEL_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.HSV_LABEL_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.HSV_LABEL_3.BackgroundTransparency = 1
	Gui.HSV_LABEL_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_3.BorderMode = Enum.BorderMode.Outline
	Gui.HSV_LABEL_3.BorderSizePixel = 0
	Gui.HSV_LABEL_3.ClipsDescendants = false
	Gui.HSV_LABEL_3.Draggable = false
	Gui.HSV_LABEL_3.LayoutOrder = 0
	Gui.HSV_LABEL_3.Position = UDim2.new(0.336, 0, 0, 0)
	Gui.HSV_LABEL_3.Rotation = 0
	Gui.HSV_LABEL_3.Selectable = false
	Gui.HSV_LABEL_3.Size = UDim2.new(0.62, 0, 1, 0)
	Gui.HSV_LABEL_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.HSV_LABEL_3.Visible = true
	Gui.HSV_LABEL_3.ZIndex = 1
	Gui.HSV_LABEL_3.Font = Enum.Font.Unknown
	Gui.HSV_LABEL_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.HSV_LABEL_3.LineHeight = 1
	Gui.HSV_LABEL_3.MaxVisibleGraphemes = -1
	Gui.HSV_LABEL_3.RichText = false
	Gui.HSV_LABEL_3.Text = "#FFFFFF"
	Gui.HSV_LABEL_3.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.HSV_LABEL_3.TextDirection = Enum.TextDirection.Auto
	Gui.HSV_LABEL_3.TextScaled = false
	Gui.HSV_LABEL_3.TextSize = 25
	Gui.HSV_LABEL_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.HSV_LABEL_3.TextStrokeTransparency = 1
	Gui.HSV_LABEL_3.TextTransparency = 0
	Gui.HSV_LABEL_3.TextTruncate = Enum.TextTruncate.None
	Gui.HSV_LABEL_3.TextWrapped = false
	Gui.HSV_LABEL_3.TextXAlignment = Enum.TextXAlignment.Left
	Gui.HSV_LABEL_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.HSV_LABEL_3.Archivable = true
	Gui.HSV_LABEL_3.Parent = Gui.ColorSetting_3

	Gui.COLOR_TRIGGER_3 = Instance.new("TextButton")
	Gui.COLOR_TRIGGER_3.Name = "COLOR_TRIGGER"
	Gui.COLOR_TRIGGER_3.Active = true
	Gui.COLOR_TRIGGER_3.AnchorPoint = Vector2.new(0, 0)
	Gui.COLOR_TRIGGER_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.COLOR_TRIGGER_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COLOR_TRIGGER_3.BackgroundTransparency = 1
	Gui.COLOR_TRIGGER_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_3.BorderMode = Enum.BorderMode.Outline
	Gui.COLOR_TRIGGER_3.BorderSizePixel = 0
	Gui.COLOR_TRIGGER_3.ClipsDescendants = false
	Gui.COLOR_TRIGGER_3.Draggable = false
	Gui.COLOR_TRIGGER_3.LayoutOrder = 0
	Gui.COLOR_TRIGGER_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.COLOR_TRIGGER_3.Rotation = 0
	Gui.COLOR_TRIGGER_3.Selectable = true
	Gui.COLOR_TRIGGER_3.Size = UDim2.new(1, 0, 1, 0)
	Gui.COLOR_TRIGGER_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COLOR_TRIGGER_3.Visible = true
	Gui.COLOR_TRIGGER_3.ZIndex = 1
	Gui.COLOR_TRIGGER_3.Font = Enum.Font.Unknown
	Gui.COLOR_TRIGGER_3.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COLOR_TRIGGER_3.LineHeight = 1
	Gui.COLOR_TRIGGER_3.MaxVisibleGraphemes = -1
	Gui.COLOR_TRIGGER_3.RichText = false
	Gui.COLOR_TRIGGER_3.Text = ""
	Gui.COLOR_TRIGGER_3.TextColor3 = Color3.fromRGB(200, 216, 240)
	Gui.COLOR_TRIGGER_3.TextDirection = Enum.TextDirection.Auto
	Gui.COLOR_TRIGGER_3.TextScaled = false
	Gui.COLOR_TRIGGER_3.TextSize = 25
	Gui.COLOR_TRIGGER_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COLOR_TRIGGER_3.TextStrokeTransparency = 1
	Gui.COLOR_TRIGGER_3.TextTransparency = 0
	Gui.COLOR_TRIGGER_3.TextTruncate = Enum.TextTruncate.None
	Gui.COLOR_TRIGGER_3.TextWrapped = true
	Gui.COLOR_TRIGGER_3.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COLOR_TRIGGER_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COLOR_TRIGGER_3.Style = Enum.ButtonStyle.Custom
	Gui.COLOR_TRIGGER_3.AutoButtonColor = false
	Gui.COLOR_TRIGGER_3.Modal = false
	Gui.COLOR_TRIGGER_3.Selected = false
	Gui.COLOR_TRIGGER_3.Archivable = true
	Gui.COLOR_TRIGGER_3.Parent = Gui.ColorSetting_3

	Gui.UICorner_79 = Instance.new("UICorner")
	Gui.UICorner_79.Name = "UICorner"
	Gui.UICorner_79.CornerRadius = UDim.new(0.07, 0)
	Gui.UICorner_79.Archivable = true
	Gui.UICorner_79.Parent = Gui.SETTINGS_FRAME_3

	Gui.TextLabel_5 = Instance.new("TextLabel")
	Gui.TextLabel_5.Name = "TextLabel"
	Gui.TextLabel_5.Active = false
	Gui.TextLabel_5.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_5.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_5.BackgroundTransparency = 1
	Gui.TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_5.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_5.BorderSizePixel = 0
	Gui.TextLabel_5.ClipsDescendants = false
	Gui.TextLabel_5.Draggable = false
	Gui.TextLabel_5.LayoutOrder = 0
	Gui.TextLabel_5.Position = UDim2.new(0.976, 0, 0.971, 0)
	Gui.TextLabel_5.Rotation = 0
	Gui.TextLabel_5.Selectable = false
	Gui.TextLabel_5.Size = UDim2.new(0, 56, 0, 50)
	Gui.TextLabel_5.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_5.Visible = true
	Gui.TextLabel_5.ZIndex = 1
	Gui.TextLabel_5.Font = Enum.Font.Unknown
	Gui.TextLabel_5.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_5.LineHeight = 1
	Gui.TextLabel_5.MaxVisibleGraphemes = -1
	Gui.TextLabel_5.RichText = false
	Gui.TextLabel_5.Text = "<UserId>"
	Gui.TextLabel_5.TextColor3 = Color3.fromRGB(233, 233, 233)
	Gui.TextLabel_5.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_5.TextScaled = false
	Gui.TextLabel_5.TextSize = 22
	Gui.TextLabel_5.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_5.TextStrokeTransparency = 1
	Gui.TextLabel_5.TextTransparency = 0.75
	Gui.TextLabel_5.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_5.TextWrapped = false
	Gui.TextLabel_5.TextXAlignment = Enum.TextXAlignment.Right
	Gui.TextLabel_5.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_5.Archivable = true
	Gui.TextLabel_5.Parent = Gui.VexarisGui

	Gui.NOTIFY_FRAME = Instance.new("Frame")
	Gui.NOTIFY_FRAME.Name = "NOTIFY_FRAME"
	Gui.NOTIFY_FRAME.Active = false
	Gui.NOTIFY_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.NOTIFY_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.NOTIFY_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.NOTIFY_FRAME.BackgroundTransparency = 1
	Gui.NOTIFY_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.NOTIFY_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.NOTIFY_FRAME.BorderSizePixel = 0
	Gui.NOTIFY_FRAME.ClipsDescendants = false
	Gui.NOTIFY_FRAME.Draggable = false
	Gui.NOTIFY_FRAME.LayoutOrder = 0
	Gui.NOTIFY_FRAME.Position = UDim2.new(0.5, 0, 0.222, 0)
	Gui.NOTIFY_FRAME.Rotation = 0
	Gui.NOTIFY_FRAME.Selectable = false
	Gui.NOTIFY_FRAME.Size = UDim2.new(0.131, 0, 0.403, 0)
	Gui.NOTIFY_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.NOTIFY_FRAME.Visible = true
	Gui.NOTIFY_FRAME.ZIndex = 1
	Gui.NOTIFY_FRAME.Style = Enum.FrameStyle.Custom
	Gui.NOTIFY_FRAME.Archivable = true
	Gui.NOTIFY_FRAME.Parent = Gui.VexarisGui

	Gui.RADAR_FRAME = Instance.new("Frame")
	Gui.RADAR_FRAME.Name = "RADAR_FRAME"
	Gui.RADAR_FRAME.Active = false
	Gui.RADAR_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.RADAR_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.RADAR_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_FRAME.BackgroundTransparency = 1
	Gui.RADAR_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RADAR_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.RADAR_FRAME.BorderSizePixel = 0
	Gui.RADAR_FRAME.ClipsDescendants = false
	Gui.RADAR_FRAME.Draggable = false
	Gui.RADAR_FRAME.LayoutOrder = 0
	Gui.RADAR_FRAME.Position = UDim2.new(0.89, 0, 0.12, 0)
	Gui.RADAR_FRAME.Rotation = 0
	Gui.RADAR_FRAME.Selectable = false
	Gui.RADAR_FRAME.Size = UDim2.new(0, 264, 0, 264)
	Gui.RADAR_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RADAR_FRAME.Visible = false
	Gui.RADAR_FRAME.ZIndex = 1
	Gui.RADAR_FRAME.Style = Enum.FrameStyle.Custom
	Gui.RADAR_FRAME.Archivable = true
	Gui.RADAR_FRAME.Parent = Gui.VexarisGui

	Gui.RADAR_MAIN_FRAME = Instance.new("Frame")
	Gui.RADAR_MAIN_FRAME.Name = "RADAR_MAIN_FRAME"
	Gui.RADAR_MAIN_FRAME.Active = false
	Gui.RADAR_MAIN_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.RADAR_MAIN_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.RADAR_MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.RADAR_MAIN_FRAME.BackgroundTransparency = 0.1
	Gui.RADAR_MAIN_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RADAR_MAIN_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.RADAR_MAIN_FRAME.BorderSizePixel = 0
	Gui.RADAR_MAIN_FRAME.ClipsDescendants = false
	Gui.RADAR_MAIN_FRAME.Draggable = false
	Gui.RADAR_MAIN_FRAME.LayoutOrder = 0
	Gui.RADAR_MAIN_FRAME.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.RADAR_MAIN_FRAME.Rotation = 0
	Gui.RADAR_MAIN_FRAME.Selectable = false
	Gui.RADAR_MAIN_FRAME.Size = UDim2.new(1, 0, 1, 0)
	Gui.RADAR_MAIN_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RADAR_MAIN_FRAME.Visible = true
	Gui.RADAR_MAIN_FRAME.ZIndex = 1
	Gui.RADAR_MAIN_FRAME.Style = Enum.FrameStyle.Custom
	Gui.RADAR_MAIN_FRAME.Archivable = true
	Gui.RADAR_MAIN_FRAME.Parent = Gui.RADAR_FRAME

	Gui.UICorner_80 = Instance.new("UICorner")
	Gui.UICorner_80.Name = "UICorner"
	Gui.UICorner_80.CornerRadius = UDim.new(0.04, 0)
	Gui.UICorner_80.Archivable = true
	Gui.UICorner_80.Parent = Gui.RADAR_MAIN_FRAME

	Gui.RADAR_SELF_POINT = Instance.new("ImageLabel")
	Gui.RADAR_SELF_POINT.Name = "RADAR_SELF_POINT"
	Gui.RADAR_SELF_POINT.Active = false
	Gui.RADAR_SELF_POINT.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.RADAR_SELF_POINT.AutomaticSize = Enum.AutomaticSize.None
	Gui.RADAR_SELF_POINT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_SELF_POINT.BackgroundTransparency = 1
	Gui.RADAR_SELF_POINT.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.RADAR_SELF_POINT.BorderMode = Enum.BorderMode.Outline
	Gui.RADAR_SELF_POINT.BorderSizePixel = 0
	Gui.RADAR_SELF_POINT.ClipsDescendants = false
	Gui.RADAR_SELF_POINT.Draggable = false
	Gui.RADAR_SELF_POINT.LayoutOrder = 0
	Gui.RADAR_SELF_POINT.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.RADAR_SELF_POINT.Rotation = 0
	Gui.RADAR_SELF_POINT.Selectable = false
	Gui.RADAR_SELF_POINT.Size = UDim2.new(0.045, 0, 0.045, 0)
	Gui.RADAR_SELF_POINT.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.RADAR_SELF_POINT.Visible = true
	Gui.RADAR_SELF_POINT.ZIndex = 1
	Gui.RADAR_SELF_POINT.Image = "rbxassetid://81389225118639"
	Gui.RADAR_SELF_POINT.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.RADAR_SELF_POINT.ImageRectOffset = Vector2.new(0, 0)
	Gui.RADAR_SELF_POINT.ImageRectSize = Vector2.new(0, 0)
	Gui.RADAR_SELF_POINT.ImageTransparency = 0
	Gui.RADAR_SELF_POINT.ResampleMode = Enum.ResamplerMode.Default
	Gui.RADAR_SELF_POINT.ScaleType = Enum.ScaleType.Stretch
	Gui.RADAR_SELF_POINT.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.RADAR_SELF_POINT.SliceScale = 1
	Gui.RADAR_SELF_POINT.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.RADAR_SELF_POINT.Archivable = true
	Gui.RADAR_SELF_POINT.Parent = Gui.RADAR_MAIN_FRAME

	Gui.UIAspectRatioConstraint_14 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_14.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_14.AspectRatio = 1
	Gui.UIAspectRatioConstraint_14.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_14.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_14.Archivable = true
	Gui.UIAspectRatioConstraint_14.Parent = Gui.RADAR_FRAME

	Gui.COMMAND_FRAME = Instance.new("Frame")
	Gui.COMMAND_FRAME.Name = "COMMAND_FRAME"
	Gui.COMMAND_FRAME.Active = false
	Gui.COMMAND_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COMMAND_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COMMAND_FRAME.BackgroundTransparency = 1
	Gui.COMMAND_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME.BorderSizePixel = 0
	Gui.COMMAND_FRAME.ClipsDescendants = false
	Gui.COMMAND_FRAME.Draggable = false
	Gui.COMMAND_FRAME.LayoutOrder = 0
	Gui.COMMAND_FRAME.Position = UDim2.new(0.5, 0, 0.493, 0)
	Gui.COMMAND_FRAME.Rotation = 0
	Gui.COMMAND_FRAME.Selectable = false
	Gui.COMMAND_FRAME.Size = UDim2.new(0.344, 0, 0.611, 0)
	Gui.COMMAND_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME.Visible = false
	Gui.COMMAND_FRAME.ZIndex = 1
	Gui.COMMAND_FRAME.Style = Enum.FrameStyle.Custom
	Gui.COMMAND_FRAME.Archivable = true
	Gui.COMMAND_FRAME.Parent = Gui.VexarisGui

	Gui.COMMAND_FRAME_MAIN = Instance.new("Frame")
	Gui.COMMAND_FRAME_MAIN.Name = "COMMAND_FRAME_MAIN"
	Gui.COMMAND_FRAME_MAIN.Active = false
	Gui.COMMAND_FRAME_MAIN.AnchorPoint = Vector2.new(0, 0)
	Gui.COMMAND_FRAME_MAIN.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME_MAIN.BackgroundColor3 = Color3.fromRGB(6, 10, 23)
	Gui.COMMAND_FRAME_MAIN.BackgroundTransparency = 0
	Gui.COMMAND_FRAME_MAIN.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_MAIN.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME_MAIN.BorderSizePixel = 0
	Gui.COMMAND_FRAME_MAIN.ClipsDescendants = false
	Gui.COMMAND_FRAME_MAIN.Draggable = false
	Gui.COMMAND_FRAME_MAIN.LayoutOrder = 0
	Gui.COMMAND_FRAME_MAIN.Position = UDim2.new(0, 0, 0, 0)
	Gui.COMMAND_FRAME_MAIN.Rotation = 0
	Gui.COMMAND_FRAME_MAIN.Selectable = false
	Gui.COMMAND_FRAME_MAIN.Size = UDim2.new(1, 0, 0.111, 0)
	Gui.COMMAND_FRAME_MAIN.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME_MAIN.Visible = true
	Gui.COMMAND_FRAME_MAIN.ZIndex = 1
	Gui.COMMAND_FRAME_MAIN.Style = Enum.FrameStyle.Custom
	Gui.COMMAND_FRAME_MAIN.Archivable = true
	Gui.COMMAND_FRAME_MAIN.Parent = Gui.COMMAND_FRAME

	Gui.UICorner_81 = Instance.new("UICorner")
	Gui.UICorner_81.Name = "UICorner"
	Gui.UICorner_81.CornerRadius = UDim.new(0.14, 0)
	Gui.UICorner_81.Archivable = true
	Gui.UICorner_81.Parent = Gui.COMMAND_FRAME_MAIN

	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME = Instance.new("Frame")
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Name = "COMMAND_FRAME_MAIN_TEXT_FRAME"
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Active = false
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.BackgroundColor3 = Color3.fromRGB(20, 32, 65)
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.BackgroundTransparency = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.BorderSizePixel = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.ClipsDescendants = false
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Draggable = false
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.LayoutOrder = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Position = UDim2.new(0.5, 0, 0.721, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Rotation = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Selectable = false
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Size = UDim2.new(0.985, 0, 0.327, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Visible = true
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.ZIndex = 1
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Style = Enum.FrameStyle.Custom
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Archivable = true
	Gui.COMMAND_FRAME_MAIN_TEXT_FRAME.Parent = Gui.COMMAND_FRAME_MAIN

	Gui.UICorner_82 = Instance.new("UICorner")
	Gui.UICorner_82.Name = "UICorner"
	Gui.UICorner_82.CornerRadius = UDim.new(0.175, 0)
	Gui.UICorner_82.Archivable = true
	Gui.UICorner_82.Parent = Gui.COMMAND_FRAME_MAIN_TEXT_FRAME

	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX = Instance.new("TextBox")
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Name = "COMMAND_FRAME_MAIN_TEXT_TEXTBOX"
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Active = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.BackgroundTransparency = 1
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.BorderSizePixel = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.ClipsDescendants = false
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Draggable = false
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.LayoutOrder = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Position = UDim2.new(0.5, 0, 0.5, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Rotation = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Selectable = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Size = UDim2.new(0.985, 0, 1, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Visible = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.ZIndex = 1
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Font = Enum.Font.Unknown
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.LineHeight = 1
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.MaxVisibleGraphemes = -1
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.RichText = false
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Text = ""
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextColor3 = Color3.fromRGB(195, 211, 234)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextDirection = Enum.TextDirection.Auto
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextScaled = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextSize = 20
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextStrokeTransparency = 1
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextTransparency = 0
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextTruncate = Enum.TextTruncate.None
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextWrapped = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextXAlignment = Enum.TextXAlignment.Left
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.TextYAlignment = Enum.TextYAlignment.Center
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.PlaceholderColor3 = Color3.fromRGB(32, 48, 80)
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.PlaceholderText = "Example [Example1] [Example2] [Example3] [Example4]"
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.ClearTextOnFocus = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.MultiLine = false
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.ShowNativeInput = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Archivable = true
	Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX.Parent = Gui.COMMAND_FRAME_MAIN_TEXT_FRAME

	Gui.UITextSizeConstraint_45 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_45.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_45.MaxTextSize = 20
	Gui.UITextSizeConstraint_45.MinTextSize = 1
	Gui.UITextSizeConstraint_45.Archivable = true
	Gui.UITextSizeConstraint_45.Parent = Gui.COMMAND_FRAME_MAIN_TEXT_TEXTBOX

	Gui.COMMAND_FRAME_MAIN_HEADER = Instance.new("Frame")
	Gui.COMMAND_FRAME_MAIN_HEADER.Name = "COMMAND_FRAME_MAIN_HEADER"
	Gui.COMMAND_FRAME_MAIN_HEADER.Active = false
	Gui.COMMAND_FRAME_MAIN_HEADER.AnchorPoint = Vector2.new(0, 0)
	Gui.COMMAND_FRAME_MAIN_HEADER.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME_MAIN_HEADER.BackgroundColor3 = Color3.fromRGB(13, 27, 62)
	Gui.COMMAND_FRAME_MAIN_HEADER.BackgroundTransparency = 0
	Gui.COMMAND_FRAME_MAIN_HEADER.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_MAIN_HEADER.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME_MAIN_HEADER.BorderSizePixel = 0
	Gui.COMMAND_FRAME_MAIN_HEADER.ClipsDescendants = false
	Gui.COMMAND_FRAME_MAIN_HEADER.Draggable = false
	Gui.COMMAND_FRAME_MAIN_HEADER.LayoutOrder = 0
	Gui.COMMAND_FRAME_MAIN_HEADER.Position = UDim2.new(0, 0, 0, 0)
	Gui.COMMAND_FRAME_MAIN_HEADER.Rotation = 0
	Gui.COMMAND_FRAME_MAIN_HEADER.Selectable = false
	Gui.COMMAND_FRAME_MAIN_HEADER.Size = UDim2.new(1, 0, 0.439, 0)
	Gui.COMMAND_FRAME_MAIN_HEADER.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME_MAIN_HEADER.Visible = true
	Gui.COMMAND_FRAME_MAIN_HEADER.ZIndex = 1
	Gui.COMMAND_FRAME_MAIN_HEADER.Style = Enum.FrameStyle.Custom
	Gui.COMMAND_FRAME_MAIN_HEADER.Archivable = true
	Gui.COMMAND_FRAME_MAIN_HEADER.Parent = Gui.COMMAND_FRAME_MAIN

	Gui.UICorner_83 = Instance.new("UICorner")
	Gui.UICorner_83.Name = "UICorner"
	Gui.UICorner_83.CornerRadius = UDim.new(0.4, 0)
	Gui.UICorner_83.Archivable = true
	Gui.UICorner_83.Parent = Gui.COMMAND_FRAME_MAIN_HEADER

	Gui.Frame_8 = Instance.new("Frame")
	Gui.Frame_8.Name = "Frame"
	Gui.Frame_8.Active = false
	Gui.Frame_8.AnchorPoint = Vector2.new(0, 0)
	Gui.Frame_8.AutomaticSize = Enum.AutomaticSize.None
	Gui.Frame_8.BackgroundColor3 = Color3.fromRGB(13, 27, 62)
	Gui.Frame_8.BackgroundTransparency = 0
	Gui.Frame_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Frame_8.BorderMode = Enum.BorderMode.Outline
	Gui.Frame_8.BorderSizePixel = 0
	Gui.Frame_8.ClipsDescendants = false
	Gui.Frame_8.Draggable = false
	Gui.Frame_8.LayoutOrder = 0
	Gui.Frame_8.Position = UDim2.new(0, 0, 0.449, 0)
	Gui.Frame_8.Rotation = 0
	Gui.Frame_8.Selectable = false
	Gui.Frame_8.Size = UDim2.new(1, 0, 0.551, 0)
	Gui.Frame_8.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Frame_8.Visible = true
	Gui.Frame_8.ZIndex = 1
	Gui.Frame_8.Style = Enum.FrameStyle.Custom
	Gui.Frame_8.Archivable = true
	Gui.Frame_8.Parent = Gui.COMMAND_FRAME_MAIN_HEADER

	Gui.TextLabel_6 = Instance.new("TextLabel")
	Gui.TextLabel_6.Name = "TextLabel"
	Gui.TextLabel_6.Active = false
	Gui.TextLabel_6.AnchorPoint = Vector2.new(0, 0)
	Gui.TextLabel_6.AutomaticSize = Enum.AutomaticSize.None
	Gui.TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.TextLabel_6.BackgroundTransparency = 1
	Gui.TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_6.BorderMode = Enum.BorderMode.Outline
	Gui.TextLabel_6.BorderSizePixel = 0
	Gui.TextLabel_6.ClipsDescendants = false
	Gui.TextLabel_6.Draggable = false
	Gui.TextLabel_6.LayoutOrder = 0
	Gui.TextLabel_6.Position = UDim2.new(0, 0, 0, 0)
	Gui.TextLabel_6.Rotation = 0
	Gui.TextLabel_6.Selectable = false
	Gui.TextLabel_6.Size = UDim2.new(1, 0, 1, 0)
	Gui.TextLabel_6.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.TextLabel_6.Visible = true
	Gui.TextLabel_6.ZIndex = 1
	Gui.TextLabel_6.Font = Enum.Font.Unknown
	Gui.TextLabel_6.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.TextLabel_6.LineHeight = 1
	Gui.TextLabel_6.MaxVisibleGraphemes = -1
	Gui.TextLabel_6.RichText = false
	Gui.TextLabel_6.Text = "VEXARIS"
	Gui.TextLabel_6.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.TextLabel_6.TextDirection = Enum.TextDirection.Auto
	Gui.TextLabel_6.TextScaled = true
	Gui.TextLabel_6.TextSize = 36
	Gui.TextLabel_6.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.TextLabel_6.TextStrokeTransparency = 1
	Gui.TextLabel_6.TextTransparency = 0
	Gui.TextLabel_6.TextTruncate = Enum.TextTruncate.None
	Gui.TextLabel_6.TextWrapped = true
	Gui.TextLabel_6.TextXAlignment = Enum.TextXAlignment.Center
	Gui.TextLabel_6.TextYAlignment = Enum.TextYAlignment.Center
	Gui.TextLabel_6.Archivable = true
	Gui.TextLabel_6.Parent = Gui.COMMAND_FRAME_MAIN_HEADER

	Gui.UITextSizeConstraint_46 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_46.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_46.MaxTextSize = 36
	Gui.UITextSizeConstraint_46.MinTextSize = 1
	Gui.UITextSizeConstraint_46.Archivable = true
	Gui.UITextSizeConstraint_46.Parent = Gui.TextLabel_6

	Gui.COMMAND_FRAME_LIST = Instance.new("Frame")
	Gui.COMMAND_FRAME_LIST.Name = "COMMAND_FRAME_LIST"
	Gui.COMMAND_FRAME_LIST.Active = false
	Gui.COMMAND_FRAME_LIST.AnchorPoint = Vector2.new(0, 0)
	Gui.COMMAND_FRAME_LIST.AutomaticSize = Enum.AutomaticSize.None
	Gui.COMMAND_FRAME_LIST.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.COMMAND_FRAME_LIST.BackgroundTransparency = 1
	Gui.COMMAND_FRAME_LIST.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.COMMAND_FRAME_LIST.BorderMode = Enum.BorderMode.Outline
	Gui.COMMAND_FRAME_LIST.BorderSizePixel = 0
	Gui.COMMAND_FRAME_LIST.ClipsDescendants = true
	Gui.COMMAND_FRAME_LIST.Draggable = false
	Gui.COMMAND_FRAME_LIST.LayoutOrder = 0
	Gui.COMMAND_FRAME_LIST.Position = UDim2.new(0, 0, 0.126, 0)
	Gui.COMMAND_FRAME_LIST.Rotation = 0
	Gui.COMMAND_FRAME_LIST.Selectable = false
	Gui.COMMAND_FRAME_LIST.Size = UDim2.new(0.998, 0, 0.483, 0)
	Gui.COMMAND_FRAME_LIST.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.COMMAND_FRAME_LIST.Visible = true
	Gui.COMMAND_FRAME_LIST.ZIndex = 1
	Gui.COMMAND_FRAME_LIST.Style = Enum.FrameStyle.Custom
	Gui.COMMAND_FRAME_LIST.Archivable = true
	Gui.COMMAND_FRAME_LIST.Parent = Gui.COMMAND_FRAME

	Gui.UIListLayout_25 = Instance.new("UIListLayout")
	Gui.UIListLayout_25.Name = "UIListLayout"
	Gui.UIListLayout_25.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_25.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Gui.UIListLayout_25.Padding = UDim.new(0.02, 0)
	Gui.UIListLayout_25.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_25.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_25.Wraps = false
	Gui.UIListLayout_25.Archivable = true
	Gui.UIListLayout_25.Parent = Gui.COMMAND_FRAME_LIST

	Gui.UIAspectRatioConstraint_15 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_15.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_15.AspectRatio = 1.2
	Gui.UIAspectRatioConstraint_15.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_15.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_15.Archivable = true
	Gui.UIAspectRatioConstraint_15.Parent = Gui.COMMAND_FRAME

	Gui.WATERMARK = Instance.new("Frame")
	Gui.WATERMARK.Name = "WATERMARK"
	Gui.WATERMARK.Active = false
	Gui.WATERMARK.AnchorPoint = Vector2.new(0, 0)
	Gui.WATERMARK.AutomaticSize = Enum.AutomaticSize.None
	Gui.WATERMARK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.WATERMARK.BackgroundTransparency = 1
	Gui.WATERMARK.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK.BorderMode = Enum.BorderMode.Outline
	Gui.WATERMARK.BorderSizePixel = 0
	Gui.WATERMARK.ClipsDescendants = false
	Gui.WATERMARK.Draggable = false
	Gui.WATERMARK.LayoutOrder = 0
	Gui.WATERMARK.Position = UDim2.new(0, 0, 0, 0)
	Gui.WATERMARK.Rotation = 0
	Gui.WATERMARK.Selectable = false
	Gui.WATERMARK.Size = UDim2.new(0, 379, 0, 86)
	Gui.WATERMARK.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.WATERMARK.Visible = true
	Gui.WATERMARK.ZIndex = 1
	Gui.WATERMARK.Style = Enum.FrameStyle.Custom
	Gui.WATERMARK.Archivable = true
	Gui.WATERMARK.Parent = Gui.VexarisGui

	Gui.WATERMARK_FRAME = Instance.new("Frame")
	Gui.WATERMARK_FRAME.Name = "WATERMARK_FRAME"
	Gui.WATERMARK_FRAME.Active = false
	Gui.WATERMARK_FRAME.AnchorPoint = Vector2.new(0, 0.5)
	Gui.WATERMARK_FRAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.WATERMARK_FRAME.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	Gui.WATERMARK_FRAME.BackgroundTransparency = 0
	Gui.WATERMARK_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.WATERMARK_FRAME.BorderSizePixel = 0
	Gui.WATERMARK_FRAME.ClipsDescendants = false
	Gui.WATERMARK_FRAME.Draggable = false
	Gui.WATERMARK_FRAME.LayoutOrder = 0
	Gui.WATERMARK_FRAME.Position = UDim2.new(0.048, 0, 0.372, 0)
	Gui.WATERMARK_FRAME.Rotation = 0
	Gui.WATERMARK_FRAME.Selectable = false
	Gui.WATERMARK_FRAME.Size = UDim2.new(0, 0, 0.393, 0)
	Gui.WATERMARK_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.WATERMARK_FRAME.Visible = true
	Gui.WATERMARK_FRAME.ZIndex = 1
	Gui.WATERMARK_FRAME.Style = Enum.FrameStyle.Custom
	Gui.WATERMARK_FRAME.Archivable = true
	Gui.WATERMARK_FRAME.Parent = Gui.WATERMARK

	Gui.UICorner_84 = Instance.new("UICorner")
	Gui.UICorner_84.Name = "UICorner"
	Gui.UICorner_84.CornerRadius = UDim.new(0.212, 0)
	Gui.UICorner_84.Archivable = true
	Gui.UICorner_84.Parent = Gui.WATERMARK_FRAME

	Gui.UIListLayout_26 = Instance.new("UIListLayout")
	Gui.UIListLayout_26.Name = "UIListLayout"
	Gui.UIListLayout_26.FillDirection = Enum.FillDirection.Horizontal
	Gui.UIListLayout_26.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Gui.UIListLayout_26.Padding = UDim.new(0, 0)
	Gui.UIListLayout_26.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_26.VerticalAlignment = Enum.VerticalAlignment.Center
	Gui.UIListLayout_26.Wraps = false
	Gui.UIListLayout_26.Archivable = true
	Gui.UIListLayout_26.Parent = Gui.WATERMARK_FRAME

	Gui.LOGO_LABEL_3 = Instance.new("ImageLabel")
	Gui.LOGO_LABEL_3.Name = "LOGO_LABEL"
	Gui.LOGO_LABEL_3.Active = false
	Gui.LOGO_LABEL_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Gui.LOGO_LABEL_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.LOGO_LABEL_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_3.BackgroundTransparency = 1
	Gui.LOGO_LABEL_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.LOGO_LABEL_3.BorderMode = Enum.BorderMode.Outline
	Gui.LOGO_LABEL_3.BorderSizePixel = 0
	Gui.LOGO_LABEL_3.ClipsDescendants = false
	Gui.LOGO_LABEL_3.Draggable = false
	Gui.LOGO_LABEL_3.LayoutOrder = 0
	Gui.LOGO_LABEL_3.Position = UDim2.new(0.085, 0, 0.5, 0)
	Gui.LOGO_LABEL_3.Rotation = 0
	Gui.LOGO_LABEL_3.Selectable = false
	Gui.LOGO_LABEL_3.Size = UDim2.new(0, 24, 0, 24)
	Gui.LOGO_LABEL_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.LOGO_LABEL_3.Visible = true
	Gui.LOGO_LABEL_3.ZIndex = 1
	Gui.LOGO_LABEL_3.Image = "rbxassetid://119299537238281"
	Gui.LOGO_LABEL_3.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Gui.LOGO_LABEL_3.ImageRectOffset = Vector2.new(0, 0)
	Gui.LOGO_LABEL_3.ImageRectSize = Vector2.new(0, 0)
	Gui.LOGO_LABEL_3.ImageTransparency = 0
	Gui.LOGO_LABEL_3.ResampleMode = Enum.ResamplerMode.Default
	Gui.LOGO_LABEL_3.ScaleType = Enum.ScaleType.Stretch
	Gui.LOGO_LABEL_3.SliceCenter = Rect.new(0, 0, 0, 0)
	Gui.LOGO_LABEL_3.SliceScale = 1
	Gui.LOGO_LABEL_3.TileSize = UDim2.new(1, 0, 1, 0)
	Gui.LOGO_LABEL_3.Archivable = true
	Gui.LOGO_LABEL_3.Parent = Gui.WATERMARK_FRAME

	Gui.Buffer = Instance.new("TextLabel")
	Gui.Buffer.Name = "Buffer"
	Gui.Buffer.Active = false
	Gui.Buffer.AnchorPoint = Vector2.new(0, 0)
	Gui.Buffer.AutomaticSize = Enum.AutomaticSize.None
	Gui.Buffer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Buffer.BackgroundTransparency = 1
	Gui.Buffer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer.BorderMode = Enum.BorderMode.Outline
	Gui.Buffer.BorderSizePixel = 0
	Gui.Buffer.ClipsDescendants = false
	Gui.Buffer.Draggable = false
	Gui.Buffer.LayoutOrder = -1
	Gui.Buffer.Position = UDim2.new(0, 0, 0, 0)
	Gui.Buffer.Rotation = 0
	Gui.Buffer.Selectable = false
	Gui.Buffer.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.Buffer.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Buffer.Visible = true
	Gui.Buffer.ZIndex = 1
	Gui.Buffer.Font = Enum.Font.SourceSans
	Gui.Buffer.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Gui.Buffer.LineHeight = 1
	Gui.Buffer.MaxVisibleGraphemes = -1
	Gui.Buffer.RichText = false
	Gui.Buffer.Text = ""
	Gui.Buffer.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.Buffer.TextDirection = Enum.TextDirection.Auto
	Gui.Buffer.TextScaled = false
	Gui.Buffer.TextSize = 14
	Gui.Buffer.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer.TextStrokeTransparency = 1
	Gui.Buffer.TextTransparency = 0
	Gui.Buffer.TextTruncate = Enum.TextTruncate.None
	Gui.Buffer.TextWrapped = false
	Gui.Buffer.TextXAlignment = Enum.TextXAlignment.Center
	Gui.Buffer.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Buffer.Archivable = true
	Gui.Buffer.Parent = Gui.WATERMARK_FRAME

	Gui.WATERMARK_USERNAME = Instance.new("TextLabel")
	Gui.WATERMARK_USERNAME.Name = "WATERMARK_USERNAME"
	Gui.WATERMARK_USERNAME.Active = false
	Gui.WATERMARK_USERNAME.AnchorPoint = Vector2.new(0, 0)
	Gui.WATERMARK_USERNAME.AutomaticSize = Enum.AutomaticSize.X
	Gui.WATERMARK_USERNAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.WATERMARK_USERNAME.BackgroundTransparency = 1
	Gui.WATERMARK_USERNAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK_USERNAME.BorderMode = Enum.BorderMode.Outline
	Gui.WATERMARK_USERNAME.BorderSizePixel = 0
	Gui.WATERMARK_USERNAME.ClipsDescendants = false
	Gui.WATERMARK_USERNAME.Draggable = false
	Gui.WATERMARK_USERNAME.LayoutOrder = 2
	Gui.WATERMARK_USERNAME.Position = UDim2.new(0, 0, 0, 0)
	Gui.WATERMARK_USERNAME.Rotation = 0
	Gui.WATERMARK_USERNAME.Selectable = false
	Gui.WATERMARK_USERNAME.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.WATERMARK_USERNAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.WATERMARK_USERNAME.Visible = true
	Gui.WATERMARK_USERNAME.ZIndex = 1
	Gui.WATERMARK_USERNAME.Font = Enum.Font.Unknown
	Gui.WATERMARK_USERNAME.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.WATERMARK_USERNAME.LineHeight = 1
	Gui.WATERMARK_USERNAME.MaxVisibleGraphemes = -1
	Gui.WATERMARK_USERNAME.RichText = false
	Gui.WATERMARK_USERNAME.Text = "Freelancer1754"
	Gui.WATERMARK_USERNAME.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.WATERMARK_USERNAME.TextDirection = Enum.TextDirection.Auto
	Gui.WATERMARK_USERNAME.TextScaled = false
	Gui.WATERMARK_USERNAME.TextSize = 22
	Gui.WATERMARK_USERNAME.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK_USERNAME.TextStrokeTransparency = 1
	Gui.WATERMARK_USERNAME.TextTransparency = 0
	Gui.WATERMARK_USERNAME.TextTruncate = Enum.TextTruncate.None
	Gui.WATERMARK_USERNAME.TextWrapped = false
	Gui.WATERMARK_USERNAME.TextXAlignment = Enum.TextXAlignment.Center
	Gui.WATERMARK_USERNAME.TextYAlignment = Enum.TextYAlignment.Center
	Gui.WATERMARK_USERNAME.Archivable = true
	Gui.WATERMARK_USERNAME.Parent = Gui.WATERMARK_FRAME

	Gui.Buffer_1 = Instance.new("TextLabel")
	Gui.Buffer_1.Name = "Buffer"
	Gui.Buffer_1.Active = false
	Gui.Buffer_1.AnchorPoint = Vector2.new(0, 0)
	Gui.Buffer_1.AutomaticSize = Enum.AutomaticSize.None
	Gui.Buffer_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Buffer_1.BackgroundTransparency = 1
	Gui.Buffer_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_1.BorderMode = Enum.BorderMode.Outline
	Gui.Buffer_1.BorderSizePixel = 0
	Gui.Buffer_1.ClipsDescendants = false
	Gui.Buffer_1.Draggable = false
	Gui.Buffer_1.LayoutOrder = 1
	Gui.Buffer_1.Position = UDim2.new(0, 0, 0, 0)
	Gui.Buffer_1.Rotation = 0
	Gui.Buffer_1.Selectable = false
	Gui.Buffer_1.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.Buffer_1.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Buffer_1.Visible = true
	Gui.Buffer_1.ZIndex = 1
	Gui.Buffer_1.Font = Enum.Font.SourceSans
	Gui.Buffer_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Gui.Buffer_1.LineHeight = 1
	Gui.Buffer_1.MaxVisibleGraphemes = -1
	Gui.Buffer_1.RichText = false
	Gui.Buffer_1.Text = ""
	Gui.Buffer_1.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.Buffer_1.TextDirection = Enum.TextDirection.Auto
	Gui.Buffer_1.TextScaled = false
	Gui.Buffer_1.TextSize = 14
	Gui.Buffer_1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_1.TextStrokeTransparency = 1
	Gui.Buffer_1.TextTransparency = 0
	Gui.Buffer_1.TextTruncate = Enum.TextTruncate.None
	Gui.Buffer_1.TextWrapped = false
	Gui.Buffer_1.TextXAlignment = Enum.TextXAlignment.Center
	Gui.Buffer_1.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Buffer_1.Archivable = true
	Gui.Buffer_1.Parent = Gui.WATERMARK_FRAME

	Gui.Buffer_2 = Instance.new("TextLabel")
	Gui.Buffer_2.Name = "Buffer"
	Gui.Buffer_2.Active = false
	Gui.Buffer_2.AnchorPoint = Vector2.new(0, 0)
	Gui.Buffer_2.AutomaticSize = Enum.AutomaticSize.None
	Gui.Buffer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Buffer_2.BackgroundTransparency = 1
	Gui.Buffer_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_2.BorderMode = Enum.BorderMode.Outline
	Gui.Buffer_2.BorderSizePixel = 0
	Gui.Buffer_2.ClipsDescendants = false
	Gui.Buffer_2.Draggable = false
	Gui.Buffer_2.LayoutOrder = 3
	Gui.Buffer_2.Position = UDim2.new(0, 0, 0, 0)
	Gui.Buffer_2.Rotation = 0
	Gui.Buffer_2.Selectable = false
	Gui.Buffer_2.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.Buffer_2.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Buffer_2.Visible = true
	Gui.Buffer_2.ZIndex = 1
	Gui.Buffer_2.Font = Enum.Font.SourceSans
	Gui.Buffer_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Gui.Buffer_2.LineHeight = 1
	Gui.Buffer_2.MaxVisibleGraphemes = -1
	Gui.Buffer_2.RichText = false
	Gui.Buffer_2.Text = ""
	Gui.Buffer_2.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.Buffer_2.TextDirection = Enum.TextDirection.Auto
	Gui.Buffer_2.TextScaled = false
	Gui.Buffer_2.TextSize = 14
	Gui.Buffer_2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_2.TextStrokeTransparency = 1
	Gui.Buffer_2.TextTransparency = 0
	Gui.Buffer_2.TextTruncate = Enum.TextTruncate.None
	Gui.Buffer_2.TextWrapped = false
	Gui.Buffer_2.TextXAlignment = Enum.TextXAlignment.Center
	Gui.Buffer_2.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Buffer_2.Archivable = true
	Gui.Buffer_2.Parent = Gui.WATERMARK_FRAME

	Gui.WATERMARK_USERID = Instance.new("TextLabel")
	Gui.WATERMARK_USERID.Name = "WATERMARK_USERID"
	Gui.WATERMARK_USERID.Active = false
	Gui.WATERMARK_USERID.AnchorPoint = Vector2.new(0, 0)
	Gui.WATERMARK_USERID.AutomaticSize = Enum.AutomaticSize.X
	Gui.WATERMARK_USERID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.WATERMARK_USERID.BackgroundTransparency = 1
	Gui.WATERMARK_USERID.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK_USERID.BorderMode = Enum.BorderMode.Outline
	Gui.WATERMARK_USERID.BorderSizePixel = 0
	Gui.WATERMARK_USERID.ClipsDescendants = false
	Gui.WATERMARK_USERID.Draggable = false
	Gui.WATERMARK_USERID.LayoutOrder = 4
	Gui.WATERMARK_USERID.Position = UDim2.new(0, 0, 0, 0)
	Gui.WATERMARK_USERID.Rotation = 0
	Gui.WATERMARK_USERID.Selectable = false
	Gui.WATERMARK_USERID.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.WATERMARK_USERID.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.WATERMARK_USERID.Visible = true
	Gui.WATERMARK_USERID.ZIndex = 1
	Gui.WATERMARK_USERID.Font = Enum.Font.Unknown
	Gui.WATERMARK_USERID.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.WATERMARK_USERID.LineHeight = 1
	Gui.WATERMARK_USERID.MaxVisibleGraphemes = -1
	Gui.WATERMARK_USERID.RichText = false
	Gui.WATERMARK_USERID.Text = "VEXARIS-12"
	Gui.WATERMARK_USERID.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.WATERMARK_USERID.TextDirection = Enum.TextDirection.Auto
	Gui.WATERMARK_USERID.TextScaled = false
	Gui.WATERMARK_USERID.TextSize = 22
	Gui.WATERMARK_USERID.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.WATERMARK_USERID.TextStrokeTransparency = 1
	Gui.WATERMARK_USERID.TextTransparency = 0
	Gui.WATERMARK_USERID.TextTruncate = Enum.TextTruncate.None
	Gui.WATERMARK_USERID.TextWrapped = false
	Gui.WATERMARK_USERID.TextXAlignment = Enum.TextXAlignment.Center
	Gui.WATERMARK_USERID.TextYAlignment = Enum.TextYAlignment.Center
	Gui.WATERMARK_USERID.Archivable = true
	Gui.WATERMARK_USERID.Parent = Gui.WATERMARK_FRAME

	Gui.Buffer_3 = Instance.new("TextLabel")
	Gui.Buffer_3.Name = "Buffer"
	Gui.Buffer_3.Active = false
	Gui.Buffer_3.AnchorPoint = Vector2.new(0, 0)
	Gui.Buffer_3.AutomaticSize = Enum.AutomaticSize.None
	Gui.Buffer_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.Buffer_3.BackgroundTransparency = 1
	Gui.Buffer_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_3.BorderMode = Enum.BorderMode.Outline
	Gui.Buffer_3.BorderSizePixel = 0
	Gui.Buffer_3.ClipsDescendants = false
	Gui.Buffer_3.Draggable = false
	Gui.Buffer_3.LayoutOrder = 5
	Gui.Buffer_3.Position = UDim2.new(0, 0, 0, 0)
	Gui.Buffer_3.Rotation = 0
	Gui.Buffer_3.Selectable = false
	Gui.Buffer_3.Size = UDim2.new(0.03, 0, 1, 0)
	Gui.Buffer_3.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.Buffer_3.Visible = true
	Gui.Buffer_3.ZIndex = 1
	Gui.Buffer_3.Font = Enum.Font.SourceSans
	Gui.Buffer_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Gui.Buffer_3.LineHeight = 1
	Gui.Buffer_3.MaxVisibleGraphemes = -1
	Gui.Buffer_3.RichText = false
	Gui.Buffer_3.Text = ""
	Gui.Buffer_3.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.Buffer_3.TextDirection = Enum.TextDirection.Auto
	Gui.Buffer_3.TextScaled = false
	Gui.Buffer_3.TextSize = 14
	Gui.Buffer_3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.Buffer_3.TextStrokeTransparency = 1
	Gui.Buffer_3.TextTransparency = 0
	Gui.Buffer_3.TextTruncate = Enum.TextTruncate.None
	Gui.Buffer_3.TextWrapped = false
	Gui.Buffer_3.TextXAlignment = Enum.TextXAlignment.Center
	Gui.Buffer_3.TextYAlignment = Enum.TextYAlignment.Center
	Gui.Buffer_3.Archivable = true
	Gui.Buffer_3.Parent = Gui.WATERMARK_FRAME

	Gui.INFO_FRAME = Instance.new("Frame")
	Gui.INFO_FRAME.Name = "INFO_FRAME"
	Gui.INFO_FRAME.Active = false
	Gui.INFO_FRAME.AnchorPoint = Vector2.new(0, 0)
	Gui.INFO_FRAME.AutomaticSize = Enum.AutomaticSize.None
	Gui.INFO_FRAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.INFO_FRAME.BackgroundTransparency = 1
	Gui.INFO_FRAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.INFO_FRAME.BorderMode = Enum.BorderMode.Outline
	Gui.INFO_FRAME.BorderSizePixel = 0
	Gui.INFO_FRAME.ClipsDescendants = false
	Gui.INFO_FRAME.Draggable = false
	Gui.INFO_FRAME.LayoutOrder = 0
	Gui.INFO_FRAME.Position = UDim2.new(6.438, 0, 1, 0)
	Gui.INFO_FRAME.Rotation = 0
	Gui.INFO_FRAME.Selectable = false
	Gui.INFO_FRAME.Size = UDim2.new(0.282, 0, 1.254, 0)
	Gui.INFO_FRAME.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.INFO_FRAME.Visible = true
	Gui.INFO_FRAME.ZIndex = 1
	Gui.INFO_FRAME.Style = Enum.FrameStyle.Custom
	Gui.INFO_FRAME.Archivable = true
	Gui.INFO_FRAME.Parent = Gui.WATERMARK

	Gui.UIListLayout_27 = Instance.new("UIListLayout")
	Gui.UIListLayout_27.Name = "UIListLayout"
	Gui.UIListLayout_27.FillDirection = Enum.FillDirection.Vertical
	Gui.UIListLayout_27.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Gui.UIListLayout_27.Padding = UDim.new(0, 0)
	Gui.UIListLayout_27.SortOrder = Enum.SortOrder.LayoutOrder
	Gui.UIListLayout_27.VerticalAlignment = Enum.VerticalAlignment.Top
	Gui.UIListLayout_27.Wraps = false
	Gui.UIListLayout_27.Archivable = true
	Gui.UIListLayout_27.Parent = Gui.INFO_FRAME

	Gui.INFO_FPS_LABEL = Instance.new("TextLabel")
	Gui.INFO_FPS_LABEL.Name = "INFO_FPS_LABEL"
	Gui.INFO_FPS_LABEL.Active = false
	Gui.INFO_FPS_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.INFO_FPS_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.INFO_FPS_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.INFO_FPS_LABEL.BackgroundTransparency = 1
	Gui.INFO_FPS_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.INFO_FPS_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.INFO_FPS_LABEL.BorderSizePixel = 0
	Gui.INFO_FPS_LABEL.ClipsDescendants = false
	Gui.INFO_FPS_LABEL.Draggable = false
	Gui.INFO_FPS_LABEL.LayoutOrder = 0
	Gui.INFO_FPS_LABEL.Position = UDim2.new(0, 0, 0, 0)
	Gui.INFO_FPS_LABEL.Rotation = 0
	Gui.INFO_FPS_LABEL.Selectable = false
	Gui.INFO_FPS_LABEL.Size = UDim2.new(1, 0, 0.5, 0)
	Gui.INFO_FPS_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.INFO_FPS_LABEL.Visible = true
	Gui.INFO_FPS_LABEL.ZIndex = 1
	Gui.INFO_FPS_LABEL.Font = Enum.Font.Unknown
	Gui.INFO_FPS_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.INFO_FPS_LABEL.LineHeight = 1
	Gui.INFO_FPS_LABEL.MaxVisibleGraphemes = -1
	Gui.INFO_FPS_LABEL.RichText = false
	Gui.INFO_FPS_LABEL.Text = "FPS: 131"
	Gui.INFO_FPS_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.INFO_FPS_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.INFO_FPS_LABEL.TextScaled = true
	Gui.INFO_FPS_LABEL.TextSize = 35
	Gui.INFO_FPS_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.INFO_FPS_LABEL.TextStrokeTransparency = 1
	Gui.INFO_FPS_LABEL.TextTransparency = 0.5
	Gui.INFO_FPS_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.INFO_FPS_LABEL.TextWrapped = true
	Gui.INFO_FPS_LABEL.TextXAlignment = Enum.TextXAlignment.Right
	Gui.INFO_FPS_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.INFO_FPS_LABEL.Archivable = true
	Gui.INFO_FPS_LABEL.Parent = Gui.INFO_FRAME

	Gui.UITextSizeConstraint_47 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_47.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_47.MaxTextSize = 35
	Gui.UITextSizeConstraint_47.MinTextSize = 1
	Gui.UITextSizeConstraint_47.Archivable = true
	Gui.UITextSizeConstraint_47.Parent = Gui.INFO_FPS_LABEL

	Gui.INFO_PING_LABEL = Instance.new("TextLabel")
	Gui.INFO_PING_LABEL.Name = "INFO_PING_LABEL"
	Gui.INFO_PING_LABEL.Active = false
	Gui.INFO_PING_LABEL.AnchorPoint = Vector2.new(0, 0)
	Gui.INFO_PING_LABEL.AutomaticSize = Enum.AutomaticSize.None
	Gui.INFO_PING_LABEL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gui.INFO_PING_LABEL.BackgroundTransparency = 1
	Gui.INFO_PING_LABEL.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gui.INFO_PING_LABEL.BorderMode = Enum.BorderMode.Outline
	Gui.INFO_PING_LABEL.BorderSizePixel = 0
	Gui.INFO_PING_LABEL.ClipsDescendants = false
	Gui.INFO_PING_LABEL.Draggable = false
	Gui.INFO_PING_LABEL.LayoutOrder = 0
	Gui.INFO_PING_LABEL.Position = UDim2.new(0, 0, 0.756, 0)
	Gui.INFO_PING_LABEL.Rotation = 0
	Gui.INFO_PING_LABEL.Selectable = false
	Gui.INFO_PING_LABEL.Size = UDim2.new(1, 0, 0.5, 0)
	Gui.INFO_PING_LABEL.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Gui.INFO_PING_LABEL.Visible = true
	Gui.INFO_PING_LABEL.ZIndex = 1
	Gui.INFO_PING_LABEL.Font = Enum.Font.Unknown
	Gui.INFO_PING_LABEL.FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Gui.INFO_PING_LABEL.LineHeight = 1
	Gui.INFO_PING_LABEL.MaxVisibleGraphemes = -1
	Gui.INFO_PING_LABEL.RichText = false
	Gui.INFO_PING_LABEL.Text = "Ping : 999ms"
	Gui.INFO_PING_LABEL.TextColor3 = Color3.fromRGB(220, 220, 225)
	Gui.INFO_PING_LABEL.TextDirection = Enum.TextDirection.Auto
	Gui.INFO_PING_LABEL.TextScaled = true
	Gui.INFO_PING_LABEL.TextSize = 35
	Gui.INFO_PING_LABEL.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Gui.INFO_PING_LABEL.TextStrokeTransparency = 1
	Gui.INFO_PING_LABEL.TextTransparency = 0.5
	Gui.INFO_PING_LABEL.TextTruncate = Enum.TextTruncate.None
	Gui.INFO_PING_LABEL.TextWrapped = true
	Gui.INFO_PING_LABEL.TextXAlignment = Enum.TextXAlignment.Right
	Gui.INFO_PING_LABEL.TextYAlignment = Enum.TextYAlignment.Center
	Gui.INFO_PING_LABEL.Archivable = true
	Gui.INFO_PING_LABEL.Parent = Gui.INFO_FRAME

	Gui.UITextSizeConstraint_48 = Instance.new("UITextSizeConstraint")
	Gui.UITextSizeConstraint_48.Name = "UITextSizeConstraint"
	Gui.UITextSizeConstraint_48.MaxTextSize = 35
	Gui.UITextSizeConstraint_48.MinTextSize = 1
	Gui.UITextSizeConstraint_48.Archivable = true
	Gui.UITextSizeConstraint_48.Parent = Gui.INFO_PING_LABEL

	Gui.UIAspectRatioConstraint_16 = Instance.new("UIAspectRatioConstraint")
	Gui.UIAspectRatioConstraint_16.Name = "UIAspectRatioConstraint"
	Gui.UIAspectRatioConstraint_16.AspectRatio = 2.897
	Gui.UIAspectRatioConstraint_16.AspectType = Enum.AspectType.FitWithinMaxSize
	Gui.UIAspectRatioConstraint_16.DominantAxis = Enum.DominantAxis.Width
	Gui.UIAspectRatioConstraint_16.Archivable = true
	Gui.UIAspectRatioConstraint_16.Parent = Gui.INFO_FRAME

end

BuildGui1()
BuildGui2()
BuildGui3()
BuildGui4()
BuildGui5()



print([[



     /$$    /$$                                        /$$             /$$      /$$                              
    | $$   | $$                                       |__/            | $$$    /$$$                              
    | $$   | $$ /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$  /$$  /$$$$$$$  | $$$$  /$$$$  /$$$$$$  /$$$$$$$  /$$   /$$
    |  $$ / $$//$$__  $$|  $$ /$$/ |____  $$ /$$__  $$| $$ /$$_____/  | $$ $$/$$ $$ /$$__  $$| $$__  $$| $$  | $$
     \  $$ $$/| $$$$$$$$ \  $$$$/   /$$$$$$$| $$  \__/| $$|  $$$$$$   | $$  $$$| $$| $$$$$$$$| $$  \ $$| $$  | $$
      \  $$$/ | $$_____/  >$$  $$  /$$__  $$| $$      | $$ \____  $$  | $$\  $ | $$| $$_____/| $$  | $$| $$  | $$
       \  $/  |  $$$$$$$ /$$/\  $$|  $$$$$$$| $$      | $$ /$$$$$$$/  | $$ \/  | $$|  $$$$$$$| $$  | $$|  $$$$$$/
        \_/    \_______/|__/  \__/ \_______/|__/      |__/|_______/   |__/     |__/ \_______/|__/  |__/ \______/ 

     Version: ]] .. UpdateVersion .. [[
]])

-- ═══════════════════════
-- ══  Device Detection ══
-- ═══════════════════════

local DeviceType = "PC"
local DeviceIcon = "🖥"

do
    local ok, vrs = pcall(game.GetService, game, "VRService")
    if ok and vrs then
        local vrOk, vrEnabled = pcall(function() return vrs.VREnabled end)
        if vrOk and vrEnabled then
            DeviceType = "VR"
            DeviceIcon = "🥽"
        end
    end

    if DeviceType == "PC" then
        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            DeviceType = "Mobile"
            DeviceIcon = "📱"
        elseif UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then
            DeviceType = "Console"
            DeviceIcon = "🎮"
        end
    end
end

local _debugLog = {}
local function dbg(msg)
    warn(msg)
    table.insert(_debugLog, msg)
end
local function copyDebugLog()
    setclipboard(table.concat(_debugLog, "\n"))
    warn("[DEBUG] Log in Zwischenablage kopiert!")
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F9 then
        copyDebugLog()
    end
end)

local BackgroundBlur = Instance.new("BlurEffect")
BackgroundBlur.Parent = game:GetService("Lighting")
BackgroundBlur.Name = "VexarisBlur"
BackgroundBlur.Size = 20
BackgroundBlur.Enabled = false

local ColorFrameBefore = false
local State = true

local savedMouseBehavior = Enum.MouseBehavior.Default
local mouseOverrideActive = false

local cursorCircleOutline = Drawing.new("Circle")
cursorCircleOutline.Radius = 5
cursorCircleOutline.Color = Color3.fromRGB(0, 0, 0)
cursorCircleOutline.Thickness = 3
cursorCircleOutline.Filled = true
cursorCircleOutline.NumSides = 64
cursorCircleOutline.Visible = false

Gui.RADAR_FRAME.Active = false
Gui.RADAR_MAIN_FRAME.Active = false

local cursorCircle = Drawing.new("Circle")
cursorCircle.Radius = 3
cursorCircle.Color = Color3.fromRGB(255, 255, 255)
cursorCircle.Thickness = 1
cursorCircle.Filled = true
cursorCircle.NumSides = 64
cursorCircle.Visible = false

Gui.WATERMARK.Visible = false

RunService.RenderStepped:Connect(function()
    if SCRIPT_KILLED then return end  -- ← NEU
    if mouseOverrideActive then
        local mousePos = UserInputService:GetMouseLocation()
        cursorCircleOutline.Position = mousePos
        cursorCircleOutline.Visible = true
        cursorCircle.Position = mousePos
        cursorCircle.Visible = true
    else
        cursorCircleOutline.Visible = false
        cursorCircle.Visible = false
    end
end)

local PanicMode = false

local function ToggleBackground(NewState)
    if PanicMode == false then
        if NewState == true then
            Gui.MAIN_FRAME.Visible = true
            if ColorFrameBefore == true then
                ColorFrameBefore = false
                Gui.COLOR_FRAME.Visible = true
            end
            BackgroundBlur.Enabled = true
            savedMouseBehavior = UserInputService.MouseBehavior
            mouseOverrideActive = true

            task.spawn(function()
                while mouseOverrideActive and Gui.MAIN_FRAME.Visible do
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                    UserInputService.MouseIconEnabled = false
                    task.wait()
                end
                -- Sicherheits-Cleanup falls Loop durch Visible=false endet
                if not mouseOverrideActive then
                    UserInputService.MouseIconEnabled = true
                end
            end)
        else
            Gui.MAIN_FRAME.Visible = false
            if Gui.COLOR_FRAME.Visible == true then
                ColorFrameBefore = true
                Gui.COLOR_FRAME.Visible = false
            end
            BackgroundBlur.Enabled = false
            mouseOverrideActive = false
            cursorCircle.Visible = false
            cursorCircleOutline.Visible = false
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = savedMouseBehavior
        end
    end
end

local MainFramePosition = UDim2.new(0.5, 0, 0.5, 0)
local ColorFramePosition = UDim2.new(0.8, 0, 0.5, 0)

task.spawn(function()
    while true do
        pcall(function()
            if Gui.VexarisGui and Gui.VexarisGui.Parent and not Gui.VexarisGui.Enabled then
                Gui.VexarisGui.Enabled = true
                Gui.MAIN_FRAME.Position  = MainFramePosition
                Gui.COLOR_FRAME.Position = ColorFramePosition
            end
        end)
        task.wait(0.1)
    end
end)

local ToggleMenuKeybind

UserInputService.InputBegan:Connect(function(Input, processed)
    if SCRIPT_KILLED then return end  -- ← NEU
    if processed then return end
    if PanicMode then return end
    if Input.KeyCode == ToggleMenuKeybind then
        if State then
            ToggleBackground(not State)
        else
            ToggleBackground(not State)
        end
        State = not State
    end
end)

local selectedKey = nil
local isWaitingForKey = true

local ignoredInputTypes = {
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.MouseButton2] = true,
    [Enum.UserInputType.MouseButton3] = true,
    [Enum.UserInputType.MouseWheel] = true,
    [Enum.UserInputType.MouseMovement] = true,
}

local function UpdateKeybindLabel()
    local keyText = selectedKeyWord and tostring(selectedKeyWord) or "..."
    local statusText = selectedKey
        and "\nDrücke Enter um fortzufahren oder wähle eine andere Taste"
        or ""
    Gui.KEYBIND_INFOLABEL.Text = "Wähle eine Taste um das Menü zu öffnen!\nAusgewählt: " .. keyText .. statusText
end

local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local function GetToggleMenuKeybind()
    Gui.MAIN_FRAME.Visible = false
    Gui.KEYBIND_FRAME.Visible = true
    selectedKey = nil
    selectedKeyWord = nil
    isWaitingForKey = true
    Gui.KEYBIND_INFOLABEL.Text = "Wähle eine Taste um das Menü zu öffnen!"

    local connection
    connection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if ignoredInputTypes[input.UserInputType] then return end

        if input.KeyCode == Enum.KeyCode.Return and selectedKey ~= nil then
            isWaitingForKey = false
            connection:Disconnect()
            Gui.KEYBIND_FRAME.Visible = false
            Gui.VexarisGui.ResetOnSpawn = false
            Gui.MAIN_FRAME.Visible = true
            Gui.WATERMARK.Visible = true
            Gui.WATERMARK.Visible = true
            Gui.WATERMARK_USERNAME.Text = Username
            Gui.WATERMARK_USERID.Text = UserId
            BackgroundBlur.Enabled = true
            ToggleMenuKeybind = selectedKey

        elseif input.KeyCode ~= Enum.KeyCode.Return and input.KeyCode ~= Enum.KeyCode.Unknown then
            selectedKey = input.KeyCode
            selectedKeyWord = input.KeyCode.Name
            UpdateKeybindLabel()
        end
    end)
end

GetToggleMenuKeybind()

-- ════════════════════
-- ══ Notify Logic ════
-- ════════════════════

local Notifies = {}
local NOTIFY_HEIGHT = 0.093
local NOTIFY_START_Y = -0.093
local NOTIFY_FIRST_Y = 0.045

local tweenSlideIn = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenShift   = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenFadeOut = TweenInfo.new(0.3,  Enum.EasingStyle.Quad,  Enum.EasingDirection.In)
local tweenRestack = TweenInfo.new(0.3,  Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function reshiftAll()
    for i, N in ipairs(Notifies) do
        local targetY = NOTIFY_FIRST_Y + (i - 1) * NOTIFY_HEIGHT
        TweenService:Create(N, tweenRestack, {Position = UDim2.new(0.5, 0, targetY, 0)}):Play()
    end
end

local function SendNotify(Message)
    for i, N in ipairs(Notifies) do
        local targetY = NOTIFY_FIRST_Y + i * NOTIFY_HEIGHT
        TweenService:Create(N, tweenShift, {Position = UDim2.new(0.5, 0, targetY, 0)}):Play()
    end

    local Copy = Gui.NOTIFY_EXAMPLE:Clone()
    local MessageLabel = Copy:WaitForChild("NOTIFY_MESSAGE_LABEL")

    MessageLabel.Text = Message
    Copy.Position = UDim2.new(0.5, 0, NOTIFY_START_Y, 0)
    Copy.Visible = true
    Copy.Parent = Gui.NOTIFY_FRAME

    table.insert(Notifies, 1, Copy)
    TweenService:Create(Copy, tweenSlideIn, {Position = UDim2.new(0.5, 0, NOTIFY_FIRST_Y, 0)}):Play()

    task.delay(5, function()
        TweenService:Create(Copy, tweenFadeOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(MessageLabel, tweenFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(Copy.UIStroke, tweenFadeOut, {Transparency = 1}):Play()
        task.wait(0.3)
        local idx = table.find(Notifies, Copy)
        if idx then table.remove(Notifies, idx) end
        Copy:Destroy()
        reshiftAll()
    end)
end

local function SendPersistentNotify(Message)
    for i, N in ipairs(Notifies) do
        local targetY = NOTIFY_FIRST_Y + i * NOTIFY_HEIGHT
        TweenService:Create(N, tweenShift, {Position = UDim2.new(0.5, 0, targetY, 0)}):Play()
    end

    local Copy = Gui.NOTIFY_EXAMPLE:Clone()
    local MessageLabel = Copy:WaitForChild("NOTIFY_MESSAGE_LABEL")

    MessageLabel.Text = Message
    Copy.Position = UDim2.new(0.5, 0, NOTIFY_START_Y, 0)
    Copy.Visible = true
    Copy.Parent = Gui.NOTIFY_FRAME

    table.insert(Notifies, 1, Copy)
    TweenService:Create(Copy, tweenSlideIn, {Position = UDim2.new(0.5, 0, NOTIFY_FIRST_Y, 0)}):Play()

    local dismissed = false
    local handle = {}

    function handle:Dismiss()
        if dismissed then return end
        dismissed = true
        TweenService:Create(Copy, tweenFadeOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(MessageLabel, tweenFadeOut, {TextTransparency = 1}):Play()
        TweenService:Create(Copy.UIStroke, tweenFadeOut, {Transparency = 1}):Play()
        task.delay(0.3, function()
            local idx = table.find(Notifies, Copy)
            if idx then table.remove(Notifies, idx) end
            Copy:Destroy()
            reshiftAll()
        end)
    end

    function handle:SetText(newText)
        MessageLabel.Text = newText
    end

    return handle
end

-- ═════════════════════
-- ══ Drag Function ════
-- ═════════════════════

local startFramePos = nil
local startDelta = nil

Gui.MenuDragDetector.DragStart:Connect(function()
    local absSize = Gui.VexarisGui.AbsoluteSize
    startFramePos = Vector2.new(
        Gui.MAIN_FRAME.Position.X.Scale * absSize.X + Gui.MAIN_FRAME.Position.X.Offset,
        Gui.MAIN_FRAME.Position.Y.Scale * absSize.Y + Gui.MAIN_FRAME.Position.Y.Offset
    )
end)

Gui.MenuDragDetector.DragContinue:Connect(function(delta)
    if startDelta == nil then startDelta = delta end
    local diff = delta - startDelta
    Gui.MAIN_FRAME.Position = UDim2.fromOffset(startFramePos.X + diff.X, startFramePos.Y + diff.Y)
end)

Gui.MenuDragDetector.DragEnd:Connect(function()
    startDelta = nil
    local absSize = Gui.VexarisGui.AbsoluteSize
    local absPos  = Gui.MAIN_FRAME.AbsolutePosition
    local anchorOffset = Gui.MAIN_FRAME.AbsoluteSize * Gui.MAIN_FRAME.AnchorPoint
    MainFramePosition = UDim2.new(
        (absPos.X + anchorOffset.X) / absSize.X, 0,
        (absPos.Y + anchorOffset.Y) / absSize.Y, 0
    )
    Gui.MAIN_FRAME.Position = MainFramePosition
    startFramePos = nil

    -- ✅ FIX: DRAG_FRAME zurück auf Origin setzen
    Gui.DRAG_FRAME.Position = UDim2.new(0, 0, 0, 0)
end)

local ColorstartFramePos = nil
local ColorstartDelta = nil

Gui.ColorDragDetector.DragStart:Connect(function()
    local absSize = Gui.VexarisGui.AbsoluteSize
    ColorstartFramePos = Vector2.new(
        Gui.COLOR_FRAME.Position.X.Scale * absSize.X + Gui.COLOR_FRAME.Position.X.Offset,
        Gui.COLOR_FRAME.Position.Y.Scale * absSize.Y + Gui.COLOR_FRAME.Position.Y.Offset
    )
end)

Gui.ColorDragDetector.DragContinue:Connect(function(delta)
    if ColorstartDelta == nil then ColorstartDelta = delta end
    local diff = delta - ColorstartDelta
    Gui.COLOR_FRAME.Position = UDim2.fromOffset(ColorstartFramePos.X + diff.X, ColorstartFramePos.Y + diff.Y)
end)

Gui.ColorDragDetector.DragEnd:Connect(function()
    ColorstartDelta = nil
    local absSize = Gui.VexarisGui.AbsoluteSize
    local absPos  = Gui.COLOR_FRAME.AbsolutePosition
    local anchorOffset = Gui.COLOR_FRAME.AbsoluteSize * Gui.COLOR_FRAME.AnchorPoint
    ColorFramePosition = UDim2.new(
        (absPos.X + anchorOffset.X) / absSize.X, 0,
        (absPos.Y + anchorOffset.Y) / absSize.Y, 0
    )
    Gui.COLOR_FRAME.Position = ColorFramePosition
    ColorstartDelta = nil
    ColorstartFramePos = nil

    -- ✅ FIX: COLOR_DRAG_FRAME zurück auf Origin setzen
    Gui.COLOR_DRAG_FRAME.Position = UDim2.new(0, 0, 0, 0)
end)

-- ════════════════════════
-- ══ Choose Color Logic ══
-- ════════════════════════

local hueGradient = Gui.COLOR_DRAGGER_FRAME:FindFirstChildOfClass("UIGradient")
hueGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0/6, Color3.fromHSV(0/6, 1, 1)),
    ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6, 1, 1)),
    ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6, 1, 1)),
    ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6, 1, 1)),
    ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6, 1, 1)),
    ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6, 1, 1)),
    ColorSequenceKeypoint.new(1,   Color3.fromHSV(1,   1, 1)),
})
hueGradient.Transparency = NumberSequence.new(0)

local function AskForColor(Start)
    local hue, saturation, value

    if typeof(Start) == "Color3" then
        hue, saturation, value = Color3.toHSV(Start)
    elseif typeof(Start) == "string" then
        local hex = Start:gsub("^#", "")
        local r = tonumber(hex:sub(1,2), 16) or 255
        local g = tonumber(hex:sub(3,4), 16) or 255
        local b = tonumber(hex:sub(5,6), 16) or 255
        hue, saturation, value = Color3.toHSV(Color3.fromRGB(r, g, b))
    else
        hue, saturation, value = 0, 1, 1
    end

    local isDraggingSquare = false
    local isDraggingHue    = false
    local updatingFields   = false

    Gui.ABDECKUNG.Visible   = true
    Gui.COLOR_FRAME.Visible = true

    local function updateFields()
        local color = Color3.fromHSV(hue, saturation, value)
        local r = math.round(color.R * 255)
        local g = math.round(color.G * 255)
        local b = math.round(color.B * 255)
        updatingFields = true
        Gui.R_FELD.Text   = tostring(r)
        Gui.G_FELD.Text   = tostring(g)
        Gui.B_FELD.Text   = tostring(b)
        Gui.HEX_FELD.Text = string.format("%02X%02X%02X", r, g, b)
        updatingFields = false
    end

    local function updateColor()
        Gui.MAIN_COLOR_FIELD.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)

        -- Weißer Gradient: links opak weiß → rechts transparent
        local whiteFrame = Gui.MAIN_COLOR_FIELD:GetChildren()[1] -- erster Frame
        local whiteGradient = whiteFrame:FindFirstChildOfClass("UIGradient")
        if whiteGradient then
            whiteGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
            })
            whiteGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1),
            })
        end

        -- Schwarzer Gradient: oben transparent → unten opak schwarz
        local blackFrame = Gui.MAIN_COLOR_FIELD:GetChildren()[2] -- zweiter Frame
        local blackGradient = blackFrame:FindFirstChildOfClass("UIGradient")
        if blackGradient then
            blackGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
            })
            blackGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 0),
            })
            blackGradient.Rotation = 90
        end

        Gui.COLOR_PREVIEW.BackgroundColor3 = Color3.fromHSV(hue, saturation, value)
        updateFields()
    end

    local function applyHSVToDraggers()
        Gui.Main_Dragger.Position = UDim2.fromScale(saturation, 1 - value)
        Gui.DRAGGER.Position      = UDim2.fromScale(hue, 0.5)
        updateColor()
    end

    local function getMousePos()
        local mouse = UserInputService:GetMouseLocation()
        local inset = GuiService:GetGuiInset()
        return mouse - inset
    end

    local function applySquare()
        local mouse   = getMousePos()
        local absPos  = Gui.MAIN_COLOR_FIELD.AbsolutePosition
        local absSize = Gui.MAIN_COLOR_FIELD.AbsoluteSize
        local x = math.clamp((mouse.X - absPos.X) / absSize.X, 0, 1)
        local y = math.clamp((mouse.Y - absPos.Y) / absSize.Y, 0, 1)
        saturation = x
        value      = 1 - y
        Gui.Main_Dragger.Position = UDim2.fromScale(x, y)
        updateColor()
    end

    local function applyHue()
        local mouse   = getMousePos()
        local absPos  = Gui.COLOR_DRAGGER_FRAME.AbsolutePosition
        local absSize = Gui.COLOR_DRAGGER_FRAME.AbsoluteSize
        local x = math.clamp((mouse.X - absPos.X) / absSize.X, 0, 1)
        hue = x
        Gui.DRAGGER.Position = UDim2.fromScale(x, 0.5)
        updateColor()
    end

    local function applyFromRGB()
        if updatingFields then return end
        local r = tonumber(Gui.R_FELD.Text)
        local g = tonumber(Gui.G_FELD.Text)
        local b = tonumber(Gui.B_FELD.Text)
        if not (r and g and b) then return end
        r = math.clamp(r, 0, 255)
        g = math.clamp(g, 0, 255)
        b = math.clamp(b, 0, 255)
        hue, saturation, value = Color3.toHSV(Color3.fromRGB(r, g, b))
        applyHSVToDraggers()
    end

    local function applyFromHex()
        if updatingFields then return end
        local hex = Gui.HEX_FELD.Text:gsub("^#", ""):upper()
        if #hex ~= 6 then return end
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16)
        local b = tonumber(hex:sub(5,6), 16)
        if not (r and g and b) then return end
        hue, saturation, value = Color3.toHSV(Color3.fromRGB(r, g, b))
        applyHSVToDraggers()
    end

    applyHSVToDraggers()

    local connections = {}
    local function connect(signal, fn)
        local c = signal:Connect(fn)
        table.insert(connections, c)
        return c
    end

    connect(Gui.MAIN_COLOR_FIELD.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSquare = true
            applySquare()
        end
    end)

    connect(Gui.Main_Dragger.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSquare = true
            applySquare()
        end
    end)

    connect(Gui.COLOR_DRAGGER_FRAME.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingHue = true
            applyHue()
        end
    end)

    connect(Gui.DRAGGER.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingHue = true
            applyHue()
        end
    end)

    connect(UserInputService.InputChanged, function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if isDraggingSquare then applySquare() end
        if isDraggingHue    then applyHue()    end
    end)

    connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSquare = false
            isDraggingHue    = false
        end
    end)

    connect(Gui.R_FELD.FocusLost,   applyFromRGB)
    connect(Gui.G_FELD.FocusLost,   applyFromRGB)
    connect(Gui.B_FELD.FocusLost,   applyFromRGB)
    connect(Gui.HEX_FELD.FocusLost, applyFromHex)

    local thread = coroutine.running()

    connect(Gui.CloseButton.MouseButton1Click, function()
        for _, c in ipairs(connections) do c:Disconnect() end
        Gui.ABDECKUNG.Visible   = false
        Gui.COLOR_FRAME.Visible = false
        local hex = Gui.HEX_FELD.Text:gsub("^#", ""):upper()
        coroutine.resume(thread, hex)
    end)

    return coroutine.yield()
end

-- ════════════════════════
-- ══  Character Getter  ══
-- ════════════════════════

-- Game-spezifische WORKSPACE_PLAYERS Pfade
local GAME_WORKSPACE_PATHS = {
    [807930589] = function() return workspace:FindFirstChild("WORKSPACE_Entities"):FindFirstChild("Players") end
}

local WORKSPACE_PLAYERS_NODE = nil

local function _resolveWorkspacePlayers()
    -- 1. Spiel-spezifischer Pfad?
    local gameId = game.GameId
    if GAME_WORKSPACE_PATHS[gameId] then
        local result = GAME_WORKSPACE_PATHS[gameId]()
        if result then return result end
    end

    return nil
end

local function GetCharacter(player, childName)
    if not player then return nil end

    local char = nil

    -- Versuche zuerst game-spezifischen WORKSPACE-Ordner
    if not WORKSPACE_PLAYERS_NODE then
        WORKSPACE_PLAYERS_NODE = _resolveWorkspacePlayers()
    end

    if WORKSPACE_PLAYERS_NODE then
        char = WORKSPACE_PLAYERS_NODE:FindFirstChild(player.Name)
    end

    -- Fallback: player.Character (NICHT rekursiv!)
    if not char then
        char = player.Character
    end

    if not char then return nil end

    if childName then
        return char:FindFirstChild(childName)
    end

    return char
end

-- Gibt HumanoidRootPart zurück (mit Fallback-Chain)
local function GetHRP(player)
    local char = GetCharacter(player)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("Torso")
end

-- Cache zurücksetzen wenn Spieler Spiel verlässt
Players.PlayerRemoving:Connect(function(player)
    -- Node selbst ist statisch, kein Cache nötig
end)

-- Node bei Bedarf neu auflösen (z.B. nach Teleport / Map-Wechsel)
workspace.ChildAdded:Connect(function()
    WORKSPACE_PLAYERS_NODE = nil  -- lazy re-resolve beim nächsten Aufruf
end)

-- =====================
-- TABLES
-- =====================

local SwitchFunctions       = {}
local DragFunctions         = {
    ["AIMBOT_FOV"] = 150,
}
local FunctionsSettings     = {}
local KeybindFunctions      = {}
local ColorFunctions        = {}
local SelectionFunctions    = {}
local ListFunctions         = {}   -- [Function_Name] = aktuell ausgewählter Eintrag (string)
local FavouriteFunctions    = {}
local SwitchUICallbacks     = {}
local FriendList            = {}

-- Panic Mode

local PanicSwitchFunctions  = {}
local PanicKeybindFunctions = {}

local ESPDefaultColors      = {
    ESP_SKELETON_ENABLE          = Color3.fromRGB(255, 255, 255),
    ESP_BOX_ENABLE               = Color3.fromRGB(255, 255, 255),
    ESP_CORNER_BOX_ENABLE        = Color3.fromRGB(255, 255, 255),
    ESP_BOX_FILL_ENABLE          = Color3.fromRGB(255, 255, 255),
    ESP_TRACER_ENABLE            = Color3.fromRGB(255, 255, 255),
    ESP_FRIENDLY_COLOR           = Color3.fromRGB(255, 255, 255),
    ESP_ENEMY_COLOR              = Color3.fromRGB(255, 255, 255),
    ESP_SELF_COLOR               = Color3.fromRGB(255, 255, 255),
    -- Freund-Farben (je ESP-Element einzeln)
    ESP_FRIEND_SKELETON_COLOR    = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_BOX_COLOR         = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_CORNER_BOX_COLOR  = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_BOX_FILL_COLOR    = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_TRACER_COLOR      = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_ARROW_COLOR       = Color3.fromRGB(0, 255, 128),
    ESP_FRIEND_HEAD_CIRCLE_COLOR = Color3.fromRGB(0, 255, 128),
}

local function getESPColor(key)
    local hex = ColorFunctions[key]
    if type(hex) == "string" and #hex >= 6 then
        local r = tonumber(hex:sub(1,2), 16) or 255
        local g = tonumber(hex:sub(3,4), 16) or 255
        local b = tonumber(hex:sub(5,6), 16) or 255
        return Color3.fromRGB(r, g, b)
    end
    return ESPDefaultColors[key] or Color3.fromRGB(255, 255, 255)
end

-- =====================
-- KEYBIND LISTEN LOGIC
-- =====================

local waitingForKeybind = nil

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not waitingForKeybind then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode == Enum.KeyCode.Unknown then return end

    local fn = waitingForKeybind
    waitingForKeybind = nil

    -- Backspace = Keybind entfernen (Unbind)
    if input.KeyCode == Enum.KeyCode.Backspace then
        KeybindFunctions[fn] = nil
        print("[Keybind] " .. fn .. " = Unbound")
        if FunctionsSettings[fn] and FunctionsSettings[fn].OnKeybindChanged then
            FunctionsSettings[fn].OnKeybindChanged(nil)
        end
        return
    end

    KeybindFunctions[fn] = input.KeyCode
    print("[Keybind] " .. fn .. " = " .. tostring(input.KeyCode.Name))

    if FunctionsSettings[fn] and FunctionsSettings[fn].OnKeybindChanged then
        FunctionsSettings[fn].OnKeybindChanged(input.KeyCode)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    for fn, kc in pairs(KeybindFunctions) do
        if kc == input.KeyCode then
            local St = SwitchFunctions[fn]
            local newState = not St
            SwitchFunctions[fn] = newState
            -- UI sofort updaten
            local cbs = SwitchUICallbacks[fn]
            if cbs then
                for _, cb in ipairs(cbs) do pcall(cb, newState) end
            end
            if FunctionsSettings[fn] and FunctionsSettings[fn].OnToggle then
                FunctionsSettings[fn].OnToggle(newState)
            end
        end
    end
end)

-- =====================
-- INTERNE BUILDER
-- =====================

local AllSwitchDefs = {}

local function Build_Switch(def, ZielTab, ZielSubmenu, zIndex, isFavCopy)
    local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    local Copy
    if def.State == "normal" then
        Copy = Gui.SWITCH_EXAMPLE:Clone()
    elseif def.State == "risk" then
        Copy = Gui.SWITCH_EXAMPLE_RISK:Clone()
    elseif def.State == "testing" then
        Copy = Gui.SWITCH_EXAMPLE_TESTING:Clone()
    end
    Copy.Visible = true
    Copy.Name = isFavCopy and ("FAV_" .. def.Function_Name) or def.Name
    Copy.ZIndex = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    local Trigger    = Copy:WaitForChild("BUTTON_MAIN_FRAME"):WaitForChild("BUTTON_FRAME"):WaitForChild("BUTTON_TRIGGER")
    local Moving     = Copy:WaitForChild("BUTTON_MAIN_FRAME"):WaitForChild("BUTTON_FRAME"):WaitForChild("BUTTON_MOVING")
    local Background = Copy:WaitForChild("BUTTON_MAIN_FRAME"):WaitForChild("BUTTON_FRAME")

    if def.State == "normal" then
        Copy:WaitForChild("MainLabel").Text = def.Name
    elseif def.State == "risk" then
        Copy:WaitForChild("MainLabel").Text = def.Name .. " [RISK]"
    elseif def.State == "testing" then
        Copy:WaitForChild("MainLabel").Text = def.Name .. " [TESTING]"
    end
    Copy:WaitForChild("Description").Text = def.Description

    local SettingsBtn    = Copy:WaitForChild("ADDITIONS_FRAME"):WaitForChild("SETTINGS_BUTTON_FRAME"):WaitForChild("SETTINGS_BUTTON")
    local SettingsFrame  = Copy:WaitForChild("SETTINGS_FRAME")
    local KeepingFrame   = SettingsFrame:WaitForChild("SETTINGS_KEEPINGFRAME")
    local KeybindSetting = KeepingFrame:WaitForChild("KeybindSetting")
    local ColorSetting   = KeepingFrame:WaitForChild("ColorSetting")
    local KeybindLabel   = KeybindSetting:WaitForChild("KEYBIND_LABEL")
    local KeybindTrigger = KeybindSetting:WaitForChild("KEYBIND_TRIGGER")
    local ColorTrigger   = ColorSetting:WaitForChild("COLOR_TRIGGER")
    local ColorPreview   = ColorSetting:WaitForChild("COLORPREVIEW")
    local HsvLabel       = ColorSetting:WaitForChild("HSV_LABEL")

    KeybindSetting.Visible = (def.HasKeybind == true)
    ColorSetting.Visible   = (def.HasColor   == true)
    SettingsFrame.Visible  = false

    local hasAnyExtra = (def.HasKeybind == true) or (def.HasColor == true)
    Copy:WaitForChild("ADDITIONS_FRAME"):WaitForChild("SETTINGS_BUTTON_FRAME").Visible = hasAnyExtra

    -- ─── Auswahl-Widget ───
    local AdditionsFrame = Copy:WaitForChild("ADDITIONS_FRAME")
    local AuswahlFrame   = AdditionsFrame:WaitForChild("AUSWAHL_FRAME")
    local ZahlLabel      = AuswahlFrame:WaitForChild("ZAHL_AUSWAHL_FRAME")
    local BtnLeft        = AuswahlFrame:WaitForChild("CHOOSE_LEFT_AUSWAHL_FRAME")
    local BtnRight       = AuswahlFrame:WaitForChild("CHOOSE_RIGHT_AUSWAHL_FRAME")

    local hasSelection = (def.maxSelection ~= nil and def.maxSelection > 0)
    AuswahlFrame.Visible = hasSelection

    if hasSelection then
        if not SelectionFunctions[def.Function_Name] then
            SelectionFunctions[def.Function_Name] = 1
        end
        -- Label updaten (Name oder Zahl)
        local function updateSelLabel()
            local cur = SelectionFunctions[def.Function_Name]
            if def.selOptions then
                ZahlLabel.Text = " " .. tostring(def.selOptions[cur] or cur) .. " "
            else
                ZahlLabel.Text = tostring(cur)
            end
        end
        updateSelLabel()

        BtnRight.MouseButton1Click:Connect(function()
            local cur = SelectionFunctions[def.Function_Name]
            if cur < def.maxSelection then
                SelectionFunctions[def.Function_Name] = cur + 1
                updateSelLabel()
            end
        end)

        BtnLeft.MouseButton1Click:Connect(function()
            local cur = SelectionFunctions[def.Function_Name]
            if cur > 1 then
                SelectionFunctions[def.Function_Name] = cur - 1
                updateSelLabel()
            end
        end)
    end

    local isSettingsOpen = false
    SettingsBtn.MouseButton1Click:Connect(function()
        isSettingsOpen = not isSettingsOpen
        if isSettingsOpen then
            SettingsFrame.Visible = true
            SettingsFrame.Size = UDim2.new(0.2456, 0, 0, 0)
            TweenService:Create(SettingsBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 45}):Play()
            TweenService:Create(SettingsFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.2456, 0, 2.0921, 0), GroupTransparency = 0}):Play()
        else
            TweenService:Create(SettingsBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
            TweenService:Create(SettingsFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0.2456, 0, 0, 0), GroupTransparency = 1}):Play()
            task.delay(0.25, function() SettingsFrame.Visible = false end)
        end
    end)

    local function ApplyVisual(state)
        if def.State == "risk" then
            if state then
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.7, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(200, 40, 60)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(42, 15, 30)}):Play()
            else
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.3, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(74, 20, 35)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(26, 8, 16)}):Play()
            end
        elseif def.State == "normal" then
            if state then
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.7, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(220, 220, 225)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(55, 55, 65)}):Play()
            else
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.3, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(32, 32, 38)}):Play()
            end
        elseif def.State == "testing" then
            if state then
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.7, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 230, 40)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(170, 160, 25)}):Play()
            else
                TweenService:Create(Moving, tweeninfo, {Position = UDim2.new(0.3, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(130, 120, 20)}):Play()
                TweenService:Create(Background, tweeninfo, {BackgroundColor3 = Color3.fromRGB(65, 60, 10)}):Play()
            end
        end
    end

    if not SwitchUICallbacks[def.Function_Name] then
        SwitchUICallbacks[def.Function_Name] = {}
    end
    table.insert(SwitchUICallbacks[def.Function_Name], ApplyVisual)

    Copy.Destroying:Connect(function()
        local list = SwitchUICallbacks[def.Function_Name]
        if list then
            for i, cb in ipairs(list) do
                if cb == ApplyVisual then table.remove(list, i) break end
            end
        end
    end)

    local function ApplyAll(state)
        for _, cb in ipairs(SwitchUICallbacks[def.Function_Name] or {}) do cb(state) end
    end

    local function Toggle()
        SwitchFunctions[def.Function_Name] = not SwitchFunctions[def.Function_Name]
        ApplyAll(SwitchFunctions[def.Function_Name])
    end

    if not isFavCopy then
        AllSwitchDefs[def.Function_Name] = def
        if SwitchFunctions[def.Function_Name] == nil then
            SwitchFunctions[def.Function_Name] = (def.default == true)
        end
    end
    ApplyVisual(SwitchFunctions[def.Function_Name] == true)

    Trigger.MouseButton1Click:Connect(Toggle)

    FunctionsSettings[def.Function_Name] = FunctionsSettings[def.Function_Name] or {}
    FunctionsSettings[def.Function_Name].OnToggle = function(newState)
        SwitchFunctions[def.Function_Name] = newState
        ApplyAll(newState)
    end

    if def.HasKeybind then
        if not isFavCopy then KeybindFunctions[def.Function_Name] = nil end

        local function SetKeybindLabel(kc)
            if kc == nil then
                KeybindLabel.Text = "Keybind: Kein"
            else
                KeybindLabel.Text = "Keybind: " .. kc.Name
            end
        end
        SetKeybindLabel(KeybindFunctions[def.Function_Name])

        local isWaiting = false
        KeybindTrigger.MouseButton1Click:Connect(function()
            if isWaiting then return end
            isWaiting = true
            waitingForKeybind = def.Function_Name
            KeybindLabel.Text = "Taste / Backspace=Unbind"
        end)

        local oldOnKeybind = FunctionsSettings[def.Function_Name].OnKeybindChanged
        FunctionsSettings[def.Function_Name].OnKeybindChanged = function(kc)
            isWaiting = false
            SetKeybindLabel(kc)
            if oldOnKeybind then oldOnKeybind(kc) end
        end

        if isFavCopy then
            local prev = FunctionsSettings[def.Function_Name].OnKeybindChanged
            FunctionsSettings[def.Function_Name].OnKeybindChanged = function(kc)
                isWaiting = false
                SetKeybindLabel(kc)
                if prev then prev(kc) end
            end
        end
    end

    if def.HasColor then
        local colorKey = def.Function_Name

        if not isFavCopy then
            if not ColorFunctions[colorKey] then
                local def3 = ESPDefaultColors[colorKey]
                if def3 then
                    ColorFunctions[colorKey] = string.format("%02X%02X%02X",
                        math.round(def3.R * 255),
                        math.round(def3.G * 255),
                        math.round(def3.B * 255))
                else
                    ColorFunctions[colorKey] = "FFFFFF"
                end
            end
        end

        local function ApplyColorToUI(hex)
            local r = tonumber(hex:sub(1,2), 16) or 255
            local g = tonumber(hex:sub(3,4), 16) or 255
            local b = tonumber(hex:sub(5,6), 16) or 255
            ColorPreview.BackgroundColor3 = Color3.fromRGB(r, g, b)
            HsvLabel.Text = "#" .. hex
        end

        ApplyColorToUI(ColorFunctions[colorKey] or "FFFFFF")

        if not FunctionsSettings[def.Function_Name].ColorCallbacks then
            FunctionsSettings[def.Function_Name].ColorCallbacks = {}
        end
        table.insert(FunctionsSettings[def.Function_Name].ColorCallbacks, ApplyColorToUI)

        Copy.Destroying:Connect(function()
            local cbs = FunctionsSettings[def.Function_Name] and FunctionsSettings[def.Function_Name].ColorCallbacks
            if cbs then
                for i, cb in ipairs(cbs) do
                    if cb == ApplyColorToUI then table.remove(cbs, i) break end
                end
            end
        end)

        ColorTrigger.MouseButton1Click:Connect(function()
            SettingsFrame.Visible = false
            local startHex = ColorFunctions[colorKey] or "FFFFFF"
            local r0 = tonumber(startHex:sub(1,2), 16) or 255
            local g0 = tonumber(startHex:sub(3,4), 16) or 255
            local b0 = tonumber(startHex:sub(5,6), 16) or 255

            local hex = AskForColor(Color3.fromRGB(r0, g0, b0))
            hex = hex:gsub("^#", ""):upper()
            ColorFunctions[colorKey] = hex

            for _, cb in ipairs(FunctionsSettings[def.Function_Name].ColorCallbacks or {}) do cb(hex) end
            print("[Color] " .. def.Function_Name .. " = #" .. hex)
        end)
    end

    local FavBtn      = Copy:WaitForChild("ADDITIONS_FRAME"):WaitForChild("FAVOURITE_BUTTON_FRAME"):WaitForChild("FAVOURITE_BUTTON")
    local FavBtnFrame = Copy:WaitForChild("ADDITIONS_FRAME"):WaitForChild("FAVOURITE_BUTTON_FRAME")

    local FAV_IMAGE_OFF = "rbxassetid://90912994285683"
    local FAV_IMAGE_ON  = "rbxassetid://84260582876317"

    if isFavCopy then
        FavBtnFrame.Visible = true
        FavBtn.Image = FAV_IMAGE_ON

        FavBtn.MouseButton1Click:Connect(function()
            TweenService:Create(FavBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Rotation = -30, Size = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            task.delay(0.2, function() Copy:Destroy() end)

            FavouriteFunctions[def.Function_Name] = false

            for _, tab in ipairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
                if tab:IsA("Frame") and tab.Name ~= "HOME" then
                    for _, submenu in ipairs(tab:GetChildren()) do
                        if submenu:IsA("ScrollingFrame") then
                            local original = submenu:FindFirstChild(def.Name)
                            if original then
                                local origFavBtn = original:FindFirstChild("FAVOURITE_BUTTON_FRAME")
                                    and original.FAVOURITE_BUTTON_FRAME:FindFirstChild("FAVOURITE_BUTTON")
                                if origFavBtn then
                                    origFavBtn.Image = FAV_IMAGE_OFF
                                    origFavBtn.Rotation = 0
                                    TweenService:Create(origFavBtn, TweenInfo.new(0.15), {Size = UDim2.new(0.8104, 0, 0.8104, 0)}):Play()
                                end
                            end
                        end
                    end
                end
            end
        end)
        return
    end

    if not FavouriteFunctions[def.Function_Name] then
        FavouriteFunctions[def.Function_Name] = false
    end

    FavBtn.Image = FavouriteFunctions[def.Function_Name] and FAV_IMAGE_ON or FAV_IMAGE_OFF

    FavBtn.MouseButton1Click:Connect(function()
        local isFav = not FavouriteFunctions[def.Function_Name]
        FavouriteFunctions[def.Function_Name] = isFav

        if isFav then
            FavBtn.Image = FAV_IMAGE_ON
            FavBtn.Rotation = 0
            local spinTween = TweenService:Create(FavBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Rotation = 360, Size = UDim2.new(1.1, 0, 1.1, 0)
            })
            spinTween:Play()
            spinTween.Completed:Connect(function()
                FavBtn.Rotation = 0
                TweenService:Create(FavBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.8104, 0, 0.8104, 0)}):Play()
            end)
            Build_Switch(def, "HOME", "HOME_FAVOURITES", 50, true)
            SendNotify(def.Name .. " zu Favoriten hinzugefügt!")
        else
            FavBtn.Image = FAV_IMAGE_OFF
            TweenService:Create(FavBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Rotation = -30, Size = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            task.delay(0.2, function()
                FavBtn.Rotation = 0
                TweenService:Create(FavBtn, TweenInfo.new(0.15), {Size = UDim2.new(0.8104, 0, 0.8104, 0)}):Play()
            end)

            local favSubmenu = Gui.MAIN_CONTENT_FRAME:FindFirstChild("HOME") and
                               Gui.MAIN_CONTENT_FRAME.HOME:FindFirstChild("HOME_FAVOURITES")
            if favSubmenu then
                local existing = favSubmenu:FindFirstChild("FAV_" .. def.Function_Name)
                if existing then existing:Destroy() end
            end
            SendNotify(def.Name .. " von Favoriten entfernt!")
        end
    end)
    local FavBtnFrameInAdd   = AdditionsFrame:FindFirstChild("FAVOURITE_BUTTON_FRAME")
    local SettingsBtnFrame   = AdditionsFrame:FindFirstChild("SETTINGS_BUTTON_FRAME")
    if FavBtnFrameInAdd   then FavBtnFrameInAdd.LayoutOrder   = 2 end
    if SettingsBtnFrame   then SettingsBtnFrame.LayoutOrder   = 3 end
    AuswahlFrame.LayoutOrder = 1
end

local function Build_Button(def, ZielTab, ZielSubmenu, zIndex)
    local Copy = Gui.BUTTON_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name    = def.Name
    Copy.ZIndex  = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    Copy:WaitForChild("MainLabel").Text   = def.Name
    Copy:WaitForChild("Description").Text = def.Description

    local KeepingFrame     = Copy:WaitForChild("KEEPING_FRAME")
    local ExecuteMainFrame = KeepingFrame:WaitForChild("EXECUTE_MAIN_FRAME")
    local ExecuteFrame     = ExecuteMainFrame:WaitForChild("EXECUTE_FRAME")
    local ExecuteTrigger   = ExecuteFrame:WaitForChild("EXECUTE_TRIGGER")
    local SearchMainFrame  = KeepingFrame:WaitForChild("SEARCHBAR_MAIN_FRAME")
    local SearchTextBox    = SearchMainFrame:WaitForChild("SEARCHBAR_TEXTBOX")
    local ButtonText       = ExecuteFrame:WaitForChild("TextLabel")

    ButtonText.Text = " " .. def.Button_Text .. " " or " Execute "

    -- Searchbar
    if def.HasSearch then
        SearchMainFrame.Visible        = true
        SearchTextBox.PlaceholderText  = tostring(def.SearchPlaceholder or "Suchen...")

        local function fire()
            FunctionsSettings[def.Function_Name] = FunctionsSettings[def.Function_Name] or {}
            if FunctionsSettings[def.Function_Name].OnExecute then
                FunctionsSettings[def.Function_Name].OnExecute(SearchTextBox.Text)
            end
            SearchTextBox.Text = ""
        end

        SearchTextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then fire() end
        end)
        ExecuteTrigger.MouseButton1Click:Connect(fire)
    else
        SearchMainFrame.Visible = false

        ExecuteTrigger.MouseButton1Click:Connect(function()
            warn("[BTN] " .. def.Function_Name .. " clicked, OnExecute = " .. tostring(FunctionsSettings[def.Function_Name] and FunctionsSettings[def.Function_Name].OnExecute ~= nil))
            FunctionsSettings[def.Function_Name] = FunctionsSettings[def.Function_Name] or {}
            if FunctionsSettings[def.Function_Name].OnExecute then
                FunctionsSettings[def.Function_Name].OnExecute()
            end
        end)
    end

    -- Hover-Effekt auf Execute-Button
    local normalColor = Color3.fromRGB(25, 25, 30)
    local hoverColor  = Color3.fromRGB(55, 55, 65)
    local clickColor  = Color3.fromRGB(220, 220, 225)
    local tweenIn     = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenOut    = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    ExecuteTrigger.MouseEnter:Connect(function()
        TweenService:Create(ExecuteFrame, tweenIn, {BackgroundColor3 = hoverColor}):Play()
        TweenService:Create(ExecuteFrame, tweenIn, {Size = UDim2.new(1.03, 0, 1.06, 0)}):Play()
    end)
    ExecuteTrigger.MouseLeave:Connect(function()
        TweenService:Create(ExecuteFrame, tweenOut, {BackgroundColor3 = normalColor}):Play()
        TweenService:Create(ExecuteFrame, tweenOut, {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    ExecuteTrigger.MouseButton1Click:Connect(function()
        TweenService:Create(ExecuteFrame, TweenInfo.new(0.08), {BackgroundColor3 = clickColor}):Play()
        TweenService:Create(ExecuteFrame, TweenInfo.new(0.06), {Size = UDim2.new(0.97, 0, 0.95, 0)}):Play()
        task.delay(0.12, function()
            TweenService:Create(ExecuteFrame, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
            TweenService:Create(ExecuteFrame, TweenInfo.new(0.12), {Size = UDim2.new(1, 0, 1, 0)}):Play()
        end)
    end)
end

local function Build_Choose(def, ZielTab, ZielSubmenu, zIndex)
    local Copy = Gui.CHOOSE_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name    = def.Name
    Copy.ZIndex  = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    Copy:WaitForChild("MainLabel").Text   = def.Name
    Copy:WaitForChild("Description").Text = def.Description

    -- Auswahl-Widget
    local AdditionsFrame = Copy:WaitForChild("ADDITIONS_FRAME")
    local AuswahlFrame   = AdditionsFrame:WaitForChild("AUSWAHL_FRAME")
    local ZahlLabel      = AuswahlFrame:WaitForChild("ZAHL_AUSWAHL_FRAME")
    local BtnLeft        = AuswahlFrame:WaitForChild("CHOOSE_LEFT_AUSWAHL_FRAME")
    local BtnRight       = AuswahlFrame:WaitForChild("CHOOSE_RIGHT_AUSWAHL_FRAME")
    AuswahlFrame.Visible = true

    -- Startwert initialisieren
    if not SelectionFunctions[def.Function_Name] then
        SelectionFunctions[def.Function_Name] = def.defaultIndex
    end

    local function updateLabel()
        local cur = SelectionFunctions[def.Function_Name]
        ZahlLabel.Text = " " .. tostring(def.options[cur] or cur) .. " "
    end
    updateLabel()

    BtnRight.MouseButton1Click:Connect(function()
        local cur = SelectionFunctions[def.Function_Name]
        if cur < #def.options then
            SelectionFunctions[def.Function_Name] = cur + 1
            updateLabel()
        end
    end)

    BtnLeft.MouseButton1Click:Connect(function()
        local cur = SelectionFunctions[def.Function_Name]
        if cur > 1 then
            SelectionFunctions[def.Function_Name] = cur - 1
            updateLabel()
        end
    end)
end


local function Build_List(def, ZielTab, ZielSubmenu, zIndex)
    -- Clone des LIST_EXAMPLE als Basis
    local Copy = Gui.LIST_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name    = def.Name
    Copy.ZIndex  = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    Copy:WaitForChild("MainLabel").Text   = def.Name
    Copy:WaitForChild("Description").Text = def.Description

    -- Refs auf die wichtigsten Kinder
    local AdditionsFrame = Copy:WaitForChild("ADDITIONS_FRAME")
    local ListFrame      = AdditionsFrame:WaitForChild("LIST_FRAME")
    local CurrentLabel   = ListFrame:WaitForChild("LIST_FRAME_CURRENT")
    local Trigger        = ListFrame:WaitForChild("LIST_FRAME_TRIGGER")

    -- Dropdown: LIST_DROPDOWN_EXAMPLE clonen (bereits fertig designed)
    local Dropdown      = Gui.LIST_DROPDOWN_EXAMPLE:Clone()
    Dropdown.Name       = "List_Dropdown"
    Dropdown.Size       = UDim2.new(1, 0, 0, 0)   -- startet zugeklappt
    Dropdown.Visible    = false
    Dropdown.Parent     = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)

    local Moving       = Dropdown:WaitForChild("LIST_DROPDOWN_MOVING")
    local DropdownList = Moving:WaitForChild("LIST_DROPDOWN_BUTTONCONTAINER")

    local BtnTemplate = Gui.LIST_DROPDOWN_BUTTON_EXAMPLE:Clone()
    BtnTemplate.Visible = false
    BtnTemplate.Parent = DropdownList  -- temporärer Parent damit FindFirstChild etc. funktioniert

    -- Zustand
    local isOpen    = false
    local lastItems = {}

    -- Hilfsfunktion: Dropdown-Inhalt befüllen
    local function populateDropdown(items)
        -- Alle geclonten Einträge löschen (Template selbst bleibt, da Visible=false)
        for _, ch in ipairs(DropdownList:GetChildren()) do
            if ch:IsA("Frame") and ch.Name ~= "LIST_DROPDOWN_BUTTON_EXAMPLE" then ch:Destroy() end
        end

        for _, itemText in ipairs(items) do
            if not BtnTemplate then continue end
            local Btn = BtnTemplate:Clone()
            Btn.Name = "LIST_DROPDOWN_BUTTON"
            Btn.Visible = true

            -- FindFirstChild statt WaitForChild → kein Infinite-yield
            local BtnText = Btn:FindFirstChild("LIST_DROPDOWN_BUTTON_TEXT")
            if BtnText then BtnText.Text = tostring(itemText) end

            Btn.Parent = DropdownList

            -- Klick auf Eintrag
            local BtnTrigger = Btn:FindFirstChildWhichIsA("TextButton") or Btn
            BtnTrigger.MouseButton1Click:Connect(function()
                ListFunctions[def.Function_Name] = tostring(itemText)
                CurrentLabel.Text = tostring(itemText)

                -- Callback
                if FunctionsSettings[def.Function_Name] and FunctionsSettings[def.Function_Name].OnSelect then
                    FunctionsSettings[def.Function_Name].OnSelect(tostring(itemText))
                end

                -- Dropdown schließen (Tween auf Dropdown = Parent von Moving)
                isOpen = false
                TweenService:Create(Dropdown, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, 0)
                }):Play()
                task.delay(0.19, function()
                    Dropdown.Visible = false
                    Dropdown.Size    = UDim2.new(1, 0, 0.644, 0)
                end)
            end)
        end
    end

    -- Startwert
    if not ListFunctions[def.Function_Name] then
        local startItems = type(def.List) == "function" and def.List() or def.List
        ListFunctions[def.Function_Name] = (startItems and startItems[1]) or ""
    end
    CurrentLabel.Text = tostring(ListFunctions[def.Function_Name])

    -- Dropdown öffnen / schließen
    -- Tween läuft immer auf Dropdown (Parent von Moving), nicht auf Moving selbst
    local function toggleDropdown()
        if isOpen then
            -- Schließen
            isOpen = false
            TweenService:Create(Dropdown, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.delay(0.19, function()
                Dropdown.Visible = false
                Dropdown.Size    = UDim2.new(1, 0, 0.644, 0)
            end)
        else
            -- Öffnen – Inhalt aktuell befüllen
            local currentItems = type(def.List) == "function" and def.List() or def.List
            populateDropdown(currentItems or {})
            Dropdown.Size    = UDim2.new(1, 0, 0, 0)
            Dropdown.Visible = true
            TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0.644, 0)
            }):Play()
            isOpen = true
        end
    end

    Trigger.MouseButton1Click:Connect(toggleDropdown)

    -- Wenn List eine Funktion ist: alle 1 Sekunde aktualisieren (auch wenn zu)
    if type(def.List) == "function" then
        task.spawn(function()
            while Copy.Parent do
                task.wait(1)
                if not Copy.Parent then break end

                local newItems = def.List()
                if isOpen then
                    populateDropdown(newItems or {})
                end

                local found = false
                for _, v in ipairs(newItems or {}) do
                    if tostring(v) == tostring(ListFunctions[def.Function_Name]) then
                        found = true; break
                    end
                end
                if not found and newItems and newItems[1] then
                    ListFunctions[def.Function_Name] = tostring(newItems[1])
                    CurrentLabel.Text = tostring(newItems[1])
                end
            end
        end)
    end
end

local function Build_Trenner(def, ZielTab, ZielSubmenu, zIndex)
    local Copy = Gui.MAIN_TEXT_TRENNER_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name = def.Text
    Copy.ZIndex = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)

    local dashes = string.rep("─", 20)
    Copy:WaitForChild("TEXT_TRENNER"):WaitForChild("TEXT_TRENNER_LABEL").Text = dashes .. "  " .. def.Text .. "  " .. dashes
end

local function Build_Drag(def, ZielTab, ZielSubmenu, zIndex)
    local Copy = Gui.DRAG_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name = def.Name
    Copy.ZIndex = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    Copy:WaitForChild("MainLabel").Text   = def.Name
    Copy:WaitForChild("Description").Text = def.Description

    local DragBg  = Copy:WaitForChild("DragBackground")
    local Slider = nil
    for _, child in ipairs(DragBg:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChildWhichIsA("UIDragDetector") then
            Slider = child
            break
        end
    end
    local Detector   = Slider and Slider:FindFirstChildWhichIsA("UIDragDetector")
    local PercentLbl = Copy:WaitForChild("PercentLabel")

    local steps   = def.steps   or 100
    local default = def.default or 0
    local current = default

    if DragFunctions[def.Function_Name] == nil then
        DragFunctions[def.Function_Name] = current
    end
    current = DragFunctions[def.Function_Name]
    PercentLbl.Text = tostring(current)

    -- Slider Position setzen
    if Slider then
        local halfWidth = Slider.Size.X.Scale / 2
        local minScale = halfWidth
        local maxScale = 1 - halfWidth
        local normalized = math.clamp(current / steps, 0, 1)
        Slider.Position = UDim2.new(minScale + normalized * (maxScale - minScale), 0, 0.5, 0)
    end

    -- Drag Callback - HIER IST DER WICHTIGE TEIL
    if Detector then
        local halfWidth = Slider.Size.X.Scale / 2
        local minScale = halfWidth
        local maxScale = 1 - halfWidth

        -- Offset BEHALTEN, aber nach jedem Move korrigieren
        Detector.ResponseStyle = Enum.UIDragDetectorResponseStyle.Offset

        Detector.DragContinue:Connect(function()
            -- Offset → Scale umrechnen relativ zu DragBackground
            local bgAbsWidth = DragBg.AbsoluteSize.X
            local sliderAbsX = Slider.AbsolutePosition.X
            local bgAbsX = DragBg.AbsolutePosition.X

            local rawScale = (sliderAbsX - bgAbsX) / bgAbsWidth + halfWidth
            local clampedScale = math.clamp(rawScale, minScale, maxScale)

            -- Zurück auf saubere Scale-Position setzen
            Slider.Position = UDim2.new(clampedScale, 0, 0.5, 0)

            local normalized = (clampedScale - minScale) / (maxScale - minScale)
            current = math.round(normalized * steps)
            DragFunctions[def.Function_Name] = current
            PercentLbl.Text = tostring(current)

            if FunctionsSettings[def.Function_Name] then
                if FunctionsSettings[def.Function_Name].OnDrag then
                    FunctionsSettings[def.Function_Name].OnDrag(current)
                end
                if FunctionsSettings[def.Function_Name].OnChange then
                    FunctionsSettings[def.Function_Name].OnChange(current)
                end
            end
        end)
    end
    
    -- Initialisiere FunctionsSettings mit Callbacks
    FunctionsSettings[def.Function_Name] = FunctionsSettings[def.Function_Name] or {}
    
    -- OnChange Callback (für Kompatibilität mit bestehenden ProtectedExecute Blöcken)
    FunctionsSettings[def.Function_Name].OnChange = function(newValue)
        current = newValue
        DragFunctions[def.Function_Name] = newValue
        PercentLbl.Text = tostring(newValue)
        if Slider then
            local halfWidth = Slider.Size.X.Scale / 2
            local minScale = halfWidth
            local maxScale = 1 - halfWidth
            local normalized = math.clamp(newValue / steps, 0, 1)
            Slider.Position = UDim2.new(minScale + normalized * (maxScale - minScale), 0, 0.5, 0)
        end
    end
    
    -- OnDrag Callback (für die SilentAim Drags)
    FunctionsSettings[def.Function_Name].OnDrag = function(newValue)
        if FunctionsSettings[def.Function_Name].OnChange then
            FunctionsSettings[def.Function_Name].OnChange(newValue)
        end
    end
end

local function Build_Keybind(def, ZielTab, ZielSubmenu, zIndex)
    local Copy = Gui.KEYBIND_EXAMPLE:Clone()
    Copy.Visible = true
    Copy.Name    = def.Name
    Copy.ZIndex  = zIndex or 100
    for _, child in ipairs(Copy:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.ZIndex = child.ZIndex + (zIndex or 100)
        end
    end
    Copy.Parent = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)
    Copy:WaitForChild("FUNCTION_NAME").Value = def.Function_Name

    Copy:WaitForChild("MainLabel").Text   = def.Name
    Copy:WaitForChild("Description").Text = def.Description

    local KeepingFrame  = Copy:WaitForChild("KEEPING_FRAME")
    local KeybindFrame  = KeepingFrame:WaitForChild("KEYBIND_MAIN_FRAME"):WaitForChild("KEYBIND_FRAME")
    local KeybindLabel  = KeybindFrame:WaitForChild("KEYBIND_TEXTLABEL")
    local KeybindTrigger = KeybindLabel:WaitForChild("KEYBIND_TRIGGER")

    -- Initialisieren
    if not KeybindFunctions[def.Function_Name] then
        KeybindFunctions[def.Function_Name] = nil
    end

    local function SetLabel(kc)
        if kc == nil then
            KeybindLabel.Text = " Kein Keybind gesetzt "
        else
            KeybindLabel.Text = " " .. kc.Name .. " "
        end
    end
    SetLabel(KeybindFunctions[def.Function_Name])

    -- Keybind Settings Frame (falls vorhanden)
    local SettingsFrame = Copy:FindFirstChild("SETTINGS_FRAME")
    local KeepFrame2    = SettingsFrame and SettingsFrame:FindFirstChild("SETTINGS_KEEPINGFRAME")
    local KbSetting     = KeepFrame2   and KeepFrame2:FindFirstChild("KeybindSetting")
    local KbLabel2      = KbSetting    and KbSetting:FindFirstChild("KEYBIND_LABEL")
    local KbTrigger2    = KbSetting    and KbSetting:FindFirstChild("KEYBIND_TRIGGER")

    local function SetAllLabels(kc)
        SetLabel(kc)
        if KbLabel2 then
            KbLabel2.Text = kc and ("Keybind: " .. kc.Name) or "Keybind: Kein"
        end
    end

    local isWaiting = false

    local function startWaiting()
        if isWaiting then return end
        isWaiting = true
        waitingForKeybind = def.Function_Name
        KeybindLabel.Text = " Taste / Backspace=Unbind "
        if KbLabel2 then KbLabel2.Text = "Taste / Backspace=Unbind" end
    end

    KeybindTrigger.MouseButton1Click:Connect(startWaiting)
    if KbTrigger2 then KbTrigger2.MouseButton1Click:Connect(startWaiting) end

    FunctionsSettings[def.Function_Name] = FunctionsSettings[def.Function_Name] or {}
    FunctionsSettings[def.Function_Name].OnKeybindChanged = function(kc)
        isWaiting = false
        KeybindFunctions[def.Function_Name] = kc
        SetAllLabels(kc)
        if def.OnChanged then def.OnChanged(kc) end
    end

    -- Hover-Effekt auf KeybindFrame
    local normalColor = Color3.fromRGB(25, 25, 30)
    local hoverColor  = Color3.fromRGB(55, 55, 65)
    local tweenInfo   = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    KeybindTrigger.MouseEnter:Connect(function()
        TweenService:Create(KeybindFrame, tweenInfo, {BackgroundColor3 = hoverColor}):Play()
    end)
    KeybindTrigger.MouseLeave:Connect(function()
        TweenService:Create(KeybindFrame, tweenInfo, {BackgroundColor3 = normalColor}):Play()
    end)
end

-- =====================
-- ÖFFENTLICHE API
-- =====================

local function Create_Switch(Name, Description, Function_Name, default, State, HasKeybind, HasColor, maxSelection)
    local selCount = 0
    local selOptions = nil
    if type(maxSelection) == "table" then
        selCount = #maxSelection
        selOptions = maxSelection
    elseif type(maxSelection) == "number" then
        selCount = maxSelection
    end
    return {
        type          = "switch",
        Name          = Name,
        Description   = Description,
        Function_Name = Function_Name,
        default       = default,
        State         = State        or "normal",
        HasKeybind    = HasKeybind   or false,
        HasColor      = HasColor     or false,
        maxSelection  = selCount,
        selOptions    = selOptions,
    }
end

local function Create_Button(Name, Description, Function_Name, Button_Text, HasSearch, SearchPlaceholder)
    return {
        type              = "button",
        Name              = Name,
        Description       = Description,
        Function_Name     = Function_Name,
        Button_Text       = Button_Text,
        HasSearch         = HasSearch         or false,
        SearchPlaceholder = SearchPlaceholder or "Suchen...",
    }
end

local function Create_Drag(Name, Description, Function_Name, steps, default)
    return {type = "drag", Name = Name, Description = Description, Function_Name = Function_Name, steps = steps, default = default}
end

local function Create_Choose(Name, Description, Function_Name, options, defaultIndex)
    return {
        type          = "choose",
        Name          = Name,
        Description   = Description,
        Function_Name = Function_Name,
        options       = options,       -- z.B. {"Kreis", "Pfeil"}
        defaultIndex  = defaultIndex or 1,
    }
end

-- Create_List: Dropdown-Auswahl
-- List kann eine Tabelle {}  ODER eine Funktion sein die eine Tabelle zurückgibt.
-- Wenn List eine Funktion ist, wird sie alle ~1 Sekunde abgefragt (Auto-Refresh).
-- Beispiel (statisch):
--   Create_List("Spieler", "Wähle einen Spieler", "TARGET_PLAYER", {"Alice","Bob"})
-- Beispiel (dynamisch / alle Spieler):
--   Create_List("Spieler", "Wähle einen Spieler", "TARGET_PLAYER",
--       function() local t={} for _,p in ipairs(Players:GetPlayers()) do t[#t+1]=p.Name end return t end)
local function Create_List(Name, Description, Function_Name, List)
    return {
        type          = "list",
        Name          = Name,
        Description   = Description,
        Function_Name = Function_Name,
        List          = List,   -- table oder function()->table
    }
end

local function Create_Trenner(Text)
    return {type = "trenner", Text = Text}
end

local function Create_Keybind(Name, Description, Function_Name, OnChanged)
    return {
        type          = "keybind",
        Name          = Name,
        Description   = Description,
        Function_Name = Function_Name,
        OnChanged     = OnChanged,  -- optional: function(keyCode) ... end
    }
end

local function Create_Submenu(Name, Text, elements, Default_State)
    return {type = "submenu", Name = Name, Text = Text, elements = elements, Default_State = Default_State}
end

local function Create_Tab(Name, Text, submenus, Default_State)
    local Button_Copy = Gui.TAB_BUTTON_EXAMPLE:Clone()
    local Tab_Copy    = Gui.TAB_EXAMPLE:Clone()

    Button_Copy.Parent  = Gui.SIDEBAR_MAINFRAME:WaitForChild("ScrollingFrame")
    Button_Copy.Visible = true
    Button_Copy.Name    = Name
    Button_Copy.Text    = Text
    Tab_Copy.Parent     = Gui.MAIN_CONTENT_FRAME
    Tab_Copy.Visible    = Default_State
    Tab_Copy.Name       = Name

    local Frame_Copy = Gui.SUBMENU_FRAME_EXAMPLE:Clone()
    Frame_Copy.Name    = Name
    Frame_Copy.Parent  = Gui.HEADER_MAINFRAME
    Frame_Copy.Visible = Default_State

    Button_Copy.MouseButton1Click:Connect(function()
        for _, F in pairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
            if F:IsA("Frame") then F.Visible = (F.Name == Name) end
        end
        for _, F in pairs(Gui.HEADER_MAINFRAME:GetChildren()) do
            if F:IsA("ScrollingFrame") and F.Name ~= "HIDE_CORNER" then F.Visible = false end
        end
        local headerFrame = Gui.HEADER_MAINFRAME:FindFirstChild(Name)
        if headerFrame then headerFrame.Visible = true end
    end)

    -- Subtile Scale-Animation für Tab-Button (klein → normal)
    do
        local baseSize = Button_Copy.Size
        local scaleIn  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local scaleOut = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        Button_Copy.MouseEnter:Connect(function()
            TweenService:Create(Button_Copy, scaleIn, {
                Size = UDim2.new(baseSize.X.Scale * 1.03, 0, baseSize.Y.Scale * 1.03, 0)
            }):Play()
        end)
        Button_Copy.MouseLeave:Connect(function()
            TweenService:Create(Button_Copy, scaleOut, {Size = baseSize}):Play()
        end)
        Button_Copy.MouseButton1Down:Connect(function()
            TweenService:Create(Button_Copy, TweenInfo.new(0.06), {
                Size = UDim2.new(baseSize.X.Scale * 0.97, 0, baseSize.Y.Scale * 0.97, 0)
            }):Play()
        end)
        Button_Copy.MouseButton1Up:Connect(function()
            TweenService:Create(Button_Copy, scaleOut, {Size = baseSize}):Play()
        end)
    end

    for _, submenuDef in ipairs(submenus) do
        local Frame = Gui.HEADER_MAINFRAME:WaitForChild(Name)

        local Button_Copy2 = Gui.SUBMENU_BUTTON_EXAMPLE:Clone()
        Button_Copy2.Parent  = Frame
        Button_Copy2.Visible = true
        Button_Copy2.Text    = submenuDef.Text
        Button_Copy2.Name    = submenuDef.Name

        local Submenu_Copy = Gui.SUBMENU_EXAMPLE:Clone()
        Submenu_Copy.Name    = submenuDef.Name
        Submenu_Copy.Parent  = Gui.MAIN_CONTENT_FRAME:WaitForChild(Name)
        Submenu_Copy.Visible = submenuDef.Default_State

        Button_Copy2.MouseButton1Click:Connect(function()
            for _, F in pairs(Gui.MAIN_CONTENT_FRAME:WaitForChild(Name):GetChildren()) do
                if F:IsA("Frame") or F:IsA("ScrollingFrame") then
                    F.Visible = (F.Name == submenuDef.Name)
                end
            end
        end)

        -- Subtile Scale-Animation für Submenu-Button
        do
            local baseSize2 = Button_Copy2.Size
            local scaleIn2  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local scaleOut2 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            Button_Copy2.MouseEnter:Connect(function()
                TweenService:Create(Button_Copy2, scaleIn2, {
                    Size = UDim2.new(baseSize2.X.Scale * 1.04, 0, baseSize2.Y.Scale * 1.05, 0)
                }):Play()
            end)
            Button_Copy2.MouseLeave:Connect(function()
                TweenService:Create(Button_Copy2, scaleOut2, {Size = baseSize2}):Play()
            end)
            Button_Copy2.MouseButton1Down:Connect(function()
                TweenService:Create(Button_Copy2, TweenInfo.new(0.06), {
                    Size = UDim2.new(baseSize2.X.Scale * 0.97, 0, baseSize2.Y.Scale * 0.97, 0)
                }):Play()
            end)
            Button_Copy2.MouseButton1Up:Connect(function()
                TweenService:Create(Button_Copy2, scaleOut2, {Size = baseSize2}):Play()
            end)
        end

        local elementIndex = 1
        for _, element in ipairs(submenuDef.elements) do
            local elementZIndex = 100 - (elementIndex - 1) * 2
            if element.type == "switch" then
                Build_Switch(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "drag" then
                Build_Drag(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "trenner" then
                Build_Trenner(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "button" then
                Build_Button(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "choose" then
                Build_Choose(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "list" then
                Build_List(element, Name, submenuDef.Name, elementZIndex)
            elseif element.type == "keybind" then
                Build_Keybind(element, Name, submenuDef.Name, elementZIndex)
            end
            elementIndex = elementIndex + 1
        end
    end
end

local function Build_HomepageItems(ZielTab, ZielSubmenu)
    local target = Gui.MAIN_CONTENT_FRAME:WaitForChild(ZielTab):WaitForChild(ZielSubmenu)

    local welcome = Gui.WILLKOMMEN_LABEL_EXAMPLE:Clone()
    welcome.Visible  = true
    welcome.Position = UDim2.new(0, 0, 0, 0)
    welcome.Size     = UDim2.new(1, 0, 0, 62)
    welcome.Parent   = target

    local welcome_text = welcome:WaitForChild("MainLabel")
    welcome_text.Text = "Willkommen zurück " .. (Username ~= nil and tostring(Username) or "Developer") .."!"
    
    local update = Gui.UPDATE_EXAMPLE:Clone()
    update.Visible  = true
    update.Position = UDim2.new(0, 0, 0, 0)
    update.Size     = UDim2.new(1, 0, 0, 260)
    update.Parent   = target

    local update_version_label = update:WaitForChild("UPDATE_VERSION_LABEL")
    update_version_label.Text = tostring(UpdateVersion)

    local update_date_label = update:WaitForChild("UPDATE_DATE_LABEL")
    update_date_label.Text = tostring(UpdateDate)

    local update_inhalt_frame = update:WaitForChild("UPDATE_INHALT_FRAME")

    local update_feature_example = update:WaitForChild("UPDATE_FEATURE_EXAMPLE")

    --Added
    local AddedCopy = update_feature_example:Clone()
    AddedCopy.Parent = update_inhalt_frame
    AddedCopy.Visible = true
    AddedCopy.Text = "[+] Added"
    for _, F in pairs(UpdateAdded) do
        local Copy = update_feature_example:Clone()
        Copy.Parent = update_inhalt_frame
        Copy.Visible = true
        Copy.Text = F
    end

    local ChangedCopy = update_feature_example:Clone()
    ChangedCopy.Parent = update_inhalt_frame
    ChangedCopy.Visible = true
    ChangedCopy.Text = "[/] Changed"
    --Changed
    for _, F in pairs(UpdateChanged) do
        local Copy = update_feature_example:Clone()
        Copy.Parent = update_inhalt_frame
        Copy.Visible = true
        Copy.Text = F
    end

    -- Deleted
    local RemovedCopy = update_feature_example:Clone()
    RemovedCopy.Parent = update_inhalt_frame
    RemovedCopy.Visible = true
    RemovedCopy.Text = "[-] Removed"
    for _, F in pairs(UpdateRemoved) do
        local Copy = update_feature_example:Clone()
        Copy.Parent = update_inhalt_frame
        Copy.Visible = true
        Copy.Text = F
    end

    local discord = Gui.COPY_DISCORD_LINK:Clone()
    discord.Visible  = true
    discord.Position = UDim2.new(0, 0, 0, 0)
    discord.Size     = UDim2.new(1, 0, 0, 56)
    discord.Parent   = target

    local discord_infolabel = discord:WaitForChild("COPY_DISCORD_INFO_LABEL")

    local discord_trigger = discord:WaitForChild("COPY_DISCORD_LINK_TRIGGER")
    discord_trigger.MouseButton1Click:Connect(function()
        setclipboard("discord.gg/NVbNPRVtPa")
        discord_infolabel.Text = "Link kopiert!"
        discord_infolabel.TextColor3 = Color3.fromRGB(29, 195, 0)
        wait(2)
        discord_infolabel.Text = "discord.gg/NVbNPRVtPa"
        discord_infolabel.TextColor3 = Color3.fromRGB(38, 38, 45)
    end)

    local website = Gui.COPY_WEBSITE_LINK:Clone()
    website.Visible  = true
    website.Position = UDim2.new(0, 0, 0, 0)
    website.Size     = UDim2.new(1, 0, 0, 56)
    website.Parent   = target

    local website_infolabel = website:WaitForChild("COPY_WEBSITE_INFO_LABEL")

    local Website_trigger = website:WaitForChild("COPY_WEBSITE_LINK_TRIGGER")
    Website_trigger.MouseButton1Click:Connect(function()
        setclipboard("https://vexaris-menu.vercel.app")
        website_infolabel.Text = "Link kopiert!"
        website_infolabel.TextColor3 = Color3.fromRGB(29, 195, 0)
        wait(2)
        website_infolabel.Text = "https://vexaris-menu.vercel.app"
        website_infolabel.TextColor3 = Color3.fromRGB(38, 38, 45)

    end)

end

-- ============================================================
-- MENU AUFBAU
-- ============================================================

SendNotify("Willkommen " .. Username .. "!")

local GermanRail = false
local Rivals = false
local Murder_Mystery_2 = false
local Jailbird = false

local function Build_Menu()
    -- Prüfen ob HOME Tab schon existiert (verhindert Doppel-Tabs)
    if Gui.MAIN_CONTENT_FRAME:FindFirstChild("HOME") then
        for _, child in ipairs(Gui.SIDEBAR_MAINFRAME.ScrollingFrame:GetChildren()) do
            if not child:IsA("UIListLayout") then child:Destroy() end
        end
        for _, child in ipairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
            child:Destroy()
        end
        for _, child in ipairs(Gui.HEADER_MAINFRAME:GetChildren()) do
            if child:IsA("ScrollingFrame") then child:Destroy() end
        end
    end

    Create_Tab("HOME", "Home", {
        Create_Submenu("HOME_INFO", "Info", {}, true),
        Create_Submenu("HOME_FAVOURITES", "Favoriten", {}, false)
    }, true)

    Build_HomepageItems("HOME", "HOME_INFO")

    Create_Tab("COMBAT", "Combat", {
        Create_Submenu("COMBAT_AIMBOT", "Aimbot", {
            Create_Switch("Aimbot", "Zielt automatisch auf den nächsten Spieler im FOV", "AIMBOT_ENABLE", false, "normal", true, false, 0),
            Create_Switch("FOV anzeigen", "Zeigt den Zielbereich als Kreis auf dem Bildschirm an", "AIMBOT_FOV_ENABLE", true, "normal", true, true, 0),
            Create_Drag("FOV Radius", "Größe des Zielbereichs in Pixeln (kleiner = präziser)", "AIMBOT_FOV", 400, 50),
            Create_Drag("Smoothness", "Wie sanft die Kamera zum Ziel gleitet (höher = langsamer)", "AIMBOT_SMOOTHNES", 200, 0),
            Create_Choose("Priority Mode", "How the aimbot selects targets", "AIMBOT_PRIORITY_MODE", {"Crosshair", "Distance 3D", "Low HP", "Cyclic", "Lock First"}, 1),
            Create_Switch("Prediction", "Berechnet die zukünftige Position des Ziels anhand seiner Bewegung + Ping", "AIMBOT_PREDICTION_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Checks"),
            Create_Switch("Friend Check", "Ignores your friends", "AIMBOT_FRIEND_CHECK_ENABLE", false, "normal", false, false, 0),
            Create_Switch("Team Check", "Ignoriert Spieler im eigenen Team", "AIMBOT_TEAM_CHECK_ENABLE", true, "normal", false, false, 0),
            Create_Switch("Alive Check", "Ignoriert bereits tote oder eliminierte Spieler", "AIMBOT_HEALTH_CHECK_ENABLE", true, "normal", false, false, 0),
        }, true),
        Create_Submenu("COMBAT_TRIGGERBOT", "Triggerbot", {
            Create_Switch("Triggerbot", "Schießt automatisch wenn ein Spieler ins Fadenkreuz gerät", "TRIGGERBOT_ENABLE", false, "testing", true, false, 0),
            Create_Switch("Triggerbot Keybind", "Schießt nur wenn Taste gedrückt wird", "TRIGGERBOT_KEYBIND", false, "normal", false, false, {"RMB", "LBM", "E", "F"}),
            Create_Trenner("Timing"),
            Create_Drag("Reaktionszeit", "Verzögerung in ms bevor geschossen wird (0 = sofort)", "TRIGGERBOT_DELAY", 500, 80),
            Create_Drag("Schuss-Intervall", "Mindestabstand zwischen zwei Schüssen in ms", "TRIGGERBOT_INTERVAL", 300, 50),
            Create_Trenner("Burst Mode"),
            Create_Switch("Burst Mode", "Feuert mehrere Schüsse schnell hintereinander wenn Ziel im Fadenkreuz", "TRIGGERBOT_BURST_ENABLE", false, "normal", false, false, 0),
            Create_Drag("Burst Schüsse", "Anzahl der Schüsse pro Burst", "TRIGGERBOT_BURST_COUNT", 10, 3),
            Create_Drag("Burst Delay", "Pause zwischen Burst-Salven in ms", "TRIGGERBOT_BURST_DELAY", 500, 150),
            Create_Trenner("Filter"),
            Create_Switch("Nur sichtbare Ziele", "Schießt nur wenn kein Hindernis zwischen dir und dem Ziel ist", "TRIGGERBOT_VISIBLE_ONLY", true, "normal", false, false, 0),
            Create_Switch("Team Check", "Schießt nicht auf Teammitglieder", "TRIGGERBOT_TEAM_CHECK", true, "normal", false, false, 0),
        }, false),
        --[[
        Create_Submenu("COMBAT_SILENT", "Silent-Aim", {
            -- General
            Create_Switch("Silent-Aim", "Schaltet Silent-Aim An/Aus", "Silent-Aim-Enable", false, "risk", true, false, 0),
            Create_Switch("Team Check", "Ignoriert Spieler im eigenen Team", "Silent-Aim-TeamCheck", false, "normal", false, false, 0),
            Create_Switch("Visible Check", "Schießt nur auf sichtbare Spieler", "Silent-Aim-VisibleCheck", false, "normal", false, false, 0),
            Create_Trenner("Ziel"),
            Create_Choose("Target Part", "Welcher Körperteil getroffen werden soll", "Silent-Aim-TargetPart", {"Head", "HumanoidRootPart", "Random"}, 1),
            Create_Choose("Methode", "Wie Silent-Aim den Schuss umlenkt", "Silent-Aim-Method", {"Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit/Target"}, 1),
            Create_Drag("Hit Chance", "Wahrscheinlichkeit dass der Schuss umgelenkt wird (0-100%)", "Silent-Aim-HitChance", 100, 100),
            Create_Trenner("FOV"),
            Create_Switch("FOV anzeigen", "Zeigt den Silent-Aim Zielbereich als Kreis an", "Silent-Aim-ShowFOV", false, "normal", true, true, 0),
            Create_Drag("FOV Radius", "Größe des Silent-Aim Zielbereichs in Pixeln", "Silent-Aim-FOVRadius", 500, 130),
            Create_Switch("Target anzeigen", "Zeigt einen Punkt auf dem aktuellen Ziel an", "Silent-Aim-ShowTarget", false, "normal", false, true, 0),
            Create_Trenner("Prediction"),
            Create_Switch("Prediction", "Berechnet die zukünftige Position des Ziels", "Silent-Aim-Prediction", false, "normal", false, false, 0),
            Create_Drag("Prediction Amount", "Stärke der Vorausberechnung (0.000 - 1.000)", "Silent-Aim-PredictionAmount", 1, 0.165),
        }, false),
        ]]
        Create_Submenu("COMBAT_HITBOX", "Hitbox-Expander", {
            Create_Switch("Hitbox Expander", "Vergrößert die Hitbox des ausgewählten Parts", "HITBOX_ENABLE", false, "normal", true, false, {"Head", "HRP"}),
            Create_Trenner("Größe"),
            Create_Drag("Hitbox Größe", "Größe der erweiterten Hitbox (1-50)", "HITBOX_SIZE", 50, 5),
            Create_Button("Custom Größe eingeben", "Gibt eine eigene Hitbox-Größe ein", "BTN_HITBOX_CUSTOM_SIZE", "Set", true, "z.B. 25"),
            Create_Button("Reset auf Standard", "Setzt Größe, Troll und alles zurück", "BTN_HITBOX_RESET", "Reset", false),
            Create_Button("Full Size (Max)", "Setzt Hitbox auf Maximum (50 oder Troll-Max)", "BTN_HITBOX_FULL", "Set", false),
            Create_Trenner("Troll"),
            Create_Switch("Troll Modus", "Multipliziert die Hitbox-Größe für extremen Effekt", "HITBOX_TROLL", false, "risk", false, false, 0),
            Create_Drag("Troll Multiplier", "Wie viel mal größer als die normale Größe (x1 - x20)", "HITBOX_TROLL_MULTIPLIER", 20, 2),
            Create_Trenner("Aussehen"),
            Create_Drag("Transparenz", "Wie durchsichtig der Part wird (0 = sichtbar, 100 = unsichtbar)", "HITBOX_TRANSPARENCY", 100, 100),
            Create_Switch("Highlight", "Markiert den vergrößerten Part farbig", "HITBOX_HIGHLIGHT", false, "normal", false, true, 0),
        }, false)
    }, false)

    Create_Tab("VISUALS", "Visuals", {
        Create_Submenu("VISUALS_MAIN", "Main", {
            Create_Trenner("Global"),
            Create_Switch("ESP Global", "Aktiviert/Deaktiviert den gesamten ESP", "ESP_GLOBAL_ENABLE", true, "normal", true, false, 0),
            Create_Switch("Self Visual", "Zeigt ESP auf sich selbst an", "ESP_SELF_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Filter"),
            Create_Switch("Team-Check", "Verbündete werden nicht markiert", "ESP_TEAM_CHECK_ENABLE", false, "normal", false, false, 0),
            Create_Switch("Visible Check", "Rot wenn Spieler hinter einer Wand ist", "ESP_VISIBLE_CHECK_ENABLE", false, "normal", false, false, 0),
        }, true),
        Create_Submenu("VISUALS_BOX", "Box", {
            Create_Trenner("Box Stil"),
            Create_Switch("Box", "Einfache 2D Box um den Spieler", "ESP_BOX_ENABLE", false, "normal", false, true, 0),
            Create_Switch("Corner Box", "Nur die Ecken der Box anzeigen", "ESP_CORNER_BOX_ENABLE", false, "normal", false, true, 0),
            Create_Switch("3D Box", "Box folgt dem echten Modell in 3D", "ESP_3D_BOX_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Box Fill"),
            Create_Switch("Box Fill", "Füllt die Box mit einer Farbe", "ESP_BOX_FILL_ENABLE", false, "normal", false, true, 0),
            Create_Drag("Fill Transparenz", "Wie durchsichtig die Füllung ist", "ESP_BOX_FILL_TRANSPARENCY", 100, 60),
            Create_Trenner("Kopf"),
            Create_Switch("Head Circle", "Kreis um den Kopf des Spielers", "ESP_HEAD_CIRCLE_ENABLE", false, "normal", false, true, 0),
        }, false),
        Create_Submenu("VISUALS_INFO", "Player Info", {
            Create_Trenner("Text"),
            Create_Switch("Namen", "Zeigt den Spielernamen über dem Kopf", "ESP_NAMES_ENABLE", false, "normal", false, false, 0),
            Create_Switch("Distanz", "Zeigt die Entfernung zum Spieler an", "ESP_DISTANCE_ENABLE", false, "normal", false, false, 0),
            Create_Switch("VoiceChat", "Zeigt an ob der Spieler Voice Chat aktiviert hat (🎙 / 🔇)", "ESP_VOICECHAT_ENABLE", false, "normal", false, false, 0),
            Create_Switch("Device", "Zeigt das Gerät des Spielers an (📱 Mobile / 🎮 Console / 🥽 VR / PC)", "ESP_DEVICE_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Health"),
            Create_Switch("Health Bar", "Lebensbalken neben der Box", "ESP_HEALTH_BAR_ENABLE", false, "normal", false, false, 0),
            Create_Switch("Lebensbasierte Farbe", "Farbe ändert sich je nach Leben", "ESP_HEALTH_COLOR_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Skeleton"),
            Create_Switch("Skeleton", "Zeigt das Knochen-Gerüst des Spielers", "ESP_SKELETON_ENABLE", false, "normal", false, true, 0),
        }, false),
        Create_Submenu("VISUALS_COMBAT", "Combat", {
            Create_Trenner("Indikatoren"),
            Create_Switch("Tracer", "...", "ESP_TRACER_ENABLE", false, "normal", false, true, {"unten", "oben"}),
            Create_Switch("Arrow Indicator", "Pfeil zeigt Richtung zu off-screen Spielern", "ESP_ARROW_INDICATOR_ENABLE", false, "normal", false, true, 0),
        }, false),
        Create_Submenu("VISUALS_CROSSHAIR", "Crosshair", {
            Create_Trenner("Crosshair"),
            Create_Switch("Crosshair", "...", "ESP_CROSSHAIR_ENABLE", false, "normal", false, true, {"Kreuz", "Dot", "Kreis", "Kreuz+Dot", "T-Shape", "X-Form"}),
            Create_Trenner("Einstellungen"),
            Create_Drag("Größe", "Länge der Crosshair-Linien", "ESP_CROSSHAIR_SIZE", 100, 20),
            Create_Drag("Dicke", "Dicke der Crosshair-Linien", "ESP_CROSSHAIR_THICKNESS", 10, 2),
            Create_Drag("Lücke", "Abstand vom Mittelpunkt", "ESP_CROSSHAIR_GAP", 50, 8),
        }, false),
        Create_Submenu("MISC_RADAR", "Radar", {
            Create_Switch("Radar", "Zeigt einen 2D-Minimap Radar mit Spielerpositionen", "RADAR_ENABLE", false, "normal", false, false, 0),
            Create_Trenner("Darstellung"),
            Create_Drag("Radar Größe", "Größe des Radar-Fensters in Pixeln (80-400)", "RADAR_SIZE", 400, 200),
            Create_Drag("Radar Reichweite", "Wie weit der Radar Spieler anzeigt (in Studs)", "RADAR_SCALE", 500, 150),
            Create_Drag("Hintergrund Transparenz", "Stellt die Transparenz den Hintergrundes ein", "RADAR_OPACITY", 100, 20),
            Create_Trenner("Spieler"),
            Create_Switch("Eigener Punkt", "Zeigt deinen Punkt auf dem Radar", "RADAR_SHOW_SELF", true, "normal", false, true, 0),
            Create_Switch("Team Farbe", "Verbündete in eigener Farbe anzeigen", "RADAR_TEAM_COLORS", true, "normal", false, true, 0),
            Create_Switch("Feind Farbe", "Feinde in eigener Farbe anzeigen", "RADAR_ENEMY_COLOR", false, "normal", false, true, 0),
            Create_Choose("Rotations-Referenz", "Wonach sich der Radar ausrichtet", "RADAR_USE_CHARACTER_ROTATION", {"Kamera", "Charakter"}, 1),
            Create_Trenner("Filter"),
            Create_Switch("Team Check", "Verbündete nicht auf Radar anzeigen", "RADAR_TEAM_CHECK", false, "normal", false, false, 0),
            Create_Switch("Sichtbarkeits-Check", "Nur sichtbare Spieler anzeigen", "RADAR_VISIBLE_CHECK", false, "normal", false, false, 0),
            Create_Drag("Max Distanz", "Ab welcher Distanz Spieler nicht mehr angezeigt werden", "RADAR_MAX_DIST", 2000, 600),
            Create_Trenner("Stil"),
            Create_Switch("Rahmen anzeigen", "Zeigt einen Rahmen um den Radar", "RADAR_BORDER_ENABLE", false, "normal", false, true, 0),
            Create_Switch("Nord-Linie", "Zeigt Blickrichtung als Linie", "RADAR_NORTH_LINE", false, "normal", false, false, 0),
            Create_Choose("Marker Stil", "Wie Spieler auf dem Radar dargestellt werden", "RADAR_USE_ARROW", {"Kreis", "Pfeil"}, 1),
        }, false),
        Create_Submenu("MISC_CHAMS", "Chams", {
            Create_Switch("Chams", "Hebt Spieler farbig durch Wände hindurch hervor", "CHAMS_ENABLE", false, "normal", false, true, 0),
            Create_Switch("Sichtbare Spieler", "Chams nur auf Spieler anwenden die sichtbar sind", "CHAMS_VISIBLE_ONLY", false, "normal", false, false, 0),
            Create_Switch("Team Check", "Keine Chams für Teammitglieder", "CHAMS_TEAM_CHECK", true, "normal", false, false, 0),
            Create_Trenner("Stil"),
            Create_Switch("Durch Wände", "Spieler auch hinter Wänden anzeigen", "CHAMS_WALLHACK", false, "risk", false, true, 0),
            Create_Switch("Team-Farben", "Farbe basierend auf Team statt fester Farbe", "CHAMS_TEAM_COLOR", false, "normal", false, false, 0),
            Create_Drag("Transparenz", "Wie durchsichtig die Chams-Färbung ist", "CHAMS_TRANSPARENCY", 100, 40),
        }, false),
        Create_Submenu("VISUALS_FRIEND", "Friend Colors", {
            Create_Trenner("Freund ESP Farben"),
            Create_Switch("Skeleton Farbe",    "Eigene Freund-Farbe für Skeleton",       "ESP_FRIEND_SKELETON_COLOR",    false, "normal", false, true, 0),
            Create_Switch("Box Farbe",         "Eigene Freund-Farbe für Box",            "ESP_FRIEND_BOX_COLOR",         false, "normal", false, true, 0),
            Create_Switch("Corner Box Farbe",  "Eigene Freund-Farbe für Corner Box",     "ESP_FRIEND_CORNER_BOX_COLOR",  false, "normal", false, true, 0),
            Create_Switch("Box Fill Farbe",    "Eigene Freund-Farbe für Box Fill",       "ESP_FRIEND_BOX_FILL_COLOR",    false, "normal", false, true, 0),
            Create_Switch("Tracer Farbe",      "Eigene Freund-Farbe für Tracer",         "ESP_FRIEND_TRACER_COLOR",      false, "normal", false, true, 0),
            Create_Switch("Arrow Farbe",       "Eigene Freund-Farbe für Arrow Indicator","ESP_FRIEND_ARROW_COLOR",       false, "normal", false, true, 0),
            Create_Switch("Head Circle Farbe", "Eigene Freund-Farbe für Head Circle",    "ESP_FRIEND_HEAD_CIRCLE_COLOR", false, "normal", false, true, 0),
        }, false),
        Create_Submenu("VISUALS_MISC", "Misc", {
            Create_Trenner("Distanz"),
            Create_Drag("Max Distanz", "Ab welcher Distanz kein ESP mehr angezeigt wird", "ESP_MAX_DISTANCE", 2000, 600),
            Create_Trenner("Watermark Test"),
            Create_Switch("Watermark FPS", "Zeigt deine FPS im Watermark an", "SHOW_FPS", false, "normal", false, false, 0),
            Create_Switch("Watermark Ping", "Zeigt deinen Ping im Watermark an", "SHOW_PING", false, "normal", false, false, 0),
        }, false),
    }, false)

    Create_Tab("TROLL", "Troll", {
        Create_Submenu("TROLL_DESYNC", "Desync", {
            Create_Switch("Enable Desync", "Trennt Clientposition von Serverposition", "DESYNC_ENABLE", false, "normal", true, false, 0),
            Create_Switch("Desync No-Clip", "Während aktiviertem Desync kann man durch Wände laufen", "DESYNC_NOCLIP_ENABLE", false, "normal", true, false, 0),
            Create_Switch("Show Server Char", "Zeigt den Server-Charakter (gefrorene Position) als Highlight an", "DESYNC_SHOW_SERVER_CHAR", false, "testing", false, false, 0),
            Create_Switch("Hide Server Char", "Versteckt deinen Charakter lokal während Desync – für andere bleibt die gefrorene Position sichtbar", "DESYNC_HIDE_SERVER_CHAR", false, "testing", false, false, 0),
        }, true),
        Create_Submenu("TROLL_CHATSPAM", "Chat Spammer", {
            Create_Switch("Enable Spammer", "Spammt Nachrichten in den Chat", "CHAT_SPAMMER_ENABLE", false, "testing", true, false, {"Vorgegeben", "Custom"})
        }, false)
    }, false)

    Create_Tab("PLAYERS", "Players", {
    
        Create_Submenu("PLAYERS_LIST", "List", {
            Create_Trenner("Spieler auswählen"),
            Create_List(
                "Spieler",
                "Wähle einen Spieler",
                "SELECTED_PLAYER",
                function()
                    local t = {}
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then t[#t+1] = p.Name end
                    end
                    if #t == 0 then t[1] = "Kein Spieler gefunden" end
                    return t
                end
            ),
            Create_Trenner("Freund"),
            Create_Button("Freund hinzufügen / entfernen", "Fügt den Spieler zur lokalen Freundesliste hinzu oder entfernt ihn", "BTN_TOGGLE_FRIEND", "Add", false),
        }, true),
    
        Create_Submenu("PLAYERS_INFO", "Info", {
            Create_Button("Info laden", "Lädt alle Roblox-Infos des ausgewählten Spielers", "BTN_LOAD_PLAYER_INFO", "Load", false),
            Create_Trenner("Account"),
            Create_Button("– Anzeigename",   "Klicken zum Kopieren", "BTN_INFO_DISPLAYNAME", "Copy", false),
            Create_Button("– UserId",        "Klicken zum Kopieren", "BTN_INFO_USERID",      "Copy", false),
            Create_Button("– Erstellt am",   "Klicken zum Kopieren", "BTN_INFO_CREATED",     "Copy", false),
            Create_Button("– Account-Alter", "Klicken zum Kopieren", "BTN_INFO_AGE",         "Copy", false),
            Create_Button("– Beschreibung",  "Klicken zum Kopieren", "BTN_INFO_DESC",        "Copy", false),
            Create_Button("– Gebannt",       "Account-Status",       "BTN_INFO_BANNED",      "Copy", false),
            Create_Trenner("Soziales"),
            Create_Button("– Freunde",       "Klicken zum Kopieren", "BTN_INFO_FRIENDS",     "Copy", false),
            Create_Button("– Follower",      "Klicken zum Kopieren", "BTN_INFO_FOLLOWERS",   "Copy", false),
            Create_Button("– Following",     "Klicken zum Kopieren", "BTN_INFO_FOLLOWING",   "Copy", false),
        }, false),
        Create_Submenu("PLAYERS_INTERACTIONS", "Interaktionen", {
            Create_Trenner("Teleport"),
            Create_Button("Zu Spieler teleportieren", "Teleportiert dich zu dem Spieler", "BTN_TELEPORT_TO_PLAYER", "Teleport", false),
            Create_Switch("Zu Spieler teleportieren Loop", "Teleportiert dich ständig zu dem Spieler", "LOOP_TELEPORT_TO_PLAYER"),
            Create_Trenner("Fling"),
            Create_Button("Spieler flingen", "Flingt den Spieler weg", "BTN_FLING_PLAYER",  "Fling", false),
        }, false)
    
    }, false)

    Create_Tab("MOVEMENT", "Movement", {
        Create_Submenu("MOVEMENT_SPEED", "Speed", {
            Create_Switch("Speed Hack", "Erhöht deine Laufgeschwindigkeit", "MOVEMENT_ENABLE_WALKSPEED", false, "normal", true, false, 0),
            Create_Drag("WalkSpeed", "Deine Bewegungsgeschwindigkeit (Standard: 16)", "MOVEMENT_ENABLE_WALKSPEED_VALUE", 500, 16),
        }, true),
        Create_Submenu("MOVEMENT_JUMP", "Jump", {
            Create_Switch("Enable JumpPower", "Schaltet JumpPower ein", "MOVEMENT_ENABLE_JUMPPOWER", false, "normal", false, false, 0),
            Create_Switch("Infinite Jump", "Ermöglicht unbegrenztes Springen in der Luft", "MOVEMENT_ENABLE_INFINITE_JUMP", false, "normal", true, false, 0),
            Create_Drag("JumpPower", "Sprungkraft des Charakters (Standard: 50)", "MOVEMENT_ENABLE_JUMPPOWER_VALUE", 500, 50),
        }, false),
        Create_Submenu("MOVEMENT_FLY", "Fly", {
            Create_Switch("Fly", "Ermöglicht freies Fliegen", "FLY_ENABLE", false, "normal", true, false, 0),
            Create_Drag("Fly Speed", "Geschwindigkeit beim Fliegen", "FLY_SPEED", 300, 50),
            Create_Trenner("Optionen"),
            Create_Switch("Fly Noclip", "Ermöglicht das fliegen durch Wände", "FLY_NOCLIP", false, "normal", true, false, 0),
            Create_Switch("Anti Kick", "Hides fly from anti-cheat detection by forcing PlatformStand and Flying state", "FLY_ANTI_KICK", false, "normal", true, false, 0),
            Create_Switch("Precision Fly", "Slows fly speed to 25% for precise positioning", "FLY_PRECISION_KEY", false, "normal", true, false, 0),
            Create_Switch("Trail", "Spawns a red particle trail behind your character while flying", "FLY_TRAIL", false, "testing", true, false, 0),
        }, false),
        Create_Submenu("MOVEMENT_NOCLIP", "Noclip", {
            Create_Switch("Noclip", "Charakter geht durch Wände und Objekte", "NOCLIP_ENABLE", false, "risk", true, false, 0),
        }, false),
        Create_Submenu("MOVEMENT_ANTIFLING", "Anti-Fling", {
            Create_Switch("Anti-Fling", "Prevents other players from flinging you away. Blocks high velocity, angular velocity, sudden teleports, and massless manipulation.", "ANTIFLING_ENABLE", false, "normal", false, false, 0),
        }, false)
    }, false) 

    Create_Tab("WORLD", "World", {
        Create_Submenu("WORLD_LIGHTING", "Lighting", {
            Create_Trenner("Fullbright"),
            Create_Switch("Fullbright", "Macht die Welt vollständig hell – keine Schatten oder Dunkelheit", "FULLBRIGHT_ENABLE", false, "normal", false, false, 0),
            Create_Drag("Helligkeit", "Helligkeit der Welt (Standard: 100 = Maximum, runter wenn zu grell)", "FULLBRIGHT_BRIGHTNESS", 100, 100),
            Create_Trenner("Fog"),
            Create_Switch("No Fog", "Entfernt den Nebel aus der Welt", "NOFOG_ENABLE", false, "normal", false, false, 0),
        }, true),
    
    }, false)

    -- Custom Scripts
    if GermanRail then
        Create_Tab("GERMANRAIL", "German Rail", {
            Create_Submenu("TRAIN_TROLL", "Train Trolls", {
                Create_Switch("Fling Trains", "Flingt Züge weg", "TRAIN_FLING_ENABLE", false, "normal", true, false, 0),
                Create_Drag("Stärke", "Stellt die Stärke des Flings ein", "TRAIN_FLING_STRENGTH", 100, 50),
            }, true),
        }, true)
    end

    if Rivals then
    end

    if Murder_Mystery_2 then
        Create_Tab("MURDER_MYSTERY_2", "Murder Mystery 2", {
            Create_Submenu("MM2_ESP_OPTIONS", "Esp Options", {
                Create_Switch("Role Colors", "ESP Farben passen sich an Rollen an", "MM2_ESP_COLORS", false, "testing", true, false, 0),
                Create_Switch("Highlight Weapon", "Highlights the Sherriff Weapon", "MM2_HIGHLIGHT_WEAPON", false, "testing", true, false, 0)
            }, true),
            Create_Submenu("MM2_SILENT_AIM", "Silent Aim", {
                Create_Switch("Enable Weapon Silent", "Enables Silent Aim for Weapon", "MM2_WEAPON_SILENT_AIM", false, "testing", true, false, 0),
                Create_Switch("Enable Knife Silent", "Enables Silent Aim for Weapon", "MM2_KNIFE_SILENT_AIM", false, "normal", true, false, 0),
                Create_Switch("Show FOV", "Shows the Silent Aim FOV", "MM2_SILENT_AIM_FOV", false, "normal", true, false, 0),
                Create_Drag("FOV Size", "Sets the Size of the FOV", "MM2_SILENT_AIM_FOV_SIZE", 400, 50),
                Create_Switch("Draw Line to Target", "Draws a line to the target", "MM2_SILENT_AIM_DRAW_LINE_TARGET", false, "normal", true, true, 0),
                Create_Trenner("Checks"),
                Create_Switch("Wall Check", "Checks if a Player is behind a wall", "MM2_SILENT_AIM_VISIBLE_CHECK", false, "normal", true, false, 0),
            }, false),
        }, false)
    end

    if Jailbird and tostring(game.PlaceId) == "14772802900" then
        Create_tab("JAILBIRD", "Jailbid", {
            Create_Submenu("JAILBIRD_SILENT_AIM", "Silent Aim", {
                Create_Switch("Enable", "Enables Silent-Aim", "JAILBIRD_SILENT_AIM", false, "testing", true, false, 0)
            })
        })
    end




    Create_Tab("CONFIG", "Config", {
    
        Create_Submenu("CONFIG_PROFILES", "Profile", {
    
            Create_Trenner("Aktives Profil"),
            Create_List(
                "Profil",
                "Wähle ein gespeichertes Profil",
                "SELECTED_CONFIG_PROFILE",
                function()
                    local configs = ListConfigs()
                    if #configs == 0 then
                        return {"(Keine Profile)"}
                    end
                    return configs
                end
            ),
    
            Create_Trenner("Profil verwalten"),
            Create_Button("Profil laden",      "Lädt das ausgewählte Profil",                "BTN_CONFIG_LOAD",   "Laden",      false),
            Create_Button("Profil speichern",  "Speichert aktuelle Einstellungen ins Profil", "BTN_CONFIG_SAVE",   "Speichern",  false),
            Create_Button("Profil löschen",    "Löscht das ausgewählte Profil",              "BTN_CONFIG_DELETE", "Löschen",    false),
            Create_Button("Profil umbenennen", "Benennt das ausgewählte Profil um",          "BTN_CONFIG_RENAME", "Umbenennen", true, "Neuer Name"),
            Create_Button("Neues Profil",      "Erstellt ein leeres neues Profil",           "BTN_CONFIG_NEW",    "Erstellen",  true, "Profilname"),
    
        }, true),
    
        Create_Submenu("CONFIG_IMPORT_EXPORT", "Import / Export", {
    
            Create_Trenner("Export"),
            Create_Button("URL kopieren", "Kopiert die Url der Config",   "BTN_CONFIG_EXPORT_URL", "Kopieren", false),
    
            Create_Trenner("Import"),
            Create_Button("Von URL laden",            "Gibt eine URL ein – die Config wird direkt daraus geladen", "BTN_CONFIG_IMPORT_URL", "Laden", true, "Config URL"),
    
        }, false),
    
        Create_Submenu("CONFIG_AUTOSAVE", "Autosave", {
    
            Create_Trenner("Autosave"),
            Create_Switch("Autosave aktiv",      "Speichert Einstellungen automatisch beim Schließen des Menüs", "CONFIG_AUTOSAVE_ENABLE",   false, "normal", false, false, 0),
            Create_Switch("Autoload beim Start", "Lädt das zuletzt verwendete Profil automatisch beim Start",    "CONFIG_AUTOLOAD_ENABLE",   false, "normal", false, false, 0),
            Create_Drag("Autosave Intervall",    "Wie oft automatisch gespeichert wird (in Sekunden)",           "CONFIG_AUTOSAVE_INTERVAL", 300, 60),
    
        }, false),
    
        Create_Submenu("CONFIG_RESET", "Reset", {
    
            Create_Trenner("Zurücksetzen"),
            Create_Button("Aktuelle Einstellungen zurücksetzen", "Setzt alle Switches, Drags, Keybinds und Colors auf Standard zurück", "BTN_CONFIG_RESET_CURRENT", "Reset",         false),
            Create_Button("Alle Profile löschen",                "Löscht alle gespeicherten Profile permanent vom Gerät",               "BTN_CONFIG_RESET_ALL",     "Alles löschen", false),
    
        }, false),
    
    }, false)



    Create_Tab("SETTINGS", "Settings", {
        Create_Submenu("SETTINGS_MAIN", "Main", {
            Create_Keybind("Panic Key", "Taste zum Aktivieren/Deaktivieren des Panic Modes", "PANIC_KEY", nil),
            Create_Button("Unload Menu", "Unloads the Menu", "BTN_UNLOAD_MENU", "Unload", false)
        }, true)
    }, false)

    -- Switch-Zustände auf alle neu erstellten UI-Elemente anwenden
    for fn, state in pairs(SwitchFunctions) do
        local cbs = SwitchUICallbacks[fn]
        if cbs then
            for _, cb in ipairs(cbs) do pcall(cb, state) end
        end
    end

    -- Farben wiederherstellen
    for fn, settings in pairs(FunctionsSettings) do
        local hex = ColorFunctions[fn]
        if hex and settings.ColorCallbacks then
            for _, cb in ipairs(settings.ColorCallbacks) do pcall(cb, hex) end
        end
    end

    -- Keybind-Labels wiederherstellen
    for fn, kc in pairs(KeybindFunctions) do
        if FunctionsSettings[fn] and FunctionsSettings[fn].OnKeybindChanged then
            pcall(FunctionsSettings[fn].OnKeybindChanged, kc)
        end
    end

    -- Favoriten wiederherstellen
    for fn, isFav in pairs(FavouriteFunctions) do
        if isFav and AllSwitchDefs[fn] then
            Build_Switch(AllSwitchDefs[fn], "HOME", "HOME_FAVOURITES", 50, true)
        end
    end
end


-- ══════════════════════════
-- ══ Custom Scripts Logic ══
-- ══════════════════════════

local function LoadCustomScripts()
    if type(Erweiterungen) == "table" then
        for _, E in pairs(Erweiterungen) do
            if E == "germanrail"       then GermanRai        = true end
            if E == "rivals"           then Rivals           = true end
            if E == "Murder_Mystery_2" then Murder_Mystery_2 = true end
        end
    else
        GermanRail = true
        Rivals = true
    end
end

LoadCustomScripts()  -- synchron, kein task.spawn
Build_Menu()         -- danach direkt
Gui.Examples:Destroy()


-- ============================================================
-- PROTECTED EXECUTION SYSTEM - FULL FEATURE WRAPPING
-- ============================================================

local ProtectedStatus = {}

local function ProtectedExecute(featureName, RequiredPlaceId, func, ...)
    local PlaceId = tostring(game.PlaceId)
    if RequiredPlaceId ~= "" and RequiredPlaceId == PlaceId then
        local success, result = pcall(func, ...)
        local errorMsg = success and nil or tostring(result)
        
        ProtectedStatus[featureName] = {
            success = success,
            error = errorMsg,
            lastRun = tick()
        }
        
        if not success then
            warn("[Vexaris] ProtectedExecute failed for '" .. featureName .. "': " .. errorMsg)
            pcall(function() SendNotify("⚠️ " .. featureName .. " failed") end)
        end
        
        return success, (success and result or nil), errorMsg
    elseif RequiredPlaceId == "" then
        local success, result = pcall(func, ...)
        local errorMsg = success and nil or tostring(result)
        
        ProtectedStatus[featureName] = {
            success = success,
            error = errorMsg,
            lastRun = tick()
        }
        
        if not success then
            warn("[Vexaris] ProtectedExecute failed for '" .. featureName .. "': " .. errorMsg)
            pcall(function() SendNotify("⚠️ " .. featureName .. " failed") end)
        end
        
        return success, (success and result or nil), errorMsg
    else
        print("ProtectedExecute: Error with PlaceId logic with: " .. featureName)
    end
end


--[[
-- ══════════════════════════
-- ══ Feature Search Logic ══
-- ══════════════════════════

ProtectedExecute("FEATURE_SEARCH", "", function()
    UserInputService.InputBegan:Connect(function(Input, processed)
        if processed then return end
        if Input.KeyCode == Enum.KeyCode.F10 then
            Gui.MAIN_FRAME.Visible = false
            BackgroundBlur.Enabled = false
            Gui.SEARCH_FRAME.Visible = true
            Gui.SEARCH_BOX:CaptureFocus()
        end
    end)

    Gui.SEARCH_BOX.FocusLost:Connect(function()
        local searchText = Gui.SEARCH_BOX.Text:lower():gsub("^%s*(.-)%s*$", "%1")

        if searchText == "" then
            Gui.MAIN_FRAME.Visible = true
            BackgroundBlur.Enabled = true
            Gui.SEARCH_FRAME.Visible = false
            return
        end

        local foundTab     = nil
        local foundSubmenu = nil

        for _, tab in ipairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
            if tab:IsA("Frame") then
                for _, submenu in ipairs(tab:GetChildren()) do
                    if submenu:IsA("ScrollingFrame") then
                        for _, element in ipairs(submenu:GetChildren()) do
                            if element:IsA("Frame") and not element.Name:find("^FAV_") then
                                local mainLabel = element:FindFirstChild("MainLabel")
                                if mainLabel and mainLabel:IsA("TextLabel") then
                                    local featureName = mainLabel.Text:lower():gsub("%[risk%]", ""):gsub("^%s*(.-)%s*$", "%1")
                                    if featureName:find(searchText, 1, true) then
                                        foundTab     = tab.Name
                                        foundSubmenu = submenu.Name
                                        break
                                    end
                                end
                            end
                        end
                    end
                    if foundTab then break end
                end
            end
            if foundTab then break end
        end

        if foundTab then
            for _, F in pairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
                if F:IsA("Frame") then F.Visible = (F.Name == foundTab) end
            end
            for _, F in pairs(Gui.HEADER_MAINFRAME:GetChildren()) do
                if F:IsA("ScrollingFrame") then F.Visible = (F.Name == foundTab) end
            end
            local tabFrame = Gui.MAIN_CONTENT_FRAME:FindFirstChild(foundTab)
            if tabFrame then
                for _, F in pairs(tabFrame:GetChildren()) do
                    if F:IsA("Frame") or F:IsA("ScrollingFrame") then
                        F.Visible = (F.Name == foundSubmenu)
                    end
                end
            end
            Gui.SEARCH_BOX.Text      = ""
            Gui.MAIN_FRAME.Visible   = true
            BackgroundBlur.Enabled   = true
            Gui.SEARCH_FRAME.Visible = false
        else
            Gui.SEARCH_INFOLABEL2.Text = "Feature nicht gefunden"
            task.wait(2)
            Gui.SEARCH_INFOLABEL2.Text = ""
        end
    end)
end)
]]

-- ═════════════════════
-- ══ ESP Logik (Optimiert)
-- ═════════════════════

ProtectedExecute("ESP", "", function()
    -- ── VoiceChat Cache ──
    local isVoiceEnabled
    do
        local _voiceCache = {}

        local function findAudioInput(player)
            -- Roblox Attribute (neueste Methode, seit 2023)
            local attr = player:GetAttribute("VoiceEnabled")
            if attr == true then return true end

            -- AudioDeviceInput im Player
            if player:FindFirstChildOfClass("AudioDeviceInput") then return true end
            if player:FindFirstChildWhichIsA("AudioDeviceInput", true) then return true end

            -- AudioDeviceInput im Character
            local char = player.Character
            if char then
                if char:FindFirstChildOfClass("AudioDeviceInput") then return true end
                if char:FindFirstChildWhichIsA("AudioDeviceInput", true) then return true end
            end

            -- Workspace-Character
            local wchar = workspace:FindFirstChild(player.Name)
            if wchar and wchar:FindFirstChildOfClass("AudioDeviceInput") then return true end

            return false
        end

        isVoiceEnabled = function(player)
            local uid = player.UserId
            if _voiceCache[uid] ~= nil then
                return _voiceCache[uid]
            end

            if findAudioInput(player) then
                _voiceCache[uid] = true
                return true
            end

            -- Async: VoiceChatService (funktioniert manchmal in bestimmten Executors)
            _voiceCache[uid] = false
            task.spawn(function()
                -- Methode A: VoiceChatService
                local ok, vcs = pcall(game.GetService, game, "VoiceChatService")
                if ok and vcs then
                    local ok2, res = pcall(vcs.IsVoiceEnabledForUserIdAsync, vcs, uid)
                    if ok2 and res == true then
                        _voiceCache[uid] = true
                        return
                    end
                end
                -- Methode B: Nochmal Attribute prüfen (kann sich nach Spawn setzen)
                task.wait(1)
                if findAudioInput(player) then
                    _voiceCache[uid] = true
                end
            end)

            return false
        end

        -- Attribute-Listener: wenn Roblox "VoiceEnabled" setzt → sofort updaten
        Players.PlayerAdded:Connect(function(p)
            _voiceCache[p.UserId] = nil
            p:GetAttributeChangedSignal("VoiceEnabled"):Connect(function()
                _voiceCache[p.UserId] = nil
            end)
            p.CharacterAdded:Connect(function() _voiceCache[p.UserId] = nil end)
        end)
        for _, p in ipairs(Players:GetPlayers()) do
            _voiceCache[p.UserId] = nil
            p:GetAttributeChangedSignal("VoiceEnabled"):Connect(function()
                _voiceCache[p.UserId] = nil
            end)
            p.CharacterAdded:Connect(function() _voiceCache[p.UserId] = nil end)
        end
        Players.PlayerRemoving:Connect(function(p) _voiceCache[p.UserId] = nil end)
    end
    -- ────────────────────────

    -- ═══════════════════════════════════
    -- ══  Player Device Detection      ══
    -- ═══════════════════════════════════
    -- Erkennt das Gerät anderer Spieler anhand von
    -- PlayerGui-Inhalten, GuiService-Hinweisen und
    -- Platform-Attributen die Roblox setzt.
    -- Wenn keine Erkennung möglich ist, wird die Funktion
    -- sofort deaktiviert und eine Benachrichtigung gesendet.

    local _deviceCache = {}   -- [userId] = { device, icon, time }
    local DEVICE_CACHE_TTL = 10  -- Sekunden bis neu gecheckt wird
    local deviceDetectionSupported = true  -- Flag ob Erkennung funktioniert

    local function detectPlayerDevice(player)
        local uid = player.UserId
        local now = tick()
        local cached = _deviceCache[uid]
        if cached and (now - cached.time) < DEVICE_CACHE_TTL then
            return cached.device, cached.icon
        end

        local device = "Unknown"
        local icon   = "[?]"

        -- Prüfe ob die nötigen Methoden existieren
        if not deviceDetectionSupported then
            return device, icon
        end

        -- Methode 1: Roblox setzt "Platform" Attribut auf dem Player (neuere Games)
        local success, platform = pcall(function()
            return player:GetAttribute("Platform") or player:GetAttribute("platform")
        end)
        
        if not success then
            -- GetAttribute nicht verfügbar -> Funktion deaktivieren
            deviceDetectionSupported = false
            SendNotify("Device Detection: GetAttribute not supported - disabling feature")
            return "Unknown", "[?]"
        end

        if platform then
            local p = tostring(platform):lower()
            if p:find("ios") or p:find("android") or p:find("phone") or p:find("mobile") then
                device, icon = "Mobile", "[📱]"
            elseif p:find("xbox") or p:find("console") or p:find("gamepad") then
                device, icon = "Console", "[🎮]"
            elseif p:find("vr") or p:find("quest") or p:find("rift") then
                device, icon = "VR", "[🥽]"
            elseif p:find("windows") or p:find("mac") or p:find("pc") or p:find("desktop") then
                device, icon = "PC", "[PC]"
            end
        end

        -- Methode 2: PlayerGui nach Touch/Mobile GUIs scannen
        if device == "Unknown" then
            local pgSuccess, pg = pcall(function()
                return player:FindFirstChildOfClass("PlayerGui")
            end)
            
            if not pgSuccess then
                deviceDetectionSupported = false
                SendNotify("Device Detection: PlayerGui access not supported - disabling feature")
                return "Unknown", "[?]"
            end

            if pg then
                local touchSuccess, hasTouch = pcall(function()
                    return pg:FindFirstChild("TouchGui") or pg:FindFirstChild("TouchControlsGui")
                end)
                
                if not touchSuccess then
                    deviceDetectionSupported = false
                    SendNotify("Device Detection: FindFirstChild not supported - disabling feature")
                    return "Unknown", "[?]"
                end

                if hasTouch then
                    device, icon = "Mobile", "[📱]"
                else
                    -- Keine Touch-Elemente, aber PlayerGui existiert -> wahrscheinlich PC
                    device, icon = "PC", "[PC]"
                end
            else
                -- Kein PlayerGui gefunden -> nicht bestimmbar
                device, icon = "Unknown", "[?]"
            end
        end

        -- Methode 3: GuiService prüfen ob Mobile
        if device == "Unknown" then
            local gsSuccess, guiService = pcall(game.GetService, game, "GuiService")
            if gsSuccess and guiService then
                local touchSuccess, isTouch = pcall(function()
                    return guiService:IsTenFootInterface()
                end)
                
                if touchSuccess then
                    if isTouch then
                        device, icon = "Console", "[🎮]"
                    else
                        -- Nicht Console -> Fallback auf PC
                        device, icon = "PC", "[PC]"
                    end
                else
                    deviceDetectionSupported = false
                    SendNotify("Device Detection: GuiService methods not supported - disabling feature")
                    return "Unknown", "[?]"
                end
            else
                deviceDetectionSupported = false
                SendNotify("Device Detection: GuiService not available - disabling feature")
                return "Unknown", "[?]"
            end
        end

        -- Methode 4: UserInputService für Touch-Support prüfen
        if device == "Unknown" then
            local uisSuccess, uis = pcall(game.GetService, game, "UserInputService")
            if uisSuccess and uis then
                local touchSuccess, touchEnabled = pcall(function()
                    return uis.TouchEnabled
                end)
                
                if touchSuccess then
                    if touchEnabled then
                        device, icon = "Mobile", "[📱]"
                    else
                        device, icon = "PC", "[PC]"
                    end
                else
                    deviceDetectionSupported = false
                    SendNotify("Device Detection: UserInputService.TouchEnabled not supported - disabling feature")
                    return "Unknown", "[?]"
                end
            else
                deviceDetectionSupported = false
                SendNotify("Device Detection: UserInputService not available - disabling feature")
                return "Unknown", "[?]"
            end
        end

        _deviceCache[uid] = { device = device, icon = icon, time = now }
        return device, icon
    end

    -- Cache leeren wenn Spieler geht
    Players.PlayerRemoving:Connect(function(p)
        _deviceCache[p.UserId] = nil
    end)
    -- ────────────────────────
    -- ────────────────────────

    local function detectRig(char)
        if not char then return "UNKNOWN" end
        if char:FindFirstChild("UpperTorso") then return "R15"
        elseif char:FindFirstChild("Torso")  then return "R6" end
        return "UNKNOWN"
    end


    local _partsCache = {}  -- key = player, value = {parts, rig, char}

    local function getCharParts(player)
        local char = GetCharacter(player)
        if not char then return nil, "UNKNOWN" end

        local cached = _partsCache[player]
        if cached and cached.char == char then
            -- Zusatz-Check: Falls ein kritischer Part zwischenzeitlich
            -- nil wurde (z.B. durch ein Spiel-Event), Cache verwerfen
            if cached.parts.Head and cached.parts.HRP then
                return cached.parts, cached.rig
            end
            _partsCache[player] = nil  -- kaputten Cache wegwerfen, neu bauen
        end

        local rig = detectRig(char)
        local parts

        if rig == "R15" then
            parts = {
                Head           = char:FindFirstChild("Head"),
                UpperTorso     = char:FindFirstChild("UpperTorso"),
                LowerTorso     = char:FindFirstChild("LowerTorso"),
                LeftArm        = char:FindFirstChild("LeftUpperArm"),
                RightArm       = char:FindFirstChild("RightUpperArm"),
                LeftHand       = char:FindFirstChild("LeftHand"),
                RightHand      = char:FindFirstChild("RightHand"),
                LeftLeg        = char:FindFirstChild("LeftUpperLeg"),
                RightLeg       = char:FindFirstChild("RightUpperLeg"),
                LeftFoot       = char:FindFirstChild("LeftFoot"),
                RightFoot      = char:FindFirstChild("RightFoot"),
                HRP            = char:FindFirstChild("HumanoidRootPart"),
                Humanoid       = char:FindFirstChildOfClass("Humanoid"),
                ShoulderOffset = Vector3.new(0, 0.8, 0),
            }
        else
            local torso = char:FindFirstChild("Torso")
            parts = {
                Head           = char:FindFirstChild("Head"),
                UpperTorso     = torso,
                LowerTorso     = torso,
                LeftArm        = char:FindFirstChild("Left Arm"),
                RightArm       = char:FindFirstChild("Right Arm"),
                LeftHand       = nil, RightHand = nil,
                LeftLeg        = char:FindFirstChild("Left Leg"),
                RightLeg       = char:FindFirstChild("Right Leg"),
                LeftFoot       = nil, RightFoot = nil,
                HRP            = char:FindFirstChild("HumanoidRootPart"),
                Humanoid       = char:FindFirstChildOfClass("Humanoid"),
                ShoulderOffset = Vector3.new(0, 0.5, 0),
            }
            rig = "R6"
        end

        -- NUR cachen wenn kritische Parts vollständig geladen sind.
        -- Sonst wird nächsten Frame nochmal FindFirstChild aufgerufen
        -- bis der Character fertig geladen ist.
        if parts.Head and parts.UpperTorso and parts.LowerTorso and parts.HRP then
            _partsCache[player] = { parts = parts, rig = rig, char = char }
        end

        return parts, rig
    end

    local _visCache    = {}
    local _cornerCache = {}
    local _hpCache     = {}
    local _predCache   = {}

    -- Cache leeren wenn Spieler geht
    Players.PlayerRemoving:Connect(function(player)
        _partsCache[player] = nil
        _visCache[player]   = nil
        local char = GetCharacter(player)
        if char then _cornerCache[char] = nil end
    end)

    local function onCharacterAdded(player, char)
        _partsCache[player] = nil
        if _visCache then _visCache[player] = nil end
        if _cornerCache then _cornerCache[char] = nil end
        if _hpCache then _hpCache[player] = nil end
        if _predCache then _predCache[player] = nil end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        player.CharacterAdded:Connect(function(char)
            onCharacterAdded(player, char)
        end)
    end

    -- Ersetze den vorhandenen Players.PlayerAdded Block:
    local function connectPlayer(player)
        player.CharacterAdded:Connect(function(char)
            onCharacterAdded(player, char)
        end)
        player.CharacterRemoving:Connect(function()
            _partsCache[player] = nil
            _visCache[player]   = nil
            _hpCache[player]    = nil
            _predCache[player]  = nil
            if PlayerDrawings and PlayerDrawings[player] then hideAll(PlayerDrawings[player]) end
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        connectPlayer(player)
    end
    Players.PlayerAdded:Connect(connectPlayer)

    -- ──────────────────────────────────────────────
    -- OPT 2: Humanoid-Health-Cache
    -- Health nur alle 100ms neu lesen statt jedes Frame
    -- ──────────────────────────────────────────────
    local _hpCache = {}
    local HP_CACHE_TTL = 0.1

    local function getCachedHP(player, humanoid)
        if not humanoid then return 1 end
        local now  = tick()
        local c    = _hpCache[player]
        if c and (now - c.time) < HP_CACHE_TTL then return c.pct end
        local pct = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
        _hpCache[player] = { pct = pct, time = now }
        return pct
    end

    -- ──────────────────────────────────────────────
    -- Drawing-Helpers (unverändert)
    -- ──────────────────────────────────────────────
    local function newLine(color, thickness)
        local l = Drawing.new("Line")
        l.Thickness = thickness or 1.5
        l.Color     = color or Color3.fromRGB(255,255,255)
        l.Visible   = false
        return l
    end

    local function newCircleDrawing(color)
        local c = Drawing.new("Circle")
        c.Thickness = 1.5
        c.Color     = color or Color3.fromRGB(255,255,255)
        c.Filled    = false
        c.NumSides  = 64
        c.Visible   = false
        return c
    end

    local function newText()
        local t = Drawing.new("Text")
        t.Size         = 14
        t.Font         = Drawing.Fonts.UI
        t.Color        = Color3.fromRGB(255,255,255)
        t.Outline      = true
        t.OutlineColor = Color3.fromRGB(0,0,0)
        t.Center       = true
        t.Visible      = false
        return t
    end

    local function newRect(color, filled)
        local r = Drawing.new("Square")
        r.Thickness = 1
        r.Color     = color or Color3.fromRGB(0,200,0)
        r.Filled    = filled or false
        r.Visible   = false
        return r
    end

    local function newQuad(color)
        local q = Drawing.new("Square")
        q.Color        = color or Color3.fromRGB(255,60,60)
        q.Filled       = true
        q.Thickness    = 0
        q.Transparency = 0.7
        q.Visible      = false
        return q
    end

    local PlayerDrawings = {}

    local function createDrawings()
        return {
            HeadToTorso   = newLine(Color3.fromRGB(255,255,255)),
            UpperToLower  = newLine(Color3.fromRGB(255,255,255)),
            TorsoLeft     = newLine(Color3.fromRGB(255,255,255)),
            TorsoRight    = newLine(Color3.fromRGB(255,255,255)),
            LeftArmFore   = newLine(Color3.fromRGB(255,255,255)),
            RightArmFore  = newLine(Color3.fromRGB(255,255,255)),
            LeftLegFore   = newLine(Color3.fromRGB(255,255,255)),
            RightLegFore  = newLine(Color3.fromRGB(255,255,255)),
            TorsoLeftLeg  = newLine(Color3.fromRGB(255,255,255)),
            TorsoRightLeg = newLine(Color3.fromRGB(255,255,255)),
            Tracer        = newLine(Color3.fromRGB(255,255,255), 1),
            BoxFilled     = newRect(Color3.fromRGB(255,60,60), true),
            Box           = newRect(Color3.fromRGB(255,60,60)),
            BoxOutline    = newRect(Color3.fromRGB(0,0,0)),
            NameText      = newText(),
            DistText      = newText(),
            VoiceText     = newText(),
            DeviceText    = newText(),
            HealthBG      = newRect(Color3.fromRGB(0,0,0), true),
            HealthFG      = newRect(Color3.fromRGB(0,200,0), true),
            CornerTL_H    = newLine(Color3.fromRGB(255,60,60)),
            CornerTL_V    = newLine(Color3.fromRGB(255,60,60)),
            CornerTR_H    = newLine(Color3.fromRGB(255,60,60)),
            CornerTR_V    = newLine(Color3.fromRGB(255,60,60)),
            CornerBL_H    = newLine(Color3.fromRGB(255,60,60)),
            CornerBL_V    = newLine(Color3.fromRGB(255,60,60)),
            CornerBR_H    = newLine(Color3.fromRGB(255,60,60)),
            CornerBR_V    = newLine(Color3.fromRGB(255,60,60)),
            ArrowL        = newLine(Color3.fromRGB(255,200,0), 2),
            ArrowR        = newLine(Color3.fromRGB(255,200,0), 2),
            _has3D        = false,
            HeadCircle    = newCircleDrawing(),
            HeadCircle_O  = newCircleDrawing(Color3.fromRGB(0,0,0)),
        }
    end

    local function ensure3DLines(d)
        if d._has3D then return end
        d._has3D = true
        local col = Color3.fromRGB(255,60,60)
        for i = 1, 12 do d["Box3D_"..i]   = newLine(col) end
        for i = 1, 24 do d["Box3D_C_"..i] = newLine(col) end
        for i = 1, 6  do d["BoxFill3D_F"..i] = newQuad(col) end
    end

    local function getOrCreate(key)
        if not PlayerDrawings[key] then PlayerDrawings[key] = createDrawings() end
        return PlayerDrawings[key]
    end

    -- ──────────────────────────────────────────────
    -- OPT 3: hideAll als pre-gebaute Liste
    -- Direkte Index-Zugriffe sind schneller als pairs()
    -- ──────────────────────────────────────────────
    local _HIDE_KEYS = {
        "HeadToTorso","UpperToLower","TorsoLeft","TorsoRight",
        "LeftArmFore","RightArmFore","LeftLegFore","RightLegFore",
        "TorsoLeftLeg","TorsoRightLeg","Tracer","BoxFilled","Box",
        "BoxOutline","NameText","DistText","VoiceText","HealthBG","HealthFG",
        "CornerTL_H","CornerTL_V","CornerTR_H","CornerTR_V",
        "CornerBL_H","CornerBL_V","CornerBR_H","CornerBR_V",
        "ArrowL","ArrowR","HeadCircle","HeadCircle_O","DeviceText",
    }

    local function hideAll(d)
        for i = 1, #_HIDE_KEYS do
            local obj = d[_HIDE_KEYS[i]]
            if obj then obj.Visible = false end
        end
        if d._has3D then
            for i = 1, 12 do if d["Box3D_"..i]      then d["Box3D_"..i].Visible      = false end end
            for i = 1, 24 do if d["Box3D_C_"..i]    then d["Box3D_C_"..i].Visible    = false end end
            for i = 1,  6 do if d["BoxFill3D_F"..i] then d["BoxFill3D_F"..i].Visible = false end end
        end
    end

    local function toScreen(pos)
        local v = Camera:WorldToViewportPoint(pos)
        return Vector2.new(v.X, v.Y), v.Z > 0, v.Z
    end

    local function getBoundingBox2D(positions3D)
        local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
        for _, pos in ipairs(positions3D) do
            local s = toScreen(pos)
            if s.X < minX then minX = s.X end
            if s.Y < minY then minY = s.Y end
            if s.X > maxX then maxX = s.X end
            if s.Y > maxY then maxY = s.Y end
        end
        return minX, minY, maxX, maxY
    end

    local function healthColor(pct)
        if pct > 0.5 then
            return Color3.fromRGB(math.floor((1-pct)*2*255), 200, 0)
        else
            return Color3.fromRGB(200, math.floor(pct*2*200), 0)
        end
    end

    local function drawSkeleton(d, p, skelColor, shoulderPos, headPos, lowerPos, rig)
        local function setLine(line, fromPos, toPos)
            line.From    = fromPos
            line.To      = toPos
            line.Color   = skelColor
            line.Visible = true
        end
        local function connectBone(line, fromPart, toPart)
            if fromPart and toPart then
                local a, aVis = toScreen(fromPart.Position)
                local b, bVis = toScreen(toPart.Position)
                if aVis and bVis then setLine(line, a, b) return true end
            end
            line.Visible = false
            return false
        end

        local _, hVis = toScreen(p.Head.Position)
        local _, sVis = toScreen(p.UpperTorso.Position + p.ShoulderOffset)
        local _, lVis = toScreen(p.LowerTorso.Position)

        if hVis and sVis then setLine(d.HeadToTorso, headPos, shoulderPos)
        else d.HeadToTorso.Visible = false end

        if rig == "R6" then
            d.UpperToLower.Visible = false
        else
            if sVis and lVis then setLine(d.UpperToLower, shoulderPos, lowerPos)
            else d.UpperToLower.Visible = false end
        end

        connectBone(d.TorsoLeft,     p.UpperTorso, p.LeftArm)
        connectBone(d.TorsoRight,    p.UpperTorso, p.RightArm)
        connectBone(d.TorsoLeftLeg,  p.LowerTorso, p.LeftLeg)
        connectBone(d.TorsoRightLeg, p.LowerTorso, p.RightLeg)

        if rig == "R15" then
            connectBone(d.LeftArmFore,  p.LeftArm,  p.LeftHand)
            connectBone(d.RightArmFore, p.RightArm, p.RightHand)
            connectBone(d.LeftLegFore,  p.LeftLeg,  p.LeftFoot)
            connectBone(d.RightLegFore, p.RightLeg, p.RightFoot)
        else
            d.LeftArmFore.Visible  = false
            d.RightArmFore.Visible = false
            d.LeftLegFore.Visible  = false
            d.RightLegFore.Visible = false
        end
    end

    local function hideSkeleton(d)
        for _, key in ipairs({"HeadToTorso","UpperToLower","TorsoLeft","TorsoRight",
            "LeftArmFore","RightArmFore","TorsoLeftLeg","TorsoRightLeg","LeftLegFore","RightLegFore"}) do
            d[key].Visible = false
        end
    end

    local _cornerCache = {}
    local CORNER_UPDATE_INTERVAL = 0.05

    local function get3DBoxCorners(char)
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return {} end
        local now = tick()
        local cached = _cornerCache[char]
        if cached and (now - cached.time) < CORNER_UPDATE_INTERVAL then
            return cached.corners
        end

        local minX, minY, minZ =  math.huge,  math.huge,  math.huge
        local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                local cf   = part.CFrame
                local half = part.Size * 0.5
                local corners3 = {
                    cf * Vector3.new( half.X,  half.Y,  half.Z),
                    cf * Vector3.new(-half.X,  half.Y,  half.Z),
                    cf * Vector3.new( half.X, -half.Y,  half.Z),
                    cf * Vector3.new(-half.X, -half.Y,  half.Z),
                    cf * Vector3.new( half.X,  half.Y, -half.Z),
                    cf * Vector3.new(-half.X,  half.Y, -half.Z),
                    cf * Vector3.new( half.X, -half.Y, -half.Z),
                    cf * Vector3.new(-half.X, -half.Y, -half.Z),
                }
                for _, w in ipairs(corners3) do
                    if w.X < minX then minX = w.X end
                    if w.Y < minY then minY = w.Y end
                    if w.Z < minZ then minZ = w.Z end
                    if w.X > maxX then maxX = w.X end
                    if w.Y > maxY then maxY = w.Y end
                    if w.Z > maxZ then maxZ = w.Z end
                end
            end
        end

        local result = {
            Vector3.new(minX,minY,minZ), Vector3.new(maxX,minY,minZ),
            Vector3.new(maxX,minY,maxZ), Vector3.new(minX,minY,maxZ),
            Vector3.new(minX,maxY,minZ), Vector3.new(maxX,maxY,minZ),
            Vector3.new(maxX,maxY,maxZ), Vector3.new(minX,maxY,maxZ),
        }
        _cornerCache[char] = { corners = result, time = now }
        return result
    end

    local _visCache = {}
    local VIS_CACHE_TTL = 0.15
    local _box3DFillWarned = false

    -- ──────────────────────────────────────────────
    -- OPT 4: Arrow-Helfer-Funktion
    -- Duplizierter Arrow-Code war ~60 Zeilen x2.
    -- Jetzt eine einzige Funktion.
    -- ──────────────────────────────────────────────
    local function drawArrow(d, hrpPos, col)
        local viewport  = Camera.ViewportSize
        local center    = Vector2.new(viewport.X / 2, viewport.Y / 2)
        local camCF     = Camera.CFrame
        local localDir  = camCF:VectorToObjectSpace(hrpPos - camCF.Position)
        local scrPos, inFront = toScreen(hrpPos)
        local onScreen = inFront
            and scrPos.X > 0 and scrPos.X < viewport.X
            and scrPos.Y > 0 and scrPos.Y < viewport.Y

        if onScreen then
            d.ArrowL.Visible = false
            d.ArrowR.Visible = false
            return
        end

        local screenDir
        if localDir.Z > 0 then screenDir = Vector2.new( localDir.X,  localDir.Y)
        else               screenDir = Vector2.new(-localDir.X, -localDir.Y) end
        local len = screenDir.Magnitude
        if len > 0 then screenDir = screenDir / len end
        local perp  = Vector2.new(-screenDir.Y, screenDir.X)
        local tip   = center + screenDir * 87
        local base1 = center + screenDir * 75 + perp * 9
        local base2 = center + screenDir * 75 - perp * 9

        d.ArrowL.From = tip;   d.ArrowL.To = base1
        d.ArrowL.Color = col;  d.ArrowL.Thickness = 2; d.ArrowL.Visible = true
        d.ArrowR.From = tip;   d.ArrowR.To = base2
        d.ArrowR.Color = col;  d.ArrowR.Thickness = 2; d.ArrowR.Visible = true
    end

    local function renderPlayer(player, d, isSelf, cfg)
        -- ── OPT 5: gecachte Parts statt fresh FindFirstChild
        local char = GetCharacter(player)
        if not char then hideAll(d) return end

        local p, rig = getCharParts(player)
        if not p then hideAll(d) return end
        if not p.Head or not p.UpperTorso or not p.LowerTorso or not p.HRP then
            hideAll(d) return
        end

        -- ── OPT 6: Distanz-Check VOR allen Screen-Berechnungen
        local myChar = GetCharacter(LocalPlayer)
        local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP and not isSelf then hideAll(d) return end
        local dist   = myHRP and (myHRP.Position - p.HRP.Position).Magnitude or 0

        if not isSelf and dist > cfg.MaxDistance then hideAll(d) return end

        -- ── OPT 7: toScreen-Ergebnisse einmalig berechnen und wiederverwenden
        local headPos,     headVis     = toScreen(p.Head.Position)
        local shoulderPos, shoulderVis = toScreen(p.UpperTorso.Position + p.ShoulderOffset)
        local lowerPos,    lowerVis    = toScreen(p.LowerTorso.Position)

        -- Arrow (einmal mit Helfer-Funktion)
        d.ArrowL.Visible = false
        d.ArrowR.Visible = false
        if cfg.Arrow and not isSelf then
            drawArrow(d, p.HRP.Position, (isFriend and SwitchFunctions["ESP_FRIEND_ARROW_COLOR"])
                and getESPColor("ESP_FRIEND_ARROW_COLOR")
                or  getESPColor("ESP_ARROW_INDICATOR_ENABLE"))
        end

        -- ── OPT 8: Früher Abbruch wenn Head off-screen
        if not headVis then
            for k, v in pairs(d) do
                if k ~= "ArrowL" and k ~= "ArrowR" then
                    pcall(function() v.Visible = false end)
                end
            end
            return
        end

        hideAll(d)

        -- Arrows nach hideAll wiederherstellen (einmal, mit Helfer)
        if cfg.Arrow and not isSelf then
            drawArrow(d, p.HRP.Position, (isFriend and SwitchFunctions["ESP_FRIEND_ARROW_COLOR"])
                and getESPColor("ESP_FRIEND_ARROW_COLOR")
                or  getESPColor("ESP_ARROW_INDICATOR_ENABLE"))
        end

        -- ── OPT 9: Visibility-Check mit Cache (unverändert, war schon gut)
        local isVisible = true
        if cfg.VisibleCheck and not isSelf and myHRP then
            local now = tick()
            local cached = _visCache[player]
            if cached and (now - cached.time) < VIS_CACHE_TTL then
                isVisible = cached.result
            else
                local origin    = myHRP.Position
                local target    = p.HRP.Position
                local direction = target - origin
                local rayParams = RaycastParams.new()
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                rayParams.FilterDescendantsInstances = {myChar, char}
                local result = workspace:Raycast(origin, direction, rayParams) == nil
                _visCache[player] = { result = result, time = now }
                isVisible = result
            end
        end

        -- Farb-Bestimmung
        local isFriend = FriendList[player.Name] == true
        local teamColor
        if isSelf then
            teamColor = getESPColor("ESP_SELF_COLOR")
        elseif player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
            teamColor = getESPColor("ESP_FRIENDLY_COLOR")
        else
            teamColor = getESPColor("ESP_ENEMY_COLOR")
        end

        -- ── OPT 10: gecachte HP statt jedes Frame property lesen
        local humanoid = p.Humanoid
        local hpPct    = getCachedHP(player, humanoid)

        local function healthBasedColor()
            return Color3.fromRGB(math.floor((1-hpPct)*255), math.floor(hpPct*200), 0)
        end

        local skelColor, boxColor
        if cfg.VisibleCheck and not isVisible then
            skelColor = Color3.fromRGB(255,0,0)
            boxColor  = Color3.fromRGB(255,0,0)
        elseif cfg.HealthColor then
            skelColor = healthBasedColor()
            boxColor  = healthBasedColor()
        else
            skelColor = (isFriend and SwitchFunctions["ESP_FRIEND_SKELETON_COLOR"])
                and getESPColor("ESP_FRIEND_SKELETON_COLOR")
                or  getESPColor("ESP_SKELETON_ENABLE")
            boxColor  = (isFriend and SwitchFunctions["ESP_FRIEND_BOX_COLOR"])
                and getESPColor("ESP_FRIEND_BOX_COLOR")
                or  (cfg.TeamCheck and teamColor or getESPColor("ESP_BOX_ENABLE"))
        end

        local showSkeleton = (isSelf and cfg.SelfSkeleton) or (not isSelf and cfg.Skeleton)
        if showSkeleton then
            drawSkeleton(d, p, skelColor, shoulderPos, headPos, lowerPos, rig)
        else
            hideSkeleton(d)
        end

        -- Tracer
        d.Tracer.Visible = cfg.Tracers and not isSelf
        if cfg.Tracers and not isSelf then
            local viewport  = Camera.ViewportSize
            local fromY = (cfg.TracerPosition == "oben") and 0 or viewport.Y
            d.Tracer.From  = Vector2.new(viewport.X / 2, fromY)
            d.Tracer.To    = headPos
            d.Tracer.Color = (isFriend and SwitchFunctions["ESP_FRIEND_TRACER_COLOR"])
                and getESPColor("ESP_FRIEND_TRACER_COLOR")
                or  getESPColor("ESP_TRACER_ENABLE")
        end

        -- ── OPT 11: get3DBoxCorners nur EINMAL pro renderPlayer aufrufen
        -- (vorher wurde es bis zu 3x aufgerufen)
        local corners3D_bbox = get3DBoxCorners(char)
        local minX, minY, maxX, maxY = getBoundingBox2D(corners3D_bbox)
        local pad  = 5
        local tl   = Vector2.new(minX - pad, minY - pad)
        local tr   = Vector2.new(maxX + pad, minY - pad)
        local br   = Vector2.new(maxX + pad, maxY + pad)
        local bl   = Vector2.new(minX - pad, maxY + pad)
        local boxW = (maxX - minX) + pad * 2
        local boxH = (maxY - minY) + pad * 2
        local cLen = math.min(boxW, boxH) * 0.25

        -- Farbe für 3D/Corner-Box (einmal berechnen, nicht zweimal)
        local box3DColor, cornerColor
        if cfg.VisibleCheck and not isVisible then
            box3DColor  = Color3.fromRGB(255,0,0)
            cornerColor = Color3.fromRGB(255,0,0)
        elseif cfg.HealthColor then
            box3DColor  = healthBasedColor()
            cornerColor = healthBasedColor()
        else
            box3DColor  = (isFriend and SwitchFunctions["ESP_FRIEND_BOX_COLOR"])
                and getESPColor("ESP_FRIEND_BOX_COLOR")
                or  (cfg.TeamCheck and teamColor or getESPColor("ESP_BOX_ENABLE"))
            cornerColor = (isFriend and SwitchFunctions["ESP_FRIEND_CORNER_BOX_COLOR"])
                and getESPColor("ESP_FRIEND_CORNER_BOX_COLOR")
                or  (cfg.TeamCheck and teamColor or getESPColor("ESP_CORNER_BOX_ENABLE"))
        end

        d.BoxOutline.Visible = false

        -- 3D-Lines sicherstellen
        if cfg.Box3D then ensure3DLines(d) end

        local box3DLines  = d._has3D and {
            d.Box3D_1,  d.Box3D_2,  d.Box3D_3,  d.Box3D_4,
            d.Box3D_5,  d.Box3D_6,  d.Box3D_7,  d.Box3D_8,
            d.Box3D_9,  d.Box3D_10, d.Box3D_11, d.Box3D_12,
        } or {}
        local box3DCLines = d._has3D and {
            d.Box3D_C_1,  d.Box3D_C_2,  d.Box3D_C_3,  d.Box3D_C_4,
            d.Box3D_C_5,  d.Box3D_C_6,  d.Box3D_C_7,  d.Box3D_C_8,
            d.Box3D_C_9,  d.Box3D_C_10, d.Box3D_C_11, d.Box3D_C_12,
            d.Box3D_C_13, d.Box3D_C_14, d.Box3D_C_15, d.Box3D_C_16,
            d.Box3D_C_17, d.Box3D_C_18, d.Box3D_C_19, d.Box3D_C_20,
            d.Box3D_C_21, d.Box3D_C_22, d.Box3D_C_23, d.Box3D_C_24,
        } or {}

        if cfg.Box3D then
            -- ── 3D Modus ──
            for _, ln in ipairs(box3DLines)  do ln.Visible = false end
            for _, ln in ipairs(box3DCLines) do ln.Visible = false end
            d.Box.Visible = false
            for _, c in ipairs({d.CornerTL_H,d.CornerTL_V,d.CornerTR_H,d.CornerTR_V,
                                d.CornerBL_H,d.CornerBL_V,d.CornerBR_H,d.CornerBR_V}) do
                c.Visible = false
            end

            if cfg.Boxes or cfg.CornerBox then
                -- OPT: corners3D_bbox bereits berechnet, direkt nutzen
                local s = {}
                local allVis = true
                for i, c3 in ipairs(corners3D_bbox) do
                    local sp, vis = toScreen(c3)
                    s[i] = sp
                    if not vis then allVis = false end
                end

                local edges = {
                    {1,2},{2,3},{3,4},{4,1},
                    {5,6},{6,7},{7,8},{8,5},
                    {1,5},{2,6},{3,7},{4,8},
                }

                if allVis then
                    if cfg.Boxes then
                        for i, edge in ipairs(edges) do
                            local ln = box3DLines[i]
                            ln.From = s[edge[1]]; ln.To = s[edge[2]]
                            ln.Color = box3DColor; ln.Thickness = 1.5; ln.Visible = true
                        end
                    elseif cfg.CornerBox then
                        local cRatio = 0.25
                        for i, edge in ipairs(edges) do
                            local a   = s[edge[1]]
                            local b   = s[edge[2]]
                            local dir = b - a
                            local ln1 = box3DCLines[i*2-1]
                            local ln2 = box3DCLines[i*2]
                            ln1.From = a; ln1.To = a + dir * cRatio
                            ln1.Color = cornerColor; ln1.Thickness = 1.5; ln1.Visible = true
                            ln2.From = b; ln2.To = b - dir * cRatio
                            ln2.Color = cornerColor; ln2.Thickness = 1.5; ln2.Visible = true
                        end
                    end
                end
            end
        else
            -- ── 2D Modus ──
            for _, ln in ipairs(box3DLines)  do ln.Visible = false end
            for _, ln in ipairs(box3DCLines) do ln.Visible = false end

            if cfg.Boxes and not cfg.CornerBox then
                d.Box.Visible   = true
                d.Box.Position  = tl
                d.Box.Size      = Vector2.new(boxW, boxH)
                d.Box.Color     = box3DColor
                d.Box.Thickness = 2
            else
                d.Box.Visible = false
            end

            if cfg.CornerBox then
                local corners2D = {
                    {d.CornerTL_H, tl, Vector2.new(tl.X+cLen, tl.Y)},
                    {d.CornerTL_V, tl, Vector2.new(tl.X, tl.Y+cLen)},
                    {d.CornerTR_H, tr, Vector2.new(tr.X-cLen, tr.Y)},
                    {d.CornerTR_V, tr, Vector2.new(tr.X, tr.Y+cLen)},
                    {d.CornerBL_H, bl, Vector2.new(bl.X+cLen, bl.Y)},
                    {d.CornerBL_V, bl, Vector2.new(bl.X, bl.Y-cLen)},
                    {d.CornerBR_H, br, Vector2.new(br.X-cLen, br.Y)},
                    {d.CornerBR_V, br, Vector2.new(br.X, br.Y-cLen)},
                }
                for _, c in ipairs(corners2D) do
                    local ln, from, to = c[1], c[2], c[3]
                    ln.From = from; ln.To = to
                    ln.Color = cornerColor; ln.Thickness = 2; ln.Visible = true
                end
            end
        end

        -- Box Fill
        local showFill = (cfg.Boxes or cfg.CornerBox) and cfg.BoxFill
        if d._has3D then
            for i = 1, 6 do
                if d["BoxFill3D_F"..i] then d["BoxFill3D_F"..i].Visible = false end
            end
        end

        if showFill then
            if cfg.Box3D then
                if not _box3DFillWarned then
                    _box3DFillWarned = true
                    SendNotify("Box Fill für 3D Box nicht verfügbar")
                end
                d.BoxFilled.Visible = false
            else
                local fillColor = (isFriend and SwitchFunctions["ESP_FRIEND_BOX_FILL_COLOR"])
                    and getESPColor("ESP_FRIEND_BOX_FILL_COLOR")
                    or  getESPColor("ESP_BOX_FILL_ENABLE")
                d.BoxFilled.Visible      = true
                d.BoxFilled.Position     = tl
                d.BoxFilled.Size         = Vector2.new(boxW, boxH)
                d.BoxFilled.Color        = fillColor
                d.BoxFilled.Filled       = true
                d.BoxFilled.Transparency = 1 - cfg.BoxFillTrans
            end
        else
            d.BoxFilled.Visible = false
        end

        -- Health Bar
        d.HealthBG.Visible = cfg.HealthBar
        d.HealthFG.Visible = cfg.HealthBar
        if cfg.HealthBar and humanoid then
            local barX   = minX - pad - 7
            local barTop = minY - pad
            local barH   = (maxY + pad) - barTop
            d.HealthBG.Position = Vector2.new(barX-1, barTop-1)
            d.HealthBG.Size     = Vector2.new(5, barH+2)
            d.HealthFG.Position = Vector2.new(barX, barTop + barH*(1-hpPct))
            d.HealthFG.Size     = Vector2.new(3, barH*hpPct)
            d.HealthFG.Color    = cfg.HealthColor and healthBasedColor() or healthColor(hpPct)
        end

        -- Name
        d.NameText.Visible = cfg.Names and not isSelf
        if cfg.Names and not isSelf then
            d.NameText.Text         = player.DisplayName
            d.NameText.Color        = Color3.fromRGB(255,255,255)
            d.NameText.Outline      = true
            d.NameText.OutlineColor = Color3.fromRGB(0,0,0)
            d.NameText.Position     = Vector2.new(headPos.X, minY-pad-18)
        end

        -- VoiceChat Indikator
        d.VoiceText.Visible = cfg.VoiceChat and not isSelf
        if cfg.VoiceChat and not isSelf then
            local hasVoice = isVoiceEnabled(player)
            local voiceOffsetY = cfg.Names and (minY-pad-33) or (minY-pad-18)
            d.VoiceText.Text         = hasVoice and "🎙 VC" or "🔇 No VC"
            d.VoiceText.Color        = hasVoice and Color3.fromRGB(80,220,80) or Color3.fromRGB(180,80,80)
            d.VoiceText.Outline      = true
            d.VoiceText.OutlineColor = Color3.fromRGB(0,0,0)
            d.VoiceText.Size         = 13
            d.VoiceText.Position     = Vector2.new(headPos.X, voiceOffsetY)
            d.VoiceText.Visible      = true
        end

        -- Device Indikator
        d.DeviceText.Visible = cfg.DeviceShow and not isSelf
        if cfg.DeviceShow and not isSelf then
            local _, deviceIcon = detectPlayerDevice(player)
            -- Y-Offset: unter Name (und ggf. VC), Reihenfolge von oben:
            -- VoiceChat → Name → DeviceIcon
            local devOffsetY = minY - pad - 18
            if cfg.Names     then devOffsetY = devOffsetY - 15 end
            if cfg.VoiceChat then devOffsetY = devOffsetY - 15 end
            d.DeviceText.Text         = deviceIcon
            d.DeviceText.Color        = Color3.fromRGB(200, 200, 210)
            d.DeviceText.Outline      = true
            d.DeviceText.OutlineColor = Color3.fromRGB(0, 0, 0)
            d.DeviceText.Size         = 13
            d.DeviceText.Position     = Vector2.new(headPos.X, devOffsetY)
            d.DeviceText.Visible      = true
        end

        -- Distanz
        d.DistText.Visible = cfg.Distance and not isSelf
        if cfg.Distance and not isSelf then
            d.DistText.Text         = string.format("[%dm]", math.floor(dist))
            d.DistText.Color        = Color3.fromRGB(220,220,220)
            d.DistText.Outline      = true
            d.DistText.OutlineColor = Color3.fromRGB(0,0,0)
            d.DistText.Position     = Vector2.new(headPos.X, maxY+pad+3)
        end

        -- Head Circle
        if d.HeadCircle   then d.HeadCircle.Visible   = false end
        if d.HeadCircle_O then d.HeadCircle_O.Visible = false end

        if cfg.HeadCircle and p.Head then
            -- headPos bereits berechnet, nur edgeScreen noch nötig
            local edgeScreen = toScreen(p.Head.Position + Vector3.new(p.Head.Size.X * 0.6, 0, 0))
            if headVis then
                local radius = math.max(4, math.abs(edgeScreen.X - headPos.X))
                d.HeadCircle.Position  = headPos
                d.HeadCircle.Radius    = radius
                d.HeadCircle.Thickness = 3
                d.HeadCircle.Color     = (isFriend and SwitchFunctions["ESP_FRIEND_HEAD_CIRCLE_COLOR"])
                    and getESPColor("ESP_FRIEND_HEAD_CIRCLE_COLOR")
                    or  getESPColor("ESP_HEAD_CIRCLE_ENABLE")
                d.HeadCircle.Visible   = true
            end
        end
    end

    local _lastCfgUpdate = 0
    local _cfg = {}

    -- ═══════════════════════
    -- ══  Radar System     ══
    -- ═══════════════════════

    -- Hilfsfunktion: Farbe aus ColorFunctions lesen
    local function radarGetColor(key, fallback)
        local hex = ColorFunctions[key]
        if type(hex) == "string" and #hex >= 6 then
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            if r and g and b then return Color3.fromRGB(r, g, b) end
        end
        return fallback
    end

    -- Sichtbarkeits-Cache
    local _radarVisCache = {}
    local RADAR_VIS_TTL  = 0.2

    local function radarIsVisible(player, hrp, myHRP, myChar, char)
        if not hrp or not myHRP then return false end
        local now    = tick()
        local cached = _radarVisCache[player]
        if cached and (now - cached.time) < RADAR_VIS_TTL then return cached.result end
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = {myChar, char}
        local result = workspace:Raycast(myHRP.Position, hrp.Position - myHRP.Position, rp) == nil
        _radarVisCache[player] = { result = result, time = now }
        return result
    end

    Players.PlayerRemoving:Connect(function(p) _radarVisCache[p] = nil end)

    -- Spieler-Punkte Cache (geklonte RADAR_EXAMPLE_POINTs)
    local RadarPlayerPoints = {}  -- [player] = ImageLabel (Clone von RADAR_EXAMPLE_POINT)

    local function getOrCreateRadarPoint(player)
        if RadarPlayerPoints[player] and RadarPlayerPoints[player].Parent then
            return RadarPlayerPoints[player]
        end
        local point = Gui.RADAR_EXAMPLE_POINT:Clone()
        point.Parent  = Gui.RADAR_MAIN_FRAME
        point.Visible = false
        RadarPlayerPoints[player] = point
        return point
    end

    local function hideRadarPoint(player)
        local p = RadarPlayerPoints[player]
        if p then p.Visible = false end
    end

    local function removeRadarPoint(player)
        local p = RadarPlayerPoints[player]
        if p then
            pcall(function() p:Destroy() end)
            RadarPlayerPoints[player] = nil
        end
    end

    Players.PlayerRemoving:Connect(function(player)
        removeRadarPoint(player)
    end)

    -- Nord-Linie (Drawing, da UILine nicht existiert)
    local RadarNorthLine = Drawing.new("Line")
    RadarNorthLine.Color     = Color3.fromRGB(220, 220, 225)
    RadarNorthLine.Thickness = 1.5
    RadarNorthLine.Transparency = 0.4
    RadarNorthLine.Visible   = false

    -- Drag-State
    local RadarDragging   = false
    local RadarDragOffset = Vector2.new(0, 0)

    -- Drag nur wenn Menü offen
    local function radarCanDrag()
        return Gui.MAIN_FRAME.Visible == true
    end

    -- Maus-Position auf Radar prüfen
    local function isMouseOverRadar(mousePos)
        if not Gui.RADAR_FRAME.Visible then return false end
        local absPos  = Gui.RADAR_FRAME.AbsolutePosition
        local absSize = Gui.RADAR_FRAME.AbsoluteSize
        return mousePos.X >= absPos.X and mousePos.X <= absPos.X + absSize.X
        and mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + absSize.Y
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        if not SwitchFunctions["RADAR_ENABLE"] then return end
        if not radarCanDrag() then return end
        local mousePos = UserInputService:GetMouseLocation()
        if isMouseOverRadar(mousePos) then
            RadarDragging   = true
            Gui.RADAR_FRAME.Active      = true   -- Drag aktiv: Maus fangen
            Gui.RADAR_MAIN_FRAME.Active = true
            local absPos    = Gui.RADAR_FRAME.AbsolutePosition
            RadarDragOffset = mousePos - absPos
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        if not RadarDragging then return end
        local mousePos = UserInputService:GetMouseLocation()
        local vp       = Camera.ViewportSize
        local size     = Gui.RADAR_FRAME.AbsoluteSize

        local newX = math.clamp(mousePos.X - RadarDragOffset.X, 0, vp.X - size.X)
        local newY = math.clamp(mousePos.Y - RadarDragOffset.Y, 0, vp.Y - size.Y)

        -- Scale-basiert setzen damit es bei Resize passt
        Gui.RADAR_FRAME.Position = UDim2.fromOffset(newX, newY)
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            RadarDragging = false
            Gui.RADAR_FRAME.Active      = false  -- Drag fertig: Maus wieder freigeben
            Gui.RADAR_MAIN_FRAME.Active = false
        end
    end)

    -- Hauptlogik
    RunService.RenderStepped:Connect(function()
        local enabled       = SwitchFunctions["RADAR_ENABLE"]
        local radarSize     = math.clamp(DragFunctions["RADAR_SIZE"]    or 200, 80, 400)
        local radarScale    = math.clamp(DragFunctions["RADAR_SCALE"]   or 150, 10, 500)
        local opacityPct    = DragFunctions["RADAR_OPACITY"]   or 20
        local showSelf      = SwitchFunctions["RADAR_SHOW_SELF"]
        local teamColors    = SwitchFunctions["RADAR_TEAM_COLORS"]
        local enemyColorOn  = SwitchFunctions["RADAR_ENEMY_COLOR"]
        local teamCheck     = SwitchFunctions["RADAR_TEAM_CHECK"]
        local visCheck      = SwitchFunctions["RADAR_VISIBLE_CHECK"]
        local maxDist       = DragFunctions["RADAR_MAX_DIST"]   or 600
        local borderEnabled = SwitchFunctions["RADAR_BORDER_ENABLE"]
        local northLine     = SwitchFunctions["RADAR_NORTH_LINE"]
        local useArrow      = (SelectionFunctions["RADAR_USE_ARROW"] or 1) == 2
    
        -- Farben
        local selfColor   = radarGetColor("RADAR_SHOW_SELF",    Color3.fromRGB(160, 160, 175))
        local teamColor   = radarGetColor("RADAR_TEAM_COLORS",  Color3.fromRGB(0, 200, 100))
        local enemyColor  = radarGetColor("RADAR_ENEMY_COLOR",  Color3.fromRGB(255, 60, 60))
        local borderColor = radarGetColor("RADAR_BORDER_ENABLE",Color3.fromRGB(55, 55, 65))
    
        if not enabled then
            Gui.RADAR_FRAME.Visible      = false
            RadarNorthLine.Visible       = false
            for _, p in ipairs(Players:GetPlayers()) do hideRadarPoint(p) end
            return
        end
    
        -- Größe anwenden
        Gui.RADAR_FRAME.Size    = UDim2.fromOffset(radarSize, radarSize)
        Gui.RADAR_FRAME.Visible = true
    
        -- Startposition (einmalig)
        if Gui.RADAR_FRAME.Position == UDim2.new(0.8897, 0, 0.12, 0) then
            local vp = Camera.ViewportSize
            Gui.RADAR_FRAME.Position = UDim2.fromOffset(vp.X - radarSize - 10, 10)
        end
    
        -- Hintergrund Transparenz
        local bgTrans = math.clamp(opacityPct / 100, 0, 1)
        Gui.RADAR_MAIN_FRAME.BackgroundTransparency = bgTrans
    
        -- Rahmen (UIStroke)
        local existingStroke = Gui.RADAR_MAIN_FRAME:FindFirstChildOfClass("UIStroke")
        if borderEnabled then
            if not existingStroke then
                local stroke = Instance.new("UIStroke")
                stroke.Color     = borderColor
                stroke.Thickness = 2
                stroke.Parent    = Gui.RADAR_MAIN_FRAME
            else
                existingStroke.Color   = borderColor
                existingStroke.Enabled = true
            end
        else
            if existingStroke then existingStroke.Enabled = false end
        end
    
        -- Eigene Position
        Gui.RADAR_SELF_POINT.Visible = showSelf == true
        if showSelf then
            Gui.RADAR_SELF_POINT.ImageColor3 = selfColor
        end
    
        -- Drag-Cursor-Hint: Transparenz wenn draggable
        if radarCanDrag() then
            Gui.RADAR_MAIN_FRAME.BackgroundTransparency = math.max(bgTrans - 0.05, 0)
        end
    
        -- Eigener Char für Berechnungen
        local myChar = GetCharacter(LocalPlayer)
        local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local halfS  = radarSize / 2
    
        -- ══════════════════════════════════════════════════════════
        -- FIX: Kamera auf YAW-only flatten (kein Pitch/Roll)
        -- Wir bauen eine CFrame die nur horizontale Rotation hat.
        -- So bleibt der Radar stabil egal ob man nach oben/unten schaut.
        -- ══════════════════════════════════════════════════════════
        local function getFlattenedCamCFrame()
            local camPos  = Camera.CFrame.Position
            local lookVec = Camera.CFrame.LookVector
            -- LookVector auf XZ-Ebene projizieren (Y auf 0 setzen)
            local flatX = lookVec.X
            local flatZ = lookVec.Z
            local flatLen = math.sqrt(flatX*flatX + flatZ*flatZ)
            if flatLen < 0.0001 then
                -- Kamera schaut direkt nach oben/unten → Fallback auf letzte gültige Richtung
                -- CFrame.new mit Up-Vektor stabil halten
                return CFrame.new(camPos, camPos + Vector3.new(0, 0, -1))
            end
            local flatLook = Vector3.new(flatX/flatLen, 0, flatZ/flatLen)
            return CFrame.new(camPos, camPos + flatLook)
        end
    
        -- Nord-Linie
        if northLine and myHRP then
            local absPos  = Gui.RADAR_FRAME.AbsolutePosition
            local inset   = GuiService:GetGuiInset()
            local cx = absPos.X + halfS + inset.X
            local cy = absPos.Y + halfS + inset.Y
    
            -- Geflattete Kamera-Vorwärtsrichtung (nur YAW)
            local flatCF   = getFlattenedCamCFrame()
            local forward  = flatCF.LookVector  -- immer horizontal
    
            -- Auf Radar-Ebene: X = rechts, Z = vorwärts (auf Radar = oben)
            -- Da wir YAW-flattened sind, ist LookVector = (X,0,Z)
            -- Die Nord-Linie zeigt in die Blickrichtung
            local lineLen = halfS * 0.7
            RadarNorthLine.From    = Vector2.new(cx, cy)
            RadarNorthLine.To      = Vector2.new(cx + forward.X * lineLen, cy + forward.Z * lineLen)
            RadarNorthLine.Visible = true
        else
            RadarNorthLine.Visible = false
        end
    
        -- Alle Spieler-Punkte
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
    
            -- Team Check
            if teamCheck
            and player.Team and LocalPlayer.Team
            and player.Team == LocalPlayer.Team then
                hideRadarPoint(player)
                continue
            end
    
            local char = GetCharacter(player)
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    
            if not hrp or not myHRP then
                hideRadarPoint(player)
                continue
            end
    
            -- Distanz Check
            local dist3D = (hrp.Position - myHRP.Position).Magnitude
            if dist3D > maxDist then
                hideRadarPoint(player)
                continue
            end
    
            -- Sichtbarkeit
            if visCheck and not radarIsVisible(player, hrp, myHRP, myChar, char) then
                hideRadarPoint(player)
                continue
            end

            local refCFrame
            local useCharRotation = (SelectionFunctions["RADAR_USE_CHARACTER_ROTATION"] or 1) == 2
            if useCharRotation then
                -- Charakter-CFrame: nur YAW flatten (HRP kann auch kippen)
                local hrpPos    = myHRP.Position
                local hrpLook   = myHRP.CFrame.LookVector
                local flatX     = hrpLook.X
                local flatZ     = hrpLook.Z
                local flatLen2  = math.sqrt(flatX*flatX + flatZ*flatZ)
                if flatLen2 > 0.0001 then
                    refCFrame = CFrame.new(hrpPos, hrpPos + Vector3.new(flatX/flatLen2, 0, flatZ/flatLen2))
                else
                    refCFrame = CFrame.new(hrpPos, hrpPos + Vector3.new(0, 0, -1))
                end
            else
                -- Kamera: auf YAW flatten
                refCFrame = getFlattenedCamCFrame()
                -- Position auf myHRP setzen damit relative Berechnung korrekt ist
                refCFrame = CFrame.new(myHRP.Position, myHRP.Position + refCFrame.LookVector)
            end
    
            -- Relative Position des Spielers (nur XZ wegen geflatteter CFrame)
            local relative = refCFrame:PointToObjectSpace(hrp.Position)
            local normX    =  relative.X / radarScale
            local normZ    =  relative.Z / radarScale
    
            -- Länge normalisieren (Rand-Clamp)
            local len = math.sqrt(normX*normX + normZ*normZ)
            local isOnEdge = len > 1
    
            -- Fade-Effekt ab 80% der Reichweite
            local fadeFactor = 0
            if len > 0.8 then
                fadeFactor = math.clamp((len - 0.8) / 0.2, 0, 1)
            end
    
            if isOnEdge then
                normX = normX / len
                normZ = normZ / len
            end
    
            -- UDim2-Position auf Radar
            local relX = 0.5 + normX * 0.45
            local relY = 0.5 + normZ * 0.45
    
            -- Farbe bestimmen
            local dotColor
            if teamColors and player.Team and LocalPlayer.Team
            and player.Team == LocalPlayer.Team then
                dotColor = teamColor
            elseif enemyColorOn then
                dotColor = enemyColor
            else
                dotColor = Color3.fromRGB(255, 60, 60)
            end
    
            -- Punkt holen/erstellen und positionieren
            local point = getOrCreateRadarPoint(player)
            point.Position         = UDim2.fromScale(relX, relY)
            point.ImageColor3      = dotColor
            point.Visible          = true
            point.ImageTransparency = fadeFactor * 0.85
    
            -- ══════════════════════════════════════════════════════
            -- NEU: Pfeil vs. Punkt Symbol + Pfeil-Rotation
            -- ══════════════════════════════════════════════════════
            if useArrow then
                -- Pfeil-Image
                point.Image = "rbxassetid://117439729894365"
    
                -- Blickrichtung des Spielers relativ zur Radar-Referenz berechnen
                local playerLook  = hrp.CFrame.LookVector
                -- Auf XZ flatten
                local plFlatX     = playerLook.X
                local plFlatZ     = playerLook.Z
                local plFlatLen   = math.sqrt(plFlatX*plFlatX + plFlatZ*plFlatZ)
    
                if plFlatLen > 0.0001 then
                    plFlatX = plFlatX / plFlatLen
                    plFlatZ = plFlatZ / plFlatLen
    
                    -- Vorwärts- und Rechts-Vektor der Referenz-CFrame
                    local refForward = refCFrame.LookVector
                    local refRight   = refCFrame.RightVector
    
                    -- Spieler-Blickrichtung in Radar-Koordinaten projizieren
                    local playerVec = Vector3.new(plFlatX, 0, plFlatZ)
                    -- dot mit Right = X auf Radar, dot mit Forward = Y auf Radar (nach unten)
                    local radarX = playerVec:Dot(refRight)
                    local radarY = playerVec:Dot(refForward)
    
                    -- Winkel in Grad (0° = nach oben auf Radar = Vorwärts-Richtung)
                    local angle = math.deg(math.atan2(radarX, radarY))
                    point.Rotation = angle
                else
                    point.Rotation = 0
                end
            else
                -- Standard: Punkt-Image, keine Rotation
                point.Image    = "rbxassetid://81389225118639"
                point.Rotation = 0
            end
        end
    
        -- Punkte für nicht mehr vorhandene Spieler aufräumen
        for player, _ in pairs(RadarPlayerPoints) do
            if not player or not player.Parent then
                removeRadarPoint(player)
            end
        end
    end)


    Players.PlayerRemoving:Connect(function(player)
        removeRadarPoint(player)
        _radarVisCache[player] = nil
    end)

    -- ════════════════════
    -- ══  Chams Logik   ══
    -- ════════════════════

    local ChamsHighlights = {}  -- key = player, value = Highlight-Instance

    local function getChamsColor(player)
        if SwitchFunctions["CHAMS_TEAM_COLOR"] then
            if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                return Color3.fromRGB(0, 200, 100), Color3.fromRGB(0, 200, 100)
            else
                return Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 60, 60)
            end
        end
        local hex = ColorFunctions["CHAMS_ENABLE"]
        if type(hex) == "string" and #hex >= 6 then
            local r = tonumber(hex:sub(1,2), 16) or 255
            local g = tonumber(hex:sub(3,4), 16) or 255
            local b = tonumber(hex:sub(5,6), 16) or 255
            return Color3.fromRGB(r, g, b), Color3.fromRGB(r, g, b)
        end
        return Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 60, 60)
    end

    local function applyChams(player)
        local char = GetCharacter(player)
        if not char then return end

        local fillColor, outlineColor = getChamsColor(player)
        local transparency = 1 - ((DragFunctions["CHAMS_TRANSPARENCY"] or 40) / 100)
        local wallhack = SwitchFunctions["CHAMS_WALLHACK"]

        if not ChamsHighlights[player] then
            local h = Instance.new("Highlight")
            h.Adornee            = char
            h.FillColor          = fillColor
            h.OutlineColor       = outlineColor
            h.FillTransparency   = transparency
            h.OutlineTransparency = 0
            h.DepthMode          = wallhack
                and Enum.HighlightDepthMode.AlwaysOnTop
                or  Enum.HighlightDepthMode.Occluded
            h.Parent             = char
            ChamsHighlights[player] = h
        else
            local h = ChamsHighlights[player]
            h.Adornee            = char
            h.FillColor          = fillColor
            h.OutlineColor       = outlineColor
            h.FillTransparency   = transparency
            h.DepthMode          = wallhack
                and Enum.HighlightDepthMode.AlwaysOnTop
                or  Enum.HighlightDepthMode.Occluded
        end
    end

    local function removeChams(player)
        local h = ChamsHighlights[player]
        if h then
            pcall(function() h:Destroy() end)
            ChamsHighlights[player] = nil
        end
    end

    RunService.Heartbeat:Connect(function()
        local enabled   = SwitchFunctions["CHAMS_ENABLE"]
        local teamCheck = SwitchFunctions["CHAMS_TEAM_CHECK"]
        local visOnly   = SwitchFunctions["CHAMS_VISIBLE_ONLY"]

        if not enabled then
            for player in pairs(ChamsHighlights) do removeChams(player) end
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end

            local shouldSkip = false

            if teamCheck and player.Team and LocalPlayer.Team
            and player.Team == LocalPlayer.Team then
                shouldSkip = true
            end

            if not shouldSkip and visOnly then
                local char  = GetCharacter(player)
                local hrp   = char and char:FindFirstChild("HumanoidRootPart")
                local myChar = GetCharacter(player)
                local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if hrp and myHRP then
                    local rp = RaycastParams.new()
                    rp.FilterType = Enum.RaycastFilterType.Exclude
                    rp.FilterDescendantsInstances = {myChar, char}
                    local res = workspace:Raycast(myHRP.Position, hrp.Position - myHRP.Position, rp)
                    if res ~= nil then shouldSkip = true end
                end
            end

            if shouldSkip then removeChams(player)
            else applyChams(player) end
        end
    end)

    Players.PlayerRemoving:Connect(function(player) removeChams(player) end)

    Players.PlayerAdded:Connect(function(player)
        player.CharacterRemoving:Connect(function() removeChams(player) end)
    end)

    -- ═════════════════════
    -- ══ Crosshair Logic ══
    -- ═════════════════════

    local CrosshairDrawings = {}

    local CROSSHAIR_TYPES = {
        [1] = "Kreuz",        -- klassisches +
        [2] = "Dot",          -- einzelner Punkt
        [3] = "Kreis",        -- Kreis
        [4] = "Kreuz + Dot",  -- + mit Punkt
        [5] = "T-Shape",      -- T-Form (kein oberer Strich)
        [6] = "X-Form",       -- diagonales X
    }

    local function newCrosshairLine(color)
        local l = Drawing.new("Line")
        l.Thickness = 2
        l.Color     = color or Color3.fromRGB(255, 255, 255)
        l.Visible   = false
        return l
    end

    local function newCrosshairCircle(color)
        local c = Drawing.new("Circle")
        c.Thickness  = 1.5
        c.Color      = color or Color3.fromRGB(255, 255, 255)
        c.Filled     = false
        c.NumSides   = 64
        c.Visible    = false
        return c
    end

    local function newCrosshairDot(color)
        local c = Drawing.new("Circle")
        c.Thickness = 0
        c.Color     = color or Color3.fromRGB(255, 255, 255)
        c.Filled    = true
        c.NumSides  = 32
        c.Radius    = 3
        c.Visible   = false
        return c
    end

    local function buildCrosshairDrawings()
        return {
            -- Outlines ZUERST erstellen (werden dahinter gerendert)
            LineUp_O    = newCrosshairLine(Color3.fromRGB(0,0,0)),
            LineDown_O  = newCrosshairLine(Color3.fromRGB(0,0,0)),
            LineLeft_O  = newCrosshairLine(Color3.fromRGB(0,0,0)),
            LineRight_O = newCrosshairLine(Color3.fromRGB(0,0,0)),
            DiagTL_O = newCrosshairLine(Color3.fromRGB(0,0,0)),
            DiagTR_O = newCrosshairLine(Color3.fromRGB(0,0,0)),
            DiagBL_O = newCrosshairLine(Color3.fromRGB(0,0,0)),
            DiagBR_O = newCrosshairLine(Color3.fromRGB(0,0,0)),
            Dot_O    = newCrosshairDot(Color3.fromRGB(0,0,0)),
            Circle_O = newCrosshairCircle(Color3.fromRGB(0,0,0)),
            -- Farbige Linien DANACH (rendern davor)
            LineUp    = newCrosshairLine(),
            LineDown  = newCrosshairLine(),
            LineLeft  = newCrosshairLine(),
            LineRight = newCrosshairLine(),
            DiagTL = newCrosshairLine(),
            DiagTR = newCrosshairLine(),
            DiagBL = newCrosshairLine(),
            DiagBR = newCrosshairLine(),
            Dot    = newCrosshairDot(),
            Circle = newCrosshairCircle(),
        }
    end

    CrosshairDrawings = buildCrosshairDrawings()

    local function hideAllCrosshair()
        CrosshairDrawings.LineUp.Visible    = false
        CrosshairDrawings.LineDown.Visible  = false
        CrosshairDrawings.LineLeft.Visible  = false
        CrosshairDrawings.LineRight.Visible = false
        CrosshairDrawings.LineUp_O.Visible    = false
        CrosshairDrawings.LineDown_O.Visible  = false
        CrosshairDrawings.LineLeft_O.Visible  = false
        CrosshairDrawings.LineRight_O.Visible = false
        CrosshairDrawings.DiagTL.Visible = false
        CrosshairDrawings.DiagTR.Visible = false
        CrosshairDrawings.DiagBL.Visible = false
        CrosshairDrawings.DiagBR.Visible = false
        CrosshairDrawings.DiagTL_O.Visible = false
        CrosshairDrawings.DiagTR_O.Visible = false
        CrosshairDrawings.DiagBL_O.Visible = false
        CrosshairDrawings.DiagBR_O.Visible = false
        CrosshairDrawings.Dot.Visible   = false
        CrosshairDrawings.Dot_O.Visible = false
        CrosshairDrawings.Circle.Visible   = false
        CrosshairDrawings.Circle_O.Visible = false
    end

    local function setLineWithOutline(main, outline, from, to, color, thickness)
        main.From      = from
        main.To        = to
        main.Color     = color
        main.Thickness = thickness
        main.Visible   = true

        outline.From      = from
        outline.To        = to
        outline.Thickness = thickness + 2
        outline.Visible   = true
    end

    local function renderCrosshair()
        if not SwitchFunctions["ESP_CROSSHAIR_ENABLE"] then
            hideAllCrosshair()
            return
        end

        local typ       = SelectionFunctions["ESP_CROSSHAIR_ENABLE"] or 1
        local size      = DragFunctions["ESP_CROSSHAIR_SIZE"]      or 20
        local thickness = DragFunctions["ESP_CROSSHAIR_THICKNESS"] or 2
        local gap       = DragFunctions["ESP_CROSSHAIR_GAP"]       or 8

        -- Farbe sicher auslesen
        local color = Color3.fromRGB(255, 255, 255)
        local hexColor = ColorFunctions["ESP_CROSSHAIR_ENABLE"]
        if type(hexColor) == "string" and #hexColor >= 6 then
            local r = tonumber(hexColor:sub(1,2), 16)
            local g = tonumber(hexColor:sub(3,4), 16)
            local b = tonumber(hexColor:sub(5,6), 16)
            if r and g and b then
                color = Color3.fromRGB(r, g, b)
            end
        end

        -- Exakte Bildschirmmitte
        local vp = Camera.ViewportSize
        local cx = math.floor(vp.X / 2)
        local cy = math.floor(vp.Y / 2)
        local center = Vector2.new(cx, cy)

        hideAllCrosshair()

        -- Outlines IMMER zuerst zeichnen (damit sie hinter der Farbe liegen)
        if typ == 1 or typ == 4 then
            setLineWithOutline(CrosshairDrawings.LineUp,    CrosshairDrawings.LineUp_O,
                Vector2.new(cx, cy - gap - size), Vector2.new(cx, cy - gap), color, thickness)
            setLineWithOutline(CrosshairDrawings.LineDown,  CrosshairDrawings.LineDown_O,
                Vector2.new(cx, cy + gap),        Vector2.new(cx, cy + gap + size), color, thickness)
            setLineWithOutline(CrosshairDrawings.LineLeft,  CrosshairDrawings.LineLeft_O,
                Vector2.new(cx - gap - size, cy), Vector2.new(cx - gap, cy), color, thickness)
            setLineWithOutline(CrosshairDrawings.LineRight, CrosshairDrawings.LineRight_O,
                Vector2.new(cx + gap, cy),        Vector2.new(cx + gap + size, cy), color, thickness)
        end

        if typ == 4 or typ == 2 then
            CrosshairDrawings.Dot_O.Position = center
            CrosshairDrawings.Dot_O.Radius   = math.max(1, thickness + 2)
            CrosshairDrawings.Dot_O.Visible  = true
            CrosshairDrawings.Dot.Position   = center
            CrosshairDrawings.Dot.Radius     = math.max(1, thickness)
            CrosshairDrawings.Dot.Color      = color
            CrosshairDrawings.Dot.Visible    = true
        end

        if typ == 3 then
            local radius = math.max(2, gap + size * 0.6)
            CrosshairDrawings.Circle_O.Position  = center
            CrosshairDrawings.Circle_O.Radius    = radius
            CrosshairDrawings.Circle_O.Thickness = thickness + 2
            CrosshairDrawings.Circle_O.Visible   = true
            CrosshairDrawings.Circle.Position    = center
            CrosshairDrawings.Circle.Radius      = radius
            CrosshairDrawings.Circle.Color       = color
            CrosshairDrawings.Circle.Thickness   = thickness
            CrosshairDrawings.Circle.Visible     = true
        end

        if typ == 5 then
            setLineWithOutline(CrosshairDrawings.LineDown,  CrosshairDrawings.LineDown_O,
                Vector2.new(cx, cy + gap),        Vector2.new(cx, cy + gap + size), color, thickness)
            setLineWithOutline(CrosshairDrawings.LineLeft,  CrosshairDrawings.LineLeft_O,
                Vector2.new(cx - gap - size, cy), Vector2.new(cx - gap, cy), color, thickness)
            setLineWithOutline(CrosshairDrawings.LineRight, CrosshairDrawings.LineRight_O,
                Vector2.new(cx + gap, cy),        Vector2.new(cx + gap + size, cy), color, thickness)
        end

        if typ == 6 then
            local d45 = (gap + size) * 0.707
            local g45 = gap * 0.707
            setLineWithOutline(CrosshairDrawings.DiagTL, CrosshairDrawings.DiagTL_O,
                Vector2.new(cx - g45, cy - g45), Vector2.new(cx - d45, cy - d45), color, thickness)
            setLineWithOutline(CrosshairDrawings.DiagTR, CrosshairDrawings.DiagTR_O,
                Vector2.new(cx + g45, cy - g45), Vector2.new(cx + d45, cy - d45), color, thickness)
            setLineWithOutline(CrosshairDrawings.DiagBL, CrosshairDrawings.DiagBL_O,
                Vector2.new(cx - g45, cy + g45), Vector2.new(cx - d45, cy + d45), color, thickness)
            setLineWithOutline(CrosshairDrawings.DiagBR, CrosshairDrawings.DiagBR_O,
                Vector2.new(cx + g45, cy + g45), Vector2.new(cx + d45, cy + d45), color, thickness)
        end
    end

    RunService.RenderStepped:Connect(function()
        -- cfg nur alle 0.1s neu einlesen (Switch-Werte ändern sich selten)
        local now = tick()
        if (now - _lastCfgUpdate) > 0.1 then
            _lastCfgUpdate = now
            _cfg = {
                Enabled      = SwitchFunctions["ESP_GLOBAL_ENABLE"],
                Skeleton     = SwitchFunctions["ESP_SKELETON_ENABLE"],
                Boxes        = SwitchFunctions["ESP_BOX_ENABLE"],
                CornerBox    = SwitchFunctions["ESP_CORNER_BOX_ENABLE"],
                Box3D        = SwitchFunctions["ESP_3D_BOX_ENABLE"],
                BoxFill      = SwitchFunctions["ESP_BOX_FILL_ENABLE"],
                BoxFillTrans = (DragFunctions["ESP_BOX_FILL_TRANSPARENCY"] or 60) / 100,
                Names        = SwitchFunctions["ESP_NAMES_ENABLE"],
                Distance     = SwitchFunctions["ESP_DISTANCE_ENABLE"],
                HealthBar    = SwitchFunctions["ESP_HEALTH_BAR_ENABLE"],
                HealthColor  = SwitchFunctions["ESP_HEALTH_COLOR_ENABLE"],
                Tracers      = SwitchFunctions["ESP_TRACER_ENABLE"],
                SelfSkeleton = SwitchFunctions["ESP_SELF_ENABLE"],
                TeamCheck    = SwitchFunctions["ESP_TEAM_CHECK_ENABLE"],
                Arrow        = SwitchFunctions["ESP_ARROW_INDICATOR_ENABLE"],
                VisibleCheck = SwitchFunctions["ESP_VISIBLE_CHECK_ENABLE"],
                MaxDistance  = DragFunctions["ESP_MAX_DISTANCE"] or 500,
                HeadCircle = SwitchFunctions["ESP_HEAD_CIRCLE_ENABLE"],
                TracerPosition = SelectionFunctions["ESP_TRACER_ENABLE"] == 2 and "oben" or "unten",
                VoiceChat  = SwitchFunctions["ESP_VOICECHAT_ENABLE"],
                DeviceShow = SwitchFunctions["ESP_DEVICE_ENABLE"],
            }
            if not _cfg.BoxFill then _box3DFillWarned = false end
        end
    
        if not _cfg.Enabled then
            for _, d in pairs(PlayerDrawings) do hideAll(d) end
            return
        end
    
        -- Veraltete Drawing-Keys bereinigen
        for key, d in pairs(PlayerDrawings) do
            if key ~= "__self__" then
                local stillExists = false
                for _, p in ipairs(Players:GetPlayers()) do
                    if p == key then stillExists = true break end
                end
                if not stillExists then hideAll(d) end
            end
        end
    
        -- 3D Lines erst lazy erstellen wenn wirklich gebraucht
        if _cfg.Box3D then
            for _, d in pairs(PlayerDrawings) do ensure3DLines(d) end
        end
    
        if _cfg.SelfSkeleton then
            local selfD = getOrCreate("__self__")
            renderPlayer(LocalPlayer, selfD, true, _cfg)
        elseif PlayerDrawings["__self__"] then
            hideAll(PlayerDrawings["__self__"])
        end
    
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if _cfg.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                if PlayerDrawings[player] then hideAll(PlayerDrawings[player]) end
                continue
            end
            local d = getOrCreate(player)
            renderPlayer(player, d, false, _cfg)
        end
        renderCrosshair()
    end)

    local function cleanupDrawings(player)
        local d = PlayerDrawings[player]
        if not d then return end
        for _, v in pairs(d) do pcall(function() v.Visible = false; v:Remove() end) end
        PlayerDrawings[player] = nil
    end

    Players.PlayerRemoving:Connect(function(player)
        cleanupDrawings(player)
        local leavingChar = GetCharacter(player)
        if leavingChar then _cornerCache[leavingChar] = nil end
        _visCache[player] = nil
    end)

    Players.PlayerAdded:Connect(function(player)
        player.CharacterRemoving:Connect(function()
            local d = PlayerDrawings[player]
            if d then hideAll(d) end
        end)
    end)
end)

ProtectedExecute("WATERMARK", "", function()
    -- Watermark Logic
    local PLAYERFPS  = 0
    local FpsText    = ""
    local PingText   = ""

    RunService.RenderStepped:Connect(function(dt)
        PLAYERFPS = math.round(1 / dt)
    end)

    task.spawn(function()
        while true do
            if SwitchFunctions["SHOW_FPS"] == true then
                Gui.INFO_FPS_LABEL.Text = "FPS: " .. PLAYERFPS
                Gui.INFO_FPS_LABEL.Visible = true
            else
                Gui.INFO_FPS_LABEL.Visible = false
            end

            if SwitchFunctions["SHOW_PING"] == true then
                Gui.INFO_PING_LABEL.Text = "Ping: " .. math.round(Players.LocalPlayer:GetNetworkPing() * 1000) .. "ms"
                Gui.INFO_PING_LABEL.Visible = true
            else
                Gui.INFO_PING_LABEL.Visible = false
            end
            task.wait(0.05)
        end
    end)
end)


-- ══════════════════
-- ══ Aimbot Logik ══
-- ══════════════════

ProtectedExecute("AIMBOT", "", function()
    local AimbotFOVCircle = Drawing.new("Circle")
    AimbotFOVCircle.Thickness = 1.5
    AimbotFOVCircle.Filled    = false
    AimbotFOVCircle.Color     = Color3.fromRGB(255, 255, 255)
    AimbotFOVCircle.Visible   = false
    AimbotFOVCircle.NumSides  = 64

    local aimbotAiming = false
    local _currentLockedTarget = nil
    local _lockExpireTime = 0
    local _reEvaluateTimer = 0

    -- PRIORITY MODES (no weapon-specific logic)
    local PRIORITY_MODES = {
        [1] = "CLOSEST_TO_CROSSHAIR",   -- Lowest distance to mouse (original behavior)
        [2] = "CLOSEST_DISTANCE_3D",    -- Nearest player in world space
        [3] = "LOWEST_HEALTH",          -- Target with minimum health percentage
        [4] = "CYCLIC",                 -- Cycle through targets every 1.2 seconds
        [5] = "LOCK_FIRST",             -- Lock first target until dead (old problematic behavior)
    }

    -- Default priority mode (1 = Closest to crosshair)
    if not SelectionFunctions["AIMBOT_PRIORITY_MODE"] then
        SelectionFunctions["AIMBOT_PRIORITY_MODE"] = 1
    end

    -- Cyclic mode variables
    local _cyclicLastSwitch = 0
    local _cyclicTargetIndex = 0
    local _cyclicTargetList = {}
    local CYCLIC_SWITCH_INTERVAL = 1.2  -- seconds

    -- Lock duration for non-lock modes (re-evaluate every 0.5 seconds)
    local RE_EVALUATE_INTERVAL = 0.5

    -- ── Prediction Cache ──
    local _predCache = {}  -- [player] = { lastPos, lastTime, velocity }

    local function getPredictedPos(player, head)
        if not head then return nil end

        local now     = tick()
        local current = head.Position
        local cached  = _predCache[player]

        local predicted
        if cached and (now - cached.lastTime) < 0.2 then
            local velocity = (current - cached.lastPos) / (now - cached.lastTime)
            local ping     = LocalPlayer:GetNetworkPing()
            local lookahead = 0.05 + ping * 0.5
            predicted = current + velocity * lookahead
        else
            predicted = current
        end

        _predCache[player] = { lastPos = current, lastTime = now }
        return predicted
    end

    -- Cache leeren wenn Spieler geht
    Players.PlayerRemoving:Connect(function(player)
        _predCache[player] = nil
        if _currentLockedTarget == player then _currentLockedTarget = nil end
    end)

    -- Mouse button handling
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            aimbotAiming = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            aimbotAiming = false
            _currentLockedTarget = nil  -- Reset lock when releasing RMB
        end
    end)

    -- Visibility check
    local function aimbot_isVisible(head)
        if not head then return false end
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local myChar = GetCharacter(LocalPlayer)
        rayParams.FilterDescendantsInstances = { myChar }
        local origin    = Camera.CFrame.Position
        local direction = head.Position - origin
        local result    = workspace:Raycast(origin, direction, rayParams)
        return result == nil or result.Instance:IsDescendantOf(head.Parent)
    end

    -- Get health percentage
    local function getHealthPercent(player)
        local char = GetCharacter(player)
        if not char then return 1 end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return 0 end
        return math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
    end

    -- Get all valid targets with their data
    local function getValidTargets(fovRadius, maxDist, doVisCheck)
        local targets = {}
        local mousePos = UserInputService:GetMouseLocation()
        local cameraPos = Camera.CFrame.Position
        local now = tick()
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end

            -- Team check
            if SwitchFunctions["AIMBOT_TEAM_CHECK_ENABLE"]
                and player.Team and LocalPlayer.Team
                and player.Team == LocalPlayer.Team then
                continue
            end

            -- Health check (skip dead players)
            if SwitchFunctions["AIMBOT_HEALTH_CHECK_ENABLE"] then
                local hp = getHealthPercent(player)
                if hp <= 0 then continue end
            end

            -- Friend check
            if SwitchFunctions["AIMBOT_FRIEND_CHECK_ENABLE"] then
                if FriendList[player.Name] then continue end
            end

            local char = GetCharacter(player)
            if not char then continue end
            local head = char:FindFirstChild("Head")
            if not head then continue end

            -- Get aim position (with or without prediction)
            local usePred = SwitchFunctions["AIMBOT_PREDICTION_ENABLE"]
            local aimPos = usePred and getPredictedPos(player, head) or head.Position

            -- 3D distance check
            local dist3D = (aimPos - cameraPos).Magnitude
            if dist3D > maxDist then continue end

            -- Screen position and FOV check
            local screenPos, onScreen = Camera:WorldToViewportPoint(aimPos)
            if not onScreen then continue end

            local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist2D > fovRadius then continue end

            -- Visibility check
            if doVisCheck and not aimbot_isVisible(head) then
                continue
            end

            -- Store target data
            table.insert(targets, {
                player = player,
                head = head,
                aimPos = aimPos,
                dist2D = dist2D,
                dist3D = dist3D,
                healthPct = getHealthPercent(player),
            })
        end
        
        return targets
    end

    -- Sort targets based on priority mode (no weapon logic)
    local function sortTargetsByPriority(targets, mode)
        if #targets <= 1 then return targets end
        
        local sorted = {}
        for _, t in ipairs(targets) do table.insert(sorted, t) end
        
        if mode == 1 then -- CLOSEST_TO_CROSSHAIR
            table.sort(sorted, function(a, b) return a.dist2D < b.dist2D end)
            
        elseif mode == 2 then -- CLOSEST_DISTANCE_3D
            table.sort(sorted, function(a, b) return a.dist3D < b.dist3D end)
            
        elseif mode == 3 then -- LOWEST_HEALTH
            table.sort(sorted, function(a, b) return a.healthPct < b.healthPct end)
            
        elseif mode == 4 then -- CYCLIC (no sorting, handled separately)
            return targets
            
        elseif mode == 5 then -- LOCK_FIRST (keep current locked target first if exists)
            if _currentLockedTarget then
                for i, t in ipairs(sorted) do
                    if t.player == _currentLockedTarget then
                        table.insert(sorted, 1, table.remove(sorted, i))
                        break
                    end
                end
            end
        end
        
        return sorted
    end

    -- Get best target using priority system
    local function getBestTarget(fovRadius, maxDist, doVisCheck)
        local mode = SelectionFunctions["AIMBOT_PRIORITY_MODE"] or 1
        local now = tick()
        
        -- Get all valid targets
        local targets = getValidTargets(fovRadius, maxDist, doVisCheck)
        if #targets == 0 then
            _currentLockedTarget = nil
            return nil
        end
        
        -- MODE 5: LOCK_FIRST (old behavior - lock until dead)
        if mode == 5 then
            if _currentLockedTarget then
                -- Check if locked target is still valid
                for _, t in ipairs(targets) do
                    if t.player == _currentLockedTarget then
                        return t
                    end
                end
                -- Target lost (dead or out of range), clear lock
                _currentLockedTarget = nil
            end
            -- No locked target, pick best and lock it
            local sorted = sortTargetsByPriority(targets, 1)  -- Use closest to crosshair for initial lock
            if #sorted > 0 then
                _currentLockedTarget = sorted[1].player
                return sorted[1]
            end
            return nil
        end
        
        -- MODE 4: CYCLIC - rotate through all valid targets
        if mode == 4 then
            if (now - _cyclicLastSwitch) >= CYCLIC_SWITCH_INTERVAL then
                _cyclicLastSwitch = now
                _cyclicTargetList = targets  -- Refresh target list
                if #_cyclicTargetList > 0 then
                    _cyclicTargetIndex = (_cyclicTargetIndex % #_cyclicTargetList) + 1
                end
            end
            if _cyclicTargetList and #_cyclicTargetList >= _cyclicTargetIndex and _cyclicTargetIndex > 0 then
                return _cyclicTargetList[_cyclicTargetIndex]
            end
            return targets[1]
        end
        
        -- MODES 1, 2, 3: Re-evaluate every RE_EVALUATE_INTERVAL seconds
        if _currentLockedTarget and (now - _reEvaluateTimer) < RE_EVALUATE_INTERVAL then
            -- Check if locked target still exists in current targets
            for _, t in ipairs(targets) do
                if t.player == _currentLockedTarget then
                    return t
                end
            end
            -- Locked target lost, fall through to re-evaluate
        end
        
        -- Re-evaluate best target
        _reEvaluateTimer = now
        local sorted = sortTargetsByPriority(targets, mode)
        if #sorted > 0 then
            _currentLockedTarget = sorted[1].player
            return sorted[1]
        end
        
        return nil
    end

    -- Legacy compatibility function (kept for any external calls)
    local function aimbot_getTarget(fovRadius, maxDist, doVisCheck)
        local best = getBestTarget(fovRadius, maxDist, doVisCheck)
        if best then
            return { head = best.head, player = best.player, aimPos = best.aimPos }
        end
        return nil
    end

    -- Main RenderStepped loop
    RunService.RenderStepped:Connect(function()
        local enabled      = SwitchFunctions["AIMBOT_ENABLE"] == true
        local showFOV      = SwitchFunctions["AIMBOT_FOV_ENABLE"]
        local fovRadius    = DragFunctions["AIMBOT_FOV"]       or 200
        local smoothness   = DragFunctions["AIMBOT_SMOOTHNES"] or 68
        local VisibleCheck = SwitchFunctions["AIMBOT_VISIBLE_CHECK_ENABLE"]
        local usePred      = SwitchFunctions["AIMBOT_PREDICTION_ENABLE"]

        -- Draw FOV circle
        if showFOV and enabled then
            local mousePos = UserInputService:GetMouseLocation()
            AimbotFOVCircle.Position = mousePos
            AimbotFOVCircle.Radius   = fovRadius
            AimbotFOVCircle.Visible  = true
            
            -- Color the FOV circle based on priority mode
            local mode = SelectionFunctions["AIMBOT_PRIORITY_MODE"] or 1
            local modeColors = {
                [1] = Color3.fromRGB(255, 255, 255),  -- White: closest to crosshair
                [2] = Color3.fromRGB(255, 255, 255),  -- Light blue: closest distance
                [3] = Color3.fromRGB(255, 255, 255),  -- Red: lowest health
                [4] = Color3.fromRGB(255, 255, 255),  -- Green: cyclic
                [5] = Color3.fromRGB(255, 255, 255),  -- Purple: lock first
            }
            AimbotFOVCircle.Color = modeColors[mode] or Color3.fromRGB(255, 255, 255)
        else
            AimbotFOVCircle.Visible = false
        end

        if not enabled then return end
        if not aimbotAiming then
            -- Reset lock when not aiming
            _currentLockedTarget = nil
            return
        end

        -- Update prediction cache every frame
        if usePred then
            for _, player in ipairs(Players:GetPlayers()) do
                if player == LocalPlayer then continue end
                local char = GetCharacter(player)
                local head = char and char:FindFirstChild("Head")
                if head then getPredictedPos(player, head) end
            end
        end

        -- Get best target using priority system
        local result = getBestTarget(fovRadius, 1000, VisibleCheck)
        if not result then return end

        -- Apply prediction if enabled
        local finalAimPos
        if usePred then
            finalAimPos = getPredictedPos(result.player, result.head)
        else
            finalAimPos = result.head.Position
        end

        local targetScreenPos = Camera:WorldToViewportPoint(finalAimPos)
        local mousePos        = UserInputService:GetMouseLocation()

        local dx = targetScreenPos.X - mousePos.X
        local dy = targetScreenPos.Y - mousePos.Y

        -- Fix 1: Nahe Ziele verursachen riesige Pixel-Sprünge auf dem Bildschirm. 
        -- Sie brauchen MEHR Smoothness (weichere Korrektur), nicht weniger!
        local dynamicSmoothness = smoothness
        if result.dist3D and result.dist3D < 50 then
            -- Wir erhöhen die Smoothness bei nahen Zielen, um das "Ausbrechen" zu verhindern
            dynamicSmoothness = math.min(smoothness * 1.5, 200) 
        elseif result.dist3D and result.dist3D > 200 then
            -- Bei weiten Zielen können wir aggressiver sein
            dynamicSmoothness = math.max(smoothness * 0.7, 5)
        end
        
        local alpha = math.clamp(1 - (dynamicSmoothness / 200), 0.005, 1)
        
        -- Fix 2: Der "Sensitivity Dampener". 
        -- Da mousemoverel() die Ingame-Kamera oft viel weiter dreht, als rohe Pixel es vermuten lassen,
        -- dämpfen wir das finale Ergebnis global ab. Wenn es immer noch zittert, setze den Wert auf 0.3 oder 0.2.
        local sensitivityDampener = 0.4 
        
        mousemoverel(dx * alpha * sensitivityDampener, dy * alpha * sensitivityDampener)
    end)
end)


-- ══════════════════════
-- ══ Triggerbot Logic ══
-- ══════════════════════

ProtectedExecute("TRIGGERBOT", "", function()
    (function()
    local lastShot      = 0
    local isCoolingDown = false

    local VALID_TARGET_PARTS = {
        Head = true,
        UpperTorso = true,
        LowerTorso = true,
        Torso = true,
        ["Left Arm"]  = true,
        ["Right Arm"] = true,
        ["Left Leg"]  = true,
        ["Right Leg"] = true,
        LeftUpperArm  = true,
        RightUpperArm = true,
        LeftLowerArm  = true,
        RightLowerArm = true,
        LeftHand      = true,
        RightHand     = true,
        LeftUpperLeg  = true,
        RightUpperLeg = true,
        LeftLowerLeg  = true,
        RightLowerLeg = true,
        LeftFoot      = true,
        RightFoot     = true,
    }

    -- ══ Char-Parts Cache (pro Spieler) ══
    local charPartsCache     = {} -- [player] = { parts={}, time=0 }
    local CHAR_CACHE_INTERVAL = 1.5

    local function triggerbot_getIgnoredCharParts(player, char)
        local now = tick()
        local entry = charPartsCache[player]
        if entry and (now - entry.time) < CHAR_CACHE_INTERVAL then
            return entry.parts
        end
        local ignored = {}
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                if not VALID_TARGET_PARTS[part.Name]
                or part.Transparency >= 0.9
                or not part.CanCollide then
                    ignored[#ignored + 1] = part
                end
            end
        end
        charPartsCache[player] = { parts = ignored, time = now }
        return ignored
    end

    -- Cache leeren wenn Spieler geht
    Players.PlayerRemoving:Connect(function(p)
        charPartsCache[p] = nil
    end)

    -- ══ Workspace Cache ══
    local cachedWorldExclude = {}
    local lastWorldCacheTime = 0
    local WORLD_CACHE_INTERVAL = 3

    local function triggerbot_getWorldExclude()
        local now = tick()
        if (now - lastWorldCacheTime) >= WORLD_CACHE_INTERVAL then
            local t = {}
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if obj.Transparency >= 0.9 or not obj.CanCollide then
                        t[#t + 1] = obj
                    end
                end
            end
            cachedWorldExclude = t
            lastWorldCacheTime = now
        end
        return cachedWorldExclude
    end

    -- ══ Raycast Params Cache (pro Ziel-Char) ══
    local rayParamsCache     = {} -- [player] = { rp=RaycastParams, time=0 }
    local RAY_CACHE_INTERVAL = 1.5

    local function triggerbot_getRayParams(player, char)
        local myChar = GetCharacter(player)
        local now    = tick()
        local entry  = rayParamsCache[player]
        if entry and (now - entry.time) < RAY_CACHE_INTERVAL then
            return entry.rp
        end

        local excluded = {}
        if myChar then excluded[#excluded + 1] = myChar end

        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character
            if c and c ~= char then
                excluded[#excluded + 1] = c
            end
        end

        for _, part in ipairs(triggerbot_getIgnoredCharParts(player, char)) do
            excluded[#excluded + 1] = part
        end

        for _, part in ipairs(triggerbot_getWorldExclude()) do
            excluded[#excluded + 1] = part
        end

        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = excluded

        rayParamsCache[player] = { rp = rp, time = now }
        return rp
    end

    Players.PlayerRemoving:Connect(function(p)
        charPartsCache[p] = nil
        rayParamsCache[p] = nil
    end)

    local function triggerbot_isVisible(player, char)
        local myChar = GetCharacter(player)
        local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return false end

        local head = char:FindFirstChild("Head")
        if not head then return false end

        local origin = myHRP.Position + Vector3.new(0, 0, 0)
        local rp     = triggerbot_getRayParams(player, char)
        local dir    = head.Position - origin
        local result = workspace:Raycast(origin, dir, rp)

        return result ~= nil and result.Instance:IsDescendantOf(char)
    end

    local function triggerbot_isAlive(char)
        if not char then return false end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if not char:FindFirstChild("HumanoidRootPart") then return false end
        if not char:FindFirstChild("Head") then return false end
        return true
    end

    local function triggerbot_isKeybindActive()
        if not SwitchFunctions["TRIGGERBOT_KEYBIND"] then return true end
        local index = SelectionFunctions["TRIGGERBOT_KEYBIND"] or 1
        if index == 1 then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        elseif index == 2 then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        elseif index == 3 then
            return UserInputService:IsKeyDown(Enum.KeyCode.E)
        elseif index == 4 then
            return UserInputService:IsKeyDown(Enum.KeyCode.F)
        end
        return true
    end

    local isBursting = false

    local function triggerbot_fire()
        if isBursting then return end

        local burstEnabled = SwitchFunctions["TRIGGERBOT_BURST_ENABLE"]

        if not burstEnabled then
            mouse1click()
            lastShot      = tick()
            isCoolingDown = false
            return
        end

        -- Burst Mode
        isBursting    = true
        isCoolingDown = true
        local count   = math.floor(DragFunctions["TRIGGERBOT_BURST_COUNT"] or 3)
        local delay   = (DragFunctions["TRIGGERBOT_BURST_DELAY"] or 150) / 1000

        task.spawn(function()
            for i = 1, count do
                mouse1click()
                task.wait(0.015) -- minimale Pause zwischen Einzelschüssen
            end
            lastShot      = tick()
            isCoolingDown = false
            task.wait(delay)
            isBursting = false
        end)
    end

    RunService.Heartbeat:Connect(function()
        if not SwitchFunctions["TRIGGERBOT_ENABLE"] then return end
        if isCoolingDown then return end
        if not triggerbot_isKeybindActive() then return end

        local delay    = (DragFunctions["TRIGGERBOT_DELAY"]    or 0) / 1000
        local interval = (DragFunctions["TRIGGERBOT_INTERVAL"] or 50) / 1000
        local visOnly  = SwitchFunctions["TRIGGERBOT_VISIBLE_ONLY"]
        local teamChk  = SwitchFunctions["TRIGGERBOT_TEAM_CHECK"]

        local now = tick()
        if (now - lastShot) < interval then return end

        local mousePos = UserInputService:GetMouseLocation()

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end

            if teamChk and player.Team and LocalPlayer.Team
            and player.Team == LocalPlayer.Team then continue end

            local char = GetCharacter(player)
            if not triggerbot_isAlive(char) then continue end

            local head = char:FindFirstChild("Head")
            if not head then continue end

            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if not onScreen then continue end

            local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist2D > 15 then continue end

            if visOnly and not triggerbot_isVisible(player, char) then continue end

            isCoolingDown = true

            if delay <= 0 then
                triggerbot_fire()
            else
                task.delay(delay, triggerbot_fire)
            end

            break
        end
    end)
    end)() -- Ende Triggerbot IIFE
end)

-- ═════════════════
-- ══ Player Mods ══
ProtectedExecute("PLAYER_MODS", "", function()
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end

        local EnableWalkSpeed    = SwitchFunctions["MOVEMENT_ENABLE_WALKSPEED"]
        local EnableJumpPower    = SwitchFunctions["MOVEMENT_ENABLE_JUMPPOWER"]
        local EnableInfiniteJump = SwitchFunctions["MOVEMENT_ENABLE_INFINITE_JUMP"]
        local WalkSpeed          = (DragFunctions["MOVEMENT_ENABLE_WALKSPEED_VALUE"] or 16)
        local JumpPower          = (DragFunctions["MOVEMENT_ENABLE_JUMPPOWER_VALUE"] or 50)


        if EnableWalkSpeed then
            hum.WalkSpeed = WalkSpeed
        else
            hum.WalkSpeed = 16
        end

        if EnableJumpPower then
            hum.UseJumpPower = true
            hum.JumpPower = JumpPower
        else
            hum.UseJumpPower = false
            hum.JumpPower = 50
        end

        if EnableInfiniteJump and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)


-- ════════════════════════
-- ══  Hitbox Expander   ══
-- ════════════════════════
ProtectedExecute("HITBOX", "", function()
    (function()

    -- ════════════════════════════════
    -- ══  Hitbox Button Handlers     ══
    -- ════════════════════════════════

    local function hitbox_setSize(newSize)
        newSize = math.clamp(newSize, 1, 999)
        DragFunctions["HITBOX_SIZE"] = newSize

        for _, tab in ipairs(Gui.MAIN_CONTENT_FRAME:GetChildren()) do
            if tab:IsA("Frame") then
                for _, sub in ipairs(tab:GetChildren()) do
                    if sub:IsA("ScrollingFrame") then
                        for _, el in ipairs(sub:GetChildren()) do
                            local fnVal = el:FindFirstChild("FUNCTION_NAME")
                            if fnVal and fnVal.Value == "HITBOX_SIZE" then
                                local lbl = el:FindFirstChild("PercentLabel")
                                if lbl then lbl.Text = tostring(newSize) end
                                local dragBg = el:FindFirstChild("DragBackground")
                                if dragBg then
                                    for _, child in ipairs(dragBg:GetChildren()) do
                                        if child:IsA("Frame") and child:FindFirstChildWhichIsA("UIDragDetector") then
                                            local normalized = math.clamp(newSize / 50, 0, 1)
                                            local halfWidth  = child.Size.X.Scale / 2
                                            child.Position   = UDim2.new(
                                                halfWidth + normalized * (1 - 2 * halfWidth),
                                                0, 0.5, 0
                                            )
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local function hitbox_setTroll(enabled)
        SwitchFunctions["HITBOX_TROLL"] = enabled
        local cbs = SwitchUICallbacks["HITBOX_TROLL"]
        if cbs then
            for _, cb in ipairs(cbs) do pcall(cb, enabled) end
        end
    end

    FunctionsSettings["BTN_HITBOX_CUSTOM_SIZE"] = FunctionsSettings["BTN_HITBOX_CUSTOM_SIZE"] or {}
    FunctionsSettings["BTN_HITBOX_CUSTOM_SIZE"].OnExecute = function(inputText)
        local value = tonumber(inputText)
        if not value then
            SendNotify("Ungültige Eingabe! Bitte eine Zahl eingeben.")
            return
        end
        value = math.floor(value)
        if value < 1 then
            SendNotify("Wert muss mindestens 1 sein!")
            return
        end

        if value > 50 then
            local neededMultiplier = math.ceil(value / 50)
            neededMultiplier = math.clamp(neededMultiplier, 1, 20)
            hitbox_setSize(50)
            DragFunctions["HITBOX_TROLL_MULTIPLIER"] = neededMultiplier
            hitbox_setTroll(true)
            SendNotify("Custom: " .. tostring(value) .. " → Troll aktiv (x" .. neededMultiplier .. ")")
        else
            hitbox_setTroll(false)
            hitbox_setSize(value)
            SendNotify("Hitbox Größe auf " .. tostring(value) .. " gesetzt.")
        end
    end

    FunctionsSettings["BTN_HITBOX_RESET"] = FunctionsSettings["BTN_HITBOX_RESET"] or {}
    FunctionsSettings["BTN_HITBOX_RESET"].OnExecute = function()
        hitbox_setTroll(false)
        hitbox_setSize(5)
        DragFunctions["HITBOX_TROLL_MULTIPLIER"] = 2
        DragFunctions["HITBOX_TRANSPARENCY"]     = 100
        SwitchFunctions["HITBOX_ENABLE"]         = false
        local cbs = SwitchUICallbacks["HITBOX_ENABLE"]
        if cbs then for _, cb in ipairs(cbs) do pcall(cb, false) end end
        SendNotify("Hitbox Expander zurückgesetzt.")
    end

    FunctionsSettings["BTN_HITBOX_FULL"] = FunctionsSettings["BTN_HITBOX_FULL"] or {}
    FunctionsSettings["BTN_HITBOX_FULL"].OnExecute = function()
        hitbox_setSize(50)
        DragFunctions["HITBOX_TROLL_MULTIPLIER"] = 20
        SendNotify("Full Size: 50 × 20 = 1000 (Troll Max)")
    end


    local HitboxOriginals  = {}
    local HitboxHighlights = {}

    local HITBOX_PART_MAP = {
        [1] = {"Head"},
        [2] = {"HumanoidRootPart"},
    }

    local function hitbox_getTargetNames()
        local index = SelectionFunctions["HITBOX_ENABLE"] or 1
        return HITBOX_PART_MAP[index] or HITBOX_PART_MAP[1]
    end

    local function hitbox_getTargetParts(char)
        local names  = hitbox_getTargetNames()
        local result = {}
        for _, name in ipairs(names) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                table.insert(result, part)
            end
        end
        return result
    end

    local function hitbox_partIsSelected(part)
        local names = hitbox_getTargetNames()
        for _, name in ipairs(names) do
            if part.Name == name then return true end
        end
        return false
    end

    local function hitbox_restorePart(part)
        local orig = HitboxOriginals[part]
        if orig and part and part.Parent then
            part.Size         = orig.size
            part.Transparency = orig.transparency
            part.CanCollide   = orig.canCollide
            part.Massless     = orig.massless  -- NEU
        end
        HitboxOriginals[part] = nil
    end

    local function hitbox_restoreAll()
        for part, orig in pairs(HitboxOriginals) do
            if part and part.Parent then
                part.Size         = orig.size
                part.Transparency = orig.transparency
                part.CanCollide   = orig.canCollide
                part.Massless     = orig.massless  -- NEU
            end
        end
        HitboxOriginals = {}
    end

    local function hitbox_removeHighlight(player)
        local h = HitboxHighlights[player]
        if h then
            pcall(function() h:Destroy() end)
            HitboxHighlights[player] = nil
        end
    end

    local function hitbox_removeAllHighlights()
        for player in pairs(HitboxHighlights) do
            hitbox_removeHighlight(player)
        end
    end

    local function hitbox_applyHighlight(player, char)
        if not SwitchFunctions["HITBOX_HIGHLIGHT"] then
            hitbox_removeHighlight(player)
            return
        end

        local hex = ColorFunctions["HITBOX_HIGHLIGHT"]
        local fillColor = Color3.fromRGB(255, 60, 60)
        if type(hex) == "string" and #hex >= 6 then
            local r = tonumber(hex:sub(1,2), 16) or 255
            local g = tonumber(hex:sub(3,4), 16) or 255
            local b = tonumber(hex:sub(5,6), 16) or 255
            fillColor = Color3.fromRGB(r, g, b)
        end

        local existing = HitboxHighlights[player]
        if existing and existing.Parent then
            existing.FillColor    = fillColor
            existing.OutlineColor = fillColor
            return
        end

        local h = Instance.new("Highlight")
        h.Adornee             = char
        h.FillColor           = fillColor
        h.OutlineColor        = fillColor
        h.FillTransparency    = 0.5
        h.OutlineTransparency = 0
        h.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent              = char
        HitboxHighlights[player] = h
    end

    local _lastHitboxSel = 0

    RunService.Heartbeat:Connect(function()
        local enabled    = SwitchFunctions["HITBOX_ENABLE"]
        local troll      = SwitchFunctions["HITBOX_TROLL"]
        local baseSize   = DragFunctions["HITBOX_SIZE"]             or 5
        local multiplier = DragFunctions["HITBOX_TROLL_MULTIPLIER"] or 2
        local size       = troll and (baseSize * multiplier) or baseSize
        local transPct   = DragFunctions["HITBOX_TRANSPARENCY"] or 100
        local trans      = math.clamp(transPct / 100, 0, 1)
        local curSel     = SelectionFunctions["HITBOX_ENABLE"] or 1

        if curSel ~= _lastHitboxSel then
            hitbox_restoreAll()
            _lastHitboxSel = curSel
        end

        if not enabled then
            hitbox_restoreAll()
            hitbox_removeAllHighlights()
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end

            local char = GetCharacter(player)
            if not char then continue end

            for part, _ in pairs(HitboxOriginals) do
                if part and part.Parent and part:IsDescendantOf(char) then
                    if not hitbox_partIsSelected(part) then
                        hitbox_restorePart(part)
                    end
                end
            end

            local parts = hitbox_getTargetParts(char)
            for _, part in ipairs(parts) do
                if not HitboxOriginals[part] then
                    HitboxOriginals[part] = {
                        size         = part.Size,
                        transparency = part.Transparency,
                        canCollide   = part.CanCollide,
                        massless     = part.Massless,  -- NEU
                    }
                end
                part.Size         = Vector3.new(size, size, size)
                part.Transparency = trans
                part.CanCollide   = false
                part.Massless     = true  -- NEU: verhindert Physik-Blockade beim Head
            end

            hitbox_applyHighlight(player, char)
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        local char = GetCharacter(player)
        if char then
            for part, _ in pairs(HitboxOriginals) do
                if part and part.Parent and part:IsDescendantOf(char) then
                    hitbox_restorePart(part)
                end
            end
        end
        hitbox_removeHighlight(player)
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        if not Gui.MAIN_FRAME.Visible then
            mouseOverrideActive = false
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)

    end)()
end)



-- ══════════════
-- ══  Desync  ══
-- ══════════════

ProtectedExecute("DESYNC", "", function()
    (function()

    local DV = {
        originalWalkSpeed = 16,
        originalJumpPower = 50,

        CAM_DISTANCE = 10,
        CAM_MIN = 3,
        CAM_MAX = 25,
        CAM_HEIGHT = 2,

        camYaw = 0,
        camPitch = math.rad(-15),
        charYaw = 0,
        rmb = false,

        velocityY = 0,
        isGrounded = false,

        freezeAlpha = 0,
        freezing = false,
        unfreezing = false,
        frozenVelSnap = Vector3.zero,

        serverCharHighlight         = nil,  -- Highlight-Part + Box für Show Server Char (legacy, unused)
        serverCharClone             = nil,  -- Echter Charakter-Clone für Show Server Char
        hideCharParts               = {},   -- Gespeicherte Original-Transparenzwerte für Hide Server Char
        hiddenOriginalFrozenCFrame  = nil,  -- Gespeichertes frozenCFrame vor dem Under-Map-Teleport
    }

    -- ══════════════════════════════════════════════
    -- ══  Hide Server Char (Under-Map-Teleport)    ══
    -- ══════════════════════════════════════════════
    -- Teleportiert frozenCFrame unter die Map (Y = -10000).
    -- PreSimulation hält Root permanent an frozenCFrame → der Original-Char
    -- liegt für den Server unsichtbar tief unter der Map.
    -- Lokal siehst du dich weiterhin an localCFrame normal.
    local function applyHideServerChar()
        if not frozenCFrame then return end
        -- Nur anwenden wenn noch nicht aktiv
        if DV.hiddenOriginalFrozenCFrame then return end
        DV.hiddenOriginalFrozenCFrame = frozenCFrame
        -- Unter die Map teleportieren (PreSimulation sorgt dafür dass Root dort bleibt)
        frozenCFrame = CFrame.new(
            frozenCFrame.Position.X,
            -500,
            frozenCFrame.Position.Z
        )
        if Root then
            Root.CFrame = frozenCFrame
            Root.AssemblyLinearVelocity  = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
        end
    end

    local function removeHideServerChar()
        if DV.hiddenOriginalFrozenCFrame then
            -- frozenCFrame auf aktuelle lokale Position zurücksetzen
            frozenCFrame = localCFrame
                and CFrame.new(localCFrame.Position)
                or DV.hiddenOriginalFrozenCFrame
            DV.hiddenOriginalFrozenCFrame = nil
        end
        DV.hideCharParts = {}
    end


    local function updateServerCharHighlight()
        -- Aufräumen wenn Feature aus oder kein frozenCFrame
        if not SwitchFunctions["DESYNC_SHOW_SERVER_CHAR"] or not frozenCFrame then
            if DV.serverCharClone then
                DV.serverCharClone:Destroy()
                DV.serverCharClone = nil
            end
            return
        end

        -- Clone erstellen (einmalig)
        if not DV.serverCharClone then
            if not Character or not Character.Parent then return end
            local ok, clone = pcall(function()
                local wasArchivable = Character.Archivable
                Character.Archivable = true
                local c = Character:Clone()
                Character.Archivable = wasArchivable
                return c
            end)
            if not ok or not clone then return end
            clone.Name = "LynxServerCharClone"

            -- Animate-Script im Clone deaktivieren damit er nicht stört
            local animScript = clone:FindFirstChild("Animate")
            if animScript then animScript.Enabled = false end

            -- Alle Scripts/LocalScripts entfernen
            local scriptsToRemove = {}
            for _, obj in ipairs(clone:GetDescendants()) do
                local s, isScript = pcall(function() return obj:IsA("Script") or obj:IsA("LocalScript") end)
                if s and isScript then
                    table.insert(scriptsToRemove, obj)
                end
            end
            for _, s in ipairs(scriptsToRemove) do pcall(function() s:Destroy() end) end


            -- Humanoid deaktivieren und dann zerstören damit er CanCollide nicht zurücksetzt
            -- (UpperTorso/LowerTorso werden sonst vom Humanoid immer wieder auf CanCollide = true gesetzt)
            local cloneHumanoid = clone:FindFirstChildOfClass("Humanoid")
            if cloneHumanoid then
                cloneHumanoid.AutoRotate = false
                cloneHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
                cloneHumanoid.PlatformStand = true
                cloneHumanoid:Destroy()  -- Komplett entfernen damit CanCollide nicht mehr zurückgesetzt wird
            end

            -- Alle BaseParts: Kollision aus, halb-transparent
            for _, obj in ipairs(clone:GetDescendants()) do
                local s, isBP = pcall(function() return obj:IsA("BasePart") end)
                if s and isBP then
                    pcall(function()
                        obj.Anchored = true
                        obj.CanCollide = false
                        obj.CanQuery = false
                        obj.CastShadow = false
                        obj.Transparency = 0.5
                    end)
                end
            end

            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(80, 80, 95)
            hl.OutlineColor = Color3.fromRGB(120, 120, 135)
            hl.OutlineTransparency = 0
            hl.FillTransparency = 0.4
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Adornee = clone
            hl.Parent = clone

            -- HumanoidRootPart unsichtbar (aber als Anker behalten)
            local hrp = clone:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Transparency = 1
            end

            clone.Parent = workspace
            DV.serverCharClone = clone
        end

        -- Clone jeden Frame an frozenCFrame halten
        if not DV.serverCharClone or not DV.serverCharClone.Parent then
            DV.serverCharClone = nil
            return
        end

        local cloneRoot = DV.serverCharClone:FindFirstChild("HumanoidRootPart")
        if cloneRoot then
            -- Wenn Hide Server Char aktiv ist, liegt frozenCFrame unter der Map –
            -- der Clone soll trotzdem an der echten eingefrorenen Position bleiben
            local targetCF = DV.hiddenOriginalFrozenCFrame or frozenCFrame
            DV.serverCharClone:SetPrimaryPartCFrame(targetCF)
        end
    end

    local function playAnim(name)
        if not anims then return end
        if currentAnim == name then return end

        for k, track in pairs(anims) do
            if k ~= name then
                track:Stop(0.15)
            end
        end

        anims[name]:Play(0.15)
        currentAnim = name
    end

    local function checkGround()
        if not Root or not localCFrame then
            return false, nil
        end

        local rayOrigin = localCFrame.Position
        local rayLength = (DV.velocityY > 0) and 0.5 or 3.2
        local rayDir = Vector3.new(0, -rayLength, 0)

        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {Character}
        params.FilterType = Enum.RaycastFilterType.Exclude

        local result = workspace:Raycast(rayOrigin, rayDir, params)

        return result ~= nil, result
    end

    local function resolveWalls(pos)
        if not Character then
            return pos
        end

        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {Character}
        params.FilterType = Enum.RaycastFilterType.Exclude

        local directions = {
            Vector3.new(1,0,0),
            Vector3.new(-1,0,0),
            Vector3.new(0,0,1),
            Vector3.new(0,0,-1),
        }

        for _, dir in ipairs(directions) do
            local result = workspace:Raycast(pos, dir * 1.2, params)

            if result then
                pos = pos - dir * (1.2 - result.Distance)
            end
        end

        return pos
    end

    local function syncCameraFromCurrent()
        local cf = Camera.CFrame
        local look = cf.LookVector

        DV.camYaw = math.atan2(-look.X, -look.Z)
        DV.camPitch = math.asin(math.clamp(look.Y, -1, 1))

        if Root then
            local dist = (cf.Position - (Root.Position + Vector3.new(0, DV.CAM_HEIGHT, 0))).Magnitude
            DV.CAM_DISTANCE = math.clamp(dist, DV.CAM_MIN, DV.CAM_MAX)
        end

        DV.charYaw = DV.camYaw
    end

    local function enableDesync()
        if not Root or not Humanoid then return end

        syncCameraFromCurrent()

        -- Sicherstellen dass Root.CFrame wirklich aktuell ist
        local currentCF = Root.CFrame
        frozenCFrame = nil
        localCFrame = nil

        Root.CFrame = currentCF

        frozenCFrame = currentCF
        localCFrame = CFrame.new(currentCF.Position)

        DV.velocityY = 0
        DV.isGrounded = false
        DV.freezeAlpha = 0
        DV.freezing = true
        DV.unfreezing = false
        DV.frozenVelSnap = Vector3.zero  -- Velocity ignorieren, sauber starten

        AnimateScript.Enabled = false
        task.wait(0.05)
        playAnim("idle")

        -- Eigenen Char lokal verstecken (nur wenn Switch aktiv)
        if SwitchFunctions["DESYNC_HIDE_SERVER_CHAR"] then
            task.defer(function()
                updateServerCharHighlight()
                applyHideServerChar()
            end)
        end
    end

    local function disableDesync()
        if not Root or not Humanoid then
            return
        end

        DV.unfreezing = true
        DV.freezing = false

        -- Highlight entfernen falls aktiv
        if DV.serverCharHighlight then
            DV.serverCharHighlight.box:Destroy()
            DV.serverCharHighlight.part:Destroy()
            DV.serverCharHighlight = nil
        end

        -- Clone entfernen falls aktiv
        if DV.serverCharClone then
            DV.serverCharClone:Destroy()
            DV.serverCharClone = nil
        end

        -- Eigene Char-Transparenz wiederherstellen
        removeHideServerChar()

        -- Fallback: alle Parts direkt zurücksetzen falls hideCharParts veraltet war
        if Character then
            for _, obj in ipairs(Character:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.LocalTransparencyModifier = 0
                end
            end
        end

        for _, track in pairs(anims) do
            track:Stop(0.2)
        end

        currentAnim = nil

        AnimateScript.Enabled = true

        task.delay(0.15, function()
            if not SwitchFunctions.DESYNC_ENABLE and Humanoid then
                Humanoid.WalkSpeed = DV.originalWalkSpeed
                Humanoid.JumpPower = DV.originalJumpPower
            end
        end)

        -- Teleport Root zu localCFrame damit der Charakter dort landet wo der Spieler war
        if localCFrame then
            Root.CFrame = localCFrame
            task.wait()
        end
        localCFrame = nil
        frozenCFrame = nil

        task.spawn(function()
            task.wait()
            Camera.CameraType = Enum.CameraType.Custom
        end)
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end

    local function loadCharacter(char)
        Character = char
        Root = char:WaitForChild("HumanoidRootPart")
        Humanoid = char:WaitForChild("Humanoid")
        AnimateScript = char:WaitForChild("Animate")

        DV.originalWalkSpeed = Humanoid.WalkSpeed
        DV.originalJumpPower = Humanoid.JumpPower

        task.wait(0.1)

        local idleAnim = Instance.new("Animation")
        idleAnim.AnimationId = AnimateScript.idle.Animation1.AnimationId

        local walkAnim = Instance.new("Animation")
        walkAnim.AnimationId = AnimateScript.run.RunAnim.AnimationId

        local jumpAnim = Instance.new("Animation")
        jumpAnim.AnimationId = AnimateScript.jump.JumpAnim.AnimationId

        local fallAnim = Instance.new("Animation")
        fallAnim.AnimationId = AnimateScript.fall.FallAnim.AnimationId

        anims = {
            idle = Humanoid:LoadAnimation(idleAnim),
            walk = Humanoid:LoadAnimation(walkAnim),
            jump = Humanoid:LoadAnimation(jumpAnim),
            fall = Humanoid:LoadAnimation(fallAnim),
        }

        anims.idle.Priority = Enum.AnimationPriority.Action
        anims.walk.Priority = Enum.AnimationPriority.Action
        anims.jump.Priority = Enum.AnimationPriority.Action
        anims.fall.Priority = Enum.AnimationPriority.Action

        currentAnim = nil
        DV.hideCharParts = {}  -- Cache leeren bei neuem Char
        if SwitchFunctions.DESYNC_ENABLE and SwitchFunctions["DESYNC_HIDE_SERVER_CHAR"] then
            task.defer(applyHideServerChar)  -- nach vollständigem Laden
        end
    end

    loadCharacter(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
    LocalPlayer.CharacterAdded:Connect(loadCharacter)

    local DESYNC_NOTIFY = nil

    task.spawn(function()
        local lastState = false
        local lastHideState = false
        local lastShowState = false

        while true do
            task.wait()

            if SwitchFunctions.DESYNC_ENABLE ~= lastState then
                lastState = SwitchFunctions.DESYNC_ENABLE

                if lastState then
                    enableDesync()
                    DESYNC_NOTIFY = SendPersistentNotify("Desync aktiv")
                else
                    disableDesync()
                    DESYNC_NOTIFY:Dismiss()
                end
            end

            -- Hide Server Char reaktiv: auch während aktivem Desync ein-/ausschaltbar
            if SwitchFunctions.DESYNC_ENABLE then
                local hideNow = SwitchFunctions["DESYNC_HIDE_SERVER_CHAR"]
                if hideNow ~= lastHideState then
                    lastHideState = hideNow
                    if hideNow then
                        applyHideServerChar()
                    else
                        removeHideServerChar()
                    end
                end

                -- Show Server Char reaktiv: Clone erstellen/zerstören wenn Switch umgeschaltet wird
                local showNow = SwitchFunctions["DESYNC_SHOW_SERVER_CHAR"]
                if showNow ~= lastShowState then
                    lastShowState = showNow
                    updateServerCharHighlight()
                end
            else
                lastHideState = false
                lastShowState = false
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            DV.rmb = true

            if SwitchFunctions.DESYNC_ENABLE then
                UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
            end

            return
        end

        if input.KeyCode == Enum.KeyCode.Space
        and SwitchFunctions.DESYNC_ENABLE
        and DV.isGrounded then

            DV.velocityY = math.sqrt(2 * workspace.Gravity * 5.5)
            DV.isGrounded = false

            playAnim("jump")
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            DV.rmb = false
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            DV.CAM_DISTANCE = math.clamp(
                DV.CAM_DISTANCE - input.Position.Z * 1.5,
                DV.CAM_MIN,
                DV.CAM_MAX
            )
        end

        if not SwitchFunctions.DESYNC_ENABLE then
            return
        end

        if not DV.rmb then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        local sens = UserInputService.MouseDeltaSensitivity * 0.4

        DV.camYaw = DV.camYaw - math.rad(input.Delta.X * sens)

        DV.camPitch = math.clamp(
            DV.camPitch - math.rad(input.Delta.Y * sens),
            math.rad(-80),
            math.rad(20)
        )
    end)

    RunService.PreSimulation:Connect(function(dt)
        if not Root or not Root.Parent then return end  -- Root.Parent check dazu!

        if not SwitchFunctions.DESYNC_ENABLE and not DV.unfreezing then
            return
        end

        if not frozenCFrame then return end

        if DV.freezing then
            DV.freezeAlpha = math.min(DV.freezeAlpha + dt * 10, 1)

            Humanoid.WalkSpeed = DV.originalWalkSpeed * (1 - DV.freezeAlpha)
            Humanoid.JumpPower = 0

            Root.AssemblyLinearVelocity = DV.frozenVelSnap * (1 - DV.freezeAlpha)
            Root.AssemblyAngularVelocity = Vector3.zero
            Root.CFrame = frozenCFrame  -- Root bleibt an frozenCFrame

            if DV.freezeAlpha >= 1 then
                DV.freezing = false
                Humanoid.WalkSpeed = 0
            end

        elseif SwitchFunctions.DESYNC_ENABLE then
            -- Server/andere sehen frozenCFrame (oder unter Map wenn Hide aktiv), PreRender setzt danach visuell um
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            Root.CFrame = frozenCFrame
            updateServerCharHighlight()

        elseif DV.unfreezing then
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero

            DV.unfreezing = false
        end
    end)

    RunService.PreRender:Connect(function(dt)
        if not Root or not Root.Parent then return end
        if not SwitchFunctions.DESYNC_ENABLE or not localCFrame then return end

        local flatLook = Vector3.new(
            math.sin(DV.camYaw) * -1,
            0,
            math.cos(DV.camYaw) * -1
        ).Unit

        local flatRight = Vector3.new(
            math.cos(DV.camYaw),
            0,
            math.sin(DV.camYaw) * -1
        ).Unit

        local dir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            dir += flatLook
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            dir -= flatLook
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            dir -= flatRight
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            dir += flatRight
        end

        -- Noclip: Gravität und Groundcheck überspringen wenn aktiv
        if SwitchFunctions.DESYNC_NOCLIP_ENABLE then
            DV.isGrounded = false
            DV.velocityY = 0
        else
            local grounded, groundResult = checkGround()

            if grounded and DV.velocityY <= 0 then
                DV.isGrounded = true

                local groundY = groundResult.Position.Y + 3
                local currentY = localCFrame.Position.Y

                if math.abs(currentY - groundY) < 2 then
                    local newY = currentY + (groundY - currentY) * math.min(dt * 25, 1)

                    localCFrame = CFrame.new(Vector3.new(
                        localCFrame.Position.X,
                        newY,
                        localCFrame.Position.Z
                    ))

                    DV.velocityY = 0
                else
                    DV.isGrounded = false

                    DV.velocityY = DV.velocityY - workspace.Gravity * dt
                    DV.velocityY = math.max(DV.velocityY, -50)
                end
            else
                DV.isGrounded = false

                DV.velocityY = DV.velocityY - workspace.Gravity * dt
                DV.velocityY = math.max(DV.velocityY, -50)
            end
        end

        local move = Vector3.zero

        if dir.Magnitude > 0 then
            move = dir.Unit * DV.originalWalkSpeed * dt
        end

        -- Noclip: kein vertikaler Versatz durch Gravity, Space/Ctrl für hoch/runter
        if SwitchFunctions.DESYNC_NOCLIP_ENABLE then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                move += Vector3.new(0, DV.originalWalkSpeed * dt, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                move -= Vector3.new(0, DV.originalWalkSpeed * dt, 0)
            end
        else
            move += Vector3.new(0, DV.velocityY * dt, 0)
        end

        local newPos = localCFrame.Position + move

        -- Noclip aktiv: Wandkollision überspringen, sonst normal resolven
        local resolvedPos = (SwitchFunctions.DESYNC_NOCLIP_ENABLE) and newPos or resolveWalls(newPos)

        localCFrame = CFrame.new(resolvedPos)

        -- Animationen
        if not DV.isGrounded and not SwitchFunctions.DESYNC_NOCLIP_ENABLE then
            if DV.velocityY > 1 then
                playAnim("jump")
            else
                playAnim("fall")
            end

        elseif dir.Magnitude > 0 then
            playAnim("walk")
            anims.walk:AdjustSpeed(DV.originalWalkSpeed / 16)
        else
            playAnim("idle")
        end

        if dir.Magnitude > 0 then
            local flatDir = Vector3.new(dir.X, 0, dir.Z)
            local targetYaw = math.atan2(-flatDir.X, -flatDir.Z)
            local diff = ((targetYaw - DV.charYaw + math.pi) % (math.pi * 2)) - math.pi
            DV.charYaw = DV.charYaw + diff * math.min(dt * 18, 1)
        end

        -- Visuell für dich: Root an localCFrame (nur du siehst das, nach Replication)
        Root.CFrame = CFrame.new(localCFrame.Position) * CFrame.Angles(0, DV.charYaw, 0)

        -- Show Server Char: Highlight aktuell halten
        updateServerCharHighlight()

        -- Kamera folgt localCFrame
        -- Kamera folgt immer localCFrame (dein fiktiver Char), nie dem Server-Clone
        local camRot =
            CFrame.Angles(0, DV.camYaw, 0)
            * CFrame.Angles(DV.camPitch, 0, 0)

        local camTarget = localCFrame.Position + Vector3.new(0, DV.CAM_HEIGHT, 0)
        local camPos = camTarget - camRot.LookVector * DV.CAM_DISTANCE

        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CFrame = CFrame.new(camPos, camTarget)

        -- Visuell: Root bleibt an localCFrame für dich sichtbar
        oot.CFrame = CFrame.new(localCFrame.Position) * CFrame.Angles(0, DV.charYaw, 0)
    end)

    end)()
end)


ProtectedExecute("FLY", "", function()
    (function()
    -- ══════════════════════════════════════
    --  FLY SYSTEM – CAMERA-RELATIVE 3D FLY
    --  WASD moves along camera vectors
    --  (full 3D, no horizontal flattening)
    -- ══════════════════════════════════════

    local FlyConnection = nil
    local FlyBodyVelocity = nil
    local FlyBodyGyro = nil
    local FlyActive = false
    local FlyKeys = {}
    local FlyInputBeganCon = nil
    local FlyInputEndedCon = nil
    local FlyTrailAttachment = nil
    local FlyTrailParticle = nil
    local FlyAntiKickConnection = nil

    -- TRAIL
    local function createTrail(char)
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        if FlyTrailAttachment then FlyTrailAttachment:Destroy(); FlyTrailAttachment = nil end
        if FlyTrailParticle then FlyTrailParticle:Destroy(); FlyTrailParticle = nil end
        
        FlyTrailAttachment = Instance.new("Attachment")
        FlyTrailAttachment.Parent = hrp
        
        FlyTrailParticle = Instance.new("ParticleEmitter")
        FlyTrailParticle.Parent = hrp
        FlyTrailParticle.Texture = "rbxassetid://15945429943"
        FlyTrailParticle.Rate = 100
        FlyTrailParticle.Lifetime = NumberRange.new(0.3, 0.6)
        FlyTrailParticle.Speed = NumberRange.new(0, 0)
        FlyTrailParticle.SpreadAngle = Vector2.new(360, 360)
        FlyTrailParticle.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.8, 0),
            NumberSequenceKeypoint.new(1, 0, 0)
        })
        FlyTrailParticle.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.4, 0),
            NumberSequenceKeypoint.new(1, 1, 0)
        })
        FlyTrailParticle.Color = ColorSequence.new(Color3.fromRGB(255, 100, 100))
        FlyTrailParticle.LockedToPart = false
        FlyTrailParticle.ZOffset = 0
        FlyTrailParticle.Enabled = true
    end

    local function removeTrail()
        if FlyTrailAttachment then FlyTrailAttachment:Destroy(); FlyTrailAttachment = nil end
        if FlyTrailParticle then FlyTrailParticle:Destroy(); FlyTrailParticle = nil end
    end

    local function stopFly()
        FlyActive = false
        
        if FlyInputBeganCon then FlyInputBeganCon:Disconnect(); FlyInputBeganCon = nil end
        if FlyInputEndedCon then FlyInputEndedCon:Disconnect(); FlyInputEndedCon = nil end
        if FlyBodyVelocity then FlyBodyVelocity:Destroy(); FlyBodyVelocity = nil end
        if FlyBodyGyro then FlyBodyGyro:Destroy(); FlyBodyGyro = nil end
        if FlyConnection then FlyConnection:Disconnect(); FlyConnection = nil end
        if FlyAntiKickConnection then FlyAntiKickConnection:Disconnect(); FlyAntiKickConnection = nil end
        
        removeTrail()
        
        local char = GetCharacter(LocalPlayer)
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            end
            if SwitchFunctions["FLY_NOCLIP"] then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
        
        FlyKeys = { W = false, A = false, S = false, D = false, Space = false, LeftControl = false }
    end

    local function antiKickPatch(char)
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
        humanoid.PlatformStand = true
        
        if FlyBodyVelocity then FlyBodyVelocity.Name = "Velocity" end
        if FlyBodyGyro then FlyBodyGyro.Name = "Gyro" end
    end

    -- CAMERA-RELATIVE 3D MOVEMENT (NOT FLATTENED TO HORIZONTAL)
    local function getMoveDirection(heldKeys, cameraLook, cameraRight)
        -- cameraLook = full 3D camera LookVector
        -- cameraRight = full 3D camera RightVector
        -- cameraUp = cameraRight:Cross(cameraLook) (implicitly world up via Space/LeftControl)
        local moveDir = Vector3.zero
        
        if heldKeys.W then moveDir += cameraLook end          -- forward = where you look
        if heldKeys.S then moveDir -= cameraLook end          -- backward = opposite of look
        if heldKeys.D then moveDir += cameraRight end         -- right = camera right
        if heldKeys.A then moveDir -= cameraRight end         -- left = opposite camera right
        if heldKeys.Space then moveDir += Vector3.new(0, 1, 0) end       -- world up
        if heldKeys.LeftControl then moveDir -= Vector3.new(0, 1, 0) end -- world down
        
        return moveDir
    end

    local function startFly()
        if FlyActive then return end
        
        local char = GetCharacter(LocalPlayer)
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        
        FlyKeys = { W = false, A = false, S = false, D = false, Space = false, LeftControl = false }
        FlyActive = true
        
        humanoid.PlatformStand = true
        
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.P = 10000
        FlyBodyVelocity.Name = "Velocity"
        FlyBodyVelocity.Parent = hrp
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        FlyBodyGyro.P = 20000
        FlyBodyGyro.D = 500
        FlyBodyGyro.CFrame = hrp.CFrame
        FlyBodyGyro.Name = "Gyro"
        FlyBodyGyro.Parent = hrp
        
        if SwitchFunctions["FLY_ANTI_KICK"] then
            antiKickPatch(char)
        end
        
        if SwitchFunctions["FLY_TRAIL"] then
            createTrail(char)
        end
        
        if SwitchFunctions["FLY_NOCLIP"] then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        local UIS = game:GetService("UserInputService")
        local camera = workspace.CurrentCamera
        
        -- CAPTURE CURRENTLY PRESSED KEYS SO DIRECTION IS IMMEDIATE ON ACTIVATION
        local currentlyPressedKeys = UIS:GetKeysPressed()
        local tempKeys = { W = false, A = false, S = false, D = false, Space = false, LeftControl = false }
        for _, key in ipairs(currentlyPressedKeys) do
            if key.KeyCode == Enum.KeyCode.W then tempKeys.W = true
            elseif key.KeyCode == Enum.KeyCode.A then tempKeys.A = true
            elseif key.KeyCode == Enum.KeyCode.S then tempKeys.S = true
            elseif key.KeyCode == Enum.KeyCode.D then tempKeys.D = true
            elseif key.KeyCode == Enum.KeyCode.Space then tempKeys.Space = true
            elseif key.KeyCode == Enum.KeyCode.LeftControl then tempKeys.LeftControl = true
            end
        end
        FlyKeys = tempKeys
        
        FlyInputBeganCon = UIS.InputBegan:Connect(function(input, gameProcessed)
            if not FlyActive then return end
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            
            local key = input.KeyCode
            if key == Enum.KeyCode.W then FlyKeys.W = true
            elseif key == Enum.KeyCode.A then FlyKeys.A = true
            elseif key == Enum.KeyCode.S then FlyKeys.S = true
            elseif key == Enum.KeyCode.D then FlyKeys.D = true
            elseif key == Enum.KeyCode.Space then FlyKeys.Space = true
            elseif key == Enum.KeyCode.LeftControl then FlyKeys.LeftControl = true
            end
        end)
        
        FlyInputEndedCon = UIS.InputEnded:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            
            local key = input.KeyCode
            if key == Enum.KeyCode.W then FlyKeys.W = false
            elseif key == Enum.KeyCode.A then FlyKeys.A = false
            elseif key == Enum.KeyCode.S then FlyKeys.S = false
            elseif key == Enum.KeyCode.D then FlyKeys.D = false
            elseif key == Enum.KeyCode.Space then FlyKeys.Space = false
            elseif key == Enum.KeyCode.LeftControl then FlyKeys.LeftControl = false
            end
        end)
        
        FlyConnection = RunService.RenderStepped:Connect(function()
            if not FlyActive then return end
            
            local currentChar = GetCharacter(LocalPlayer)
            if not currentChar then stopFly(); return end
            
            local currentHRP = currentChar:FindFirstChild("HumanoidRootPart")
            local currentHum = currentChar:FindFirstChildOfClass("Humanoid")
            if not currentHRP or not currentHum then stopFly(); return end
            
            if SwitchFunctions["FLY_ANTI_KICK"] then
                if not currentHum.PlatformStand then
                    currentHum.PlatformStand = true
                end
                currentHum:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            else
                if not currentHum.PlatformStand then
                    currentHum.PlatformStand = true
                end
            end
            
            if FlyBodyVelocity and FlyBodyVelocity.Parent ~= currentHRP then
                FlyBodyVelocity.Parent = currentHRP
                FlyBodyVelocity.Name = "Velocity"
            end
            if FlyBodyGyro and FlyBodyGyro.Parent ~= currentHRP then
                FlyBodyGyro.Parent = currentHRP
                FlyBodyGyro.Name = "Gyro"
            end
            
            if SwitchFunctions["FLY_NOCLIP"] then
                for _, part in ipairs(currentChar:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            
            if SwitchFunctions["FLY_ANTI_KICK"] then
                antiKickPatch(currentChar)
            end
            
            if SwitchFunctions["FLY_TRAIL"] and not FlyTrailParticle then
                createTrail(currentChar)
            end
            
            local speed = DragFunctions["FLY_SPEED"] or 50
            
            if SwitchFunctions["FLY_PRECISION_KEY"] then
                speed = speed * 0.25
            end
            
            local cameraNow = workspace.CurrentCamera
            if not cameraNow then return end
            
            local camLook = cameraNow.CFrame.LookVector
            local camRight = cameraNow.CFrame.RightVector
            
            -- FULL 3D CAMERA-RELATIVE MOVEMENT
            local moveDir = getMoveDirection(FlyKeys, camLook, camRight)
            
            if moveDir.Magnitude > 0.001 then
                FlyBodyVelocity.Velocity = moveDir.Unit * speed
            else
                FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            
            local pos = currentHRP.Position
            FlyBodyGyro.CFrame = CFrame.new(pos, pos + camLook)
        end)
    end

    local FlyToggleConnection = RunService.RenderStepped:Connect(function()
        local enabled = SwitchFunctions["FLY_ENABLE"]
        
        if enabled and not FlyActive then
            startFly()
        elseif not enabled and FlyActive then
            stopFly()
        end
        
        if FlyActive then
            if SwitchFunctions["FLY_TRAIL"] then
                if not FlyTrailParticle then
                    local char = GetCharacter(LocalPlayer)
                    if char then createTrail(char) end
                end
            else
                if FlyTrailParticle then
                    removeTrail()
                end
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        if player == LocalPlayer then stopFly() end
    end)

    end)()
end)



-- ============================================================
-- PLAYERS TAB – Logik  (funktioniert nach Build_Menu())
-- Nutzt FunctionsSettings[x] = FunctionsSettings[x] or {}
-- damit bestehende Tabellen nicht überschrieben werden.
-- ============================================================
do
    -- ── Hilfsfunktionen ──────────────────────────────────────

    local function HttpFetch(url)
        local ok, res = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if ok then return res end
        return nil
    end

    local function FormatDate(isoStr)
        if not isoStr then return "Unbekannt" end
        local y, mo, d = isoStr:match("^(%d+)-(%d+)-(%d+)")
        if y then return d .. "." .. mo .. "." .. y end
        return isoStr
    end

    local function AccountAgeDays(isoStr)
        if not isoStr then return "?" end
        local y, mo, d = isoStr:match("^(%d+)-(%d+)-(%d+)")
        if not y then return "?" end
        local function toEpoch(yr, mn, dy)
            local days = 0
            for year = 1970, yr - 1 do
                days = days + (((year%4==0 and year%100~=0) or year%400==0) and 366 or 365)
            end
            local months = {31,28,31,30,31,30,31,31,30,31,30,31}
            if ((yr%4==0 and yr%100~=0) or yr%400==0) then months[2]=29 end
            for m = 1, mn-1 do days = days + months[m] end
            return (days + dy - 1) * 86400
        end
        local diff = math.max(0, os.time() - toEpoch(tonumber(y), tonumber(mo), tonumber(d)))
        return tostring(math.floor(diff / 86400)) .. " Tage"
    end

    -- Gecachte Daten des zuletzt geladenen Spielers
    local CachedInfo = {}

    local function UpdateInfoLabels(data)
        local playersTab = Gui.MAIN_CONTENT_FRAME:FindFirstChild("PLAYERS")
        if not playersTab then return end
        local infoSub = playersTab:FindFirstChild("PLAYERS_INFO")
        if not infoSub then return end

        local labelMap = {
            BTN_INFO_DISPLAYNAME = "Anzeigename:    " .. tostring(data.displayName  or "—"),
            BTN_INFO_USERID      = "UserId:         " .. tostring(data.userId       or "—"),
            BTN_INFO_CREATED     = "Erstellt am:    " .. FormatDate(data.created),
            BTN_INFO_AGE         = "Alter:          " .. AccountAgeDays(data.created),
            BTN_INFO_DESC        = "Beschreibung:   " .. tostring(data.description ~= "" and data.description or "Keine"),
            BTN_INFO_BANNED      = "Gebannt:        " .. (data.isBanned and "Ja ⚠️" or "Nein ✓"),
            BTN_INFO_FRIENDS     = "Freunde:        " .. tostring(data.friends    or "—"),
            BTN_INFO_FOLLOWERS   = "Follower:       " .. tostring(data.followers  or "—"),
            BTN_INFO_FOLLOWING   = "Following:      " .. tostring(data.following  or "—"),
        }

        for _, item in ipairs(infoSub:GetDescendants()) do
            local fnVal = item:FindFirstChild("FUNCTION_NAME")
            if fnVal and labelMap[fnVal.Value] then
                local mainLabel = item:FindFirstChild("MainLabel")
                if mainLabel then mainLabel.Text = labelMap[fnVal.Value] end
            end
        end
    end

    local function WechselZuInfo()
        local playersTab = Gui.MAIN_CONTENT_FRAME:FindFirstChild("PLAYERS")
        if not playersTab then return end
        for _, f in ipairs(playersTab:GetChildren()) do
            if f:IsA("Frame") or f:IsA("ScrollingFrame") then
                f.Visible = (f.Name == "PLAYERS_INFO")
            end
        end
    end

    -- ── FunctionsSettings mit or{}-Pattern (sicher nach Build_Menu) ──

    FunctionsSettings["BTN_LOAD_PLAYER_INFO"] = FunctionsSettings["BTN_LOAD_PLAYER_INFO"] or {}
    FunctionsSettings["BTN_LOAD_PLAYER_INFO"].OnExecute = function()
        local selectedName = ListFunctions["SELECTED_PLAYER"]
        if not selectedName or selectedName == "" or selectedName == "Kein Spieler gefunden" then
            SendNotify("Kein Spieler ausgewählt!")
            return
        end

        local targetPlayer = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == selectedName then targetPlayer = p break end
        end

        if not targetPlayer then
            SendNotify("Spieler nicht mehr im Server!")
            return
        end

        SendNotify("Lade Infos für " .. selectedName .. "...")
        WechselZuInfo()

        task.spawn(function()
            local data = {}

            -- Basis-Info
            local userInfo = HttpFetch("https://users.roblox.com/v1/users/" .. targetPlayer.UserId)
            if userInfo and userInfo.id then
                data.displayName = userInfo.displayName or userInfo.name
                data.userId      = userInfo.id
                data.created     = userInfo.created
                data.description = userInfo.description or ""
                data.isBanned    = userInfo.isBanned or false
            else
                -- Fallback: lokale Daten
                data.displayName = targetPlayer.DisplayName
                data.userId      = targetPlayer.UserId
                data.created     = nil
                data.description = ""
                data.isBanned    = false
            end

            -- Freunde
            local friendData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/friends/count")
            data.friends = friendData and friendData.count or "—"

            -- Follower
            local followerData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/followers/count")
            data.followers = followerData and followerData.count or "—"

            -- Following
            local followingData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/followings/count")
            data.following = followingData and followingData.count or "—"

            CachedInfo = data
            UpdateInfoLabels(data)
            SendNotify("✓ Infos geladen: " .. selectedName)
        end)
    end

    -- Kopier-Callbacks mit or{}-Pattern
    local function SetCopyCallback(key, btnName, label)
        FunctionsSettings[btnName] = FunctionsSettings[btnName] or {}
        FunctionsSettings[btnName].OnExecute = function()
            local val = CachedInfo[key]
            if not val or val == "—" then
                SendNotify("Zuerst Info laden!")
                return
            end
            pcall(setclipboard, tostring(val))
            SendNotify(label .. " kopiert!")
        end
    end

    SetCopyCallback("displayName", "BTN_INFO_DISPLAYNAME", "Anzeigename")
    SetCopyCallback("userId",      "BTN_INFO_USERID",      "UserId")
    SetCopyCallback("description", "BTN_INFO_DESC",        "Beschreibung")
    SetCopyCallback("friends",     "BTN_INFO_FRIENDS",     "Freundeanzahl")
    SetCopyCallback("followers",   "BTN_INFO_FOLLOWERS",   "Followeranzahl")
    SetCopyCallback("following",   "BTN_INFO_FOLLOWING",   "Followinganzahl")

    -- Erstellungsdatum kopiert den rohen ISO-String
    FunctionsSettings["BTN_INFO_CREATED"] = FunctionsSettings["BTN_INFO_CREATED"] or {}
    FunctionsSettings["BTN_INFO_CREATED"].OnExecute = function()
        local val = CachedInfo.created
        if not val then SendNotify("Zuerst Info laden!") return end
        pcall(setclipboard, FormatDate(val))
        SendNotify("Erstellungsdatum kopiert!")
    end

    -- Account-Alter kopiert die berechneten Tage
    FunctionsSettings["BTN_INFO_AGE"] = FunctionsSettings["BTN_INFO_AGE"] or {}
    FunctionsSettings["BTN_INFO_AGE"].OnExecute = function()
        local val = CachedInfo.created
        if not val then SendNotify("Zuerst Info laden!") return end
        local age = AccountAgeDays(val)
        pcall(setclipboard, age)
        SendNotify("Account-Alter kopiert: " .. age)
    end

    -- Gebannt-Button hat keine Kopier-Funktion (nur Anzeige)
    FunctionsSettings["BTN_INFO_BANNED"] = FunctionsSettings["BTN_INFO_BANNED"] or {}
    FunctionsSettings["BTN_INFO_BANNED"].OnExecute = function() end


    FunctionsSettings["SELECTED_PLAYER"] = FunctionsSettings["SELECTED_PLAYER"] or {}
    FunctionsSettings["SELECTED_PLAYER"].OnSelect = function(selectedName)
        if not selectedName or selectedName == "" or selectedName == "Kein Spieler gefunden" then
            return
        end
        
        local targetPlayer = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == selectedName then
                targetPlayer = p
                break
            end
        end
        
        if not targetPlayer then
            return
        end
        
        -- Silently load info in background (no notification spam)
        task.spawn(function()
            local data = {}
            
            local userInfo = HttpFetch("https://users.roblox.com/v1/users/" .. targetPlayer.UserId)
            if userInfo and userInfo.id then
                data.displayName = userInfo.displayName or userInfo.name
                data.userId      = userInfo.id
                data.created     = userInfo.created
                data.description = userInfo.description or ""
                data.isBanned    = userInfo.isBanned or false
            else
                data.displayName = targetPlayer.DisplayName
                data.userId      = targetPlayer.UserId
                data.created     = nil
                data.description = ""
                data.isBanned    = false
            end
            
            local friendData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/friends/count")
            data.friends = friendData and friendData.count or "—"
            
            local followerData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/followers/count")
            data.followers = followerData and followerData.count or "—"
            
            local followingData = HttpFetch("https://friends.roblox.com/v1/users/" .. targetPlayer.UserId .. "/followings/count")
            data.following = followingData and followingData.count or "—"
            
            CachedInfo = data
            UpdateInfoLabels(data)
        end)
    end

end


ProtectedExecute("FLING_PLAYER", "", function()
    FunctionsSettings["BTN_FLING_PLAYER"] = FunctionsSettings["BTN_FLING_PLAYER"] or {}
    FunctionsSettings["BTN_FLING_PLAYER"].OnExecute = function()
        -- Check if Anti-Fling is enabled - if yes, block fling and notify
        if SwitchFunctions["ANTIFLING_ENABLE"] == true then
            SendNotify("Anti-Fling ist aktiviert! Deaktiviere Anti-Fling um Fling zu nutzen!")
            return
        end

        local selectedName = ListFunctions["SELECTED_PLAYER"]
        if not selectedName or selectedName == "" or selectedName == "Kein Spieler gefunden" then
            SendNotify("Kein Spieler ausgewählt!")
            return
        end

        local targetPlayer = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == selectedName then
                targetPlayer = p
                break
            end
        end

        if not targetPlayer then
            SendNotify("Spieler nicht mehr im Server!")
            return
        end

        local targetChar = targetPlayer.Character
        if not targetChar then
            SendNotify("Ziel-Charakter nicht gefunden!")
            return
        end

        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetHRP then
            SendNotify("Ziel hat keine HumanoidRootPart!")
            return
        end

        local myChar = LocalPlayer.Character
        if not myChar then
            SendNotify("Eigener Charakter nicht gefunden!")
            return
        end

        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then
            SendNotify("Eigene HumanoidRootPart nicht gefunden!")
            return
        end

        -- Persistent notification for fling status
        local flingNotify = SendPersistentNotify("Flinge " .. selectedName .. " ...")

        local TARGET_FLUNG_VELOCITY_THRESHOLD = 50
        local OWN_FLING_THRESHOLD = 80
        local MAX_FLING_DURATION = 3  -- seconds (identical to standalone)

        local flingRunning = true
        local startTime = tick()

        -- Anchor CFrame (identical to standalone: fixed at start)
        local anchorCF = myHRP.CFrame

        -- Death detection on OWN humanoid (identical to standalone)
        local myHumanoid = myChar:FindFirstChildOfClass("Humanoid")
        local deathConnection = nil

        if myHumanoid then
            deathConnection = myHumanoid.Died:Connect(function()
                flingRunning = false
                flingNotify:SetText("Eigener Charakter gestorben - Fling abgebrochen")
                task.wait(1.5)
                flingNotify:Dismiss()
                if deathConnection then
                    pcall(function() deathConnection:Disconnect() end)
                end
            end)
        end

        -- Fling execution coroutine (identical logic to standalone)
        task.spawn(function()
            local angle = 0

            while flingRunning and targetHRP and targetHRP.Parent and myHRP and myHRP.Parent do
                local ownVelocity    = myHRP.AssemblyLinearVelocity.Magnitude
                local targetVelocity = targetHRP.AssemblyLinearVelocity.Magnitude

                -- Target flung condition (threshold 50, identical to standalone)
                if targetVelocity > TARGET_FLUNG_VELOCITY_THRESHOLD then
                    flingRunning = false
                    -- Reset own position/velocity on success (identical to standalone)
                    myHRP.CFrame = anchorCF
                    myHRP.AssemblyLinearVelocity  = Vector3.zero
                    myHRP.AssemblyAngularVelocity = Vector3.zero
                    local duration = math.floor((tick() - startTime) * 100) / 100
                    flingNotify:SetText(selectedName .. " erfolgreich geflingt! (" .. duration .. "s)")
                    task.wait(2)
                    flingNotify:Dismiss()
                    break
                end

                -- Own fling detection → reset position (identical to standalone)
                if ownVelocity > OWN_FLING_THRESHOLD then
                    myHRP.CFrame = anchorCF
                    myHRP.AssemblyLinearVelocity  = Vector3.zero
                    myHRP.AssemblyAngularVelocity = Vector3.zero
                end

                -- Spiral fling logic (identical to standalone)
                local targetPos = targetHRP.Position
                angle = angle + 0.5

                local offset = Vector3.new(
                    math.cos(angle) * 4,
                    0,
                    math.sin(angle) * 4
                )

                myHRP.CFrame = CFrame.new(targetPos + offset)
                myHRP.AssemblyAngularVelocity = Vector3.new(10000, 10000, 10000)

                RunService.Heartbeat:Wait()
            end

            -- Cleanup on normal exit
            if not flingRunning then
                if myHRP and myHRP.Parent then
                    myHRP.AssemblyLinearVelocity  = Vector3.zero
                    myHRP.AssemblyAngularVelocity = Vector3.zero
                end
            end

            if deathConnection then
                pcall(function() deathConnection:Disconnect() end)
            end
        end)

        -- Timeout safety net (3s, identical to standalone)
        task.delay(MAX_FLING_DURATION, function()
            if flingRunning then
                flingRunning = false
                if myHRP and myHRP.Parent then
                    myHRP.AssemblyLinearVelocity  = Vector3.zero
                    myHRP.AssemblyAngularVelocity = Vector3.zero
                end
                flingNotify:SetText("Timeout - " .. selectedName .. " konnte nicht geflingt werden")
                task.wait(2)
                flingNotify:Dismiss()
            end
        end)
    end
end)

ProtectedExecute("TOGGLE_FRIEND", "", function()
    -- Hilfsfunktion: Button-Label im Players-Tab aktualisieren
    local function UpdateFriendButtonLabel(name)
        local playersTab = Gui.MAIN_CONTENT_FRAME:FindFirstChild("PLAYERS")
        if not playersTab then return end
        local listSub = playersTab:FindFirstChild("PLAYERS_LIST")
        if not listSub then return end
        for _, item in ipairs(listSub:GetDescendants()) do
            local fnVal = item:FindFirstChild("FUNCTION_NAME")
            if fnVal and fnVal.Value == "BTN_TOGGLE_FRIEND" then
                local lbl = item:FindFirstChild("MainLabel")
                if lbl then
                    if name and FriendList[name] then
                        lbl.Text = "Als Freund entfernen"
                    elseif name then
                        lbl.Text = "Als Freund hinzufügen"
                    else
                        lbl.Text = "Als Freund hinzufügen"
                    end
                end
            end
        end
    end

    FunctionsSettings["BTN_TOGGLE_FRIEND"] = FunctionsSettings["BTN_TOGGLE_FRIEND"] or {}
    FunctionsSettings["BTN_TOGGLE_FRIEND"].OnExecute = function()
        local selectedName = ListFunctions["SELECTED_PLAYER"]
        if not selectedName or selectedName == "" or selectedName == "Kein Spieler gefunden" then
            SendNotify("Kein Spieler ausgewählt!")
            return
        end

        if FriendList[selectedName] then
            FriendList[selectedName] = nil
            UpdateFriendButtonLabel(selectedName)
            SendNotify(selectedName .. " aus Freundesliste entfernt!")
        else
            FriendList[selectedName] = true
            UpdateFriendButtonLabel(selectedName)
            SendNotify(selectedName .. " zur Freundesliste hinzugefügt!")
        end
    end

    -- Button-Label aktualisieren wenn Spieler-Auswahl sich ändert
    local _lastSelected = nil
    RunService.Heartbeat:Connect(function()
        local cur = ListFunctions["SELECTED_PLAYER"]
        if cur ~= _lastSelected then
            _lastSelected = cur
            UpdateFriendButtonLabel(cur)
        end
    end)
end)

ProtectedExecute("ANTIFLING", "", function()
    local antiflingConnection = nil
    local function startIYAntiFling()
        if antiflingConnection then return end
        
        antiflingConnection = RunService.Stepped:Connect(function()
            if not SwitchFunctions["ANTIFLING_ENABLE"] then return end
            
            local myChar = Players.LocalPlayer.Character
            if not myChar then return end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    end

    local function stopIYAntiFling()
        if antiflingConnection then
            antiflingConnection:Disconnect()
            antiflingConnection = nil
        end
        
        -- Restore CanCollide for other players' parts
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
            end
        end
    end

    -- Monitor switch state
    task.spawn(function()
        while true do
            if SwitchFunctions["ANTIFLING_ENABLE"] then
                startIYAntiFling()
            else
                stopIYAntiFling()
            end
            task.wait(0.5)
        end
    end)

    -- Clean up when players leave
    Players.PlayerRemoving:Connect(function(player)
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end)
end)


-- ===================
-- == Panic Handler ==
-- ===================

local LastMenuState

ProtectedExecute("PanicMode", "", function()
    local function EnablePanic()
        -- Kopie erstellen
        PanicSwitchFunctions  = {}
        PanicKeybindFunctions = {}
        for Key, Value in pairs(SwitchFunctions) do
            PanicSwitchFunctions[Key] = Value
        end
        for Key, Value in pairs(KeybindFunctions) do
            PanicKeybindFunctions[Key] = Value
        end

        -- Originale leeren (nicht neu zuweisen!)
        for Key, _ in pairs(SwitchFunctions) do
            SwitchFunctions[Key] = false
        end
        for Key, _ in pairs(KeybindFunctions) do
            if Key ~= "PANIC_KEY" then
                KeybindFunctions[Key] = nil
            end
        end

        PanicMode = true

        LastMenuState = Gui.MAIN_FRAME.Visible  -- Fix: MAIN_FRAME statt MainFrame

        -- Alles verstecken
        Gui.MAIN_FRAME.Visible    = false
        Gui.COLOR_FRAME.Visible   = false
        Gui.WATERMARK.Visible     = false
        BackgroundBlur.Enabled    = false
        mouseOverrideActive       = false
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior    = savedMouseBehavior
        cursorCircle.Visible        = false
        cursorCircleOutline.Visible = false
    end

    local function DisablePanic()
        -- Inhalt zurück in die originalen Tables kopieren
        for Key, Value in pairs(PanicSwitchFunctions) do
            SwitchFunctions[Key] = Value
        end
        for Key, Value in pairs(PanicKeybindFunctions) do
            KeybindFunctions[Key] = Value
        end

        PanicKeybindFunctions = {}
        PanicSwitchFunctions  = {}
        PanicMode = false

        if LastMenuState == true then
            ToggleBackground(true)
        end

        Gui.WATERMARK.Visible = true
    end

    -- Panic Keybind: End-Taste (änderbar)
    UserInputService.InputBegan:Connect(function(Input, processed)
        if processed then return end
        local panicKey = KeybindFunctions["PANIC_KEY"]
        if panicKey and Input.KeyCode == panicKey then
            if PanicMode then
                DisablePanic()
            else
                EnablePanic()
            end
        end
    end)
end)


ProtectedExecute("KILL_MENU", "", function()
    FunctionsSettings["BTN_UNLOAD_MENU"] = FunctionsSettings["BTN_UNLOAD_MENU"] or {}
    FunctionsSettings["BTN_UNLOAD_MENU"].OnExecute = function()
        SendNotify("Unloading Menu...")
        wait(0.6)
        SCRIPT_KILLED = true

        -- Mouse sofort zurücksetzen
        pcall(function()
            mouseOverrideActive = false
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            cursorCircle.Visible = false
            cursorCircleOutline.Visible = false
        end)

        -- Alle Switches aus
        for Key, _ in pairs(SwitchFunctions) do
            SwitchFunctions[Key] = false
        end
        KeybindFunctions = {}

        -- GUI zerstören
        pcall(function() Gui.VexarisGui:Destroy() end)
        pcall(function() BackgroundBlur:Destroy() end)
        pcall(function() cursorCircle:Remove() end)
        pcall(function() cursorCircleOutline:Remove() end)
    end
end)


-- Ziel = ListFunctions["SELECTED_PLAYER"]

ProtectedExecute("TELEPORT_TO_PLAYER", "", function()
    FunctionsSettings["BTN_TELEPORT_TO_PLAYER"] = FunctionsSettings["BTN_TELEPORT_TO_PLAYER"] or {}
    FunctionsSettings["BTN_TELEPORT_TO_PLAYER"].OnExecute = function()

        local ZielName = ListFunctions["SELECTED_PLAYER"]
        if not ZielName or ZielName == "" then return end

        local ZielSpieler = game.Players:FindFirstChild(ZielName)
        if not ZielSpieler then return end

        local ZielChar = ZielSpieler.Character
        if not ZielChar then return end

        local ZielRoot = ZielChar:FindFirstChild("HumanoidRootPart")
        if not ZielRoot then return end

        local EigenerChar = game.Players.LocalPlayer.Character
        if not EigenerChar then return end

        local EigenerRoot = EigenerChar:FindFirstChild("HumanoidRootPart")
        if not EigenerRoot then return end

        EigenerRoot.CFrame = ZielRoot.CFrame + Vector3.new(0, 3, 0)

    end
end)

ProtectedExecute("LOOP_TELEPORT_TO_PLAYER", "", function()
    -- an/aus = SwitchFunctions["LOOP_TELEPORT_TO_PLAYER"] = true/false

    task.spawn(function()
        while true do
            task.wait(0.01)

            if not SwitchFunctions["LOOP_TELEPORT_TO_PLAYER"] then continue end

            local ZielName = ListFunctions["SELECTED_PLAYER"]
            if not ZielName or ZielName == "" then continue end

            local ZielSpieler = game.Players:FindFirstChild(ZielName)
            if not ZielSpieler then continue end

            local ZielChar = ZielSpieler.Character
            if not ZielChar then continue end

            local ZielRoot = ZielChar:FindFirstChild("HumanoidRootPart")
            if not ZielRoot then continue end

            local EigenerChar = game.Players.LocalPlayer.Character
            if not EigenerChar then continue end

            local EigenerRoot = EigenerChar:FindFirstChild("HumanoidRootPart")
            if not EigenerRoot then continue end

            EigenerRoot.CFrame = ZielRoot.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end)


-- ═══════════════════
-- ══ Fullbright    ══
-- ═══════════════════
 
ProtectedExecute("FULLBRIGHT", "", function()
 
    local Lighting = game:GetService("Lighting")
 
    -- Original-Werte speichern zum Wiederherstellen
    local OriginalValues = {
        Brightness          = Lighting.Brightness,
        Ambient             = Lighting.Ambient,
        OutdoorAmbient      = Lighting.OutdoorAmbient,
        GlobalShadows       = Lighting.GlobalShadows,
        EnvironmentDiffuseScale  = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        ExposureCompensation = Lighting.ExposureCompensation,
    }
 
    local function ApplyFullbright()
        local brightnessValue = DragFunctions["FULLBRIGHT_BRIGHTNESS"] or 100
        -- Drag geht 0-100, wir mappen das auf 0-10 für Brightness
        local mappedBrightness = (brightnessValue / 100) * 10
 
        Lighting.Brightness               = mappedBrightness
        Lighting.Ambient                  = Color3.fromRGB(178, 178, 178)
        Lighting.OutdoorAmbient           = Color3.fromRGB(178, 178, 178)
        Lighting.GlobalShadows            = false
        Lighting.EnvironmentDiffuseScale  = 1
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ExposureCompensation     = 0
 
        -- Atmosphere entfernen falls vorhanden
        local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo then atmo.Density = 0 end
 
        -- ColorCorrection auf neutral setzen
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
        if cc then
            cc.Brightness = 0
            cc.Contrast   = 0
            cc.Saturation = 0
        end
    end
 
    local function RestoreLighting()
        Lighting.Brightness               = OriginalValues.Brightness
        Lighting.Ambient                  = OriginalValues.Ambient
        Lighting.OutdoorAmbient           = OriginalValues.OutdoorAmbient
        Lighting.GlobalShadows            = OriginalValues.GlobalShadows
        Lighting.EnvironmentDiffuseScale  = OriginalValues.EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale = OriginalValues.EnvironmentSpecularScale
        Lighting.ExposureCompensation     = OriginalValues.ExposureCompensation
    end
 
    -- Switch-Callback registrieren
    FunctionsSettings["FULLBRIGHT_ENABLE"] = FunctionsSettings["FULLBRIGHT_ENABLE"] or {}
    FunctionsSettings["FULLBRIGHT_ENABLE"].OnToggle = function(state)
        if state then
            ApplyFullbright()
        else
            RestoreLighting()
        end
    end
 
    -- Loop: Brightness-Drag live updaten während Fullbright aktiv ist
    -- (damit der Slider sofort reagiert ohne Switch neu zu toggeln)
    task.spawn(function()
        local lastBrightness = DragFunctions["FULLBRIGHT_BRIGHTNESS"]
        while true do
            task.wait(0.1)
            if SCRIPT_KILLED then break end
            if SwitchFunctions["FULLBRIGHT_ENABLE"] then
                local current = DragFunctions["FULLBRIGHT_BRIGHTNESS"]
                if current ~= lastBrightness then
                    lastBrightness = current
                    ApplyFullbright()
                end
            end
        end
    end)
 
    -- Manche Spiele setzen Lighting-Werte per Script zurück
    -- Dagegen absichern mit einem sanften Loop
    task.spawn(function()
        while true do
            task.wait(2)
            if SCRIPT_KILLED then break end
            if SwitchFunctions["FULLBRIGHT_ENABLE"] then
                -- Nur neu setzen wenn ein anderes Script es verändert hat
                local mappedBrightness = ((DragFunctions["FULLBRIGHT_BRIGHTNESS"] or 100) / 100) * 10
                if math.abs(Lighting.Brightness - mappedBrightness) > 0.5
                or Lighting.GlobalShadows == true then
                    ApplyFullbright()
                end
            end
        end
    end)
 
end)
 
 
-- ═══════════════════
-- ══  No Fog       ══
-- ═══════════════════
 
ProtectedExecute("NOFOG", "", function()
 
    local Lighting = game:GetService("Lighting")
 
    -- Original-Fog-Werte speichern
    local OriginalFog = {
        FogStart = Lighting.FogStart,
        FogEnd   = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
    }
 
    local OriginalAtmosphere = {}
    local function SaveAtmosphere()
        local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo then
            OriginalAtmosphere = {
                Density     = atmo.Density,
                Offset      = atmo.Offset,
                Color       = atmo.Color,
                Decay       = atmo.Decay,
                Glare       = atmo.Glare,
                Haze        = atmo.Haze,
            }
        end
    end
    SaveAtmosphere()
 
    local function ApplyNoFog()
        -- Standard Fog-Properties entfernen
        Lighting.FogStart = 100000
        Lighting.FogEnd   = 100001
 
        -- Atmosphere-Objekt (modernere Fog-Methode) entfernen
        local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo then
            atmo.Density = 0
            atmo.Haze    = 0
            atmo.Glare   = 0
        end
    end
 
    local function RestoreFog()
        Lighting.FogStart = OriginalFog.FogStart
        Lighting.FogEnd   = OriginalFog.FogEnd
        Lighting.FogColor = OriginalFog.FogColor
 
        local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo and OriginalAtmosphere.Density ~= nil then
            atmo.Density = OriginalAtmosphere.Density
            atmo.Haze    = OriginalAtmosphere.Haze
            atmo.Glare   = OriginalAtmosphere.Glare
            atmo.Offset  = OriginalAtmosphere.Offset
        end
    end
 
    FunctionsSettings["NOFOG_ENABLE"] = FunctionsSettings["NOFOG_ENABLE"] or {}
    FunctionsSettings["NOFOG_ENABLE"].OnToggle = function(state)
        if state then
            SaveAtmosphere()
            ApplyNoFog()
        else
            RestoreFog()
        end
    end
 
    -- Schutz gegen Spiele die Fog per Script setzen
    task.spawn(function()
        while true do
            task.wait(2)
            if SCRIPT_KILLED then break end
            if SwitchFunctions["NOFOG_ENABLE"] then
                if Lighting.FogEnd < 99999 then
                    ApplyNoFog()
                end
            end
        end
    end)
 
    -- Wenn ein neues Atmosphere-Objekt gespawnt wird, sofort auf 0 setzen
    Lighting.ChildAdded:Connect(function(child)
        if child:IsA("Atmosphere") and SwitchFunctions["NOFOG_ENABLE"] then
            task.wait() -- 1 Frame warten bis es initialisiert ist
            child.Density = 0
            child.Haze    = 0
            child.Glare   = 0
        end
    end)
 
end)


--[[
if getgenv().MM2_HookInitialized then
    print("[DEBUG] Hook läuft bereits im Hintergrund und bleibt dauerhaft aktiv!")
    return
end
getgenv().MM2_HookInitialized = true

-- Der dauerhafte Metatable-Hook (überlebt jeden Reset!)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    -- Blockiert die originalen Schüsse/Messerwürfe des Spiels IMMER
    if method == "FireServer" and (self.Name == "Shoot" or self.Name == "KnifeThrown") then
        if not checkcaller() then
            return nil -- Blockiert das originale Spielskript
        end
    end
    
    return oldNamecall(self, ...)
end)

print("[DEBUG] Dauerhafter Schutz aktiv – Ignoriert Resets ab jetzt!")

ProtectedExecute("MM2_TEST", "142823291", function()
    print("HALLOOOOOO!!!!")
    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.5
    FOVCircle.Filled = false
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Visible = false
    FOVCircle.NumSides = 64

    local TracerLine = Drawing.new("Line")
    TracerLine.Thickness = 1.5
    TracerLine.Color = Color3.fromRGB(255, 0, 0)
    TracerLine.Visible = false

    local currentClosestHead = nil

    local function isVisible(head)
        if not head then return false end
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local myChar = LocalPlayer.Character
        if myChar then
            rayParams.FilterDescendantsInstances = { myChar }
        end
        local origin = Camera.CFrame.Position
        local direction = head.Position - origin
        local result = workspace:Raycast(origin, direction, rayParams)
        return result == nil or result.Instance:IsDescendantOf(head.Parent)
    end

    RunService.RenderStepped:Connect(function()
        local gunEnabled = SwitchFunctions["MM2_WEAPON_SILENT_AIM"]
        local knifeEnabled = SwitchFunctions["MM2_KNIFE_SILENT_AIM"]
        local fovEnabled = SwitchFunctions["MM2_SILENT_AIM_FOV"]
        local fovSize = DragFunctions["MM2_SILENT_AIM_FOV_SIZE"]
        local visibleCheck = SwitchFunctions["MM2_SILENT_AIM_VISIBLE_CHECK"]
        local draw_line_to_target = SwitchFunctions["MM2_SILENT_AIM_DRAW_LINE_TARGET"]
        local line_to_target_color = getESPColor("MM2_SILENT_AIM_DRAW_LINE_TARGET")

        local aimbotActive = (gunEnabled or knifeEnabled)
        local mousePos = UserInputService:GetMouseLocation()

        FOVCircle.Visible = aimbotActive and fovEnabled
        if FOVCircle.Visible then
            FOVCircle.Radius = fovSize
            FOVCircle.Position = mousePos
        end

        if aimbotActive then
            local closestDist = fovEnabled and fovSize or math.huge
            local closestHead = nil
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                        local head = char.Head
                        if visibleCheck and not isVisible(head) then continue end
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                closestHead = head
                            end
                        end
                    end
                end
            end
            currentClosestHead = closestHead
            if closestHead and draw_line_to_target then
                local tPos, _ = Camera:WorldToViewportPoint(closestHead.Position)
                TracerLine.Visible = true
                TracerLine.From = mousePos
                TracerLine.To = Vector2.new(tPos.X, tPos.Y)
                TracerLine.Color = line_to_target_color
            else
                TracerLine.Visible = false
            end
        else
            TracerLine.Visible = false
            currentClosestHead = nil
        end
    end)

    local function isToolEquipped(toolName)
        local char = LocalPlayer.Character
        if not char then return false end
        return char:FindFirstChild(toolName) ~= nil
    end

    local function findToolAnywhere(toolName)
        local char = LocalPlayer.Character
        if not char then return nil end
        local bp = LocalPlayer:FindFirstChild("Backpack")
        return (bp and bp:FindFirstChild(toolName)) or char:FindFirstChild(toolName)
    end

    -- Function to get the correct remote path for Gun
    local function getGunRemote(tool)
        -- Try both possible remote structures
        local remote = tool:FindFirstChild("Shoot")
        if remote and remote:IsA("RemoteEvent") then
            return remote
        end
        remote = tool:FindFirstChild("Events")
        if remote then
            local shoot = remote:FindFirstChild("Shoot")
            if shoot and shoot:IsA("RemoteEvent") then
                return shoot
            end
        end
        -- Fallback: search all descendants
        local found = nil
        local function search(parent)
            for _, child in ipairs(parent:GetChildren()) do
                if child:IsA("RemoteEvent") and (child.Name == "Shoot" or child.Name:lower():find("shoot")) then
                    found = child
                    return
                end
                search(child)
                if found then return end
            end
        end
        search(tool)
        return found
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- GUN LOGIC
            local toggleVal = SwitchFunctions["MM2_WEAPON_SILENT_AIM"]
            if not toggleVal then return end
            if not currentClosestHead then return end

            -- Check if Gun is equipped (try multiple possible names)
            local gunNames = {"Gun", "Pistol", "Revolver", "Weapon"}
            local hasGun = false
            for _, name in ipairs(gunNames) do
                if isToolEquipped(name) then
                    hasGun = true
                    break
                end
            end
            if not hasGun then return end

            local targetChar = currentClosestHead.Parent
            if not targetChar then return end

            -- Find Gun tool
            local gunTool = nil
            for _, name in ipairs(gunNames) do
                gunTool = findToolAnywhere(name)
                if gunTool then break end
            end
            if not gunTool then return end

            local remote = getGunRemote(gunTool)
            if not remote then
                -- Debug: print tool children for inspection
                print("[GUN] Tool children:", table.concat(iterChildren(gunTool), ", "))
                return
            end

            -- Build arguments (same as Knife logic)
            local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("UpperTorso") or targetChar.Head
            local targetCFrame = targetPart.CFrame
            local offsetCFrame = targetCFrame * CFrame.new(0, 0.5, 0)
            local args = { offsetCFrame, targetCFrame }

            remote:FireServer(unpack(args))

        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            -- KNIFE LOGIC (unchanged, working)
            local toggleVal = SwitchFunctions["MM2_KNIFE_SILENT_AIM"]
            if not toggleVal then return end
            if not currentClosestHead then return end
            if not isToolEquipped("Knife") then return end

            local targetChar = currentClosestHead.Parent
            if not targetChar then return end

            local knifeTool = findToolAnywhere("Knife")
            if not knifeTool then return end

            local remote = knifeTool:FindFirstChild("Events")
            if remote then
                remote = remote:FindFirstChild("KnifeThrown")
            end
            if not remote then return end

            local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("UpperTorso") or targetChar.Head
            local targetCFrame = targetPart.CFrame
            local offsetCFrame = targetCFrame * CFrame.new(0, 0.5, 0)
            local args = { offsetCFrame, targetCFrame }

            remote:FireServer(unpack(args))
        end
    end)

    -- Helper for debug
    local function iterChildren(obj)
        local names = {}
        for _, c in ipairs(obj:GetChildren()) do
            table.insert(names, c.Name .. "(" .. c.ClassName .. ")")
        end
        return names
    end

    print("[DEBUG] ===== FIXED GUN SCRIPT LOADED =====")
end)
--]]


--[[
ProtectedExecute("SILENT-AIM", "A", function()

    -- STANDARDFARBEN für SilentAim FOV auf Weiß setzen
    -- Stelle sicher dass ColorFunctions für FOV existiert
    if not ColorFunctions["Silent-Aim-ShowFOV"] then
        ColorFunctions["Silent-Aim-ShowFOV"] = "FFFFFF"
    end
    if not ColorFunctions["Silent-Aim-ShowTarget"] then
        ColorFunctions["Silent-Aim-ShowTarget"] = "FFFFFF"
    end

    -- Callbacks SOFORT setzen
    FunctionsSettings["Silent-Aim-Enable"] = FunctionsSettings["Silent-Aim-Enable"] or {}
    FunctionsSettings["Silent-Aim-Enable"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-Enable"] = state
        safeSetSilentAim("Enabled", state)
    end

    FunctionsSettings["Silent-Aim-TeamCheck"] = FunctionsSettings["Silent-Aim-TeamCheck"] or {}
    FunctionsSettings["Silent-Aim-TeamCheck"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-TeamCheck"] = state
        safeSetSilentAim("TeamCheck", state)
    end

    FunctionsSettings["Silent-Aim-VisibleCheck"] = FunctionsSettings["Silent-Aim-VisibleCheck"] or {}
    FunctionsSettings["Silent-Aim-VisibleCheck"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-VisibleCheck"] = state
        safeSetSilentAim("VisibleCheck", state)
    end

    FunctionsSettings["Silent-Aim-ShowFOV"] = FunctionsSettings["Silent-Aim-ShowFOV"] or {}
    FunctionsSettings["Silent-Aim-ShowFOV"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-ShowFOV"] = state
        safeSetSilentAim("FOVVisible", state)
        -- Farbe auch setzen wenn aktiviert
        if state then
            local hex = ColorFunctions["Silent-Aim-ShowFOV"] or "FFFFFF"
            safeSetSilentAim("FOVColor", Color3.fromRGB(
                tonumber(hex:sub(1,2), 16) or 255,
                tonumber(hex:sub(3,4), 16) or 255,
                tonumber(hex:sub(5,6), 16) or 255
            ))
        end
    end

    FunctionsSettings["Silent-Aim-ShowTarget"] = FunctionsSettings["Silent-Aim-ShowTarget"] or {}
    FunctionsSettings["Silent-Aim-ShowTarget"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-ShowTarget"] = state
        safeSetSilentAim("ShowSilentAimTarget", state)
        if state then
            local hex = ColorFunctions["Silent-Aim-ShowTarget"] or "FFFFFF"
            safeSetSilentAim("SilentAimTargetColor", Color3.fromRGB(
                tonumber(hex:sub(1,2), 16) or 255,
                tonumber(hex:sub(3,4), 16) or 255,
                tonumber(hex:sub(5,6), 16) or 255
            ))
        end
    end

    FunctionsSettings["Silent-Aim-Prediction"] = FunctionsSettings["Silent-Aim-Prediction"] or {}
    FunctionsSettings["Silent-Aim-Prediction"].OnToggle = function(state)
        SwitchFunctions["Silent-Aim-Prediction"] = state
        safeSetSilentAim("MouseHitPrediction", state)
    end

    -- DRAG CALLBACKS - Diese werden jetzt korrekt ausgeführt
    FunctionsSettings["Silent-Aim-HitChance"] = FunctionsSettings["Silent-Aim-HitChance"] or {}
    FunctionsSettings["Silent-Aim-HitChance"].OnDrag = function(val)
        DragFunctions["Silent-Aim-HitChance"] = val
        safeSetSilentAim("HitChance", val)
    end
    -- Auch OnChange für Kompatibilität
    FunctionsSettings["Silent-Aim-HitChance"].OnChange = function(val)
        DragFunctions["Silent-Aim-HitChance"] = val
        safeSetSilentAim("HitChance", val)
    end

    FunctionsSettings["Silent-Aim-FOVRadius"] = FunctionsSettings["Silent-Aim-FOVRadius"] or {}
    FunctionsSettings["Silent-Aim-FOVRadius"].OnDrag = function(val)
        DragFunctions["Silent-Aim-FOVRadius"] = val
        safeSetSilentAim("FOVRadius", val)
    end
    FunctionsSettings["Silent-Aim-FOVRadius"].OnChange = function(val)
        DragFunctions["Silent-Aim-FOVRadius"] = val
        safeSetSilentAim("FOVRadius", val)
    end

    FunctionsSettings["Silent-Aim-PredictionAmount"] = FunctionsSettings["Silent-Aim-PredictionAmount"] or {}
    FunctionsSettings["Silent-Aim-PredictionAmount"].OnDrag = function(val)
        DragFunctions["Silent-Aim-PredictionAmount"] = val
        safeSetSilentAim("MouseHitPredictionAmount", val / 1000)
    end
    FunctionsSettings["Silent-Aim-PredictionAmount"].OnChange = function(val)
        DragFunctions["Silent-Aim-PredictionAmount"] = val
        safeSetSilentAim("MouseHitPredictionAmount", val / 1000)
    end

    FunctionsSettings["Silent-Aim-TargetPart"] = FunctionsSettings["Silent-Aim-TargetPart"] or {}
    FunctionsSettings["Silent-Aim-TargetPart"].OnSelect = function(val)
        safeSetSilentAim("TargetPart", val)
    end

    FunctionsSettings["Silent-Aim-Method"] = FunctionsSettings["Silent-Aim-Method"] or {}
    FunctionsSettings["Silent-Aim-Method"].OnSelect = function(val)
        safeSetSilentAim("SilentAimMethod", val)
    end

    -- FARBE CALLBACKS
    if not FunctionsSettings["Silent-Aim-ShowFOV"].ColorCallbacks then
        FunctionsSettings["Silent-Aim-ShowFOV"].ColorCallbacks = {}
    end
    table.insert(FunctionsSettings["Silent-Aim-ShowFOV"].ColorCallbacks, function(hex)
        safeSetSilentAim("FOVColor", Color3.fromRGB(
            tonumber(hex:sub(1,2), 16) or 255,
            tonumber(hex:sub(3,4), 16) or 255,
            tonumber(hex:sub(5,6), 16) or 255
        ))
    end)

    if not FunctionsSettings["Silent-Aim-ShowTarget"].ColorCallbacks then
        FunctionsSettings["Silent-Aim-ShowTarget"].ColorCallbacks = {}
    end
    table.insert(FunctionsSettings["Silent-Aim-ShowTarget"].ColorCallbacks, function(hex)
        safeSetSilentAim("SilentAimTargetColor", Color3.fromRGB(
            tonumber(hex:sub(1,2), 16) or 255,
            tonumber(hex:sub(3,4), 16) or 255,
            tonumber(hex:sub(5,6), 16) or 255
        ))
    end)

    -- Hilfsfunktion mit pcall
    local function safeSetSilentAim(key, value)
        local success, err = pcall(function()
            if getgenv().SilentAimSettings then
                getgenv().SilentAimSettings[key] = value
            end
        end)
        if not success then
            warn("[VEXARIS] Fehler beim Setzen von SilentAimSettings." .. tostring(key) .. ": " .. tostring(err))
        end
    end

    -- Synchronisationsfunktion
    local function syncAllSilentAimSettings()
        if not getgenv().SilentAimSettings then return end
        
        safeSetSilentAim("Enabled", SwitchFunctions["Silent-Aim-Enable"] or false)
        safeSetSilentAim("TeamCheck", SwitchFunctions["Silent-Aim-TeamCheck"] or false)
        safeSetSilentAim("VisibleCheck", SwitchFunctions["Silent-Aim-VisibleCheck"] or false)
        safeSetSilentAim("FOVVisible", SwitchFunctions["Silent-Aim-ShowFOV"] or false)
        safeSetSilentAim("ShowSilentAimTarget", SwitchFunctions["Silent-Aim-ShowTarget"] or false)
        safeSetSilentAim("MouseHitPrediction", SwitchFunctions["Silent-Aim-Prediction"] or false)
        safeSetSilentAim("HitChance", DragFunctions["Silent-Aim-HitChance"] or 100)
        safeSetSilentAim("FOVRadius", DragFunctions["Silent-Aim-FOVRadius"] or 130)
        safeSetSilentAim("MouseHitPredictionAmount", (DragFunctions["Silent-Aim-PredictionAmount"] or 165) / 1000)
        
        local partIdx = SelectionFunctions["Silent-Aim-TargetPart"] or 1
        local partMap = {[1] = "Head", [2] = "HumanoidRootPart", [3] = "Random"}
        safeSetSilentAim("TargetPart", partMap[partIdx] or "Head")
        
        local methodIdx = SelectionFunctions["Silent-Aim-Method"] or 1
        local methodMap = {
            [1] = "Raycast",
            [2] = "FindPartOnRay",
            [3] = "FindPartOnRayWithWhitelist",
            [4] = "FindPartOnRayWithIgnoreList",
            [5] = "Mouse.Hit/Target"
        }
        safeSetSilentAim("SilentAimMethod", methodMap[methodIdx] or "Raycast")
        
        -- Farben setzen
        local fovHex = ColorFunctions["Silent-Aim-ShowFOV"] or "FFFFFF"
        safeSetSilentAim("FOVColor", Color3.fromRGB(
            tonumber(fovHex:sub(1,2), 16) or 255,
            tonumber(fovHex:sub(3,4), 16) or 255,
            tonumber(fovHex:sub(5,6), 16) or 255
        ))
        
        local targetHex = ColorFunctions["Silent-Aim-ShowTarget"] or "FFFFFF"
        safeSetSilentAim("SilentAimTargetColor", Color3.fromRGB(
            tonumber(targetHex:sub(1,2), 16) or 255,
            tonumber(targetHex:sub(3,4), 16) or 255,
            tonumber(targetHex:sub(5,6), 16) or 255
        ))
    end

    -- ASYNC: SilentAim.laden im Hintergrund mit korrekter Warteschleife
    task.spawn(function()
        print("[VEXARIS] Lade SilentAim.lua...")
        
        local loadSuccess, loadErr = pcall(function()
            loadstring(game:HttpGet("https://raw.githack.com/SpyTA/s/main/SilentAim.lua"))()
        end)
        
        if not loadSuccess then
            warn("[VEXARIS] SilentAim.lua konnte nicht geladen werden: " .. tostring(loadErr))
            return
        end
        
        print("[VEXARIS] SilentAim.lua geladen, warte auf Initialisierung...")
        
        -- Warte auf SilentAimSettings mit maximal 15 Sekunden Timeout
        local timeout = 0
        local step = 0.1
        local maxTimeout = 15
        
        repeat
            task.wait(step)
            timeout = timeout + step
            if timeout > maxTimeout then
                warn("[VEXARIS] SilentAimSettings wurde nicht innerhalb von " .. maxTimeout .. " Sekunden initialisiert")
                return
            end
        until getgenv().SilentAimSettings ~= nil
        
        print("[VEXARIS] SilentAimSettings erfolgreich geladen!")
        
        -- Rayfield deaktivieren (async, nicht blockierend)
        task.spawn(function()
            local startTime = tick()
            local duration = 15
            while (tick() - startTime) < duration do
                pcall(function()
                    local hiddenUi = game:GetService("CoreGui"):FindFirstChild("HiddenUI")
                    if hiddenUi then
                        local rayfield = hiddenUi:FindFirstChild("Rayfield")
                        if rayfield then rayfield.Enabled = false end
                    end
                    local rayfieldDirect = game:GetService("CoreGui"):FindFirstChild("Rayfield")
                    if rayfieldDirect then rayfieldDirect.Enabled = false end
                end)
                task.wait(0.1)
            end
        end)
        
        -- Alle Werte synchronisieren
        syncAllSilentAimSettings()
        
        print("[VEXARIS] SilentAim vollständig initialisiert")
    end)
    
    -- Periodischer Sync alle 0.2 Sekunden (asynchron, non-blocking)
    task.spawn(function()
        while true do
            task.wait(0.2)
            if getgenv().SilentAimSettings then
                syncAllSilentAimSettings()
            end
        end
    end)
end)
]]



-- ── Hilfsfunktionen ──────────────────────────────────────────
 
-- Serialisiert einen KeyCode zu einem String (z.B. "E", "F", "LeftShift")
local function SerializeKeyCode(kc)
    if kc == nil then return nil end
    local ok, name = pcall(function() return kc.Name end)
    if ok and name then return name end
    return nil
end
 
-- Deserialisiert einen KeyCode-String zurück zu Enum.KeyCode
local function DeserializeKeyCode(name)
    if name == nil then return nil end
    local ok, kc = pcall(function() return Enum.KeyCode[name] end)
    if ok and kc then return kc end
    return nil
end
 
-- Sammelt den kompletten Config-State aus allen State-Tabellen
local function CollectConfigState()
    -- KeybindFunctions: KeyCode → string
    local serializedKeybinds = {}
    for fn, kc in pairs(KeybindFunctions) do
        serializedKeybinds[fn] = SerializeKeyCode(kc)
    end
 
    -- FunctionsSettings: nur serialisierbare Daten (kein Callbacks/Closures)
    -- Wir speichern nur was wirklich ein "Einstellungswert" ist.
    -- Callbacks werden beim Laden neu gebaut (durch Build_Switch etc.)
    local serializedFuncSettings = {}
    for fn, settings in pairs(FunctionsSettings) do
        local entry = {}
        -- Nur primitive Felder sichern (keine Funktionen)
        if type(settings.Value) ~= "function"   and settings.Value   ~= nil then entry.Value   = settings.Value   end
        if type(settings.Min)   ~= "function"   and settings.Min     ~= nil then entry.Min     = settings.Min     end
        if type(settings.Max)   ~= "function"   and settings.Max     ~= nil then entry.Max     = settings.Max     end
        if type(settings.Label) ~= "function"   and settings.Label   ~= nil then entry.Label   = settings.Label   end
        -- Nur hinzufügen wenn wirklich was drin ist
        if next(entry) ~= nil then
            serializedFuncSettings[fn] = entry
        end
    end
 
    return {
        switches         = SwitchFunctions,
        drags            = DragFunctions,
        keybinds         = serializedKeybinds,
        colors           = ColorFunctions,
        favourites       = FavouriteFunctions,
        selections       = SelectionFunctions,
        functionSettings = serializedFuncSettings,
    }
end
 
-- Wendet einen gespeicherten Config-State auf alle State-Tabellen an
-- und aktualisiert danach alle UI-Callbacks
local function ApplyConfigState(state)
    if not state then return end
 
    -- Switches
    if type(state.switches) == "table" then
        for fn, val in pairs(state.switches) do
            SwitchFunctions[fn] = val
            -- UI-Callback aufrufen falls vorhanden
            local cbs = SwitchUICallbacks and SwitchUICallbacks[fn]
            if cbs then
                for _, cb in ipairs(cbs) do pcall(cb, val) end
            end
            if FunctionsSettings[fn] and FunctionsSettings[fn].OnToggle then
                pcall(FunctionsSettings[fn].OnToggle, val)
            end
        end
    end
 
    -- Drags
    if type(state.drags) == "table" then
        for fn, val in pairs(state.drags) do
            DragFunctions[fn] = val
            -- Drag-OnChange aufrufen falls vorhanden
            if FunctionsSettings[fn] and FunctionsSettings[fn].OnChange then
                pcall(FunctionsSettings[fn].OnChange, val)
            end
        end
    end
 
    -- Keybinds
    if type(state.keybinds) == "table" then
        for fn, kcName in pairs(state.keybinds) do
            local kc = DeserializeKeyCode(kcName)
            KeybindFunctions[fn] = kc
            if FunctionsSettings[fn] and FunctionsSettings[fn].OnKeybindChanged then
                pcall(FunctionsSettings[fn].OnKeybindChanged, kc)
            end
        end
    end
 
    -- Colors
    if type(state.colors) == "table" then
        for fn, hex in pairs(state.colors) do
            ColorFunctions[fn] = hex
            if FunctionsSettings[fn] and FunctionsSettings[fn].ColorCallbacks then
                for _, cb in ipairs(FunctionsSettings[fn].ColorCallbacks) do
                    pcall(cb, hex)
                end
            end
        end
    end
 
    -- Favourites
    if type(state.favourites) == "table" then
        for fn, isFav in pairs(state.favourites) do
            FavouriteFunctions[fn] = isFav
        end
        -- Favourites-Tab neu bauen (sofern Build_Switch verfügbar)
        if AllSwitchDefs then
            for fn, isFav in pairs(FavouriteFunctions) do
                if isFav and AllSwitchDefs[fn] then
                    pcall(Build_Switch, AllSwitchDefs[fn], "HOME", "HOME_FAVOURITES", 50, true)
                end
            end
        end
    end
 
    -- Selections (List-Elemente)
    if type(state.selections) == "table" then
        for fn, idx in pairs(state.selections) do
            SelectionFunctions[fn] = idx
            if FunctionsSettings[fn] and FunctionsSettings[fn].OnSelect then
                -- OnSelect erwartet einen String-Wert, wir rufen mit Index auf
                pcall(FunctionsSettings[fn].OnSelect, tostring(idx))
            end
        end
    end
 
    -- FunctionsSettings (nur primitive Felder)
    if type(state.functionSettings) == "table" then
        for fn, entry in pairs(state.functionSettings) do
            FunctionsSettings[fn] = FunctionsSettings[fn] or {}
            for k, v in pairs(entry) do
                -- Nie Callbacks überschreiben
                if type(v) ~= "function" then
                    FunctionsSettings[fn][k] = v
                end
            end
        end
    end
end
 
-- Schreibt eine Config als .json Datei lokal ab
-- configState   = CollectConfigState()
-- shareUrl      = string oder nil (wenn Server nicht erreichbar)
local function WriteConfigFile(configName, configState, shareUrl)
    local payload = {
        name      = configName,
        shareUrl  = shareUrl or nil,
        savedAt   = os.time(),
        state     = configState,
    }
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not ok then
        SendNotify("❌ Config konnte nicht kodiert werden!")
        return false
    end
    local path = CONFIG_FOLDER .. "/" .. configName .. ".json"
    local writeOk, writeErr = pcall(writefile, path, encoded)
    if not writeOk then
        SendNotify("❌ Schreiben fehlgeschlagen: " .. tostring(writeErr))
        return false
    end
    return true
end
 
-- Liest eine Config-Datei und gibt das dekodierte Objekt zurück
local function ReadConfigFile(configName)
    local path = CONFIG_FOLDER .. "/" .. configName .. ".json"
    if not isfile(path) then return nil end
    local ok, raw = pcall(readfile, path)
    if not ok then return nil end
    local decodeOk, payload = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not decodeOk then return nil end
    return payload
end
 
-- Listet alle lokal gespeicherten Config-Namen auf
 
-- ── Server-Kommunikation ──────────────────────────────────────
 
-- Erstellt eine Share-URL beim Server und gibt sie zurück.
-- Gibt nil + Fehlermeldung zurück falls es nicht klappt.
local function RequestShareUrl(configName, configState)
    local payload = {
        userId     = UserId,
        configName = configName,
        configData = configState,
    }
 
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not ok then
        return nil, "Encoding fehlgeschlagen"
    end
 
    -- POST /config/share
    local httpFunc = (syn and syn.request) or request or http_request or HttpService.RequestAsync
    local reqOk, response = pcall(function()
        return httpFunc({
            Url    = SERVER_BASE_URL .. "/config/share",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
            },
            Body = encoded,
        })
    end)

    if not reqOk then
        warn("[Vexaris/ConfigShare] RequestAsync fehlgeschlagen: " .. tostring(response))
        return nil, "Netzwerk-Fehler"
    end

    -- Komplette Antwort loggen
    warn("[Vexaris/ConfigShare] StatusCode: " .. tostring(response.StatusCode))
    warn("[Vexaris/ConfigShare] Body: " .. tostring(response.Body):sub(1, 400))

    -- HTTP-Status prüfen
    if response.StatusCode == 429 then
        local bodyOk, body = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)
        local retryAfter = (bodyOk and body and body.retryAfter) or 15
        return nil, "rate_limited:" .. tostring(retryAfter)
    end
 
    if response.StatusCode ~= 200 then
        return nil, "Server-Fehler (" .. tostring(response.StatusCode) .. ": " .. tostring(response.Body):sub(1, 200) .. ")"
    end
 
    -- Body dekodieren
    local decodeOk, body = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)
    if not decodeOk or not body or not body.success then
        return nil, "Ungültige Server-Antwort"
    end
 
    return body.url, nil
end
 
-- Lädt eine Config von einer Share-URL (GET /import/<code>)
local function FetchConfigFromUrl(url)
    -- Code aus der URL extrahieren
    local code = url:match("/import/([a-z0-9]+)$")
    if not code then
        return nil, "Ungültige URL (kein Import-Code gefunden)"
    end
 
    local importUrl = SERVER_BASE_URL .. "/import/" .. code
 
    local httpFunc = (syn and syn.request) or request or http_request or HttpService.RequestAsync
    local reqOk, response = pcall(function()
        return httpFunc({
            Url    = importUrl,
            Method = "GET",
        })
    end)

    if not reqOk then
        return nil, "Netzwerk-Fehler"
    end
 
    if response.StatusCode == 404 then
        return nil, "Config nicht gefunden (abgelaufen oder ungültig)"
    end
 
    if response.StatusCode ~= 200 then
        return nil, "Server-Fehler (" .. tostring(response.StatusCode) .. ")"
    end
 
    local decodeOk, body = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)
    if not decodeOk or not body or not body.success then
        return nil, "Ungültige Server-Antwort"
    end
 
    return body, nil  -- body enthält: configName, configData, sharedBy, createdAt
end
 
-- ── Neues Profil erstellen (BTN_CONFIG_NEW) ──────────────────
FunctionsSettings["BTN_CONFIG_NEW"] = FunctionsSettings["BTN_CONFIG_NEW"] or {}
FunctionsSettings["BTN_CONFIG_NEW"].OnExecute = function(inputText)
    local configName = inputText and inputText:match("^%s*(.-)%s*$") or ""
    if configName == "" then
        SendNotify("Profilname darf nicht leer sein!")
        return
    end
    -- Ungültige Zeichen entfernen (nur alphanum + Leerzeichen + _ -)
    configName = configName:gsub("[^%w%s%-_]", ""):sub(1, 40)
    if configName == "" then
        SendNotify("Ungültiger Profilname!")
        return
    end
 
    local configState = CollectConfigState()
    SendNotify("Erstelle Share-URL...")
 
    -- Server anfragen (in einem Task damit UI nicht einfriert)
    task.spawn(function()
        warn("[Vexaris/NEW] task.spawn gestartet")
        local shareUrl, err = RequestShareUrl(configName, configState)
        warn("[Vexaris/NEW] RequestShareUrl fertig | shareUrl=" .. tostring(shareUrl) .. " | err=" .. tostring(err))

        if err then
            if err:sub(1, 12) == "rate_limited" then
                local sec = err:match(":(%d+)$") or "15"
                SendNotify("Warte noch " .. sec .. " Sekunden!")
                return
            else
                -- Anderer Fehler: offline Fallback (ohne URL speichern)
                SendNotify("Server nicht erreichbar – Config ohne URL gespeichert")
                local saved = WriteConfigFile(configName, configState, nil)
                if saved then
                    SendNotify("Profil \"" .. configName .. "\" gespeichert (offline)")
                end
                return
            end
        end
 
        -- Erfolg: mit URL speichern
        local saved = WriteConfigFile(configName, configState, shareUrl)
        if saved then
            SendNotify("Profil \"" .. configName .. "\" erstellt!")
            SendNotify("URL gespeichert in Profil")
        end
    end)
end
 
-- ── Profil speichern (BTN_CONFIG_SAVE) ───────────────────────
-- Überschreibt das aktuell ausgewählte Profil lokal.
-- Hält die vorhandene shareUrl falls keine neue angefragt werden soll.
FunctionsSettings["BTN_CONFIG_SAVE"] = FunctionsSettings["BTN_CONFIG_SAVE"] or {}
FunctionsSettings["BTN_CONFIG_SAVE"].OnExecute = function()
    -- Aktuell gewähltes Profil aus SelectionFunctions
    local selectedIdx  = SelectionFunctions["SELECTED_CONFIG_PROFILE"] or 1
    local configList   = ListConfigs()
    local configName   = configList[selectedIdx]
 
    if not configName then
        SendNotify("Kein Profil ausgewählt!")
        return
    end
 
    -- Vorhandene URL aus der Datei lesen (falls schon eine existiert)
    local existing    = ReadConfigFile(configName)
    local oldShareUrl = existing and existing.shareUrl or nil
 
    local configState = CollectConfigState()
    local saved       = WriteConfigFile(configName, configState, oldShareUrl)
    if saved then
        SendNotify("Profil \"" .. configName .. "\" gespeichert!")
    end
end
 
-- ── Profil laden (BTN_CONFIG_LOAD) ───────────────────────────
FunctionsSettings["BTN_CONFIG_LOAD"] = FunctionsSettings["BTN_CONFIG_LOAD"] or {}
FunctionsSettings["BTN_CONFIG_LOAD"].OnExecute = function()
    local selectedIdx = SelectionFunctions["SELECTED_CONFIG_PROFILE"] or 1
    local configList  = ListConfigs()
    local configName  = configList[selectedIdx]
 
    if not configName then
        SendNotify("Kein Profil ausgewählt!")
        return
    end
 
    local payload = ReadConfigFile(configName)
    if not payload then
        SendNotify("Profil \"" .. configName .. "\" nicht gefunden!")
        return
    end
 
    ApplyConfigState(payload.state)
    SendNotify("Profil \"" .. configName .. "\" geladen!")
end
 
-- ── Profil löschen (BTN_CONFIG_DELETE) ───────────────────────
FunctionsSettings["BTN_CONFIG_DELETE"] = FunctionsSettings["BTN_CONFIG_DELETE"] or {}
FunctionsSettings["BTN_CONFIG_DELETE"].OnExecute = function()
    local selectedIdx = SelectionFunctions["SELECTED_CONFIG_PROFILE"] or 1
    local configList  = ListConfigs()
    local configName  = configList[selectedIdx]
 
    if not configName then
        SendNotify("Kein Profil ausgewählt!")
        return
    end
 
    local path  = CONFIG_FOLDER .. "/" .. configName .. ".json"
    local ok    = pcall(delfile, path)
    if ok then
        SendNotify("Profil \"" .. configName .. "\" gelöscht!")
    else
        SendNotify("Löschen fehlgeschlagen!")
    end
end
 
-- ── Profil umbenennen (BTN_CONFIG_RENAME) ────────────────────
FunctionsSettings["BTN_CONFIG_RENAME"] = FunctionsSettings["BTN_CONFIG_RENAME"] or {}
FunctionsSettings["BTN_CONFIG_RENAME"].OnExecute = function(inputText)
    local newName = inputText and inputText:match("^%s*(.-)%s*$") or ""
    if newName == "" then
        SendNotify("❌ Neuer Name darf nicht leer sein!")
        return
    end
    newName = newName:gsub("[^%w%s%-_]", ""):sub(1, 40)
 
    local selectedIdx = SelectionFunctions["SELECTED_CONFIG_PROFILE"] or 1
    local configList  = ListConfigs()
    local oldName     = configList[selectedIdx]
 
    if not oldName then
        SendNotify("Kein Profil ausgewählt!")
        return
    end
 
    local payload = ReadConfigFile(oldName)
    if not payload then
        SendNotify("Profil nicht lesbar!")
        return
    end
 
    payload.name = newName
    local saved  = WriteConfigFile(newName, payload.state, payload.shareUrl)
    if saved then
        -- Alte Datei entfernen
        pcall(delfile, CONFIG_FOLDER .. "/" .. oldName .. ".json")
        SendNotify("Profil umbenannt zu \"" .. newName .. "\"!")
    end
end
 
-- ── URL kopieren (BTN_CONFIG_EXPORT_URL) ─────────────────────
FunctionsSettings["BTN_CONFIG_EXPORT_URL"] = FunctionsSettings["BTN_CONFIG_EXPORT_URL"] or {}
FunctionsSettings["BTN_CONFIG_EXPORT_URL"].OnExecute = function()
    local selectedIdx = SelectionFunctions["SELECTED_CONFIG_PROFILE"] or 1
    local configList  = ListConfigs()
    local configName  = configList[selectedIdx]
 
    if not configName then
        SendNotify("Kein Profil ausgewählt!")
        return
    end
 
    local payload = ReadConfigFile(configName)
    if not payload then
        SendNotify("Profil nicht gefunden!")
        return
    end
 
    if not payload.shareUrl then
        SendNotify("Keine Share-URL in diesem Profil!")
        SendNotify("Erstelle es neu um eine URL zu generieren")
        return
    end
 
    -- In Zwischenablage kopieren
    local clipOk = pcall(function()
        setclipboard(payload.shareUrl)
    end)
    if clipOk then
        SendNotify("URL kopiert!")
    else
        -- Fallback: einfach anzeigen
        SendNotify("URL kopiert!")
    end
end
 
-- ── Von URL importieren (BTN_CONFIG_IMPORT_URL) ───────────────
-- Lädt eine fremde Config vom Server und speichert sie lokal –
-- exakt so als hätte man sie selbst erstellt (inklusive shareUrl).
FunctionsSettings["BTN_CONFIG_IMPORT_URL"] = FunctionsSettings["BTN_CONFIG_IMPORT_URL"] or {}
FunctionsSettings["BTN_CONFIG_IMPORT_URL"].OnExecute = function(inputText)
    local url = inputText and inputText:match("^%s*(.-)%s*$") or ""
    if url == "" then
        SendNotify("Bitte eine URL eingeben!")
        return
    end
 
    -- Grundvalidierung: muss /import/ enthalten
    if not url:find("/import/") then
        SendNotify("Ungültige Vexaris-Import-URL!")
        return
    end
 
    SendNotify("Lade Config von Server...")
 
    task.spawn(function()
        local result, err = FetchConfigFromUrl(url)
 
        if err then
            SendNotify("Import fehlgeschlagen: " .. err)
            return
        end
 
        local configName  = result.configName or "Importiert"
        local configState = result.configData
 
        if not configState then
            SendNotify("Config-Daten fehlen in der Antwort!")
            return
        end
 
        -- Lokal speichern (mit der originalen shareUrl damit man sie weiterteilen kann)
        local saved = WriteConfigFile(configName, configState, url)
        if not saved then
            SendNotify("Speichern fehlgeschlagen!")
            return
        end
 
        -- Sofort anwenden – identisch zum Ersteller
        ApplyConfigState(configState)
 
        SendNotify("Config \"" .. configName .. "\" importiert & angewendet!")
        SendNotify("Profil gespeichert")
    end)
end
 
-- ── Aktuelles Profil zurücksetzen (BTN_CONFIG_RESET_CURRENT) ──
FunctionsSettings["BTN_CONFIG_RESET_CURRENT"] = FunctionsSettings["BTN_CONFIG_RESET_CURRENT"] or {}
FunctionsSettings["BTN_CONFIG_RESET_CURRENT"].OnExecute = function()
    -- Alle State-Tabellen leeren
    for fn in pairs(SwitchFunctions) do
        SwitchFunctions[fn] = false
        local cbs = SwitchUICallbacks and SwitchUICallbacks[fn]
        if cbs then for _, cb in ipairs(cbs) do pcall(cb, false) end end
        if FunctionsSettings[fn] and FunctionsSettings[fn].OnToggle then
            pcall(FunctionsSettings[fn].OnToggle, false)
        end
    end
    for fn in pairs(DragFunctions) do
        DragFunctions[fn] = nil
    end
    for fn in pairs(KeybindFunctions) do
        KeybindFunctions[fn] = nil
        if FunctionsSettings[fn] and FunctionsSettings[fn].OnKeybindChanged then
            pcall(FunctionsSettings[fn].OnKeybindChanged, nil)
        end
    end
    for fn in pairs(ColorFunctions) do
        ColorFunctions[fn] = nil
    end
    for fn in pairs(FavouriteFunctions) do
        FavouriteFunctions[fn] = false
    end
    for fn in pairs(SelectionFunctions) do
        SelectionFunctions[fn] = 1
    end
 
    SendNotify("Profil zurückgesetzt!")
end
 
-- ── Alle Profile löschen (BTN_CONFIG_RESET_ALL) ───────────────
FunctionsSettings["BTN_CONFIG_RESET_ALL"] = FunctionsSettings["BTN_CONFIG_RESET_ALL"] or {}
FunctionsSettings["BTN_CONFIG_RESET_ALL"].OnExecute = function()
    local ok, files = pcall(listfiles, CONFIG_FOLDER)
    if not ok then
        print("[VEXARIS] - [CONFIG] Ordner nicht lesbar!")
        return
    end
    local count = 0
    for _, path in ipairs(files) do
        if path:match("%.json$") then
            pcall(delfile, path)
            count = count + 1
        end
    end
    SendNotify("Alle Profile gelöscht!")
end
