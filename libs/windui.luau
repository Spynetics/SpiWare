--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /
    |__/|__/_/_//_/\_,_/\____/___/

    by .ftgs#0 (Discord)

    This script is NOT intended to be modified.
    To view the source code, see the 'Src' folder on the official GitHub repository.

    Author: .ftgs#0 (Discord User)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/84CNGY5wAV
]]


local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()





local b=game:GetService"RunService"local c=
b.Heartbeat
local d=game:GetService"UserInputService"
local e=game:GetService"TweenService"

local f=loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/Footagesus/Icons/main/Main.lua")()
f.SetIconsType"lucide"

local g={
Font="rbxassetid://12187365364",
CanDraggable=true,
Theme=nil,
Themes=nil,
WindUI=nil,
Signals={},
Objects={},
FontObjects={},
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
}
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
}
}

function g.Init(h)
g.WindUI=h
end


function g.AddSignal(h,i)
table.insert(g.Signals,h:Connect(i))
end

function g.DisconnectAll()
for h,i in next,g.Signals do
local j=table.remove(g.Signals,h)
j:Disconnect()
end
end


function g.SafeCallback(h,...)
if not h then
return
end

local i,j=pcall(h,...)
if not i then local
k, l=j:find":%d+: "


warn("[ WindUI: DEBUG Mode ] "..j)

return g.WindUI:Notify{
Title="DEBUG Mode: Error",
Content=not l and j or j:sub(l+1),
Duration=8,
}
end
end

function g.SetTheme(h)
g.Theme=h
g.UpdateTheme(nil,true)
end

function g.AddFontObject(h)
table.insert(g.FontObjects,h)
g.UpdateFont(g.Font)
end

function g.UpdateFont(h)
g.Font=h
for i,j in next,g.FontObjects do
j.FontFace=Font.new(h,j.FontFace.Weight,j.FontFace.Style)
end
end

function g.GetThemeProperty(h,i)
return i[h]or g.Themes.Dark[h]
end

function g.AddThemeObject(h,i)
g.Objects[h]={Object=h,Properties=i}
g.UpdateTheme(h,false)
return h
end

function g.UpdateTheme(h,i)
local function ApplyTheme(j)
for k,l in pairs(j.Properties or{})do
local m=g.GetThemeProperty(l,g.Theme)
if m then
if not i then
j.Object[k]=Color3.fromHex(m)
else
g.Tween(j.Object,0.08,{[k]=Color3.fromHex(m)}):Play()
end
end
end
end

if h then
local j=g.Objects[h]
if j then
ApplyTheme(j)
end
else
for j,k in pairs(g.Objects)do
ApplyTheme(k)
end
end
end

function g.Icon(h)
return f.Icon(h)
end

function g.New(h,i,j)
local k=Instance.new(h)

for l,m in next,g.DefaultProperties[h]or{}do
k[l]=m
end

for n,o in next,i or{}do
if n~="ThemeTag"then
k[n]=o
end
end

for p,q in next,j or{}do
q.Parent=k
end

if i and i.ThemeTag then
g.AddThemeObject(k,i.ThemeTag)
end
if i and i.FontFace then
g.AddFontObject(k)
end
return k
end

function g.Tween(h,i,j,...)
return e:Create(h,TweenInfo.new(i,...),j)
end

function g.NewRoundFrame(h,i,j,k,n)






local o=g.New(n and"ImageButton"or"ImageLabel",{
Image=i=="Squircle"and"rbxassetid://80999662900595"
or i=="SquircleOutline"and"rbxassetid://117788349049947"
or i=="SquircleOutline2"and"rbxassetid://117817408534198"
or i=="Shadow-sm"and"rbxassetid://84825982946844"
or i=="Squircle-TL-TR"and"rbxassetid://73569156276236",
ScaleType="Slice",
SliceCenter=i~="Shadow-sm"and Rect.new(256
,256
,256
,256

)or Rect.new(512,512,512,512),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=j.ThemeTag and j.ThemeTag
},k)

for p,q in pairs(j or{})do
if p~="ThemeTag"then
o[p]=q
end
end

local function UpdateSliceScale(r)
local s=i~="Shadow-sm"and(r/(256))or(r/512)
o.SliceScale=s
end

UpdateSliceScale(h)

return o
end

local h=g.New local i=
g.Tween

function g.SetDraggable(j)
g.CanDraggable=j
end

function g.Drag(j,k,n)
local o
local p,q,r,s
local t={
CanDraggable=true
}

if not k or type(k)~="table"then
k={j}
end

local function update(u)
local v=u.Position-r
g.Tween(j,0.02,{Position=UDim2.new(
s.X.Scale,s.X.Offset+v.X,
s.Y.Scale,s.Y.Offset+v.Y
)}):Play()
end

for u,v in pairs(k)do
v.InputBegan:Connect(function(w)
if(w.UserInputType==Enum.UserInputType.MouseButton1 or w.UserInputType==Enum.UserInputType.Touch)and t.CanDraggable then
if o==nil then
o=v
p=true
r=w.Position
s=j.Position

if n and type(n)=="function"then
n(true,o)
end

w.Changed:Connect(function()
if w.UserInputState==Enum.UserInputState.End then
p=false
o=nil

if n and type(n)=="function"then
n(false,o)
end
end
end)
end
end
end)

v.InputChanged:Connect(function(w)
if o==v and p then
if w.UserInputType==Enum.UserInputType.MouseMovement or w.UserInputType==Enum.UserInputType.Touch then
q=w
end
end
end)
end

d.InputChanged:Connect(function(w)
if w==q and p and o~=nil then
if t.CanDraggable then
update(w)
end
end
end)

function t.Set(w,x)
t.CanDraggable=x
end

return t
end

function g.Image(j,k,n,o,p,q,r)
local function SanitizeFilename(s)
s=s:gsub("[%s/\\:*?\"<>|]+","-")
s=s:gsub("[^%w%-_%.]","")
return s
end

o=o or"Temp"
k=SanitizeFilename(k)

local s=h("Frame",{
Size=UDim2.new(0,0,0,0),

BackgroundTransparency=1,
},{
h("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(g.Icon(j)or r)and{
ImageColor3=q and"Icon"
}or nil,
},{
h("UICorner",{
CornerRadius=UDim.new(0,n)
})
})
})
if g.Icon(j)then
s.ImageLabel.Image=g.Icon(j)[1]
s.ImageLabel.ImageRectOffset=g.Icon(j)[2].ImageRectPosition
s.ImageLabel.ImageRectSize=g.Icon(j)[2].ImageRectSize
end
if string.find(j,"http")then
local t="WindUI/"..o.."/Assets/."..p.."-"..k..".png"
local u,v=pcall(function()
task.spawn(function()
if not isfile(t)then
local u=g.Request{
Url=j,
Method="GET",
}.Body

writefile(t,u)
end
s.ImageLabel.Image=getcustomasset(t)
end)
end)
if not u then
warn("[ WindUI.Creator ]  '"..identifyexecutor().."' doesnt support the URL Images. Error: "..v)

s:Destroy()
end
elseif string.find(j,"rbxassetid")then
s.ImageLabel.Image=j
end

return s
end

return g end function a.b()
return{
Dark={
Name="Dark",
Accent="#18181b",
Dialog="#18181b",
Outline="#FFFFFF",
Text="#FFFFFF",
Placeholder="#999999",
Background="#101010",
Button="#52525b",
Icon="#a1a1aa",
},
Light={
Name="Light",
Accent="#FFFFFF",
Dialog="#f4f4f5",
Outline="#09090b",
Text="#000000",
Placeholder="#777777",
Background="#e4e4e7",
Button="#18181b",
Icon="#52525b",
},
Rose={
Name="Rose",
Accent="#f43f5e",
Outline="#ffe4e6",
Text="#ffe4e6",
Placeholder="#fda4af",
Background="#881337",
Button="#e11d48",
Icon="#fecdd3",
},
Plant={
Name="Plant",
Accent="#22c55e",
Outline="#dcfce7",
Text="#dcfce7",
Placeholder="#bbf7d0",
Background="#14532d",
Button="#22c55e",
Icon="#86efac",
},
Red={
Name="Red",
Accent="#ef4444",
Outline="#fee2e2",
Text="#ffe4e6",
Placeholder="#fca5a5",
Background="#7f1d1d",
Button="#ef4444",
Icon="#fecaca",
},
Indigo={
Name="Indigo",
Accent="#6366f1",
Outline="#e0e7ff",
Text="#e0e7ff",
Placeholder="#a5b4fc",
Background="#312e81",
Button="#6366f1",
Icon="#c7d2fe",
},
Sky={
Name="Sky",
Accent="#0ea5e9",
Outline="#e0f2fe",
Text="#e0f2fe",
Placeholder="#7dd3fc",
Background="#075985",
Button="#0ea5e9",
Icon="#bae6fd",
},
Violet={
Name="Violet",
Accent="#8b5cf6",
Outline="#ede9fe",
Text="#ede9fe",
Placeholder="#c4b5fd",
Background="#4c1d95",
Button="#8b5cf6",
Icon="#ddd6fe",
},
Amber={
Name="Amber",
Accent="#f59e0b",
Outline="#fef3c7",
Text="#fef3c7",
Placeholder="#fcd34d",
Background="#78350f",
Button="#f59e0b",
Icon="#fde68a",
},
Emerald={
Name="Emerald",
Accent="#10b981",
Outline="#d1fae5",
Text="#d1fae5",
Placeholder="#6ee7b7",
Background="#064e3b",
Button="#10b981",
Icon="#a7f3d0",
},
}end function a.c()
local b={}

local d=a.load'a'
local e=d.New
local f=d.Tween


function b.New(g,h,i,j,k,n,o)
j=j or"Primary"
local p=not o and 10 or 99
local q
if h and h~=""then
q=e("ImageLabel",{
Image=d.Icon(h)[1],
ImageRectSize=d.Icon(h)[2].ImageRectSize,
ImageRectOffset=d.Icon(h)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local r=e("TextButton",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=k,
BackgroundTransparency=1
},{
d.NewRoundFrame(p,"Squircle",{
ThemeTag={
ImageColor3=j~="White"and"Button"or nil,
},
ImageColor3=j=="White"and Color3.new(1,1,1)or nil,
Size=UDim2.new(1,0,1,0),
Name="Squircle",
ImageTransparency=j=="Primary"and 0 or j=="White"and 0 or 1
}),

d.NewRoundFrame(p,"Squircle",{



ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(1,0,1,0),
Name="Special",
ImageTransparency=j=="Secondary"and 0.95 or 1
}),

d.NewRoundFrame(p,"Shadow-sm",{



ImageColor3=Color3.new(0,0,0),
Size=UDim2.new(1,3,1,3),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Shadow",
ImageTransparency=j=="Secondary"and 0 or 1,
Visible=not o
}),

d.NewRoundFrame(p,not o and"SquircleOutline"or"SquircleOutline2",{
ThemeTag={
ImageColor3=j~="White"and"Outline"or nil,
},
Size=UDim2.new(1,0,1,0),
ImageColor3=j=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=j=="Primary"and.95 or.85,
Name="SquircleOutline",
}),

d.NewRoundFrame(p,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3=j~="White"and"Text"or nil
},
ImageColor3=j=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=1
},{
e("UIPadding",{
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
}),
e("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
q,
e("TextLabel",{
BackgroundTransparency=1,
FontFace=Font.new(d.Font,Enum.FontWeight.SemiBold),
Text=g or"Button",
ThemeTag={
TextColor3=(j~="Primary"and j~="White")and"Text",
},
TextColor3=j=="Primary"and Color3.new(1,1,1)or j=="White"and Color3.new(0,0,0)or nil,
AutomaticSize="XY",
TextSize=18,
})
})
})

d.AddSignal(r.MouseEnter,function()
f(r.Frame,.047,{ImageTransparency=.95}):Play()
end)
d.AddSignal(r.MouseLeave,function()
f(r.Frame,.047,{ImageTransparency=1}):Play()
end)
d.AddSignal(r.MouseButton1Up,function()
if n then
n:Close()()
end
if i then
d.SafeCallback(i)
end
end)

return r
end


return b end function a.d()
local b={}

local d=a.load'a'
local e=d.New local f=
d.Tween


function b.New(g,h,i,j,k)
j=j or"Input"
local n=10
local o
if h and h~=""then
o=e("ImageLabel",{
Image=d.Icon(h)[1],
ImageRectSize=d.Icon(h)[2].ImageRectSize,
ImageRectOffset=d.Icon(h)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local p=j~="Input"

local q=e("TextBox",{
BackgroundTransparency=1,
TextSize=16,
FontFace=Font.new(d.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,o and-29 or 0,1,0),
PlaceholderText=g,
ClearTextOnFocus=false,
ClipsDescendants=true,
TextWrapped=p,
MultiLine=p,
TextXAlignment="Left",
TextYAlignment=j=="Input"and"Center"or"Top",

ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
})

local r=e("Frame",{
Size=UDim2.new(1,0,0,42),
Parent=i,
BackgroundTransparency=1
},{
e("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
d.NewRoundFrame(n,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
}),
d.NewRoundFrame(n,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.9,
}),
d.NewRoundFrame(n,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.95
},{
e("UIPadding",{
PaddingTop=UDim.new(0,j=="Input"and 0 or 12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,j=="Input"and 0 or 12),
}),
e("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment=j=="Input"and"Center"or"Top",
HorizontalAlignment="Left",
}),
o,
q,
})
})
})










d.AddSignal(q.FocusLost,function()
if k then
d.SafeCallback(k,q.Text)
end
end)

return r
end


return b end function a.e()
local b=a.load'a'
local d=b.New
local e=b.Tween

local f={
Holder=nil,
Window=nil,
Parent=nil,
}

function f.Init(g,h)
f.Window=g
f.Parent=h
return f
end

function f.Create(g)
local h={
UICorner=32,
UIPadding=12,
UIElements={}
}

if g then h.UIPadding=0 end
if g then h.UICorner=26 end

if not g then
h.UIElements.FullScreen=d("Frame",{
ZIndex=999,
BackgroundTransparency=1,
BackgroundColor3=Color3.fromHex"#000000",
Size=UDim2.new(1,0,1,0),
Active=false,
Visible=false,
Parent=f.Parent or(f.Window and f.Window.UIElements and f.Window.UIElements.Main and f.Window.UIElements.Main.Main)
},{
d("UICorner",{
CornerRadius=UDim.new(0,f.Window.UICorner)
})
})
end

h.UIElements.Main=d("Frame",{
Size=UDim2.new(0,280,0,0),
ThemeTag={
BackgroundColor3="Dialog",
},
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=false,
ZIndex=99999,
},{
d("UIPadding",{
PaddingTop=UDim.new(0,h.UIPadding),
PaddingLeft=UDim.new(0,h.UIPadding),
PaddingRight=UDim.new(0,h.UIPadding),
PaddingBottom=UDim.new(0,h.UIPadding),
})
})

h.UIElements.MainContainer=b.NewRoundFrame(h.UICorner,"Squircle",{
Visible=false,

ImageTransparency=g and 0.15 or 0,
Parent=g and f.Parent or h.UIElements.FullScreen,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
AutomaticSize="XY",
ThemeTag={
ImageColor3="Dialog"
},
ZIndex=9999,
},{





h.UIElements.Main,



b.NewRoundFrame(h.UICorner,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
ThemeTag={
ImageColor3="Outline",
},
},{
d("UIGradient",{
Rotation=45,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
})
})
})

function h.Open(i)
if not g then
h.UIElements.FullScreen.Visible=true
h.UIElements.FullScreen.Active=true
end

task.spawn(function()
h.UIElements.MainContainer.Visible=true

if not g then
e(h.UIElements.FullScreen,0.1,{BackgroundTransparency=.3}):Play()
end
e(h.UIElements.MainContainer,0.1,{ImageTransparency=0}):Play()


task.spawn(function()
task.wait(0.05)
h.UIElements.Main.Visible=true
end)
end)
end
function h.Close(i)
if not g then
e(h.UIElements.FullScreen,0.1,{BackgroundTransparency=1}):Play()
h.UIElements.FullScreen.Active=false
task.spawn(function()
task.wait(.1)
h.UIElements.FullScreen.Visible=false
end)
end
h.UIElements.Main.Visible=false

e(h.UIElements.MainContainer,0.1,{ImageTransparency=1}):Play()



task.spawn(function()
task.wait(.1)
if not g then
h.UIElements.FullScreen:Destroy()
else
h.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return h
end

return f end function a.f()
local b={}


local d=a.load'a'
local e=d.New local f=
d.Tween

local g=a.load'c'.New
local h=a.load'd'.New

function b.new(i,j,k)
local n=a.load'e'.Init(nil,i.WindUI.ScreenGui.KeySystem)
local o=n.Create(true)


local p

local q=200

local r=430
if i.KeySystem.Thumbnail and i.KeySystem.Thumbnail.Image then
r=430+(q/2)
end

o.UIElements.Main.AutomaticSize="Y"
o.UIElements.Main.Size=UDim2.new(0,r,0,0)

local s

if i.Icon then

s=d.Image(
i.Icon,
i.Title..":"..i.Icon,
0,
i.WindUI.Window,
"KeySystem",
i.IconThemed
)
s.Size=UDim2.new(0,24,0,24)
s.LayoutOrder=-1
end

local t=e("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=i.Title,
FontFace=Font.new(d.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20
})
local u=e("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text="Key System",
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
TextTransparency=1,
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
TextSize=16
})

local v=e("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
e("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
s,t
})

local w=e("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





v,u,
})

local x=h("Enter Key","key",nil,"Input",function(x)
p=x
end)

local y
if i.KeySystem.Note and i.KeySystem.Note~=""then
y=e("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=i.KeySystem.Note,
TextSize=18,
TextTransparency=.4,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
RichText=true
})
end

local z=e("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
e("Frame",{
BackgroundTransparency=1,
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
},{
e("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
})
})
})


local A
if i.KeySystem.Thumbnail and i.KeySystem.Thumbnail.Image then
local B
if i.KeySystem.Thumbnail.Title then
B=e("TextLabel",{
Text=i.KeySystem.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
A=e("ImageLabel",{
Image=i.KeySystem.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,q,1,0),
Parent=o.UIElements.Main,
ScaleType="Crop"
},{
B,
e("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

e("Frame",{

Size=UDim2.new(1,A and-q or 0,1,0),
Position=UDim2.new(0,A and q or 0,0,0),
BackgroundTransparency=1,
Parent=o.UIElements.Main
},{
e("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
e("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
w,
y,
x,
z,
e("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})





local B=g("Exit","log-out",function()
o:Close()()
end,"Tertiary",z.Frame)

if A then
B.Parent=A
B.Size=UDim2.new(0,0,0,42)
B.Position=UDim2.new(0,16,1,-16)
B.AnchorPoint=Vector2.new(0,1)
end

if i.KeySystem.URL then
g("Get key","key",function()
setclipboard(i.KeySystem.URL)
end,"Secondary",z.Frame)
end

local C=g("Submit","arrow-right",function()
local C=p
local D
if type(i.KeySystem.Key)=="table"then
D=table.find(i.KeySystem.Key,tostring(C))
else
D=tostring(i.KeySystem.Key)==tostring(C)
end

if D then
o:Close()()

if i.KeySystem.SaveKey then
local E=i.Folder or i.Title
writefile(E.."/"..j..".key",tostring(C))
end

task.wait(.4)
k(true)
end
end,"Primary",z)

C.AnchorPoint=Vector2.new(1,0.5)
C.Position=UDim2.new(1,0,0.5,0)










o:Open()
end

return b end function a.g()
local b=a.load'a'
local d=b.New
local e=b.Tween

local f={
Size=UDim2.new(0,300,1,-156),
SizeLower=UDim2.new(0,300,1,-56),
UICorner=16,
UIPadding=14,
ButtonPadding=9,
Holder=nil,
NotificationIndex=0,
Notifications={}
}

function f.Init(g)
local h={
Lower=false
}

function h.SetLower(i)
h.Lower=i
h.Frame.Size=i and f.SizeLower or f.Size
end

h.Frame=d("Frame",{
Position=UDim2.new(1,-29,0,56),
AnchorPoint=Vector2.new(1,0),
Size=f.Size,
Parent=g,
BackgroundTransparency=1,




},{
d("UIListLayout",{
HorizontalAlignment="Center",
SortOrder="LayoutOrder",
VerticalAlignment="Bottom",
Padding=UDim.new(0,8),
}),
d("UIPadding",{
PaddingBottom=UDim.new(0,29)
})
})
return h
end

function f.New(g)
local h={
Title=g.Title or"Notification",
Content=g.Content or nil,
Icon=g.Icon or nil,
IconThemed=g.IconThemed,
Background=g.Background,
BackgroundImageTransparency=g.BackgroundImageTransparency,
Duration=g.Duration or 5,
Buttons=g.Buttons or{},
CanClose=true,
UIElements={},
Closed=false,
}
if h.CanClose==nil then
h.CanClose=true
end
f.NotificationIndex=f.NotificationIndex+1
f.Notifications[f.NotificationIndex]=h

local i=d("UICorner",{
CornerRadius=UDim.new(0,f.UICorner),
})

local j=d("UIStroke",{
ThemeTag={
Color="Text"
},
Transparency=1,
Thickness=.6,
})

local k

if h.Icon then





















k=b.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.Window,
"Notification",
h.IconThemed
)
k.Size=UDim2.new(0,26,0,26)
k.Position=UDim2.new(0,f.UIPadding,0,f.UIPadding)

end

local n
if h.CanClose then
n=d("ImageButton",{
Image=b.Icon"x"[1],
ImageRectSize=b.Icon"x"[2].ImageRectSize,
ImageRectOffset=b.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
Size=UDim2.new(0,16,0,16),
Position=UDim2.new(1,-f.UIPadding,0,f.UIPadding),
AnchorPoint=Vector2.new(1,0),
ThemeTag={
ImageColor3="Text"
}
},{
d("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})
end

local o=d("Frame",{
Size=UDim2.new(1,0,0,3),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text",
},

})

local p=d("Frame",{
Size=UDim2.new(1,
h.Icon and-28-f.UIPadding or 0,
1,0),
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
AutomaticSize="Y",
},{
d("UIPadding",{
PaddingTop=UDim.new(0,f.UIPadding),
PaddingLeft=UDim.new(0,f.UIPadding),
PaddingRight=UDim.new(0,f.UIPadding),
PaddingBottom=UDim.new(0,f.UIPadding),
}),
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,-30-f.UIPadding,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Text"
},
Text=h.Title,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold)
}),
d("UIListLayout",{
Padding=UDim.new(0,f.UIPadding/3)
})
})

if h.Content then
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=15,
ThemeTag={
TextColor3="Text"
},
Text=h.Content,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
Parent=p
})
end


local q=d("CanvasGroup",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(2,0,1,0),
AnchorPoint=Vector2.new(0,1),
AutomaticSize="Y",
BackgroundTransparency=.25,
ThemeTag={
BackgroundColor3="Accent"
},

},{
d("ImageLabel",{
Name="Background",
Image=h.Background,
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ScaleType="Crop",
ImageTransparency=h.BackgroundImageTransparency

}),

j,i,
p,
k,n,
o,

})

local r=d("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=g.Holder
},{
q
})

function h.Close(s)
if not h.Closed then
h.Closed=true
e(r,0.45,{Size=UDim2.new(1,0,0,-8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(q,0.55,{Position=UDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
task.wait(.45)
r:Destroy()
end
end

task.spawn(function()
task.wait()
e(r,0.45,{Size=UDim2.new(
1,
0,
0,
q.AbsoluteSize.Y
)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(q,0.45,{Position=UDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if h.Duration then
e(o,h.Duration,{Size=UDim2.new(0,0,0,3)},Enum.EasingStyle.Linear,Enum.EasingDirection.InOut):Play()
task.wait(h.Duration)
h:Close()
end
end)

if n then
b.AddSignal(n.TextButton.MouseButton1Click,function()
h:Close()
end)
end


return h
end

return f end function a.h()
local b={}

local d=a.load'a'
local e=d.New local f=
d.Tween


function b.new(g)
local h={
Title=g.Title or"Dialog",
Content=g.Content,
Icon=g.Icon,
IconThemed=g.IconThemed,
Thumbnail=g.Thumbnail,
Buttons=g.Buttons
}

local i=a.load'e'.Init(nil,g.WindUI.ScreenGui.Popups)
local j=i.Create(true)

local k=200

local n=430
if h.Thumbnail and h.Thumbnail.Image then
n=430+(k/2)
end

j.UIElements.Main.AutomaticSize="Y"
j.UIElements.Main.Size=UDim2.new(0,n,0,0)



local o

if h.Icon then
o=d.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.WindUI.Window,
"Popup",
g.IconThemed
)
o.Size=UDim2.new(0,22,0,22)
o.LayoutOrder=-1
end


local p=e("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=h.Title,
TextXAlignment="Left",
FontFace=Font.new(d.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20
})

local q=e("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
e("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
o,p
})

local r=e("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





q,
})

local s
if h.Content and h.Content~=""then
s=e("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=h.Content,
TextSize=18,
TextTransparency=.2,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
RichText=true
})
end

local t=e("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
e("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
HorizontalAlignment="Right"
})
})

local u
if h.Thumbnail and h.Thumbnail.Image then
local v
if h.Thumbnail.Title then
v=e("TextLabel",{
Text=h.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
u=e("ImageLabel",{
Image=h.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,k,1,0),
Parent=j.UIElements.Main,
ScaleType="Crop"
},{
v,
e("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

e("Frame",{

Size=UDim2.new(1,u and-k or 0,1,0),
Position=UDim2.new(0,u and k or 0,0,0),
BackgroundTransparency=1,
Parent=j.UIElements.Main
},{
e("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
e("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
r,
s,
t,
e("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})

local v=a.load'c'.New

for w,x in next,h.Buttons do
v(x.Title,x.Icon,x.Callback,x.Variant,t,j)
end

j:Open()


return h
end

return b end function a.i()
local b={}

local d=a.load'a'
local e=d.New local f=
d.Tween


function b.New(g,h,i)
local j=10
local k
if h and h~=""then
k=e("ImageLabel",{
Image=d.Icon(h)[1],
ImageRectSize=d.Icon(h)[2].ImageRectSize,
ImageRectOffset=d.Icon(h)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local n=e("TextLabel",{
BackgroundTransparency=1,
TextSize=16,
FontFace=Font.new(d.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,k and-29 or 0,1,0),
TextXAlignment="Left",
ThemeTag={
TextColor3="Text",
},
Text=g,
})

local o=e("TextButton",{
Size=UDim2.new(1,0,0,42),
Parent=i,
BackgroundTransparency=1,
Text="",
},{
e("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
d.NewRoundFrame(j,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
}),
d.NewRoundFrame(j,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.9,
}),
d.NewRoundFrame(j,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.95
},{
e("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
e("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
k,
n,
})
})
})

return o
end


return b end function a.j()
local b={}

local d=game:GetService"UserInputService"

local e=a.load'a'
local f=e.New local g=
e.Tween


function b.New(h,i,j,k)
local n=f("Frame",{
Size=UDim2.new(0,k,1,0),
BackgroundTransparency=1,
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
Parent=i,
ZIndex=999,
Active=true,
})

local o=e.NewRoundFrame(k/2,"Squircle",{
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.85,
ThemeTag={ImageColor3="Text"},
Parent=n,
})

local p=f("Frame",{
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
ZIndex=999,
Parent=o,
})

local q=false
local r=0

local function updateSliderSize()
local s=h
local t=s.AbsoluteCanvasSize.Y
local u=s.AbsoluteWindowSize.Y

if t<=u then
o.Visible=false
return
end

local v=math.clamp(u/t,0.1,1)
o.Size=UDim2.new(1,0,v,0)
o.Visible=true
end

local function updateScrollingFramePosition()
local s=o.Position.Y.Scale
local t=h.AbsoluteCanvasSize.Y
local u=h.AbsoluteWindowSize.Y
local v=math.max(t-u,0)

if v<=0 then return end

local w=math.max(1-o.Size.Y.Scale,0)
if w<=0 then return end

local x=s/w

h.CanvasPosition=Vector2.new(
h.CanvasPosition.X,
x*v
)
end

local function updateThumbPosition()
if q then return end

local s=h.CanvasPosition.Y
local t=h.AbsoluteCanvasSize.Y
local u=h.AbsoluteWindowSize.Y
local v=math.max(t-u,0)

if v<=0 then
o.Position=UDim2.new(0,0,0,0)
return
end

local w=s/v
local x=math.max(1-o.Size.Y.Scale,0)
local y=math.clamp(w*x,0,x)

o.Position=UDim2.new(0,0,y,0)
end

e.AddSignal(n.InputBegan,function(s)
if(s.UserInputType==Enum.UserInputType.MouseButton1 or s.UserInputType==Enum.UserInputType.Touch)then
local t=o.AbsolutePosition.Y
local u=t+o.AbsoluteSize.Y

if not(s.Position.Y>=t and s.Position.Y<=u)then
local v=n.AbsolutePosition.Y
local w=n.AbsoluteSize.Y
local x=o.AbsoluteSize.Y

local y=s.Position.Y-v-x/2
local z=w-x

local A=math.clamp(y/z,0,1-o.Size.Y.Scale)

o.Position=UDim2.new(0,0,A,0)
updateScrollingFramePosition()
end
end
end)

e.AddSignal(p.InputBegan,function(s)
if s.UserInputType==Enum.UserInputType.MouseButton1 or s.UserInputType==Enum.UserInputType.Touch then
q=true
r=s.Position.Y-o.AbsolutePosition.Y

local t
local u

t=d.InputChanged:Connect(function(v)
if v.UserInputType==Enum.UserInputType.MouseMovement or v.UserInputType==Enum.UserInputType.Touch then
local w=n.AbsolutePosition.Y
local x=n.AbsoluteSize.Y
local y=o.AbsoluteSize.Y

local z=v.Position.Y-w-r
local A=x-y

local B=math.clamp(z/A,0,1-o.Size.Y.Scale)

o.Position=UDim2.new(0,0,B,0)
updateScrollingFramePosition()
end
end)

u=d.InputEnded:Connect(function(v)
if v.UserInputType==Enum.UserInputType.MouseButton1 or v.UserInputType==Enum.UserInputType.Touch then
q=false
if t then t:Disconnect()end
if u then u:Disconnect()end
end
end)
end
end)

e.AddSignal(h:GetPropertyChangedSignal"AbsoluteWindowSize",function()
updateSliderSize()
updateThumbPosition()
end)

e.AddSignal(h:GetPropertyChangedSignal"AbsoluteCanvasSize",function()
updateSliderSize()
updateThumbPosition()
end)

e.AddSignal(h:GetPropertyChangedSignal"CanvasPosition",function()
if not q then
updateThumbPosition()
end
end)

updateSliderSize()
updateThumbPosition()

return n
end


return b end function a.k()

local b=game:GetService"HttpService"

local d
d={
Window=nil,
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(e)
return{
__type=e.__type,
value=e.Default:ToHex(),
transparency=e.Transparency or nil,
}
end,
Load=function(e,f)
if e then
e:Update(Color3.fromHex(f.value),f.transparency or nil)
end
end
},
Dropdown={
Save=function(e)
return{
__type=e.__type,
value=e.Value,
}
end,
Load=function(e,f)
if e then
e:Select(f.value)
end
end
},
Input={
Save=function(e)
return{
__type=e.__type,
value=e.Value,
}
end,
Load=function(e,f)
if e then
e:Set(f.value)
end
end
},
Keybind={
Save=function(e)
return{
__type=e.__type,
value=e.Value,
}
end,
Load=function(e,f)
if e then
e:Set(f.value)
end
end
},
Slider={
Save=function(e)
return{
__type=e.__type,
value=e.Value.Default,
}
end,
Load=function(e,f)
if e then
e:Set(f.value)
end
end
},
Toggle={
Save=function(e)
return{
__type=e.__type,
value=e.Value,
}
end,
Load=function(e,f)
if e then
e:Set(f.value)
end
end
},
}
}

function d.Init(e,f)
if not f.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."

return false
end

d.Window=f
d.Folder=f.Folder
d.Path="WindUI/"..tostring(d.Folder).."/config/"

return d
end

function d.CreateConfig(e,f)
local g={
Path=d.Path..f..".json",

Elements={}
}

if not f then
return false,"No config file is selected"
end

function g.Register(h,i,j)
g.Elements[i]=j
end

function g.Save(h)
local i={
Elements={}
}

for j,k in next,g.Elements do
if d.Parser[k.__type]then
i.Elements[tostring(j)]=d.Parser[k.__type].Save(k)
end
end

print(b:JSONEncode(i))

writefile(g.Path,b:JSONEncode(i))
end

function g.Load(h)
if not isfile(g.Path)then return false,"Invalid file"end

local i=b:JSONDecode(readfile(g.Path))

for j,k in next,i.Elements do
if g.Elements[j]and d.Parser[k.__type]then
task.spawn(function()
d.Parser[k.__type].Load(g.Elements[j],k)
end)
end
end

end


d.Configs[f]=g

return g
end

function d.AllConfigs(e)
if listfiles then
local f={}
for g,h in next,listfiles(d.Path)do
local i=h:match"([^\\/]+)%.json$"
if i then
table.insert(f,i)
end
end

return f
end
return false
end

return d end function a.l()
local b={}

local d=a.load'a'
local e=d.New
local f=d.Tween

local g=game:GetService"UserInputService"


function b.New(h)
local i={
Button=nil
}

local j













local k=e("TextLabel",{
Text=h.Title,
TextSize=17,
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
})

local n=e("Frame",{
Size=UDim2.new(0,36,0,36),
BackgroundTransparency=1,
Name="Drag",
},{
e("ImageLabel",{
Image=d.Icon"move"[1],
ImageRectOffset=d.Icon"move"[2].ImageRectPosition,
ImageRectSize=d.Icon"move"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
})
})
local o=e("Frame",{
Size=UDim2.new(0,1,1,0),
Position=UDim2.new(0,36,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=.9,
})

local p=e("Frame",{
Size=UDim2.new(0,0,0,0),
Position=UDim2.new(0.5,0,0,28),
AnchorPoint=Vector2.new(0.5,0.5),
Parent=h.Parent,
BackgroundTransparency=1,
Active=true,
Visible=false,
})
local q=e("TextButton",{
Size=UDim2.new(0,0,0,44),
AutomaticSize="X",
Parent=p,
Active=false,
BackgroundTransparency=.25,
ZIndex=99,
BackgroundColor3=Color3.new(0,0,0),
},{



e("UICorner",{
CornerRadius=UDim.new(1,0)
}),
e("UIStroke",{
Thickness=1,
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=0,
},{
e("UIGradient",{
Color=ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff")
})
}),
n,
o,

e("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),

e("TextButton",{
AutomaticSize="XY",
Active=true,
BackgroundTransparency=1,
Size=UDim2.new(0,0,0,36),

BackgroundColor3=Color3.new(1,1,1),
},{
e("UICorner",{
CornerRadius=UDim.new(1,-4)
}),
j,
e("UIListLayout",{
Padding=UDim.new(0,h.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
k,
e("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
}),
e("UIPadding",{
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
})
})

i.Button=q



function i.SetIcon(r,s)
if j then
j:Destroy()
end
if s then
j=d.Image(
s,
h.Title,
0,
h.Folder,
"OpenButton",
true,
h.IconThemed
)
j.Size=UDim2.new(0,22,0,22)
j.LayoutOrder=-1
j.Parent=i.Button.TextButton
end
end

if h.Icon then
i:SetIcon(h.Icon)
end



d.AddSignal(q:GetPropertyChangedSignal"AbsoluteSize",function()
p.Size=UDim2.new(
0,q.AbsoluteSize.X,
0,q.AbsoluteSize.Y
)
end)

d.AddSignal(q.TextButton.MouseEnter,function()
f(q.TextButton,.1,{BackgroundTransparency=.93}):Play()
end)
d.AddSignal(q.TextButton.MouseLeave,function()
f(q.TextButton,.1,{BackgroundTransparency=1}):Play()
end)

local r=d.Drag(p)


function i.Visible(s,t)
p.Visible=t
end

function i.Edit(s,t)
local u={
Title=t.Title,
Icon=t.Icon,
Enabled=t.Enabled,
Position=t.Position,
Draggable=t.Draggable,
OnlyMobile=t.OnlyMobile,
CornerRadius=t.CornerRadius or UDim.new(1,0),
StrokeThickness=t.StrokeThickness or 2,
Color=t.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if u.Enabled==false then
h.IsOpenButtonEnabled=false
end
if u.Draggable==false and n and o then
n.Visible=u.Draggable
o.Visible=u.Draggable

if r then
r:Set(u.Draggable)
end
end
if u.Position and OpenButtonContainer then
OpenButtonContainer.Position=u.Position

end

local v=g.KeyboardEnabled or not g.TouchEnabled
b.Visible=not u.OnlyMobile or not v

if not b.Visible then return end

if k then
if u.Title then
k.Text=u.Title
elseif u.Title==nil then

end
end

if u.Icon then
i:SetIcon(u.Icon)
end

q.UIStroke.UIGradient.Color=u.Color
if Glow then
Glow.UIGradient.Color=u.Color
end

q.UICorner.CornerRadius=u.CornerRadius
q.TextButton.UICorner.CornerRadius=UDim.new(u.CornerRadius.Scale,u.CornerRadius.Offset-4)
q.UIStroke.Thickness=u.StrokeThickness
end

return i
end



return b end function a.m()
local b={}

local d=a.load'a'
local e=d.New
local f=d.Tween


function b.New(g,h)
local i={
Container=nil,
ToolTipSize=16,
}

local j=e("TextLabel",{
AutomaticSize="XY",
TextWrapped=true,
BackgroundTransparency=1,
FontFace=Font.new(d.Font,Enum.FontWeight.Medium),
Text=g,
TextSize=17,
ThemeTag={
TextColor3="Text",
}
})

local k=e("UIScale",{
Scale=.9
})

local n=e("CanvasGroup",{
AnchorPoint=Vector2.new(0.5,0),
AutomaticSize="XY",
BackgroundTransparency=1,
Parent=h,
GroupTransparency=1,
Visible=false
},{
e("UISizeConstraint",{
MaxSize=Vector2.new(400,math.huge)
}),
e("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
LayoutOrder=99,
Visible=false
},{
e("ImageLabel",{
Size=UDim2.new(0,i.ToolTipSize,0,i.ToolTipSize/2),
BackgroundTransparency=1,
Rotation=180,
Image="rbxassetid://89524607682719",
ThemeTag={
ImageColor3="Accent",
},
},{
e("ImageLabel",{
Size=UDim2.new(0,i.ToolTipSize,0,i.ToolTipSize/2),
BackgroundTransparency=1,
LayoutOrder=99,
ImageTransparency=.9,
Image="rbxassetid://89524607682719",
ThemeTag={
ImageColor3="Text",
},
}),
}),
}),
e("Frame",{
AutomaticSize="XY",
ThemeTag={
BackgroundColor3="Accent",
},

},{
e("UICorner",{
CornerRadius=UDim.new(0,16),
}),
e("Frame",{
ThemeTag={
BackgroundColor3="Text",
},
AutomaticSize="XY",
BackgroundTransparency=.9,
},{
e("UICorner",{
CornerRadius=UDim.new(0,16),
}),
e("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),

j,
e("UIPadding",{
PaddingTop=UDim.new(0,12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,12),
}),
})
}),
k,
e("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})
i.Container=n

function i.Open(o)
n.Visible=true

f(n,.16,{GroupTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(k,.18,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

function i.Close(o)
f(n,.2,{GroupTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(k,.2,{Scale=.9},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(.25)

n.Visible=false
n:Destroy()
end

return i
end


return b end function a.n()
local b=a.load'a'
local d=b.New
local e=b.NewRoundFrame
local f=b.Tween

game:GetService"UserInputService"


return function(g)
local h={
Title=g.Title,
Desc=g.Desc or nil,
Hover=g.Hover,
Thumbnail=g.Thumbnail,
ThumbnailSize=g.ThumbnailSize or 80,
Image=g.Image,
IconThemed=g.IconThemed or false,
ImageSize=g.ImageSize or 30,
Color=g.Color,
Scalable=g.Scalable,
Parent=g.Parent,
UIPadding=14,
UICorner=14,
UIElements={}
}

local i=h.ImageSize
local j=h.ThumbnailSize
local k=true


local n=0

local o
local p
if h.Thumbnail then
o=b.Image(
h.Thumbnail,
h.Title,
h.UICorner-3,
g.Window.Folder,
"Thumbnail",
false,
h.IconThemed
)
o.Size=UDim2.new(1,0,0,j)
end
if h.Image then
p=b.Image(
h.Image,
h.Title,
h.UICorner-3,
g.Window.Folder,
"Image",
h.Color and true or false
)
if h.Color=="White"then
p.ImageLabel.ImageColor3=Color3.new(0,0,0)
elseif h.Color then
p.ImageLabel.ImageColor3=Color3.new(1,1,1)
end
p.Size=UDim2.new(0,i,0,i)

n=i
end

local function CreateText(q,r)
return d("TextLabel",{
BackgroundTransparency=1,
Text=q or"",
TextSize=r=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not h.Color and(r=="Desc"and"Icon"or"Text")or nil,
},
TextColor3=h.Color and(h.Color=="White"and Color3.new(0,0,0)or h.Color~="White"and Color3.new(1,1,1))or nil,
TextTransparency=h.Color and(r=="Desc"and.3 or 0),
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(b.Font,Enum.FontWeight.Medium)
})
end

local q=CreateText(h.Title,"Title")
local r=CreateText(h.Desc,"Desc")
if not h.Desc or h.Desc==""then
r.Visible=false
end

h.UIElements.Container=d("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
d("UIListLayout",{
Padding=UDim.new(0,h.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
o,
d("Frame",{
Size=UDim2.new(1,-g.TextOffset,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
d("UIListLayout",{
Padding=UDim.new(0,h.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
p,
d("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,-n,0,(50-(h.UIPadding*2)))
},{
d("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
q,
r
}),
})
})

h.UIElements.Locked=e(h.UICorner,"Squircle",{
Size=UDim2.new(1,h.UIPadding*2,1,h.UIPadding*2),
ImageTransparency=.4,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
ZIndex=9999999,
})

h.UIElements.Main=e(h.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,50),
AutomaticSize="Y",
ImageTransparency=h.Color and.1 or.95,



Parent=g.Parent,
ThemeTag={
ImageColor3=not h.Color and"Text"or nil
},
ImageColor3=h.Color and Color3.fromHex(b.Colors[h.Color])or nil
},{
h.UIElements.Container,
h.UIElements.Locked,
d("UIPadding",{
PaddingTop=UDim.new(0,h.UIPadding),
PaddingLeft=UDim.new(0,h.UIPadding),
PaddingRight=UDim.new(0,h.UIPadding),
PaddingBottom=UDim.new(0,h.UIPadding),
}),
},true)

if h.Hover then
b.AddSignal(h.UIElements.Main.MouseEnter,function()
if k then
f(h.UIElements.Main,.05,{ImageTransparency=h.Color and.15 or.9}):Play()
end
end)
b.AddSignal(h.UIElements.Main.InputEnded,function()
if k then
f(h.UIElements.Main,.05,{ImageTransparency=h.Color and.1 or.95}):Play()
end
end)
end

function h.SetTitle(s,t)
q.Text=t
end

function h.SetDesc(s,t)
r.Text=t or""
if not t then
r.Visible=false
elseif not r.Visible then
r.Visible=true
end
end






function h.Destroy(s)
h.UIElements.Main:Destroy()
end


function h.Lock(s)
k=false
h.UIElements.Locked.Active=true
h.UIElements.Locked.Visible=true
end

function h.Unlock(s)
k=true
h.UIElements.Locked.Active=false
h.UIElements.Locked.Visible=false
end





return h
end end function a.o()
local b=a.load'a'
local d=b.New

local e={}

function e.New(f,g)
local h={
__type="Button",
Title=g.Title or"Button",
Desc=g.Desc or nil,
Locked=g.Locked or false,
Callback=g.Callback or function()end,
UIElements={}
}

local i=true

h.ButtonFrame=a.load'n'{
Title=h.Title,
Desc=h.Desc,
Parent=g.Parent,




Window=g.Window,
TextOffset=20,
Hover=true,
Scalable=true,
}

h.UIElements.ButtonIcon=d("ImageLabel",{
Image=b.Icon"mouse-pointer-click"[1],
ImageRectOffset=b.Icon"mouse-pointer-click"[2].ImageRectPosition,
ImageRectSize=b.Icon"mouse-pointer-click"[2].ImageRectSize,
BackgroundTransparency=1,
Parent=h.ButtonFrame.UIElements.Main,
Size=UDim2.new(0,20,0,20),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
ThemeTag={
ImageColor3="Text"
}
})

function h.Lock(j)
i=false
return h.ButtonFrame:Lock()
end
function h.Unlock(j)
i=true
return h.ButtonFrame:Unlock()
end

if h.Locked then
h:Lock()
end

b.AddSignal(h.ButtonFrame.UIElements.Main.MouseButton1Click,function()
if i then
task.spawn(function()
b.SafeCallback(h.Callback)
end)
end
end)
return h.__type,h
end

return e end function a.p()
local b={}

local d=a.load'a'
local e=d.New
local f=d.Tween


function b.New(g,h,i,j)
local k={}


local n=13
local o
if h and h~=""then
o=e("ImageLabel",{
Size=UDim2.new(1,-7,1,-7),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=d.Icon(h)[1],
ImageRectOffset=d.Icon(h)[2].ImageRectPosition,
ImageRectSize=d.Icon(h)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
})
end

local p=d.NewRoundFrame(n,"Squircle",{
ImageTransparency=.95,
ThemeTag={
ImageColor3="Text"
},
Parent=i,
Size=UDim2.new(0,42,0,26),
},{
d.NewRoundFrame(n,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Button",
},
ImageTransparency=1,
}),
d.NewRoundFrame(n,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
},{
e("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
}
})
}),


d.NewRoundFrame(n,"Squircle",{
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(0,3,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=0,
ImageColor3=Color3.new(1,1,1),
Name="Frame",
},{
o,
})
})

function k.Set(q,r)
if r then
f(p.Frame,0.1,{
Position=UDim2.new(1,-22,0.5,0),

},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(p.Layer,0.1,{
ImageTransparency=0,
}):Play()
f(p.Stroke,0.1,{
ImageTransparency=0.95,
}):Play()

if o then
f(o,0.1,{
ImageTransparency=0,
}):Play()
end
else
f(p.Frame,0.1,{
Position=UDim2.new(0,4,0.5,0),
Size=UDim2.new(0,18,0,18),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(p.Layer,0.1,{
ImageTransparency=1,
}):Play()
f(p.Stroke,0.1,{
ImageTransparency=1,
}):Play()

if o then
f(o,0.1,{
ImageTransparency=1,
}):Play()
end
end

task.spawn(function()
if j then
d.SafeCallback(j,r)
end
end)


end

return p,k
end


return b end function a.q()
local b={}

local d=a.load'a'
local e=d.New
local f=d.Tween


function b.New(g,h,i,j)
local k={}

h=h or"check"

local n=10
local o=e("ImageLabel",{
Size=UDim2.new(1,-10,1,-10),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=d.Icon(h)[1],
ImageRectOffset=d.Icon(h)[2].ImageRectPosition,
ImageRectSize=d.Icon(h)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(1,1,1),
})

local p=d.NewRoundFrame(n,"Squircle",{
ImageTransparency=.95,
ThemeTag={
ImageColor3="Text"
},
Parent=i,
Size=UDim2.new(0,27,0,27),
},{
d.NewRoundFrame(n,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Button",
},
ImageTransparency=1,
}),
d.NewRoundFrame(n,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
},{
e("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
}
})
}),

o,
})

function k.Set(q,r)
if r then
f(p.Layer,0.06,{
ImageTransparency=0,
}):Play()
f(p.Stroke,0.06,{
ImageTransparency=0.95,
}):Play()
f(o,0.06,{
ImageTransparency=0,
}):Play()
else
f(p.Layer,0.05,{
ImageTransparency=1,
}):Play()
f(p.Stroke,0.05,{
ImageTransparency=1,
}):Play()
f(o,0.06,{
ImageTransparency=1,
}):Play()
end

task.spawn(function()
if j then
d.SafeCallback(j,r)
end
end)
end

return p,k
end


return b end function a.r()
local b=a.load'a'local d=
b.New local e=
b.Tween

local f=a.load'p'.New
local g=a.load'q'.New

local h={}

function h.New(i,j)
local k={
__type="Toggle",
Title=j.Title or"Toggle",
Desc=j.Desc or nil,
Value=j.Value,
Icon=j.Icon or nil,
Type=j.Type or"Toggle",
Callback=j.Callback or function()end,
UIElements={}
}
k.ToggleFrame=a.load'n'{
Title=k.Title,
Desc=k.Desc,




Window=j.Window,
Parent=j.Parent,
TextOffset=44,
Hover=false,
}

local n=true

if k.Value==nil then
k.Value=false
end



function k.Lock(o)
n=false
return k.ToggleFrame:Lock()
end
function k.Unlock(o)
n=true
return k.ToggleFrame:Unlock()
end

if k.Locked then
k:Lock()
end

local o=k.Value

local p,q
if k.Type=="Toggle"then
p,q=f(o,k.Icon,k.ToggleFrame.UIElements.Main,k.Callback)
elseif k.Type=="Checkbox"then
p,q=g(o,k.Icon,k.ToggleFrame.UIElements.Main,k.Callback)
else
error("Unknown Toggle Type: "..tostring(k.Type))
end

p.AnchorPoint=Vector2.new(1,0.5)
p.Position=UDim2.new(1,0,0.5,0)

function k.Set(r,s)
if n then
q:Set(s)
o=s
k.Value=s
end
end

k:Set(o)

b.AddSignal(k.ToggleFrame.UIElements.Main.MouseButton1Click,function()
k:Set(not o)
end)

return k.__type,k
end

return h end function a.s()
local b=a.load'a'
local e=b.New
local f=b.Tween

local g={}

local h=false

function g.New(i,j)
local k={
__type="Slider",
Title=j.Title or"Slider",
Desc=j.Desc or nil,
Locked=j.Locked or nil,
Value=j.Value or{},
Step=j.Step or 1,
Callback=j.Callback or function()end,
UIElements={},
IsFocusing=false,
}
local n
local o
local p
local q=k.Value.Default or k.Value.Min or 0

local r=q
local s=(q-(k.Value.Min or 0))/((k.Value.Max or 100)-(k.Value.Min or 0))

local t=true
local u=k.Step%1~=0

local function FormatValue(v)
if u then
return string.format("%.2f",v)
else
return tostring(math.floor(v+0.5))
end
end

local function CalculateValue(v)
if u then
return math.floor(v/k.Step+0.5)*k.Step
else
return math.floor(v/k.Step+0.5)*k.Step
end
end

k.SliderFrame=a.load'n'{
Title=k.Title,
Desc=k.Desc,
Parent=j.Parent,
TextOffset=0,
Hover=false,
}

k.UIElements.SliderIcon=b.NewRoundFrame(99,"Squircle",{
ImageTransparency=.95,
Size=UDim2.new(1,-68,0,4),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
b.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(s,0,1,0),
ImageTransparency=.1,
ThemeTag={
ImageColor3="Button",
},
},{
b.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,13,0,13),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Text",
},
})
})
})

k.UIElements.SliderContainer=e("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Parent=k.SliderFrame.UIElements.Container,
},{
e("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
k.UIElements.SliderIcon,
e("TextBox",{
Size=UDim2.new(0,60,0,0),
TextXAlignment="Left",
Text=FormatValue(q),
ThemeTag={
TextColor3="Text"
},
TextTransparency=.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
})
})

function k.Lock(v)
t=false
return k.SliderFrame:Lock()
end
function k.Unlock(v)
t=true
return k.SliderFrame:Unlock()
end

if k.Locked then
k:Lock()
end

function k.Set(v,w,x)
if t then
if not k.IsFocusing and not h and(not x or(x.UserInputType==Enum.UserInputType.MouseButton1 or x.UserInputType==Enum.UserInputType.Touch))then
w=math.clamp(w,k.Value.Min or 0,k.Value.Max or 100)

local y=math.clamp((w-(k.Value.Min or 0))/((k.Value.Max or 100)-(k.Value.Min or 0)),0,1)
w=CalculateValue(k.Value.Min+y*(k.Value.Max-k.Value.Min))

if w~=r then
f(k.UIElements.SliderIcon.Frame,0.08,{Size=UDim2.new(y,0,1,0)}):Play()
k.UIElements.SliderContainer.TextBox.Text=FormatValue(w)
k.Value.Default=FormatValue(w)
r=w
b.SafeCallback(k.Callback,FormatValue(w))
end

if x then
n=(x.UserInputType==Enum.UserInputType.Touch)
k.SliderFrame.Parent.ScrollingEnabled=false
h=true
o=game:GetService"RunService".RenderStepped:Connect(function()
local z=n and x.Position.X or game:GetService"UserInputService":GetMouseLocation().X
local A=math.clamp((z-k.UIElements.SliderIcon.AbsolutePosition.X)/k.UIElements.SliderIcon.AbsoluteSize.X,0,1)
w=CalculateValue(k.Value.Min+A*(k.Value.Max-k.Value.Min))

if w~=r then
f(k.UIElements.SliderIcon.Frame,0.08,{Size=UDim2.new(A,0,1,0)}):Play()
k.UIElements.SliderContainer.TextBox.Text=FormatValue(w)
k.Value.Default=FormatValue(w)
r=w
b.SafeCallback(k.Callback,FormatValue(w))
end
end)
p=game:GetService"UserInputService".InputEnded:Connect(function(z)
if(z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch)and x==z then
o:Disconnect()
p:Disconnect()
h=false
k.SliderFrame.Parent.ScrollingEnabled=true
end
end)
end
end
end
end

b.AddSignal(k.UIElements.SliderContainer.TextBox.FocusLost,function(v)
if v then
local w=tonumber(k.UIElements.SliderContainer.TextBox.Text)
if w then
k:Set(w)
else
k.UIElements.SliderContainer.TextBox.Text=FormatValue(r)
end
end
end)

b.AddSignal(k.UIElements.SliderContainer.InputBegan,function(v)
k:Set(q,v)
end)

return k.__type,k
end

return g end function a.t()
local b=game:GetService"UserInputService"

local e=a.load'a'
local f=e.New local g=
e.Tween

local h={
UICorner=6,
UIPadding=8,
}

local i=a.load'i'.New

function h.New(j,k)
local n={
__type="Keybind",
Title=k.Title or"Keybind",
Desc=k.Desc or nil,
Locked=k.Locked or false,
Value=k.Value or"F",
Callback=k.Callback or function()end,
CanChange=k.CanChange or true,
Picking=false,
UIElements={},
}

local o=true

n.KeybindFrame=a.load'n'{
Title=n.Title,
Desc=n.Desc,
Parent=k.Parent,
TextOffset=85,
Hover=n.CanChange,
}

n.UIElements.Keybind=i(n.Value,nil,n.KeybindFrame.UIElements.Main)

n.UIElements.Keybind.Size=UDim2.new(
0,24
+n.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
n.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
n.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)

f("UIScale",{
Parent=n.UIElements.Keybind,
Scale=.85,
})

e.AddSignal(n.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",function()
n.UIElements.Keybind.Size=UDim2.new(
0,24
+n.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
end)

function n.Lock(p)
o=false
return n.KeybindFrame:Lock()
end
function n.Unlock(p)
o=true
return n.KeybindFrame:Unlock()
end

function n.Set(p,q)
n.Value=q
n.UIElements.Keybind.Frame.Frame.TextLabel.Text=q
end

if n.Locked then
n:Lock()
end

e.AddSignal(n.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if o then
if n.CanChange then
n.Picking=true
n.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."

task.wait(0.2)

local p
p=b.InputBegan:Connect(function(q)
local r

if q.UserInputType==Enum.UserInputType.Keyboard then
r=q.KeyCode.Name
elseif q.UserInputType==Enum.UserInputType.MouseButton1 then
r="MouseLeft"
elseif q.UserInputType==Enum.UserInputType.MouseButton2 then
r="MouseRight"
end

local s
s=b.InputEnded:Connect(function(t)
if t.KeyCode.Name==r or r=="MouseLeft"and t.UserInputType==Enum.UserInputType.MouseButton1 or r=="MouseRight"and t.UserInputType==Enum.UserInputType.MouseButton2 then
n.Picking=false

n.UIElements.Keybind.Frame.Frame.TextLabel.Text=r
n.Value=r

p:Disconnect()
s:Disconnect()
end
end)
end)
end
end
end)
e.AddSignal(b.InputBegan,function(p)
if o then
if p.KeyCode.Name==n.Value then
e.SafeCallback(n.Callback,p.KeyCode.Name)
end
end
end)
return n.__type,n
end

return h end function a.u()
local b=a.load'a'
local e=b.New local f=
b.Tween

local g={
UICorner=8,
UIPadding=8,
}local h=a.load'c'


.New
local i=a.load'd'.New

function g.New(j,k)
local n={
__type="Input",
Title=k.Title or"Input",
Desc=k.Desc or nil,
Type=k.Type or"Input",
Locked=k.Locked or false,
InputIcon=k.InputIcon or false,
Placeholder=k.Placeholder or"Enter Text...",
Value=k.Value or"",
Callback=k.Callback or function()end,
ClearTextOnFocus=k.ClearTextOnFocus or false,
UIElements={},
}

local o=true

n.InputFrame=a.load'n'{
Title=n.Title,
Desc=n.Desc,
Parent=k.Parent,
TextOffset=0,
Hover=false,
}

local p=i(n.Placeholder,n.InputIcon,n.InputFrame.UIElements.Container,n.Type,function(p)
n:Set(p)
end)
p.Size=UDim2.new(1,0,0,n.Type=="Input"and 42 or 148)

e("UIScale",{
Parent=p,
Scale=1,
})

function n.Lock(q)
o=false
return n.InputFrame:Lock()
end
function n.Unlock(q)
o=true
return n.InputFrame:Unlock()
end


function n.Set(q,r)
if o then
b.SafeCallback(n.Callback,r)

p.Frame.Frame.TextBox.Text=r
n.Value=r
end
end
function n.SetPlaceholder(q,r)
p.Frame.Frame.TextBox.PlaceholderText=r
n.Placeholder=r
end

n:Set(n.Value)

if n.Locked then
n:Lock()
end

return n.__type,n
end

return g end function a.v()
local b=game:GetService"UserInputService"
local e=game:GetService"Players".LocalPlayer:GetMouse()
local g=game:GetService"Workspace".CurrentCamera

local h=a.load'a'
local i=h.New
local j=h.Tween

local k=a.load'i'.New

local n={
UICorner=10,
UIPadding=12,
MenuCorner=15,
MenuPadding=5,
TabPadding=10,
}

function n.New(o,p)
local q={
__type="Dropdown",
Title=p.Title or"Dropdown",
Desc=p.Desc or nil,
Locked=p.Locked or false,
Values=p.Values or{},
MenuWidth=p.MenuWidth or 170,
Value=p.Value,
AllowNone=p.AllowNone,
Multi=p.Multi,
Callback=p.Callback or function()end,

UIElements={},

Opened=false,
Tabs={}
}

if q.Multi and not q.Value then
q.Value={}
end

local r=true

q.DropdownFrame=a.load'n'{
Title=q.Title,
Desc=q.Desc,
Parent=p.Parent,
TextOffset=0,
Hover=false,
}


q.UIElements.Dropdown=k("",nil,q.DropdownFrame.UIElements.Container)

q.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
q.UIElements.Dropdown.Frame.Frame.TextLabel.Size=UDim2.new(1,q.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

q.UIElements.Dropdown.Size=UDim2.new(1,0,0,40)






i("ImageLabel",{
Image=h.Icon"chevrons-up-down"[1],
ImageRectOffset=h.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=h.Icon"chevrons-up-down"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,-12,0.5,0),
ThemeTag={
ImageColor3="Icon"
},
AnchorPoint=Vector2.new(1,0.5),
Parent=q.UIElements.Dropdown.Frame
})

q.UIElements.UIListLayout=i("UIListLayout",{
Padding=UDim.new(0,n.MenuPadding),
FillDirection="Vertical"
})

q.UIElements.Menu=h.NewRoundFrame(n.MenuCorner,"Squircle",{
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=0.05,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
},{
i("UIPadding",{
PaddingTop=UDim.new(0,n.MenuPadding),
PaddingLeft=UDim.new(0,n.MenuPadding),
PaddingRight=UDim.new(0,n.MenuPadding),
PaddingBottom=UDim.new(0,n.MenuPadding),
}),
i("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),

ClipsDescendants=true
},{
i("UICorner",{
CornerRadius=UDim.new(0,n.MenuCorner-n.MenuPadding),
}),
i("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),
ScrollBarThickness=0,
ScrollingDirection="Y",
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
ScrollBarImageTransparency=1,
},{
q.UIElements.UIListLayout,
})
})
})

q.UIElements.MenuCanvas=i("Frame",{
Size=UDim2.new(0,q.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,

Parent=p.WindUI.DropdownGui,
AnchorPoint=Vector2.new(1,0),
},{
q.UIElements.Menu,






i("UISizeConstraint",{
MinSize=Vector2.new(170,0)
})
})

function q.Lock(s)
r=false
return q.DropdownFrame:Lock()
end
function q.Unlock(s)
r=true
return q.DropdownFrame:Unlock()
end

if q.Locked then
q:Lock()
end

local function RecalculateCanvasSize()
q.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=UDim2.fromOffset(0,q.UIElements.UIListLayout.AbsoluteContentSize.Y)
end

local function RecalculateListSize()
if#q.Values>10 then
q.UIElements.MenuCanvas.Size=UDim2.fromOffset(q.UIElements.MenuCanvas.AbsoluteSize.X,392)
else
q.UIElements.MenuCanvas.Size=UDim2.fromOffset(q.UIElements.MenuCanvas.AbsoluteSize.X,q.UIElements.UIListLayout.AbsoluteContentSize.Y+(n.MenuPadding*2))
end
end

function UpdatePosition()
local s=q.UIElements.Dropdown
local t=q.UIElements.MenuCanvas

local u=g.ViewportSize.Y-(s.AbsolutePosition.Y+s.AbsoluteSize.Y)-n.MenuPadding-54
local v=t.AbsoluteSize.Y+n.MenuPadding

local w=-54
if u<v then
w=v-u-54
end

t.Position=UDim2.new(
0,
s.AbsolutePosition.X+s.AbsoluteSize.X,
0,
s.AbsolutePosition.Y+s.AbsoluteSize.Y-w+n.MenuPadding
)
end



function q.Display(s)
local t=q.Values
local u=""

if q.Multi then
for v,w in next,t do
if table.find(q.Value,w)then
u=u..w..", "
end
end
u=u:sub(1,#u-2)
else
u=q.Value or""
end

q.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(u==""and"--"or u)
end

function q.Refresh(s,t)
for u,v in next,q.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not v:IsA"UIListLayout"then
v:Destroy()
end
end

q.Tabs={}

for w,x in next,t do

local y={
Name=x,
Selected=false,
UIElements={},
}
y.UIElements.TabItem=h.NewRoundFrame(n.MenuCorner-n.MenuPadding,"Squircle",{
Size=UDim2.new(1,0,0,34),

ImageTransparency=1,
Parent=q.UIElements.Menu.Frame.ScrollingFrame,

ImageColor3=Color3.new(1,1,1),

},{
h.NewRoundFrame(n.MenuCorner-n.MenuPadding,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
Name="Highlight",
},{
i("UIGradient",{
Rotation=80,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
i("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
i("UIPadding",{

PaddingLeft=UDim.new(0,n.TabPadding),
PaddingRight=UDim.new(0,n.TabPadding),

}),
i("UICorner",{
CornerRadius=UDim.new(0,n.MenuCorner-n.MenuPadding)
}),













i("TextLabel",{
Text=x,
TextXAlignment="Left",
FontFace=Font.new(h.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text"
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=.4,
AutomaticSize="Y",

Size=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
})
})
},true)


if q.Multi then
y.Selected=table.find(q.Value or{},y.Name)
else
y.Selected=q.Value==y.Name
end

if y.Selected then
y.UIElements.TabItem.ImageTransparency=.95
y.UIElements.TabItem.Highlight.ImageTransparency=.75


y.UIElements.TabItem.Frame.TextLabel.TextTransparency=0.05
end

q.Tabs[w]=y

q:Display()

local function Callback()
q:Display()
task.spawn(function()
h.SafeCallback(q.Callback,q.Value)
end)
end

h.AddSignal(y.UIElements.TabItem.MouseButton1Click,function()
if q.Multi then
if not y.Selected then
y.Selected=true
j(y.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
j(y.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()

j(y.UIElements.TabItem.Frame.TextLabel,0.1,{TextTransparency=0}):Play()
table.insert(q.Value,y.Name)
else
if not q.AllowNone and#q.Value==1 then
return
end
y.Selected=false
j(y.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
j(y.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()

j(y.UIElements.TabItem.Frame.TextLabel,0.1,{TextTransparency=.4}):Play()
for z,A in ipairs(q.Value)do
if A==y.Name then
table.remove(q.Value,z)
break
end
end
end
else
for z,A in next,q.Tabs do

j(A.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
j(A.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()

j(A.UIElements.TabItem.Frame.TextLabel,0.1,{TextTransparency=.5}):Play()
A.Selected=false
end
y.Selected=true
j(y.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
j(y.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()

j(y.UIElements.TabItem.Frame.TextLabel,0.1,{TextTransparency=0.05}):Play()
q.Value=y.Name
end
Callback()
end)

RecalculateCanvasSize()
RecalculateListSize()
end

local y=0
for z,A in next,q.Tabs do
if A.UIElements.TabItem.Frame.TextLabel then

local B=A.UIElements.TabItem.Frame.TextLabel.TextBounds.X
y=math.max(y,B)
end
end

q.UIElements.MenuCanvas.Size=UDim2.new(0,y+6+6+5+5+18+6+6,q.UIElements.MenuCanvas.Size.Y.Scale,q.UIElements.MenuCanvas.Size.Y.Offset)

end


q:Refresh(q.Values)

function q.Select(s,t)
if t then
q.Value=t
else
if q.Multi then
q.Value={}
else
q.Value=nil

end
end
q:Refresh(q.Values)
end


RecalculateListSize()

function q.Open(s)
if r then
q.UIElements.Menu.Visible=true
q.UIElements.MenuCanvas.Visible=true
q.UIElements.MenuCanvas.Active=true
q.UIElements.Menu.Size=UDim2.new(
1,0,
0,0
)
j(q.UIElements.Menu,0.1,{
Size=UDim2.new(
1,0,
1,0
)
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(.1)
q.Opened=true
end)




UpdatePosition()
end
end
function q.Close(s)
q.Opened=false

j(q.UIElements.Menu,0.25,{
Size=UDim2.new(
1,0,
0,0
)
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()


task.spawn(function()
task.wait(.2)
q.UIElements.Menu.Visible=false
end)

task.spawn(function()
task.wait(.25)
q.UIElements.MenuCanvas.Visible=false
q.UIElements.MenuCanvas.Active=false
end)
end

h.AddSignal(q.UIElements.Dropdown.MouseButton1Click,function()
q:Open()
end)

h.AddSignal(b.InputBegan,function(s)
if
s.UserInputType==Enum.UserInputType.MouseButton1
or s.UserInputType==Enum.UserInputType.Touch
then
local t,v=q.UIElements.MenuCanvas.AbsolutePosition,q.UIElements.MenuCanvas.AbsoluteSize
if
p.Window.CanDropdown
and q.Opened
and(e.X<t.X
or e.X>t.X+v.X
or e.Y<(t.Y-20-1)
or e.Y>t.Y+v.Y
)
then
q:Close()
end
end
end)

h.AddSignal(q.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition",UpdatePosition)

return q.__type,q
end

return n end function a.w()






local b={}
local e={
lua={
"and","break","or","else","elseif","if","then","until","repeat","while","do","for","in","end",
"local","return","function","export",
},
rbx={
"game","workspace","script","math","string","table","task","wait","select","next","Enum",
"tick","assert","shared","loadstring","tonumber","tostring","type",
"typeof","unpack","Instance","CFrame","Vector3","Vector2","Color3","UDim","UDim2","Ray","BrickColor",
"OverlapParams","RaycastParams","Axes","Random","Region3","Rect","TweenInfo",
"collectgarbage","not","utf8","pcall","xpcall","_G","setmetatable","getmetatable","os","pairs","ipairs"
},
operators={
"#","+","-","*","%","/","^","=","~","=","<",">",
}
}

local g={
numbers=Color3.fromHex"#FAB387",
boolean=Color3.fromHex"#FAB387",
operator=Color3.fromHex"#94E2D5",
lua=Color3.fromHex"#CBA6F7",
rbx=Color3.fromHex"#F38BA8",
str=Color3.fromHex"#A6E3A1",
comment=Color3.fromHex"#9399B2",
null=Color3.fromHex"#F38BA8",
call=Color3.fromHex"#89B4FA",
self_call=Color3.fromHex"#89B4FA",
local_property=Color3.fromHex"#CBA6F7",
}

local function createKeywordSet(h)
local i={}
for j,k in ipairs(h)do
i[k]=true
end
return i
end

local h=createKeywordSet(e.lua)
local i=createKeywordSet(e.rbx)
local j=createKeywordSet(e.operators)

local function getHighlight(k,n)
local o=k[n]

if g[o.."_color"]then
return g[o.."_color"]
end

if tonumber(o)then
return g.numbers
elseif o=="nil"then
return g.null
elseif o:sub(1,2)=="--"then
return g.comment
elseif j[o]then
return g.operator
elseif h[o]then
return g.lua
elseif i[o]then
return g.rbx
elseif o:sub(1,1)=="\""or o:sub(1,1)=="\'"then
return g.str
elseif o=="true"or o=="false"then
return g.boolean
end

if k[n+1]=="("then
if k[n-1]==":"then
return g.self_call
end

return g.call
end

if k[n-1]=="."then
if k[n-2]=="Enum"then
return g.rbx
end

return g.local_property
end
end

function b.run(k)
local n={}
local o=""

local p=false
local q=false
local r=false

for s=1,#k do
local t=k:sub(s,s)

if q then
if t=="\n"and not r then
table.insert(n,o)
table.insert(n,t)
o=""

q=false
elseif k:sub(s-1,s)=="]]"and r then
o..="]"

table.insert(n,o)
o=""

q=false
r=false
else
o=o..t
end
elseif p then
if t==p and k:sub(s-1,s-1)~="\\"or t=="\n"then
o=o..t
p=false
else
o=o..t
end
else
if k:sub(s,s+1)=="--"then
table.insert(n,o)
o="-"
q=true
r=k:sub(s+2,s+3)=="[["
elseif t=="\""or t=="\'"then
table.insert(n,o)
o=t
p=t
elseif j[t]then
table.insert(n,o)
table.insert(n,t)
o=""
elseif t:match"[%w_]"then
o=o..t
else
table.insert(n,o)
table.insert(n,t)
o=""
end
end
end

table.insert(n,o)

local s={}

for t,v in ipairs(n)do
local w=getHighlight(n,t)

if w then
local x=string.format("<font color = \"#%s\">%s</font>",w:ToHex(),v:gsub("<","&lt;"):gsub(">","&gt;"))

table.insert(s,x)
else
table.insert(s,v)
end
end

return table.concat(s)
end

return b end function a.x()
local b={}

local e=a.load'a'
local g=e.New
local h=e.Tween

local i=a.load'w'

function b.New(j,k,n,o,p)
local q={
Radius=12,
Padding=10
}

local r=g("TextLabel",{
Text="",
TextColor3=Color3.fromHex"#CDD6F4",
TextTransparency=0,
TextSize=14,
TextWrapped=false,
LineHeight=1.15,
RichText=true,
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
AutomaticSize="XY",
},{
g("UIPadding",{
PaddingTop=UDim.new(0,q.Padding+3),
PaddingLeft=UDim.new(0,q.Padding+3),
PaddingRight=UDim.new(0,q.Padding+3),
PaddingBottom=UDim.new(0,q.Padding+3),
})
})
r.Font="Code"

local s=g("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticCanvasSize="X",
ScrollingDirection="X",
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
},{
r
})

local t=g("TextButton",{
BackgroundTransparency=1,
Size=UDim2.new(0,30,0,30),
Position=UDim2.new(1,-q.Padding/2,0,q.Padding/2),
AnchorPoint=Vector2.new(1,0),
Visible=o and true or false,
},{
e.NewRoundFrame(q.Radius-4,"Squircle",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Button",
},{
g("UIScale",{
Scale=1,
}),
g("ImageLabel",{
Image=e.Icon"copy"[1],
ImageRectSize=e.Icon"copy"[2].ImageRectSize,
ImageRectOffset=e.Icon"copy"[2].ImageRectPosition,
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Size=UDim2.new(0,12,0,12),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.1,
})
})
})

e.AddSignal(t.MouseEnter,function()
h(t.Button,.05,{ImageTransparency=.95}):Play()
h(t.Button.UIScale,.05,{Scale=.9}):Play()
end)
e.AddSignal(t.InputEnded,function()
h(t.Button,.08,{ImageTransparency=1}):Play()
h(t.Button.UIScale,.08,{Scale=1}):Play()
end)

e.NewRoundFrame(q.Radius,"Squircle",{



ImageColor3=Color3.fromHex"#212121",
ImageTransparency=.035,
Size=UDim2.new(1,0,0,20+(q.Padding*2)),
AutomaticSize="Y",
Parent=n,
},{
e.NewRoundFrame(q.Radius,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.955,
}),
g("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
},{
e.NewRoundFrame(q.Radius,"Squircle-TL-TR",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.96,
Size=UDim2.new(1,0,0,20+(q.Padding*2)),
Visible=k and true or false
},{
g("ImageLabel",{
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Image="rbxassetid://132464694294269",



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.2,
}),
g("TextLabel",{
Text=k,



TextColor3=Color3.fromHex"#ffffff",
TextTransparency=.2,
TextSize=16,
AutomaticSize="Y",
FontFace=Font.new(e.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
BackgroundTransparency=1,
TextTruncate="AtEnd",
Size=UDim2.new(1,t and-20-(q.Padding*2),0,0)
}),
g("UIPadding",{

PaddingLeft=UDim.new(0,q.Padding+3),
PaddingRight=UDim.new(0,q.Padding+3),

}),
g("UIListLayout",{
Padding=UDim.new(0,q.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
s,
g("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
})
}),
t,
})

e.AddSignal(r:GetPropertyChangedSignal"TextBounds",function()
s.Size=UDim2.new(1,0,0,(r.TextBounds.Y/(p or 1))+((q.Padding+3)*2))
end)

function q.Set(v)
r.Text=i.run(v)
end

q.Set(j)

e.AddSignal(t.MouseButton1Click,function()
if o then
o()
local v=e.Icon"check"
t.Button.ImageLabel.Image=v[1]
t.Button.ImageLabel.ImageRectSize=v[2].ImageRectSize
t.Button.ImageLabel.ImageRectOffset=v[2].ImageRectPosition
end
end)
return q
end


return b end function a.y()
local b=a.load'a'local e=
b.New


local g=a.load'x'

local h={}

function h.New(i,j)
local k={
__type="Code",
Title=j.Title,
Code=j.Code,
UIElements={}
}

local n=not k.Locked











local o=g.New(k.Code,k.Title,j.Parent,function()
if n then
local o=k.Title or"code"
local p,q=pcall(function()
toclipboard(k.Code)
end)
if p then
j.WindUI:Notify{
Title="Success",
Content="The "..o.." copied to your clipboard.",
Icon="check",
Duration=5,
}
else
j.WindUI:Notify{
Title="Error",
Content="The "..o.." is not copied. Error: "..q,
Icon="x",
Duration=5,
}
end
end
end,j.WindUI.UIScale)

function k.SetCode(p,q)
o.Set(q)
end

return k.__type,k
end

return h end function a.z()
local b=a.load'a'
local e=b.New local g=
b.Tween

local h=game:GetService"UserInputService"
game:GetService"TouchInputService"
local i=game:GetService"RunService"
local j=game:GetService"Players"

local k=i.RenderStepped
local n=j.LocalPlayer
local o=n:GetMouse()

local p=a.load'c'.New
local q=a.load'd'.New

local r={
UICorner=8,
UIPadding=8
}

function r.Colorpicker(s,t,v)
local w={
__type="Colorpicker",
Title=t.Title,
Desc=t.Desc,
Default=t.Default,
Callback=t.Callback,
Transparency=t.Transparency,
UIElements=t.UIElements,
}

function w.SetHSVFromRGB(x,y)
local z,A,B=Color3.toHSV(y)
w.Hue=z
w.Sat=A
w.Vib=B
end

w:SetHSVFromRGB(w.Default)

local x=a.load'e'.Init(t.Window)
local y=x.Create()

w.ColorpickerFrame=y



local z,A,B=w.Hue,w.Sat,w.Vib

w.UIElements.Title=e("TextLabel",{
Text=w.Title,
TextSize=20,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=y.UIElements.Main
},{
e("UIPadding",{
PaddingTop=UDim.new(0,8),
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,8),
})
})





local C=e("ImageLabel",{
Size=UDim2.new(0,18,0,18),
ScaleType=Enum.ScaleType.Fit,
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Image="http://www.roblox.com/asset/?id=4805639000",
})

w.UIElements.SatVibMap=e("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(z,1,1),
BackgroundTransparency=0,
Parent=y.UIElements.Main,
},{
e("UICorner",{
CornerRadius=UDim.new(0,8),
}),
e("UIStroke",{
Thickness=.6,
ThemeTag={
Color="Text"
},
Transparency=.8,
}),
C,
})

w.UIElements.Inputs=e("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(w.Transparency and 240 or 210,40),
BackgroundTransparency=1,
Parent=y.UIElements.Main
},{
e("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection="Vertical",
})
})





local D=e("Frame",{
BackgroundColor3=w.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=w.Transparency,
},{
e("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

e("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(85,208),
Size=UDim2.fromOffset(75,24),
Parent=y.UIElements.Main,
},{
e("UICorner",{
CornerRadius=UDim.new(0,8),
}),
e("UIStroke",{
Thickness=1,
Transparency=0.8,
ThemeTag={
Color="Text"
}
}),
D,
})

local E=e("Frame",{
BackgroundColor3=w.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=0,
ZIndex=9,
},{
e("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

e("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,208),
Size=UDim2.fromOffset(75,24),
Parent=y.UIElements.Main,
},{
e("UICorner",{
CornerRadius=UDim.new(0,8),
}),
e("UIStroke",{
Thickness=1,
Transparency=0.8,
ThemeTag={
Color="Text"
}
}),
E,
})

local F={}

for G=0,1,0.1 do
table.insert(F,ColorSequenceKeypoint.new(G,Color3.fromHSV(G,1,1)))
end

local G=e("UIGradient",{
Color=ColorSequence.new(F),
Rotation=90,
})

local H=e("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local I=e("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=H,


BackgroundColor3=w.Default
},{
e("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
e("UICorner",{
CornerRadius=UDim.new(1,0),
})
})

local J=e("Frame",{
Size=UDim2.fromOffset(10,192),
Position=UDim2.fromOffset(180,40),
Parent=y.UIElements.Main,
},{
e("UICorner",{
CornerRadius=UDim.new(1,0),
}),
G,
H,
})


function CreateNewInput(K,L)
local M=q(K,nil,w.UIElements.Inputs)

e("TextLabel",{
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=17,
FontFace=Font.new(b.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=M.Frame,
Text=K,
})

e("UIScale",{
Parent=M,
Scale=.85,
})

M.Frame.Frame.TextBox.Text=L
M.Size=UDim2.new(0,150,0,42)

return M
end

local function ToRGB(K)
return{
R=math.floor(K.R*255),
G=math.floor(K.G*255),
B=math.floor(K.B*255)
}
end

local K=CreateNewInput("Hex","#"..w.Default:ToHex())

local L=CreateNewInput("Red",ToRGB(w.Default).R)
local M=CreateNewInput("Green",ToRGB(w.Default).G)
local N=CreateNewInput("Blue",ToRGB(w.Default).B)
local O
if w.Transparency then
O=CreateNewInput("Alpha",((1-w.Transparency)*100).."%")
end

local P=e("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254),
BackgroundTransparency=1,
Parent=y.UIElements.Main,
LayoutOrder=4,
},{
e("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
}),
})

local Q={
{
Title="Cancel",
Variant="Secondary",
Callback=function()end
},
{
Title="Apply",
Icon="chevron-right",
Variant="Primary",
Callback=function()v(Color3.fromHSV(w.Hue,w.Sat,w.Vib),w.Transparency)end
}
}

for R,S in next,Q do
local T=p(S.Title,S.Icon,S.Callback,S.Variant,P,y,true)
T.Size=UDim2.new(0.5,-3,0,40)
T.AutomaticSize="None"
end



local T,U,V
if w.Transparency then
local W=e("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.fromOffset(0,0),
BackgroundTransparency=1,
})

U=e("ImageLabel",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
ThemeTag={
BackgroundColor3="Text",
},
Parent=W,

},{
e("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
e("UICorner",{
CornerRadius=UDim.new(1,0),
})

})

V=e("Frame",{
Size=UDim2.fromScale(1,1),
},{
e("UIGradient",{
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
Rotation=270,
}),
e("UICorner",{
CornerRadius=UDim.new(0,6),
}),
})

T=e("Frame",{
Size=UDim2.fromOffset(10,192),
Position=UDim2.fromOffset(210,40),
Parent=y.UIElements.Main,
BackgroundTransparency=1,
},{
e("UICorner",{
CornerRadius=UDim.new(1,0),
}),
e("ImageLabel",{
Image="rbxassetid://14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{
e("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
V,
W,
})
end

function w.Round(W,X,Y)
if Y==0 then
return math.floor(X)
end
X=tostring(X)
return X:find"%."and tonumber(X:sub(1,X:find"%."+Y))or X
end


function w.Update(W,X,Y)
if X then z,A,B=Color3.toHSV(X)else z,A,B=w.Hue,w.Sat,w.Vib end

w.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(z,1,1)
C.Position=UDim2.new(A,0,1-B,0)
E.BackgroundColor3=Color3.fromHSV(z,A,B)
I.BackgroundColor3=Color3.fromHSV(z,1,1)
I.Position=UDim2.new(0.5,0,z,0)

K.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(z,A,B):ToHex()
L.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(z,A,B)).R
M.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(z,A,B)).G
N.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(z,A,B)).B

if Y or w.Transparency then
E.BackgroundTransparency=w.Transparency or Y
V.BackgroundColor3=Color3.fromHSV(z,A,B)
U.BackgroundColor3=Color3.fromHSV(z,A,B)
U.BackgroundTransparency=w.Transparency or Y
U.Position=UDim2.new(0.5,0,1-w.Transparency or Y,0)
O.Frame.Frame.TextBox.Text=w:Round((1-w.Transparency or Y)*100,0).."%"
end
end

w:Update(w.Default,w.Transparency)




local function GetRGB()
local W=Color3.fromHSV(w.Hue,w.Sat,w.Vib)
return{R=math.floor(W.r*255),G=math.floor(W.g*255),B=math.floor(W.b*255)}
end



local function clamp(W,X,Y)
return math.clamp(tonumber(W)or 0,X,Y)
end

b.AddSignal(K.Frame.Frame.TextBox.FocusLost,function(W)
if W then
local X=K.Frame.Frame.TextBox.Text:gsub("#","")
local Y,Z=pcall(Color3.fromHex,X)
if Y and typeof(Z)=="Color3"then
w.Hue,w.Sat,w.Vib=Color3.toHSV(Z)
w:Update()
w.Default=Z
end
end
end)

local function updateColorFromInput(W,X)
b.AddSignal(W.Frame.Frame.TextBox.FocusLost,function(Y)
if Y then
local Z=W.Frame.Frame.TextBox
local _=GetRGB()
local aa=clamp(Z.Text,0,255)
Z.Text=tostring(aa)

_[X]=aa
local ab=Color3.fromRGB(_.R,_.G,_.B)
w.Hue,w.Sat,w.Vib=Color3.toHSV(ab)
w:Update()
end
end)
end

updateColorFromInput(L,"R")
updateColorFromInput(M,"G")
updateColorFromInput(N,"B")

if w.Transparency then
b.AddSignal(O.Frame.Frame.TextBox.FocusLost,function(aa)
if aa then
local ab=O.Frame.Frame.TextBox
local W=clamp(ab.Text,0,100)
ab.Text=tostring(W)

w.Transparency=1-W*0.01
w:Update(nil,w.Transparency)
end
end)
end



local aa=w.UIElements.SatVibMap
b.AddSignal(aa.InputBegan,function(ab)
if ab.UserInputType==Enum.UserInputType.MouseButton1 or ab.UserInputType==Enum.UserInputType.Touch then
while h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local W=aa.AbsolutePosition.X
local X=W+aa.AbsoluteSize.X
local Y=math.clamp(o.X,W,X)

local Z=aa.AbsolutePosition.Y
local _=Z+aa.AbsoluteSize.Y
local ac=math.clamp(o.Y,Z,_)

w.Sat=(Y-W)/(X-W)
w.Vib=1-((ac-Z)/(_-Z))
w:Update()

k:Wait()
end
end
end)

b.AddSignal(J.InputBegan,function(ab)
if ab.UserInputType==Enum.UserInputType.MouseButton1 or ab.UserInputType==Enum.UserInputType.Touch then
while h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local ac=J.AbsolutePosition.Y
local W=ac+J.AbsoluteSize.Y
local X=math.clamp(o.Y,ac,W)

w.Hue=((X-ac)/(W-ac))
w:Update()

k:Wait()
end
end
end)

if w.Transparency then
b.AddSignal(T.InputBegan,function(ab)
if ab.UserInputType==Enum.UserInputType.MouseButton1 or ab.UserInputType==Enum.UserInputType.Touch then
while h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local ac=T.AbsolutePosition.Y
local W=ac+T.AbsoluteSize.Y
local X=math.clamp(o.Y,ac,W)

w.Transparency=1-((X-ac)/(W-ac))
w:Update()

k:Wait()
end
end
end)
end

return w
end

function r.New(aa,ab)
local ac={
__type="Colorpicker",
Title=ab.Title or"Colorpicker",
Desc=ab.Desc or nil,
Locked=ab.Locked or false,
Default=ab.Default or Color3.new(1,1,1),
Callback=ab.Callback or function()end,
Window=ab.Window,
Transparency=ab.Transparency,
UIElements={}
}

local s=true


ac.ColorpickerFrame=a.load'n'{
Title=ac.Title,
Desc=ac.Desc,
Parent=ab.Parent,
TextOffset=40,
Hover=false,
}

ac.UIElements.Colorpicker=b.NewRoundFrame(r.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=ac.Default,
Parent=ac.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,30,0,30),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
ZIndex=2
},nil,true)


function ac.Lock(t)
s=false
return ac.ColorpickerFrame:Lock()
end
function ac.Unlock(t)
s=true
return ac.ColorpickerFrame:Unlock()
end

if ac.Locked then
ac:Lock()
end


function ac.Update(t,v,w)
ac.UIElements.Colorpicker.ImageTransparency=w or 0
ac.UIElements.Colorpicker.ImageColor3=v
ac.Default=v
if w then
ac.Transparency=w
end
end

function ac.Set(t,v,w)
return ac:Update(v,w)
end

b.AddSignal(ac.UIElements.Colorpicker.MouseButton1Click,function()
if s then
r:Colorpicker(ac,function(t,v)
ac:Update(t,v)
ac.Default=t
ac.Transparency=v
b.SafeCallback(ac.Callback,t,v)
end).ColorpickerFrame:Open()
end
end)

return ac.__type,ac
end

return r end function a.A()
local aa=a.load'a'
local ab=aa.New
local ac=aa.Tween

local b={}

function b.New(e,g)
local h={
__type="Section",
Title=g.Title or"Section",
Icon=g.Icon,
TextXAlignment=g.TextXAlignment or"Left",
TextSize=g.TextSize or 19,
UIElements={},
}

local i
if h.Icon then
i=aa.Image(
h.Icon,
h.Icon..":"..h.Title,
0,
g.Window.Folder,
h.__type,
true
)
i.Size=UDim2.new(0,24,0,24)
end

h.UIElements.Main=ab("TextLabel",{
BackgroundTransparency=1,
TextXAlignment="Left",
AutomaticSize="XY",
TextSize=h.TextSize,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),


Text=h.Title,
})

ab("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=g.Parent,
},{
i,
h.UIElements.Main,
ab("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=h.TextXAlignment,
}),
ab("UIPadding",{
PaddingTop=UDim.new(0,4),
PaddingBottom=UDim.new(0,2),
})
})





function h.SetTitle(j,k)
h.UIElements.Main.Text=k
end
function h.Destroy(j)
h.UIElements.Main.AutomaticSize="None"
h.UIElements.Main.Size=UDim2.new(1,0,0,h.UIElements.Main.TextBounds.Y)

ac(h.UIElements.Main,.1,{TextTransparency=1}):Play()
task.wait(.1)
ac(h.UIElements.Main,.15,{Size=UDim2.new(1,0,0,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

return h.__type,h
end

return b end function a.B()
game:GetService"UserInputService"
local aa=game.Players.LocalPlayer:GetMouse()

local ab=a.load'a'
local ac=ab.New
local b=ab.Tween

local e=a.load'c'.New
local g=a.load'm'.New
local h=a.load'j'.New


local i={
Window=nil,
WindUI=nil,
Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(i)end
}

function i.Init(j,k,n,o)
i.Window=j
i.WindUI=k
i.ToolTipParent=n
i.TabHighlight=o
return i
end

function i.New(j)
local k={
__type="Tab",
Title=j.Title or"Tab",
Desc=j.Desc,
Icon=j.Icon,
IconThemed=j.IconThemed,
Locked=j.Locked,
ShowTabTitle=j.ShowTabTitle,
Selected=false,
Index=nil,
Parent=j.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=i.Window.UICorner-(i.Window.UIPadding/2),
}

local n=i.Window
local o=i.WindUI

i.TabCount=i.TabCount+1
local p=i.TabCount
k.Index=p

k.UIElements.Main=ab.NewRoundFrame(k.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=UDim2.new(1,-7,0,0),
AutomaticSize="Y",
Parent=j.Parent,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
},{
ab.NewRoundFrame(k.UICorner,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
ac("UIGradient",{
Rotation=80,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
ab.NewRoundFrame(k.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
ac("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ac("TextLabel",{
Text=k.Title,
ThemeTag={
TextColor3="Text"
},
TextTransparency=not k.Locked and 0.4 or.7,
TextSize=15,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize="Y",
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
}),
ac("UIPadding",{
PaddingTop=UDim.new(0,2+(n.UIPadding/2)),
PaddingLeft=UDim.new(0,4+(n.UIPadding/2)),
PaddingRight=UDim.new(0,4+(n.UIPadding/2)),
PaddingBottom=UDim.new(0,2+(n.UIPadding/2)),
})
}),
},true)

local q=0
local r
local s

if k.Icon then
r=ab.Image(
k.Icon,
k.Icon..":"..k.Title,
0,
i.Window.Folder,
k.__type,
true,
k.IconThemed
)
r.Size=UDim2.new(0,16,0,16)
r.Parent=k.UIElements.Main.Frame
r.ImageLabel.ImageTransparency=not k.Locked and 0 or.7
k.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,-30,0,0)
q=-30

k.UIElements.Icon=r


s=ab.Image(
k.Icon,
k.Icon..":"..k.Title,
0,
i.Window.Folder,
k.__type,
true,
k.IconThemed
)
s.Size=UDim2.new(0,16,0,16)
s.ImageLabel.ImageTransparency=not k.Locked and 0 or.7
q=-30




end

k.UIElements.ContainerFrame=ac("ScrollingFrame",{
Size=UDim2.new(1,0,1,k.ShowTabTitle and-((n.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
ac("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,6),
HorizontalAlignment="Center",
})
})





k.UIElements.ContainerFrameCanvas=ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
Parent=n.UIElements.MainBar,
ZIndex=5,
},{
k.UIElements.ContainerFrame,
ac("Frame",{
Size=UDim2.new(1,0,0,((n.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=k.ShowTabTitle or false,
Name="TabTitle"
},{
s,
ac("TextLabel",{
Text=k.Title,
ThemeTag={
TextColor3="Text"
},
TextSize=20,
TextTransparency=.1,
Size=UDim2.new(1,-q,1,0),
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
TextTruncate="AtEnd",
RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
}),
ac("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
ac("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ac("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
},
Position=UDim2.new(0,0,0,((n.UIPadding*2.4)+12)),
Visible=k.ShowTabTitle or false,
})
})

i.Containers[p]=k.UIElements.ContainerFrameCanvas
i.Tabs[p]=k

k.ContainerFrame=ContainerFrameCanvas

ab.AddSignal(k.UIElements.Main.MouseButton1Click,function()
if not k.Locked then
i:SelectTab(p)
end
end)

h(k.UIElements.ContainerFrame,k.UIElements.ContainerFrameCanvas,n,3)

local t
local v
local w
local x=false



if k.Desc then


ab.AddSignal(k.UIElements.Main.InputBegan,function()
x=true
v=task.spawn(function()
task.wait(0.35)
if x and not t then
t=g(k.Desc,i.ToolTipParent)

local function updatePosition()
if t then
t.Container.Position=UDim2.new(0,aa.X,0,aa.Y-20)
end
end

updatePosition()
w=aa.Move:Connect(updatePosition)
t:Open()
end
end)
end)

end

ab.AddSignal(k.UIElements.Main.MouseEnter,function()
if not k.Locked then
b(k.UIElements.Main.Frame,0.08,{ImageTransparency=.97}):Play()
end
end)
ab.AddSignal(k.UIElements.Main.InputEnded,function()
if k.Desc then
x=false
if v then
task.cancel(v)
v=nil
end
if w then
w:Disconnect()
w=nil
end
if t then
t:Close()
t=nil
end
end

if not k.Locked then
b(k.UIElements.Main.Frame,0.08,{ImageTransparency=1}):Play()
end
end)



local y={
Button=a.load'o',
Toggle=a.load'r',
Slider=a.load's',
Keybind=a.load't',
Input=a.load'u',
Dropdown=a.load'v',
Code=a.load'y',
Colorpicker=a.load'z',
Section=a.load'A',
}

function k.Divider(z)
local A=ac("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local B=ac("Frame",{
Parent=k.UIElements.ContainerFrame,
Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
A
})

return B
end

function k.Paragraph(z,A)
A.Parent=k.UIElements.ContainerFrame
A.Window=n
A.Hover=false

A.TextOffset=0
A.IsButtons=A.Buttons and#A.Buttons>0 and true or false

local B={
__type="Paragraph",
Title=A.Title or"Paragraph",
Desc=A.Desc or nil,

Locked=A.Locked or false,
}
local C=a.load'n'(A)

B.ParagraphFrame=C
if A.Buttons and#A.Buttons>0 then
local D=ac("Frame",{
Size=UDim2.new(1,0,0,38),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=C.UIElements.Container
},{
ac("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
})
})


for E,F in next,A.Buttons do
local G=e(F.Title,F.Icon,F.Callback,"White",D)
G.Size=UDim2.new(1,0,0,38)

end
end

function B.SetTitle(D,E)
B.ParagraphFrame:SetTitle(E)
end
function B.SetDesc(D,E)
B.ParagraphFrame:SetDesc(E)
end
function B.Destroy(D)
B.ParagraphFrame:Destroy()
end

table.insert(k.Elements,B)
return B
end

for z,A in pairs(y)do
k[z]=function(B,C)
C.Parent=B.UIElements.ContainerFrame
C.Window=n
C.WindUI=o local

D, E=A:New(C)
table.insert(B.Elements,E)

local F
for G,H in pairs(E)do
if typeof(H)=="table"and G:match"Frame$"then
F=H
break
end
end

if F then
function E.SetTitle(I,J)
F:SetTitle(J)
end
function E.SetDesc(I,J)
F:SetDesc(J)
end
function E.Destroy(I)
F:Destroy()
end
end
return E
end
end


task.spawn(function()
local B=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-n.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=k.UIElements.ContainerFrame
},{
ac("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),
ac("ImageLabel",{
Size=UDim2.new(0,48,0,48),
Image=ab.Icon"frown"[1],
ImageRectOffset=ab.Icon"frown"[2].ImageRectPosition,
ImageRectSize=ab.Icon"frown"[2].ImageRectSize,
ThemeTag={
ImageColor3="Icon"
},
BackgroundTransparency=1,
ImageTransparency=.6,
}),
ac("TextLabel",{
AutomaticSize="XY",
Text="This tab is empty",
ThemeTag={
TextColor3="Text"
},
TextSize=18,
TextTransparency=.5,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
})
})





ab.AddSignal(k.UIElements.ContainerFrame.ChildAdded,function()
B.Visible=false
end)
end)

return k
end

function i.OnChange(j,k)
i.OnChangeFunc=k
end

function i.SelectTab(j,k)
if not i.Tabs[k].Locked then
i.SelectedTab=k

for n,o in next,i.Tabs do
if not o.Locked then
b(o.UIElements.Main,0.15,{ImageTransparency=1}):Play()
b(o.UIElements.Main.Outline,0.15,{ImageTransparency=1}):Play()
b(o.UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0.3}):Play()
if o.UIElements.Icon then
b(o.UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.4}):Play()
end
o.Selected=false
end
end
b(i.Tabs[k].UIElements.Main,0.15,{ImageTransparency=0.95}):Play()
b(i.Tabs[k].UIElements.Main.Outline,0.15,{ImageTransparency=0.85}):Play()
b(i.Tabs[k].UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0}):Play()
if i.Tabs[k].UIElements.Icon then
b(i.Tabs[k].UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.1}):Play()
end
i.Tabs[k].Selected=true


task.spawn(function()
for p,q in next,i.Containers do
q.AnchorPoint=Vector2.new(0,0.05)
q.Visible=false
end
i.Containers[k].Visible=true
b(i.Containers[k],0.15,{AnchorPoint=Vector2.new(0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()
end)

i.OnChangeFunc(k)
end
end

return i end function a.C()
local aa={}


local ab=a.load'a'
local ac=ab.New
local b=ab.Tween

local e=a.load'B'

function aa.New(g,h,i,j)
local k={
Title=g.Title or"Section",
Icon=g.Icon,
IconThemed=g.IconThemed,
Opened=g.Opened or false,

HeaderSize=42,
IconSize=18,

Expandable=false,
}

local n
if k.Icon then
n=ab.Image(
k.Icon,
k.Icon,
0,
i,
"Section",
true,
k.IconThemed
)

n.Size=UDim2.new(0,k.IconSize,0,k.IconSize)
n.ImageLabel.ImageTransparency=.25
end

local o=ac("Frame",{
Size=UDim2.new(0,k.IconSize,0,k.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ac("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=ab.Icon"chevron-down"[1],
ImageRectSize=ab.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=ab.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.7,
})
})

local p=ac("Frame",{
Size=UDim2.new(1,0,0,k.HeaderSize),
BackgroundTransparency=1,
Parent=h,
ClipsDescendants=true,
},{
ac("TextButton",{
Size=UDim2.new(1,0,0,k.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
n,
ac("TextLabel",{
Text=k.Title,
TextXAlignment="Left",
Size=UDim2.new(
1,
n and(-k.IconSize-10)*2
or(-k.IconSize-10),

1,
0
),
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
TextSize=14,
BackgroundTransparency=1,
TextTransparency=.7,

TextWrapped=true
}),
ac("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
o,
ac("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,k.HeaderSize)
},{
ac("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,0),
VerticalAlignment="Bottom",
}),
})
})


function k.Tab(q,r)
if not k.Expandable then
k.Expandable=true
o.Visible=true
end
r.Parent=p.Content
return e.New(r)
end

function k.Open(q)
if k.Expandable then
k.Opened=true
b(p,0.33,{
Size=UDim2.new(1,0,0,k.HeaderSize+(p.Content.AbsoluteSize.Y/j))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

b(o.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function k.Close(q)
if k.Expandable then
k.Opened=false
b(p,0.26,{
Size=UDim2.new(1,0,0,k.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
b(o.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

ab.AddSignal(p.TextButton.MouseButton1Click,function()
if k.Expandable then
if k.Opened then
k:Close()
else
k:Open()
end
end
end)

if k.Opened then
task.spawn(function()
task.wait()
k:Open()
end)
end



return k
end


return aa end function a.D()
return{
Tab="table-of-contents",
Paragraph="type",
Button="square-mouse-pointer",
Toggle="toggle-right",
Slider="sliders-horizontal",
Keybind="command",
Input="text-cursor-input",
Dropdown="chevrons-up-down",
Code="terminal",
Colorpicker="palette",
}end function a.E()
game:GetService"UserInputService"

local aa={
Margin=8,
Padding=9,
}


local ab=a.load'a'
local ac=ab.New
local b=ab.Tween


function aa.new(e,g,h)
local i={
IconSize=14,
Padding=14,
Radius=18,
Width=400,
MaxHeight=380,

Icons=a.load'D'
}


local j=ac("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(
1,
-((i.IconSize*2)+(i.Padding*2)),
0,
0
),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
TextSize=17,
})

local k=ac("ImageLabel",{
Image=ab.Icon"x"[1],
ImageRectSize=ab.Icon"x"[2].ImageRectSize,
ImageRectOffset=ab.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=.2,
Size=UDim2.new(0,i.IconSize,0,i.IconSize)
},{
ac("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})

local n=ac("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false
},{
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
ac("UIPadding",{
PaddingTop=UDim.new(0,i.Padding),
PaddingLeft=UDim.new(0,i.Padding),
PaddingRight=UDim.new(0,i.Padding),
PaddingBottom=UDim.new(0,i.Padding),
})
})

local o=ab.NewRoundFrame(i.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Accent",
},
ImageTransparency=0,
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
},{
ac("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("ImageLabel",{
Image=ab.Icon"search"[1],
ImageRectSize=ab.Icon"search"[2].ImageRectSize,
ImageRectOffset=ab.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.05,
Size=UDim2.new(0,i.IconSize,0,i.IconSize)
}),
j,
k,
ac("UIListLayout",{
Padding=UDim.new(0,i.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ac("UIPadding",{
PaddingLeft=UDim.new(0,i.Padding),
PaddingRight=UDim.new(0,i.Padding),
})
})
}),
ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
ac("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=.9,
Visible=false,
}),
n,
ac("UISizeConstraint",{
MaxSize=Vector2.new(i.Width,i.MaxHeight),
}),
}),
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
})
})

local p=ac("Frame",{
Size=UDim2.new(0,i.Width,0,0),
AutomaticSize="Y",
Parent=g,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
ac("UIScale",{
Scale=.9,
}),
o,
ab.NewRoundFrame(i.Radius,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=.7,
},{
ac("UIGradient",{
Rotation=45,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
})
})
})

local function CreateSearchTab(q,r,s,t,v,w)
local x=ac("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=t or nil
},{
ab.NewRoundFrame(i.Radius-4,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main"
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,i.Padding-2),
PaddingLeft=UDim.new(0,i.Padding),
PaddingRight=UDim.new(0,i.Padding),
PaddingBottom=UDim.new(0,i.Padding-2),
}),
ac("ImageLabel",{
Image=ab.Icon(s)[1],
ImageRectSize=ab.Icon(s)[2].ImageRectSize,
ImageRectOffset=ab.Icon(s)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=.2,
Size=UDim2.new(0,i.IconSize,0,i.IconSize)
}),
ac("Frame",{
Size=UDim2.new(1,-i.IconSize-i.Padding,0,0),
BackgroundTransparency=1,
},{
ac("TextLabel",{
Text=q,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title"
}),
ac("TextLabel",{
Text=r or"",
Visible=r and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=.2,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc"
})or nil,
ac("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
})
}),
ac("UIListLayout",{
Padding=UDim.new(0,i.Padding),
FillDirection="Horizontal",
})
},true),
ac("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-i.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=v,

},{
ab.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=.9,
}),
ac("Frame",{
Size=UDim2.new(1,-i.Padding-2,0,0),
Position=UDim2.new(0,i.Padding+2,0,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right"
})
})



x.Main.Size=UDim2.new(
1,
0,
0,
x.Main.Frame.Desc.Visible and(((i.Padding-2)*2)+x.Main.Frame.Title.TextBounds.Y+6+x.Main.Frame.Desc.TextBounds.Y)
or(((i.Padding-2)*2)+x.Main.Frame.Title.TextBounds.Y)
)

ab.AddSignal(x.Main.MouseEnter,function()
b(x.Main,.04,{ImageTransparency=.95}):Play()
end)
ab.AddSignal(x.Main.InputEnded,function()
b(x.Main,.08,{ImageTransparency=1}):Play()
end)
ab.AddSignal(x.Main.MouseButton1Click,function()
if w then
w()
end
end)

return x
end

local function ContainsText(q,r)
if not r or r==""then
return false
end

if not q or q==""then
return false
end

local s=string.lower(q)
local t=string.lower(r)

return string.find(s,t,1,true)~=nil
end

local function Search(q)
if not q or q==""then
return{}
end

local r={}
for s,t in next,e.Tabs do
local v=ContainsText(t.Title or"",q)
local w={}

for x,y in next,t.Elements do
if y.__type~="Section"then
local z=ContainsText(y.Title or"",q)
local A=ContainsText(y.Desc or"",q)

if z or A then
w[x]={
Title=y.Title,
Desc=y.Desc,
Original=y,
__type=y.__type
}
end
end
end

if v or next(w)~=nil then
r[s]={
Tab=t,
Title=t.Title,
Icon=t.Icon,
Elements=w,
}
end
end
return r
end

function i.Search(q,r)
r=r or""

local s=Search(r)

n.Visible=true
o.Frame.Results.Frame.Visible=true
for t,v in next,n:GetChildren()do
if v.ClassName~="UIListLayout"and v.ClassName~="UIPadding"then
v:Destroy()
end
end

if s and next(s)~=nil then
for w,x in next,s do
local y=i.Icons.Tab
local z=CreateSearchTab(x.Title,nil,y,n,true,function()
i:Close()
e:SelectTab(w)
end)
if x.Elements and next(x.Elements)~=nil then
for A,B in next,x.Elements do
local C=i.Icons[B.__type]
CreateSearchTab(B.Title,B.Desc,C,z:FindFirstChild"ParentContainer"and z.ParentContainer.Frame or nil,false,function()
i:Close()
e:SelectTab(w)

end)

end
end
end
elseif r~=""then
ac("TextLabel",{
Size=UDim2.new(1,0,0,70),
BackgroundTransparency=1,
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=.2,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Parent=n,
Name="NotFound",
})
else
n.Visible=false
o.Frame.Results.Frame.Visible=false
end
end

ab.AddSignal(j:GetPropertyChangedSignal"Text",function()
i:Search(j.Text)
end)

ab.AddSignal(n.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

b(n,.06,{Size=UDim2.new(
1,
0,
0,
math.clamp(n.UIListLayout.AbsoluteContentSize.Y+(i.Padding*2),0,i.MaxHeight)
)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function i.Open(q)
task.spawn(function()
o.Frame.Visible=true
p.Visible=true
b(p.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function i.Close(q)
task.spawn(function()
h()
o.Frame.Visible=false
b(p.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(.12)
p.Visible=false
end)
end

ab.AddSignal(k.TextButton.MouseButton1Click,function()
i:Close()
end)

i:Open()

return i
end

return aa end function a.F()

local aa=game:GetService"UserInputService"
game:GetService"RunService"

local ab=workspace.CurrentCamera

local ac=a.load'a'
local b=ac.New
local e=ac.Tween


local g=a.load'i'.New
local h=a.load'c'.New
local i=a.load'j'.New

local j=a.load'k'

local k=false

return function(n)
local o={
Title=n.Title or"UI Library",
Author=n.Author,
Icon=n.Icon,
IconThemed=n.IconThemed,
Folder=n.Folder,
Resizable=n.Resizable,
Background=n.Background,
BackgroundImageTransparency=n.BackgroundImageTransparency or 0,
User=n.User or{},
Size=n.Size and UDim2.new(
0,math.clamp(n.Size.X.Offset,480,700),
0,math.clamp(n.Size.Y.Offset,350,520))or UDim2.new(0,580,0,460),
ToggleKey=n.ToggleKey or Enum.KeyCode.G,
Transparent=n.Transparent or false,
HideSearchBar=n.HideSearchBar,
ScrollBarEnabled=n.ScrollBarEnabled or false,
SideBarWidth=n.SideBarWidth or 200,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=16,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=n.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=false,
IsOpenButtonEnabled=true,

ConfigManager=nil,
CurrentTab=nil,
TabModule=nil,

OnCloseCallback=nil,
OnDestroyCallback=nil,

TopBarButtons={},

}

if o.HideSearchBar~=false then
o.HideSearchBar=true
end
if o.Resizable~=false then
o.CanResize=true
o.Resizable=true
end

if o.Folder then
makefolder("WindUI/"..o.Folder)
end

local p=b("UICorner",{
CornerRadius=UDim.new(0,o.UICorner)
})

o.ConfigManager=j:Init(o)



local q=b("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(.5,.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true
},{
b("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
})
})
local r=ac.NewRoundFrame(o.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
b("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=ac.Icon"expand"[1],
ImageRectOffset=ac.Icon"expand"[2].ImageRectPosition,
ImageRectSize=ac.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local s=ac.NewRoundFrame(o.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})










o.UIElements.SideBar=b("ScrollingFrame",{
Size=UDim2.new(
1,
o.ScrollBarEnabled and-3-(o.UIPadding/2)or 0,
1,
not o.HideSearchBar and-45 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ClipsDescendants=true,
VerticalScrollBarPosition="Left",
},{
b("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
b("UIPadding",{
PaddingTop=UDim.new(0,o.UIPadding/2),


PaddingBottom=UDim.new(0,o.UIPadding/2),
}),
b("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,0)
})
}),
b("UIPadding",{

PaddingLeft=UDim.new(0,o.UIPadding/2),
PaddingRight=UDim.new(0,o.UIPadding/2),

}),

})

o.UIElements.SideBarContainer=b("Frame",{
Size=UDim2.new(0,o.SideBarWidth,1,o.User.Enabled and-94-(o.UIPadding*2)or-52),
Position=UDim2.new(0,0,0,52),
BackgroundTransparency=1,
Visible=true,
},{
b("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(
1,
0,
1,
not o.HideSearchBar and-45-o.UIPadding/2 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
}),
o.UIElements.SideBar,
})

if o.ScrollBarEnabled then
i(o.UIElements.SideBar,o.UIElements.SideBarContainer.Content,o,3)
end


o.UIElements.MainBar=b("Frame",{
Size=UDim2.new(1,-o.UIElements.SideBarContainer.AbsoluteSize.X,1,-52),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
ac.NewRoundFrame(o.UICorner-(o.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ZIndex=3,
ImageTransparency=.95,
Name="Background",
}),
b("UIPadding",{
PaddingTop=UDim.new(0,o.UIPadding/2),
PaddingLeft=UDim.new(0,o.UIPadding/2),
PaddingRight=UDim.new(0,o.UIPadding/2),
PaddingBottom=UDim.new(0,o.UIPadding/2),
})
})

local t=b("ImageLabel",{
Image="rbxassetid://8992230677",
ImageColor3=Color3.new(0,0,0),
ImageTransparency=1,
Size=UDim2.new(1,120,1,116),
Position=UDim2.new(0,-60,0,-58),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

local v

if aa.TouchEnabled and not aa.KeyboardEnabled then
v=false
elseif aa.KeyboardEnabled then
v=true
else
v=nil
end









local w
if o.User.Enabled then local
x, y=game.Players:GetUserThumbnailAsync(
o.User.Anonymous and 1 or game.Players.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)

w=b("TextButton",{
Size=UDim2.new(0,
(o.UIElements.SideBarContainer.AbsoluteSize.X)-(o.UIPadding/2),
0,
42+(o.UIPadding)
),
Position=UDim2.new(0,o.UIPadding/2,1,-(o.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
},{
ac.NewRoundFrame(o.UICorner-(o.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
b("UIGradient",{
Rotation=78,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
ac.NewRoundFrame(o.UICorner-(o.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
b("ImageLabel",{
Image=x,
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=.93,
},{
b("UICorner",{
CornerRadius=UDim.new(1,0)
})
}),
b("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
b("TextLabel",{
Text=o.User.Anonymous and"Anonymous"or game.Players.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ac.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
}),
b("TextLabel",{
Text=o.User.Anonymous and"@anonymous"or"@"..game.Players.LocalPlayer.Name,
TextSize=15,
TextTransparency=.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ac.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
}),
b("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
})
}),
b("UIListLayout",{
Padding=UDim.new(0,o.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
b("UIPadding",{
PaddingLeft=UDim.new(0,o.UIPadding/2),
PaddingRight=UDim.new(0,o.UIPadding/2),
})
})
})

if o.User.Callback then
ac.AddSignal(w.MouseButton1Click,function()
o.User.Callback()
end)
ac.AddSignal(w.MouseEnter,function()
e(w.UserIcon,0.04,{ImageTransparency=.95}):Play()
e(w.Outline,0.04,{ImageTransparency=.85}):Play()
end)
ac.AddSignal(w.InputEnded,function()
e(w.UserIcon,0.04,{ImageTransparency=1}):Play()
e(w.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local x
local y


local z=ac.NewRoundFrame(99,"Squircle",{
ImageTransparency=.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
b("Frame",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
})
})

local A=b("TextLabel",{
Text=o.Title,
FontFace=Font.new(ac.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="Text"
}
})

o.UIElements.Main=b("Frame",{
Size=o.Size,
Position=o.Position,
BackgroundTransparency=1,
Parent=n.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
},{
t,
ac.NewRoundFrame(o.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,-240),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="Background"
},

},{
b("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=o.Background,
ImageTransparency=1,
ScaleType="Crop",
},{
b("UICorner",{
CornerRadius=UDim.new(0,o.UICorner)
}),
}),
z,
q,



}),
UIStroke,
p,
r,
s,
b("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
b("UICorner",{
CornerRadius=UDim.new(0,o.UICorner)
}),
o.UIElements.SideBarContainer,
o.UIElements.MainBar,

w,

y,
b("Frame",{
Size=UDim2.new(1,0,0,52),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar"
},{
x,






b("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left"
},{
b("UIListLayout",{
Padding=UDim.new(0,o.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
b("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
b("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Top",
}),
A,
}),
b("UIPadding",{
PaddingLeft=UDim.new(0,4)
})
}),
b("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Name="Right",
},{
b("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),

}),
b("UIPadding",{
PaddingTop=UDim.new(0,o.UIPadding),
PaddingLeft=UDim.new(0,o.UIPadding),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,o.UIPadding),
})
})
})
})


function o.CreateTopbarButton(B,C,D,E,F,G)
local H=ac.Image(
D,
D,
0,
o.Folder,
"TopbarIcon",
true,
G
)
H.Size=UDim2.new(0,16,0,16)
H.AnchorPoint=Vector2.new(0.5,0.5)
H.Position=UDim2.new(0.5,0,0.5,0)

local I=ac.NewRoundFrame(9,"Squircle",{
Size=UDim2.new(0,36,0,36),
LayoutOrder=F or 999,
Parent=o.UIElements.Main.Main.Topbar.Right,

ZIndex=9999,
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=1
},{
ac.NewRoundFrame(9,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
b("UIGradient",{
Rotation=45,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
H
},true)



o.TopBarButtons[100-F]={
Name=C,
Object=I
}

ac.AddSignal(I.MouseButton1Click,function()
E()
end)
ac.AddSignal(I.MouseEnter,function()
e(I,.15,{ImageTransparency=.93}):Play()
e(I.Outline,.15,{ImageTransparency=.75}):Play()

end)
ac.AddSignal(I.MouseLeave,function()
e(I,.1,{ImageTransparency=1}):Play()
e(I.Outline,.1,{ImageTransparency=1}):Play()

end)

return I
end



local B=ac.Drag(
o.UIElements.Main,
{o.UIElements.Main.Main.Topbar,z.Frame},
function(B,C)
if not o.Closed then
if B and C==z.Frame then
e(z,.1,{ImageTransparency=.35}):Play()
else
e(z,.2,{ImageTransparency=.8}):Play()
end
end
end
)














if o.Author then
b("TextLabel",{
Text=o.Author,
FontFace=Font.new(ac.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.4,
AutomaticSize="XY",
Parent=o.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="Text"
}
})

end

local C=a.load'l'.New(o)


task.spawn(function()
if o.Icon then

local D=ac.Image(
o.Icon,
o.Title,
0,
o.Folder,
"Window",
true,
o.IconThemed
)
D.Parent=o.UIElements.Main.Main.Topbar.Left
D.Size=UDim2.new(0,22,0,22)

C:SetIcon(o.Icon)











else
C:SetIcon(o.Icon)
OpenButtonIcon.Visible=false
end
end)

function o.SetToggleKey(D,E)
o.ToggleKey=E
end

function o.SetBackgroundImage(D,E)
o.UIElements.Main.Background.ImageLabel.Image=E
end
function o.SetBackgroundImageTransparency(D,E)
o.UIElements.Main.Background.ImageLabel.ImageTransparency=E
o.BackgroundImageTransparency=E
end

local D
local E
ac.Icon"minimize"
ac.Icon"maximize"

o:CreateTopbarButton("Fullscreen","maximize",function()
o:ToggleFullscreen()
end,998)

function o.ToggleFullscreen(F)
local G=o.IsFullscreen

B:Set(G)

if not G then
D=o.UIElements.Main.Position
E=o.UIElements.Main.Size

o.CanResize=false
else
if o.Resizable then
o.CanResize=true
end
end

e(o.UIElements.Main,0.45,{Size=G and E or UDim2.new(1,-20,1,-72)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

e(o.UIElements.Main,0.45,{Position=G and D or UDim2.new(0.5,0,0.5,26)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()



o.IsFullscreen=not G
end


o:CreateTopbarButton("Minimize","minus",function()
o:Close()
task.spawn(function()
task.wait(.3)
if not v and o.IsOpenButtonEnabled then

C:Visible(true)
end
end)

local F=v and"Press "..o.ToggleKey.Name.." to open the Window"or"Click the Button to open the Window"

if not o.IsOpenButtonEnabled then
k=true
end
if not k then
k=not k
n.WindUI:Notify{
Title="Minimize",
Content="You've closed the Window. "..F,
Icon="eye-off",
Duration=5,
}
end
end,997)

function o.OnClose(F,G)
o.OnCloseCallback=G
end
function o.OnDestroy(F,G)
o.OnDestroyCallback=G
end

function o.Open(F)
task.spawn(function()
task.wait(.06)
o.Closed=false

e(o.UIElements.Main.Background,0.2,{
ImageTransparency=o.Transparent and n.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

e(o.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,0),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

e(o.UIElements.Main.Background.ImageLabel,0.2,{ImageTransparency=o.BackgroundImageTransparency},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

e(t,0.25,{ImageTransparency=.7},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
e(UIStroke,0.25,{Transparency=.8},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

task.spawn(function()
task.wait(.5)
e(z,.45,{Size=UDim2.new(0,200,0,4),ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
task.wait(.45)
B:Set(true)
if o.Resizable then
e(q.ImageLabel,.45,{ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
o.CanResize=true
end
end)


o.CanDropdown=true

o.UIElements.Main.Visible=true
task.spawn(function()
task.wait(.05)
o.UIElements.Main.Main.Visible=true
end)
end)
end
function o.Close(F)
local G={}

if o.OnCloseCallback then
task.spawn(function()
ac.SafeCallback(o.OnCloseCallback)
end)
end

o.UIElements.Main.Main.Visible=false
o.CanDropdown=false
o.Closed=true

e(o.UIElements.Main.Background,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()

e(o.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,-240),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()


e(o.UIElements.Main.Background.ImageLabel,0.2,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(t,0.25,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
e(UIStroke,0.25,{Transparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

e(z,.3,{Size=UDim2.new(0,0,0,4),ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()
e(q.ImageLabel,.3,{ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
B:Set(false)
o.CanResize=false

task.spawn(function()
task.wait(0.4)
o.UIElements.Main.Visible=false
end)

function G.Destroy(H)
if o.OnDestroyCallback then
task.spawn(function()
ac.SafeCallback(o.OnDestroyCallback)
end)
end
o.Destroyed=true
task.wait(0.4)
n.Parent.Parent:Destroy()


end

return G
end

function o.ToggleTransparency(F,G)

o.Transparent=G
n.WindUI.Transparent=G

o.UIElements.Main.Background.ImageTransparency=G and n.WindUI.TransparencyValue or 0

o.UIElements.MainBar.Background.ImageTransparency=G and 0.97 or 0.95

end


function o.SetUIScale(F,G)
n.WindUI.UIScale=G
e(n.WindUI.ScreenGui.UIScale,.2,{Scale=G},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

do

if(ab.ViewportSize.X-40<o.UIElements.Main.AbsoluteSize.X)
or(ab.ViewportSize.Y-40<o.UIElements.Main.AbsoluteSize.Y)then
if not o.IsFullscreen then
o:SetUIScale(.9)
end
end
end

if not v and o.IsOpenButtonEnabled then
ac.AddSignal(C.Button.TextButton.MouseButton1Click,function()

C:Visible(false)
o:Open()
end)
end

ac.AddSignal(aa.InputBegan,function(F,G)
if G then return end

if F.KeyCode==o.ToggleKey then
if o.Closed then
o:Open()
else
o:Close()
end
end
end)

task.spawn(function()

o:Open()
end)

function o.EditOpenButton(F,G)
return C:Edit(G)
end


local F=a.load'B'
local G=a.load'C'
local H=F.Init(o,n.WindUI,n.Parent.Parent.ToolTips)
H:OnChange(function(I)o.CurrentTab=I end)

o.TabModule=F

function o.Tab(I,J)
J.Parent=o.UIElements.SideBar.Frame
return H.New(J)
end

function o.SelectTab(I,J)
H:SelectTab(J)
end

function o.Section(I,J)
return G.New(J,o.UIElements.SideBar.Frame,o.Folder,n.WindUI.UIScale)
end

function o.IsResizable(I,J)
o.Resizable=J
o.CanResize=J
end

function o.Divider(I)
local J=b("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local K=b("Frame",{
Parent=o.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
J
})

return K
end

local I=a.load'e'.Init(o,nil)
function o.Dialog(J,K)
local L={
Title=K.Title or"Dialog",
Width=K.Width or 320,
Content=K.Content,
Buttons=K.Buttons or{},

TextPadding=10,
}
local M=I.Create(false)

M.UIElements.Main.Size=UDim2.new(0,L.Width,0,0)

local N=b("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=M.UIElements.Main
},{
b("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,M.UIPadding),
VerticalAlignment="Center"
}),
b("UIPadding",{
PaddingTop=UDim.new(0,L.TextPadding),
PaddingLeft=UDim.new(0,L.TextPadding),
PaddingRight=UDim.new(0,L.TextPadding),
})
})

local O
if K.Icon then
O=ac.Image(
K.Icon,
L.Title..":"..K.Icon,
0,
o,
"Dialog",
true,
K.IconThemed
)
O.Size=UDim2.new(0,22,0,22)
O.Parent=N
end

M.UIElements.UIListLayout=b("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
Parent=M.UIElements.Main
})

b("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=M.UIElements.Main,
})


M.UIElements.Title=b("TextLabel",{
Text=L.Title,
TextSize=20,
FontFace=Font.new(ac.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,O and-26-M.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=N
})
if L.Content then
b("TextLabel",{
Text=L.Content,
TextSize=18,
TextTransparency=.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(ac.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=M.UIElements.Main
},{
b("UIPadding",{
PaddingLeft=UDim.new(0,L.TextPadding),
PaddingRight=UDim.new(0,L.TextPadding),
PaddingBottom=UDim.new(0,L.TextPadding),
})
})
end

local P=b("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
})

local Q=b("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=M.UIElements.Main,
LayoutOrder=4,
},{
P,
})


local R={}

for S,T in next,L.Buttons do
local U=h(T.Title,T.Icon,T.Callback,T.Variant,Q,M,true)
table.insert(R,U)
end

local function CheckButtonsOverflow()
P.FillDirection=Enum.FillDirection.Horizontal
P.HorizontalAlignment=Enum.HorizontalAlignment.Right
P.VerticalAlignment=Enum.VerticalAlignment.Center
Q.AutomaticSize=Enum.AutomaticSize.None

for U,V in ipairs(R)do
V.Size=UDim2.new(0,0,1,0)
V.AutomaticSize=Enum.AutomaticSize.X
end

wait()

local W=P.AbsoluteContentSize.X
local X=Q.AbsoluteSize.X

if W>X then
P.FillDirection=Enum.FillDirection.Vertical
P.HorizontalAlignment=Enum.HorizontalAlignment.Right
P.VerticalAlignment=Enum.VerticalAlignment.Bottom
Q.AutomaticSize=Enum.AutomaticSize.Y

for Y,Z in ipairs(R)do
Z.Size=UDim2.new(1,0,0,40)
Z.AutomaticSize=Enum.AutomaticSize.None
end
else
local Y=X-W
if Y>0 then
local Z
local _=math.huge

for ad,ae in ipairs(R)do
local af=ae.AbsoluteSize.X
if af<_ then
_=af
Z=ae
end
end

if Z then
Z.Size=UDim2.new(0,_+Y,1,0)
Z.AutomaticSize=Enum.AutomaticSize.None
end
end
end
end

ac.AddSignal(M.UIElements.Main:GetPropertyChangedSignal"AbsoluteSize",CheckButtonsOverflow)
CheckButtonsOverflow()

wait()
M:Open()

return M
end

o:CreateTopbarButton("Close","x",function()
e(o.UIElements.Main,0.35,{Position=UDim2.new(0.5,0,0.5,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
o:Dialog{

Title="Close Window",
Content="Do you want to close this window? You will not be able to open it again.",
Buttons={
{
Title="Cancel",

Callback=function()end,
Variant="Secondary",
},
{
Title="Close Window",

Callback=function()o:Close():Destroy()end,
Variant="Primary",
}
}
}
end,999)


local function startResizing(ad)
if o.CanResize then
isResizing=true
r.Active=true
initialSize=o.UIElements.Main.Size
initialInputPosition=ad.Position
e(r,0.12,{ImageTransparency=.65}):Play()
e(r.ImageLabel,0.12,{ImageTransparency=0}):Play()
e(q.ImageLabel,0.1,{ImageTransparency=.35}):Play()

ac.AddSignal(ad.Changed,function()
if ad.UserInputState==Enum.UserInputState.End then
isResizing=false
r.Active=false
e(r,0.2,{ImageTransparency=1}):Play()
e(r.ImageLabel,0.17,{ImageTransparency=1}):Play()
e(q.ImageLabel,0.17,{ImageTransparency=.8}):Play()
end
end)
end
end

ac.AddSignal(q.InputBegan,function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch then
if o.CanResize then
startResizing(ad)
end
end
end)

ac.AddSignal(aa.InputChanged,function(ad)
if ad.UserInputType==Enum.UserInputType.MouseMovement or ad.UserInputType==Enum.UserInputType.Touch then
if isResizing and o.CanResize then
local ae=ad.Position-initialInputPosition
local af=UDim2.new(0,initialSize.X.Offset+ae.X*2,0,initialSize.Y.Offset+ae.Y*2)

e(o.UIElements.Main,0,{
Size=UDim2.new(
0,math.clamp(af.X.Offset,480,700),
0,math.clamp(af.Y.Offset,350,520)
)}):Play()
end
end
end)




if not o.HideSearchBar then
local ad=a.load'E'
local ae=false





















local af=g("Search","search",o.UIElements.SideBarContainer)
af.Size=UDim2.new(1,-o.UIPadding/2,0,39)
af.Position=UDim2.new(0,o.UIPadding/2,0,o.UIPadding/2)

ac.AddSignal(af.MouseButton1Click,function()
if ae then return end

ad.new(o.TabModule,o.UIElements.Main,function()

ae=false
if o.Resizable then
o.CanResize=true
end

e(s,0.1,{ImageTransparency=1}):Play()
s.Active=false
end)
e(s,0.1,{ImageTransparency=.65}):Play()
s.Active=true

ae=true
o.CanResize=false
end)
end




function o.DisableTopbarButtons(ad,ae)
for af,J in next,ae do
for K,L in next,o.TopBarButtons do
if L.Name==J then
L.Object.Visible=false
end
end
end
end

return o
end end end
local aa={
Window=nil,
Theme=nil,
Creator=a.load'a',
Themes=a.load'b',
Transparent=false,

TransparencyValue=.15,

UIScale=1,

ConfigManager=nil
}


local ab=a.load'f'

local ac=aa.Themes
local ad=aa.Creator

local ae=ad.New local af=
ad.Tween

ad.Themes=ac

local b=game:GetService"Players"and game:GetService"Players".LocalPlayer or nil
aa.Themes=ac

local e=protectgui or(syn and syn.protect_gui)or function()end

local g=gethui and gethui()or game.CoreGui


aa.ScreenGui=ae("ScreenGui",{
Name="WindUI",
Parent=g,
IgnoreGuiInset=true,
ScreenInsets="None",
},{
ae("UIScale",{
Scale=aa.Scale,
}),
ae("Folder",{
Name="Window"
}),






ae("Folder",{
Name="KeySystem"
}),
ae("Folder",{
Name="Popups"
}),
ae("Folder",{
Name="ToolTips"
})
})

aa.NotificationGui=ae("ScreenGui",{
Name="WindUI/Notifications",
Parent=g,
IgnoreGuiInset=true,
})
aa.DropdownGui=ae("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=g,
IgnoreGuiInset=true,
})
e(aa.ScreenGui)
e(aa.NotificationGui)
e(aa.DropdownGui)

ad.Init(aa)

math.clamp(aa.TransparencyValue,0,0.4)

local h=a.load'g'
local i=h.Init(aa.NotificationGui)

function aa.Notify(j,k)
k.Holder=i.Frame
k.Window=aa.Window
k.WindUI=aa
return h.New(k)
end

function aa.SetNotificationLower(j,k)
i.SetLower(k)
end

function aa.SetFont(j,k)
ad.UpdateFont(k)
end

function aa.AddTheme(j,k)
ac[k.Name]=k
return k
end

function aa.SetTheme(j,k)
if ac[k]then
aa.Theme=ac[k]
ad.SetTheme(ac[k])
ad.UpdateTheme()

return ac[k]
end
return nil
end

aa:SetTheme"Dark"

function aa.GetThemes(j)
return ac
end
function aa.GetCurrentTheme(j)
return aa.Theme.Name
end
function aa.GetTransparency(j)
return aa.Transparent or false
end
function aa.GetWindowSize(j)
return Window.UIElements.Main.Size
end


function aa.Popup(j,k)
k.WindUI=aa
return a.load'h'.new(k)
end


function aa.CreateWindow(j,k)
local n=a.load'F'

if not isfolder"WindUI"then
makefolder"WindUI"
end
if k.Folder then
makefolder(k.Folder)
else
makefolder(k.Title)
end

k.WindUI=aa
k.Parent=aa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

local o=true

local p=ac[k.Theme or"Dark"]

aa.Theme=p

ad.SetTheme(p)

local q=b.Name or"Unknown"

if k.KeySystem then
o=false
if k.KeySystem.SaveKey and k.Folder then
if isfile(k.Folder.."/"..q..".key")then
local r
if type(k.KeySystem.Key)=="table"then
r=table.find(k.KeySystem.Key,readfile(k.Folder.."/"..q..".key"))
else
r=tostring(k.KeySystem.Key)==tostring(readfile(k.Folder.."/"..q..".key"))
end
if r then
o=true
end
else
ab.new(k,q,function(r)o=r end)
end
else
ab.new(k,q,function(r)o=r end)
end
repeat task.wait()until o
end

local r=n(k)

aa.Transparent=k.Transparent
aa.Window=r














return r
end

return aa