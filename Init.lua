local LINJECTOR_VERSION="10.09.2023"

loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisInstanceProtect.lua"))() -- credit to iris
local hash=loadstring(game:HttpGet("https://raw.githubusercontent.com/zzerexx/scripts/main/HashLib.lua"), "HashLib")()
local disassemble=loadstring(game:HttpGet("https://raw.githubusercontent.com/TheSeaweedMonster/Luau/main/decompile.lua"), "Disassembler")()

local MarketplaceService=game:GetService'MarketplaceService'
local TweenService=game:GetService('TweenService')
local localplayer=game:GetService'Players'.LocalPlayer

local hashlibalgs={"sha1", "sha224"}
local hashalgs={
	"md5", "sha1", "sha224", "sha256", "sha384", "sha512", "sha3-256", "sha3-384", "sha3-512",
	"md2", "haval", "ripemd128", "ripemd160", "ripemd256", "ripemd320"
}
local consolecolor, colors="white", {
	['black']="black",
	['blue']="blue",
	['green']="green",
	['cyan']="cyan",
	['red']="red",
	['magenta']="magenta",
	['brown']="white",
	['light_gray']="white",
	['dark_gray']="white",
	['light_blue']="blue",
	['light_green']="green",
	['light_cyan']="cyan",
	['light_red']="red",
	['light_magenta']="magenta",
	['yellow']="yellow",
}
local ciphers={
	['aes-cbc']="CBC",
	['aes-cfb']="CFB",
	['aes-ctr']="CTR",
	['aes-ofb']="OFB",
	['aes-gcm']="GCM"
}
local specialinfo={
	MeshPart={
		"PhysicsData",
		"InitialSize"
	},
	UnionOperation={
		"AssetId",
		"ChildData",
		"FormFactor",
		"InitialSize",
		"MeshData",
		"PhysicsData"
	},
	Terrain={
		"SmoothGrid",
		"MaterialColors"
	}
}
local funcs={ 
	"getlocal",
	"getlocals",
	"setlocal",
	"getcallstack",
	"isuntouched",
	"setuntouched",
	"setupvaluename",
	"XPROTECT",
	"getpointerfromstate",
	"setnonreplicatedproperty",
	"readbinarystring"
}
local unavailable={
	"create_secure_function",
	"run_secure_function",
	"run_secure_lua",
	"secrun"
}
getgenv().Drawing.Fonts={
	['UI']=0,
	['System']=1,
	['Plex']=2,
	['Monospace']=3
}
local none=newcclosure(function() end, "none")

local function define(name, value, parent)
	local Function=(typeof(value) == "function" and islclosure(value) and newcclosure(value, name)) or value
	if parent ~= nil then
		parent[name]=lol
		return
	end
	getgenv()[name]=Function
end
local function connection(conn, enabled)
	for _,v in next, getconnections(conn) do
		if enabled then
			v:Enable()
		else
			v:Disable()
		end
	end
end


for _,v in next, funcs do 
	define(v, none)
end
for _,v in next, unavailable do
	define(v, none, t)
end

define(identifyexecutor, function()
	return "LInjector UWP", LINJECTOR_VERSION
end)
define(getexecutorname, function()
	return "LInjector UWP", LINJECTOR_VERSION
end)

define("disassemble", disassemble)

define("syn_io_read", readfile)
define("syn_io_write", writefile)
define("syn_io_append", appendfile)
define("syn_io_makefolder", makefolder)
define("syn_io_listdir", listfiles)
define("syn_io_isfile", isfile)
define("syn_io_isfolder", isfolder)
define("syn_io_delfile", delfile)
define("syn_io_delfolder", delfolder)

define("syn_mouse1click", mouse1click)
define("syn_mouse1press", mouse1press)
define("syn_mouse1release", mouse1release)

define("syn_mouse2click", mouse2click)
define("syn_mouse2press", mouse2press)
define("syn_mouse2release", mouse2release)

define("syn_mousescroll", mousescroll)
define("syn_mousemoverel", mousemoverel)
define("syn_mousemoveabs", mousemoveabs)

define("syn_keypress", keypress)
define("syn_keyrelease", keyrelease)


define("syn_crypt_encrypt", crypt.encrypt)
define("syn_crypt_decrypt", crypt.decrypt)
define("syn_crypt_b64_encode", crypt.base64encode)
define("syn_crypt_b64_decode", crypt.base64decode)
define("syn_crypt_random", crypt.generatekey)
define("syn_crypt_hash", function(data)
	return crypt.hash(data, "sha384")
end)
define("syn_crypt_derive", function(_, len)
	return crypt.generatebytes(len)
end)

define("syn_getgenv", getgenv)
define("syn_getrenv", getrenv)
define("syn_getsenv", getsenv)
define("syn_getmenv", getmenv)
define("syn_getreg", getreg)
define("syn_getgc", getgc)
define("syn_getinstances", getinstances)
define("syn_context_get", getidentity)
define("syn_context_set", setidentity)
define("syn_setfflag", setfflag)
define("syn_dumpstring", dumpstring)
define("syn_islclosure", islclosure)
define("syn_checkcaller", checkcaller)
define("syn_clipboard_set", setclipboard)
define("syn_newcclosure", newcclosure)
define("syn_decompile", decompile)
define("syn_getloadedmodules", getloadedmodules)
define("syn_getcallingscript", getcallingscript)
define("syn_isactive", isrbxactive)
define("syn_websocket_connect", function(a)
	assert(typeof(a) == "string", string.format("bad argument #1 to 'syn_websocket_connect' (string expected, got %s)", typeof(a)))
	return WebSocket.connect(a)
end)
define("syn_websocket_close", function(a)
	assert(a.OnMessage ~= nil, "Websocket connection expected")
	a:Close()
end)

define("is_synapse_function", isourclosure)
define("is_protosmasher_closure", isourclosure)
define("is_protosmasher_caller", checkcaller)
define("is_lclosure", islclosure)
define("iswindowactive", isrbxactive)
define("validfgwindow", isrbxactive)
define("getsynasset", getcustomasset)
define("getvirtualinputmanager", function()
	return cloneref(game:GetService("VirtualInputManager")) 
end)
local t={}
define("protect_gui", ProtectInstance, t) -- credit to iris
define("unprotect_gui", UnProtectInstance, t)


define("is_beta", function()
	return false
end, t)

local c=crypt
local crypt={}
define("encrypt", c.encrypt, crypt)
define("decrypt", c.decrypt, crypt)
define("hash", function(data)
	return c.hash(data, "sha384"):lower()
end, crypt)
define("derive", function(_, len)
	return c.generatebytes(len)
end, t)

define("random", c.generatebytes, crypt)

local base64={}
define("encode", c.base64encode, base64)
define("decode", c.base64decode, base64)
define("base64", base64, crypt)

local lz4={}
define("compress", lz4compress, lz4)
define("decompress", lz4decompress, lz4)
define("lz4", lz4, crypt)

local custom={}
define("encrypt", function(cipher, data, key, nonce)
	cipher=cipher:lower()
	if cipher:find("eax") or cipher:find("bf") then
		return ""
	end
	return crypt.custom_encrypt(data, key, nonce, ciphers[cipher:gsub("_", "-")])
end, custom)
define("decrypt", function(cipher, data, key, nonce)
	cipher=cipher:lower()
	if cipher:find("eax") or cipher:find("bf") then
		return ""
	end
	return crypt.custom_decrypt(data, key, nonce, ciphers[cipher:gsub("_", "-")])
end, custom)
define("hash", function(alg, data)
	alg=alg:lower():gsub("_", "-")
	local HashLib=table.find(hashlibalgs, alg)
	local SwLib=table.find(hashalgs, alg)
	assert(HashLib or SwLib, "bad argument #1 to 'hash' (non-existant hash algorithm)")
	if HashLib then 
		return hash[alg:gsub("-", "_")](data)
	end
	if SwLib then
		return c.hash(data, alg):lower()
	end
end, custom)

define("custom", custom, crypt)
define("crypt", crypt, t)
define("crypto", crypt, t)
define("websocket", WebSocket, t)

--[[define("secure_call", function(func, env, ...)
	local functype=typeof(func) 
	local envtype=typeof(env)
	assert(functype == "function", string.format("bad argument #1 to 'secure_call' (function expected, got %s)", functype))
	assert(envtype == "Instance", string.format("bad argument #2 to 'secure_call' (Instance expected, got %s)", envtype))
	local envclass=env.ClassName
	assert(envclass == "LocalScript" or envclass == "ModuleScript", string.format("bad argument #2 to 'secure_call' (LocalScript or ModuleScript expected, got %s)", envclass))
	local _, fenv=xpcall(function()
		return getsenv(env)
	end, function()
		return getfenv(func)
	end)
	return coroutine.wrap(function(...)
		setidentity(2)
		setfenv(0, fenv)
		setfenv(1, fenv)
		return func(...)
	end)(...)
end, t)]]


define("ror", bit.rrotate, bit)
define("rol", bit.lrotate, bit)
define("tohex", function(a)
	return tonumber(string.format("%08x", a % 4294967296))
end, bit)

define("syn", t)

define("LInjector", {
	loaded=true
})

setreadonly(syn, true)
setreadonly(LInjector, true)
setreadonly(bit, true)

local Functions={
	["messagebox"]="showmsg",
	["setDiscordRPC"]="setrpc",
	["rconsoleprint"]="rprintconsole",
	["rconsoleinfo"]="rconsoleinfo",
	["rconsolename"]="rconsolename",
	["rconsolewarn"]="rconsolewarn",
	["rconsoleerr"]="rconsoleerr",
	["toclipboard"]="toClipboard",
	["rconsoleclose"]="closeconsole",
	["rconsoleshow"]="showconsole",
	["rconsoleclear"]="consoleclear",
}

SendFunction=function(text)
	writefile("LINJECTOR/LINJECTOR.li", text)
end

for name, func in pairs(Functions) do
	define(name,function(...)
		local String, args="",table.pack(...)
		for i=1, args.n do
			String=("%s|||%s"):format(String, tostring(args[i]))
		end
		SendFunction(('%s%s'):format(name, String))
	end)
end

define("rprintconsole",rconsoleprint)
define("setclipboard",toclipboard)
define("set_clipboard",toclipboard)
define("set_clipboard",toclipboard)
define("Clipboard",{
	set=toclipboard
})

SendFunction(('welcome|||%s|||%s'):format(localplayer.DisplayName, MarketplaceService:GetProductInfo(game.PlaceId).Name))


-- Thank you Valyseonly

local LInjNotification=Instance.new("ScreenGui")
local holder_1=Instance.new("Frame")
local UIListLayout_1=Instance.new("UIListLayout")
local container_1=Instance.new("Frame")
local main_1=Instance.new("Frame")
local Top_1=Instance.new("TextLabel")
local UICorner_1=Instance.new("UICorner")
local LExIcon_1=Instance.new("ImageLabel")
local UIPadding_1=Instance.new("UIPadding")
local UICorner_2=Instance.new("UICorner")
local UIGradient_1=Instance.new("UIGradient")
local UIStroke_1=Instance.new("UIStroke")
local UIGradient_2=Instance.new("UIGradient")
local information_1=Instance.new("TextLabel")
local UIPadding_2=Instance.new("UIPadding")
local UIPadding_3=Instance.new("UIPadding")
LInjNotification.Name=c.generatebytes()
LInjNotification.Parent=game.CoreGui
LInjNotification.DisplayOrder=2147483647
holder_1.Parent=LInjNotification
holder_1.AnchorPoint=Vector2.new(0.5, 0.5)
holder_1.BackgroundColor3=Color3.fromRGB(255,255,255)
holder_1.BackgroundTransparency=1
holder_1.BorderColor3=Color3.fromRGB(0,0,0)
holder_1.BorderSizePixel=0
holder_1.Position=UDim2.new(0.5, 0,0.5, 0)
holder_1.Size=UDim2.new(1, 0,1, 0)
UIListLayout_1.Parent=holder_1
UIListLayout_1.HorizontalAlignment=Enum.HorizontalAlignment.Right
UIListLayout_1.SortOrder=Enum.SortOrder.LayoutOrder
UIListLayout_1.VerticalAlignment=Enum.VerticalAlignment.Bottom
container_1.Parent=holder_1
container_1.AnchorPoint=Vector2.new(0.5, 0.5)
container_1.BackgroundColor3=Color3.fromRGB(255,255,255)
container_1.BackgroundTransparency=1
container_1.BorderColor3=Color3.fromRGB(0,0,0)
container_1.BorderSizePixel=0
container_1.Position=UDim2.new(0.907002985, 0,0.891910732, 0)
container_1.Size=UDim2.new(0, 250,0, 155)
main_1.Parent=container_1
main_1.AnchorPoint=Vector2.new(0.5, 0.5)
main_1.AutomaticSize=Enum.AutomaticSize.XY
main_1.BackgroundColor3=Color3.fromRGB(255,255,255)
main_1.BorderColor3=Color3.fromRGB(0,0,0)
main_1.BorderSizePixel=0
main_1.Position=UDim2.new(2, -100,1, -70)
main_1.Size=UDim2.new(0, 215,0, 100)
Top_1.Parent=main_1
Top_1.AnchorPoint=Vector2.new(0.5, 0.5)
Top_1.BackgroundColor3=Color3.fromRGB(21,16,45)
Top_1.BorderColor3=Color3.fromRGB(27,42,53)
Top_1.Position=UDim2.new(0.5, 0,0.119999997, 0)
Top_1.Size=UDim2.new(0, 215,0, 25)
Top_1.Font=Enum.Font.Gotham
Top_1.Text="LInjector"
Top_1.TextColor3=Color3.fromRGB(255,255,255)
Top_1.TextSize=14
Top_1.TextXAlignment=Enum.TextXAlignment.Left
UICorner_1.Parent=Top_1
UICorner_1.CornerRadius=UDim.new(0,4)
LExIcon_1.Parent=Top_1
LExIcon_1.AnchorPoint=Vector2.new(0.5, 0.5)
LExIcon_1.BackgroundColor3=Color3.fromRGB(255,255,255)
LExIcon_1.BackgroundTransparency=1
LExIcon_1.BorderColor3=Color3.fromRGB(27,42,53)
LExIcon_1.Position=UDim2.new(-0.12110053, 0,0.5, 0)
LExIcon_1.Size=UDim2.new(0, 21,0, 21)
LExIcon_1.Image="rbxassetid://14149221913"
UIPadding_1.Parent=Top_1
UIPadding_1.PaddingLeft=UDim.new(0,40)
UICorner_2.Parent=main_1
UICorner_2.CornerRadius=UDim.new(0,4)
UIGradient_1.Parent=main_1
UIGradient_1.Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 46)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 31, 54))}
UIGradient_1.Rotation=90
UIStroke_1.Parent=main_1
UIStroke_1.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
UIStroke_1.Color=Color3.fromRGB(255,255,255)
UIStroke_1.Thickness=2
UIGradient_2.Parent=UIStroke_1
UIGradient_2.Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 39, 122)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 144, 213))}
information_1.Parent=main_1
information_1.AnchorPoint=Vector2.new(0.5, 0.5)
information_1.BackgroundColor3=Color3.fromRGB(255,255,255)
information_1.BackgroundTransparency=1
information_1.BorderColor3=Color3.fromRGB(0,0,0)
information_1.BorderSizePixel=0
information_1.Position=UDim2.new(0.49999997, 0,0.610000014, 0)
information_1.Size=UDim2.new(0, 214,0, 78)
information_1.Text=""
information_1.Font=Enum.Font.Montserrat
information_1.TextColor3=Color3.fromRGB(255,255,255)
information_1.TextSize=12
information_1.TextWrapped=true
information_1.TextXAlignment=Enum.TextXAlignment.Left
information_1.TextYAlignment=Enum.TextYAlignment.Top
UIPadding_2.Parent=information_1
UIPadding_2.PaddingLeft=UDim.new(0,10)
UIPadding_2.PaddingRight=UDim.new(0,2)
UIPadding_2.PaddingTop=UDim.new(0,10)
UIPadding_3.Parent=container_1
UIPadding_3.PaddingRight=UDim.new(0,20)

local function SAOKCV_fake_script() -- LInjNotification.scriptz
	local scriptz=Instance.new('LocalScript', LInjNotification)
	scriptz.Name=c.generatebytes()
	
	local function TypeWrite (Obj, Text)
		for I=1, #Text, 1 do
			Obj.Text=string.sub (Text, 1, I)
			wait()
		end
	end
	
	local Frame=main_1
	local BorderGradient=UIGradient_2
	local InformationBox=information_1

	local TWEEN_LENGTH=0.5
	local function Hide()
		for _, Child in next, Frame.Parent:GetDescendants() do 
			if Child:IsA ("TextLabel") then
				TweenService:Create(Child, TweenInfo.new (TWEEN_LENGTH), {TextTransparency=1, TextStrokeTransparency=1}):Play()
			elseif Child:IsA ("Frame") then
				TweenService:Create (Child, TweenInfo.new (TWEEN_LENGTH), {BackgroundTransparency=1}):Play()
			elseif Child:IsA ("ImageLabel") then
				TweenService:Create (Child, TweenInfo.new(TWEEN_LENGTH), {ImageTransparency=1}):Play()
			elseif Child:IsA ("UIStroke") then
				TweenService:Create (Child, TweenInfo.new(TWEEN_LENGTH), {Transparency=1}):Play()
			end
		end
	end

	local TweenInf=TweenInfo.new (2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0)
	local TweenRt=TweenService:Create (BorderGradient, TweenInf, {Rotation=360})

	local TweenSwitchFrame=TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
	local ShowFrame=TweenService:Create (Frame, TweenSwitchFrame, {Position=UDim2.new(1,  -100, 1, -70)})
	local HideFrame=TweenService:Create (Frame, TweenSwitchFrame, {Position=UDim2.new(2,  -100, 1, -70)})
	
	TweenRt:Play()
	ShowFrame:Play()
	ShowFrame.Completed:Wait()

	TypeWrite(InformationBox, "Todas Função carregada com successfully.\n\nAproveite Menorzin")

	wait(3)

	HideFrame:Play()
	HideFrame.Completed:Wait()
	LInjNotification:Remove()
end
coroutine.wrap(SAOKCV_fake_script)()
