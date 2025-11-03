script_name("carbCrosshair")
script_version("1.0")
script_url("https://kekwait.su")
script_author("Corenale | FireByte#2973")
script_description("CarboneumCrosshair - Crosshair from CS2 to GTA:SA!")

local imgui 	 =	require 'mimgui'
local cjc		 =	require 'carbjsonconfig'
local ffi		 =	require 'ffi'
local BigNum	 =	(function() local v0=256;local v1=2^24 ;local v2={};v2.__index={};local v4={__index=function(v79,v80) local v81={};local v82=v79.n;for v235=1,v82-1  do v81[v235]=0;end v81[v82]=v80;while v81[v82]>=v79.Base  do local v237=v81[v82];local v238=v237%v79.Base ;v81[v82]=v238;v82=v82-1 ;v81[v82]=(v237-v238)/v79.Base ;end v79[v80]=v81;return setmetatable(v81,v2);end};local v5={__index=function(v85,v86) local v87=setmetatable({n=v86,Base=v85.Base},v4);v85[v86]=v87;return v87;end};local v6=setmetatable({},{__index=function(v89,v90) local v91=setmetatable({Base=v90},v5);v89[v90]=v91;return v91;end});local function v7(v93,v94) local v95={};local v96= #v93;for v240=1,v96-1  do v95[v240]=(v94-v93[v240]) -1 ;end local v97=v94-v93[v96] ;while v97==v94  do v95[v96]=0;v96=v96-1 ;if (v96==0) then break;end v97=v95[v96] + 1 ;end if (v96>0) then v95[v96]=v97;end return setmetatable(v95,v2);end local function v8(v98,v99) return v98[1]>=(v99/2) ;end local function v9(v100,v101) local v102=v8(v100,v101);return (v102 and v7(v100,v101)) or v100 ,v102;end local function v10(v103,v104,v105) local v106=0;local v107={};for v243= #v103,1, -1 do local v244=v103[v243] + v104[v243] + v106 ;if (v244>=v105) then local v298=v244%v105 ;v106=(v244-v298)/v105 ;v244=v298;else v106=0;end v107[v243]=v244;end return setmetatable(v107,v2);end local function v11(v108,v109,v110) return v10(v108,v7(v109,v110),v110);end local function v12(v111,v112) for v246=1, #v111 do if (v111[v246]~=v112[v246]) then return false;end end return true;end local function v13(v113,v114,v115) local v116=v113[1];local v117=v114[1];if (v116~=v117) then if (v116>=(v115/2)) then if (v117>=(v115/2)) then return v116<v117 ;else return true;end elseif (v117>=(v115/2)) then return false;end return v116<v117 ;end for v247=2, #v113 do local v248=v113[v247];local v249=v114[v247];if (v248~=v249) then return v248<v249 ;end end return false;end local function v14(v118,v119,v120) local v121= #v118;local v122={};for v250=v121,1, -1 do local v251=v119[v250];if (v251==0) then if  not v122[v250] then v122[v250]=0;end else for v315=v121,1, -1 do local v316=v118[v315];local v317=(v250 + v315) -v121 ;if (v317>0) then local v322=(v251 * v316) + (v122[v317] or 0) ;local v323=v322%v120 ;local v324=(v322-v323)/v120 ;v122[v317]=v323;while (v324>0) and (v317>1)  do v317=v317-1 ;v322=(v122[v317] or 0) + v324 ;v323=v322%v120 ;v324=(v322-v323)/v120 ;v122[v317]=v323;end end end end end return setmetatable(v122,v2);end local function v15(v123,v124,v125) local v126= #v123;local v127,v128;v123,v127=v9(v123,v125);v124,v128=v9(v124,v125);local v129;if v127 then v129= not v128;elseif v128 then v129=true;else v129=false;end if v13(v123,v124,v125) then return v6[v125][v126][0],v123;end local v130;local v131;for v252=1,v126 do if (v124[v252]~=0) then v130=v252;v131=v124[v252];break;end end if  not v130 then error("Cannot divide by 0");end local v132;local v133=v123;repeat local v253=v8(v133,v125);if v253 then v133=v7(v133,v125);end local v254=setmetatable({},v2);local v255=0;for v281=1,v130 do local v282=(v125 * v255) + v133[v281] ;v255=v282%v131 ;v254[(v126-v130) + v281 ]=(v282-v255)/v131 ;end for v284=1,v126-v130  do v254[v284]=0;end if v253 then v254=v7(v254,v125);end v132=(v132 and v10(v132,v254,v125)) or v254 ;v133=v11(v123,v14(v124,v132,v125),v125);until v13((v9(v133,v125)),v124,v125) if v8(v133,v125) then v132=v11(v132,v6[v125][v126][1],v125);v133=v11(v123,v14(v124,v132,v125),v125);end if v129 then v132=v7(v132,v125);end return v132,v133;end local function v16(v134,v135,v136) local v137= #v134;if v12(v135,v6[v136][v137][0],v136) then return v6[v136][v137][1];end local v138=v16(v134,v15(v135,v6[v136][v137][2],v136),v136);if ((v135[v137]%2)==0) then return v14(v138,v138,v136);else return v14(v134,v14(v138,v138,v136),v136);end end local function v17(v139,v140,v141) local v142,v143=v15(v139,v140,v141);return v143;end local v18=math.log;local v19=v18(11);local function v20(v144,v145) local v146= #v144;local v147=v8(v144,v145);if (((v19/v18(v145)) + 1)<v146) then local v286={};local v287=v6[v145][v146][10];local v288=v6[v145][v146][0];local v289=0;repeat local v300;v144,v300=v15(v144,v287,v145);v289=v289 + 1 ;v286[v289]=v300[v146];until v12(v144,v288) if (v147 and  not v12(v286,v6[v145][v289][0])) then v286[v289 + 1 ]="-";end return table.concat(v286):reverse();else local v290=1;local v291=0;for v303=v146,2, -1 do v291=v291 + (v144[v303] * v290) ;v290=v290 * v145 ;end return tostring(v291 + ((v144[1] -((v147 and v145) or 0)) * v290) );end end local function v21(v148,v149) local v150=typeof or type ;if v149 then return function(v304,...) local v305=type(v304);if (v305=="number") then v304=v2.new(tostring(v304));elseif (v305=="string") then v304=v2.new(v304);elseif ((v305~="table") or (getmetatable(v304)~=v2)) then error("bad argument to #1: expected BigNum, got "   .. v150(v304) );end return v148(v304,v1,...);end;else return function(v306,v307) local v308=type(v306);if (v308=="number") then v306=v2.new(tostring(v306));elseif (v308=="string") then v306=v2.new(v306);elseif ((v308~="table") or (getmetatable(v306)~=v2)) then error("bad argument to #1: expected BigNum, got "   .. v150(v306) );end local v309=type(v307);if (v309=="number") then v307=v2.new(tostring(v307));elseif (v309=="string") then v307=v2.new(v307);elseif ((v309~="table") or (getmetatable(v307)~=v2)) then error("bad argument to #2: expected BigNum, got "   .. v150(v307) );end if ( #v306~= #v307) then error("You cannot operate on BigNums with different radix: "   ..  #v306   .. " and "   ..  #v307 );end return v148(v306,v307,v1);end;end end local function v22(v151,v152,v153) local v154=v6[v153][ #v151][0];while  not v12(v152,v154,v153) do v151,v152=v152,v17(v151,v152,v153);end return v151;end local function v23(v155,v156,v157) local v158=v6[v157][ #v155][0];return ((v155~=v158) and (v156~=v158) and (v14(v155,v156,v157)/v22(v155,v156,v157))) or v158 ;end local v24=("0"):byte();local function v25(v159,v160,v161) v161=v161 or 2 ;local v162=v20(v159,v160);if (( #v162-2)<v161) then return v162;else local v292={};for v310=1,v161 do v292[v310]=v162:byte(v310) -v24 ;end v292[v161 + 1 ]=(v162:byte(v161 + 1 ) -v24) + ((((v162:byte(v161 + 2 ) -v24)>4) and 1) or 0) ;v292[v161 + 2 ]= #v162-1 ;return ("%d."   .. ("%d"):rep(v161)   .. "e%d"):format(unpack(v292));end end v2.__tostring=v21(v20,true);v2.__unm=v21(v7,true);v2.__index.toScientificNotation=v21(v25,true);v2.__add=v21(v10);v2.__sub=v21(v11);v2.__mul=v21(v14);v2.__div=v21(v15);v2.__pow=v21(v16);v2.__mod=v21(v17);v2.__lt=v21(v13);v2.__eq=v21(v12);v2.__index.GDC=v21(v22);v2.__index.LCM=v21(v23);local function v39(v163,v164,v165,v166,v167,v168) if v166 then v166=tonumber(v166);local v295=v165:find(".",1,true) -1 ;local v296=v295 + v166 ;v165=(v165:sub(1,v295)   .. v165:sub(v295 + 2 )):sub(1,((v296>0) and v296) or 0 );if (v165=="") then v165="0";end return v14(v39(v163,v164,v165,nil,v167,v168),v16(v6[v168][v163][10],v6[v168][v163][v296-#v165 ],v168),v168);end local v169={(("0"):rep(v163-#v165 )   .. v165):byte(1, -1)};local v170= #v169;local v171=v6[v167][v170][0];local v172=v6[v167][v170][v168];for v256=1,v170 do v169[v256]=v169[v256] -v24 ;end local v173={};local v174=v163;repeat local v258;v169,v258=v15(v169,v172,v167);v173[v174]=tonumber(table.concat(v258));v174=v174-1 ;until v12(v169,v171) for v260=1,v174 do v173[v260]=0;end return setmetatable((v164 and v7(v173,v168)) or v173 ,v2);end v2.new=function(v175,v176) local v177=type(v175);if (v177=="number") then v175=tostring(v175);v177="string";end if (v177=="string") then local v297= #v175;if (v297>0) then local v319,v320=v175:match("^(%-?)0[Xx](%x*%.?%x*)$");if (v320 and (v320~="") and (v320~=".")) then return error("Hexidecimal is currently unsupported");else local v326,v327,v328,v329,v330=v175:find("^(%-?)(%d*(%.?)%d*)");if ((v329~="") and (v329~=".")) then local v332=v175:match("^[Ee]([%+%-]?%d+)$",v327 + 1 );if (v332 or (v327==v297)) then return v39(v176 or v0 ,v328=="-" ,(v332 and (v330=="") and (v329   .. ".")) or v329 ,v332,10,v1);end end end end error(v175   .. " is not a valid Decimal value" );elseif (v177=="table") then return setmetatable(v175,v2);else error(tostring(v175)   .. " is not a valid input to BigNum.new, please supply a string or table" );end end;v2.GetRange=function(v178,v179,v180) if  not v180 then v180=v1;end local v181={};for v262=2,v179 or v0  do v181[v262]=v180-1 ;end v181[1]=((v180-(v180%2))/2) -1 ;return "+/- "   .. v25(v181,v180) ;end;v2.SetDefaultRadix=function(v183,v184) v0=v184;end;local v43=58;local v44=64 * 64 ;local v45=v44 * 64 ;v2.fromString64=function(v185) local v186={};for v264=1, #v185/4  do local v265=4 * v264 ;local v266,v267,v268,v269=v185:byte(v265-3 ,v265);v186[v264]=((v266-v43) * v45) + ((v267-v43) * v44) + ((v268-v43) * 64) + (v269-v43) ;end return setmetatable(v186,v2);end;v2.__index.toString64=function(v187) local v188={};for v271=1, #v187 do local v272=v187[v271];local v273=v272%64 ;v272=(v272-v273)/64 ;local v274=v272%64 ;v272=(v272-v274)/64 ;local v275=v272%64 ;v272=(v272-v275)/64 ;local v276=v272%64 ;v188[v271]=string.char(v276 + v43 ,v275 + v43 ,v274 + v43 ,v273 + v43 );end return table.concat(v188);end;v2.__index.toConstantForm=function(v189,v190) v190=v190 or 16 ;local v191={"local CONSTANT_NUMBER = BigNum.new{\n\t"};local v192= #v189;for v278=1,v192 do local v279=tostring(v189[v278]);table.insert(v191,(" "):rep(0)   .. v279 );table.insert(v191,",");if ((v278%v190)==0) then table.insert(v191,"\n\t");else table.insert(v191," ");end end table.remove(v191);v191[ #v191]="\n}";WRITE_FILE_FOR_PLATFORM[PLATFORM](table.concat(v191));end;v2.__index.stringify=function(v194,v195) return ((v8(v194,v195 or v1 ) and "-") or " ")   .. "{"   .. table.concat(v194,", ")   .. "}" ;end;local v50={};v50.__index={};local function v52(v196,v197,v198) if v8(v197,v198) then v196=v7(v196,v198);v197=v7(v197,v198);end return setmetatable({Numerator=v196,Denominator=v197},v50);end local function v53(v199,v200) local v201=v22(v199.Numerator,v199.Denominator,v200);v199.Numerator=v15(v199.Numerator,v201,v200);v199.Denominator=v15(v199.Denominator,v201,v200);return v199;end local function v54(v204,v205,v206) return v52(v10(v14(v204.Numerator,v205.Denominator,v206),v14(v205.Numerator,v204.Denominator,v206),v206),v14(v204.Denominator,v205.Denominator,v206),v206);end local function v55(v207,v208,v209) return v52(v11(v14(v207.Numerator,v208.Denominator,v209),v14(v208.Numerator,v207.Denominator,v209),v209),v14(v207.Denominator,v208.Denominator,v209),v209);end local function v56(v210,v211,v212) return v52(v14(v210.Numerator,v211.Numerator,v212),v14(v210.Denominator,v211.Denominator,v212),v212);end local function v57(v213,v214,v215) return v52(v14(v213.Numerator,v214.Denominator,v215),v14(v213.Denominator,v214.Numerator,v215),v215);end local function v58() error("The modulo operation is undefined for Fractions");end local function v59(v216,v217,v218) v217=v15(v217.Numerator,v217.Denominator,v218);if (type(v217)=="number") then return v52(v16(v216.Numerator,v217,v218),v16(v216.Denominator,v217,v218),v218);else error("Cannot raise "   .. v20(v216,v218)   .. " to the Power of "   .. v20(v217,v218) );end end local function v60(v219,v220) return v20(v219.Numerator,v220)   .. " / "   .. v20(v219.Denominator,v220) ;end local function v61(v221,v222,v223) return v25(v221.Numerator,v222,v223)   .. " / "   .. v25(v221.Denominator,v222,v223) ;end local function v62(v224,v225,v226) return v13(v14(v224.Numerator,v225.Denominator,v226),v14(v225.Numerator,v224.Denominator,v226),v226);end local function v63(v227,v228) return v52(v7(v227.Numerator,v228),v227.Denominator,v228);end local function v64(v229,v230,v231) return v12(v14(v229.Numerator,v230.Denominator,v231),v14(v230.Numerator,v229.Denominator,v231),v231);end local function v65(v232,v233) local v234=typeof or type ;if v233 then return function(v312,...) if (getmetatable(v312)~=v50) then error("bad argument to #1: expected Fraction, got "   .. v234(v312) );end return v232(v312,v1,...);end;else return function(v313,v314) if (getmetatable(v313)~=v50) then error("bad argument to #1: expected Fraction, got "   .. v234(v313) );end if (getmetatable(v314)~=v50) then error("bad argument to #2: expected Fraction, got "   .. v234(v314) );end if ( #v313~= #v314) then error("You cannot operate on Fractions with BigNums of different sizes: "   ..  #v313   .. " and "   ..  #v314 );end return v232(v313,v314,v1);end;end end v50.__tostring=v65(v60,true);v50.__unm=v65(v63,true);v50.__index.Reduce=v65(v53,true);v50.__index.toScientificNotation=v65(v61,true);v50.__add=v65(v54);v50.__sub=v65(v55);v50.__mul=v65(v56);v50.__div=v65(v57);v50.__pow=v65(v59);v50.__mod=v65(v58);v50.__lt=v65(v62);v50.__eq=v65(v64);v2.newFraction=v21(v52);return v2; end)(); BigNum:SetDefaultRadix(256)
-- BigNum Library (https://github.com/RoStrap/Math/blob/master/BigNum.lua)

function math.round(v) return v+6e15-6e15 end

local CCamera			=	ffi.cast("void*", 0xB6F028)
local getWeaponRadius	=	ffi.cast("float (__thiscall*)(int CPed)", 0x609CD0)
local getWeaponSkill	=	ffi.cast("uint8_t (__thiscall*)(int CPed)", 0x5E6580)
local getWeapInfo		=	ffi.cast("int32_t (__cdecl*)(int weaponID, int skill)", 0x743C60)
local getBonePosition	=	ffi.cast("void (__thiscall*)(int CPed, float* CVector, int boneId, bool bDynamic)", 0x5E4280)
local getCrossPos		=	ffi.cast("void (__thiscall*)(void* CCamera, float range, float srcx, float srcy, float srcz, float* CVector, float* CVector)", 0x514970)

local CWorld__ProcessLineOfSight = ffi.cast("bool (__cdecl*)(float *origin, float *target, float *outColPoint, uint32_t *outEntity, bool buildings, bool vehicles, bool peds, bool objects, bool dummies, bool seeThrough, bool doIgnoreCameraCheck, bool shootThrough)", 0x56BA00)

local TEMP = {
	WindowProc = ffi.new("bool[1]"),
	thisScript = thisScript(),
	buf = ffi.new("char[35]"),
	CHPatch1 = ffi.new('char[16]', "\xD9\x05\x00\x00\x00\x00\x8B\x08\xE9"), CHPatch2 = ffi.new('float[1]'),
	get_crosshair_position_1 = ffi.new("float[3]"), get_crosshair_position_2 = ffi.new("float[3]"), getBodyPartCoordinates = ffi.new("float[3]"), windowCollapsed = true,
}

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
    if msg == 6 then
		if wparam == 0 then
			TEMP.windowCollapsed = false
		elseif wparam == 1 then
			TEMP.windowCollapsed = true
		end
    end
end)

function shareCodeToBytes(a)
	
	local ca = {}; a:gsub("CSGO--", ""):gsub("---", ""):gsub(".",function(c) table.insert(ca,c) end)
	
	local ra = {}; for i=#ca, 1, -1 do ra[#ra+1] = ca[i] end
	
	local big = BigNum.new("0")
	for i = 1, 25 do
		big = big * 57 + ('ABCDEFGHJKLMNOPQRSTUVWXYZabcdefhijkmnopqrstuvwxyz23456789'):find(ra[i]) - 1
	end
	
	local array, rmndr = {}, 0
	for i = 36, 1, -1 do
		big, rmndr = BigNum.__div(big, 16)
		array[i] = string.format("%x", tonumber(tostring(rmndr)))
		if BigNum.__lt(big, 16) then
			array[i-1] = string.format("%x", tonumber(tostring(big)))
			array[1] = array[1] and array[1] or 0
			break
		end
	end
	
	local ba = {}
	for i = 0, 16, 1 do
		ba[i+1] = tonumber("0x"..array[(i*2)+1]..array[(i*2)+2])
	end
	
	return ba
end

function bytesToShareCode(bytes)
	
	for i = 1, 18 do
		bytes[1] = bytes[1] + bytes[i]
	end
	bytes[1] = bit.band(bytes[1], 0xFF)
	
	local hexNum = ""
	for i = 1, #bytes do
		hexNum = hexNum..string.format("%02x", bytes[i])
	end
	
	local total = BigNum.new("0")
	
	for i = 1, #hexNum do
		total = total + (tonumber("0x"..hexNum:sub(i, i)) * (BigNum.__pow(16, (#hexNum - i))))
	end
	
	local chars = "CSGO-"
	for i = 1, 25 do
		local rem = tonumber(tostring(total % 57)) + 1
		chars = chars..('ABCDEFGHJKLMNOPQRSTUVWXYZabcdefhijkmnopqrstuvwxyz23456789'):sub(rem, rem)..((i % 5 == 0 and i ~= 25) and "-" or "")
		total = total / 57
	end
	
	return chars
end

function getBodyPartCoordinates(id, handle)
	if doesCharExist(handle) then
		local vec = TEMP.getBodyPartCoordinates
		getBonePosition(getCharPointer(handle), vec, id, true)
		return vec[0], vec[1], vec[2]
	end
end

function get_crosshair_position(d, pPos)
	local vec_out = TEMP.get_crosshair_position_1
	local tmp_vec = TEMP.get_crosshair_position_2
	local pPos = pPos or {getCharCoordinates(PLAYER_PED)}
	local weap = ffi.cast('uint32_t*', ffi.cast("int32_t*", 0xB7CD98)[0]+0x5A0+28*ffi.cast("uint8_t*", ffi.cast("int32_t*", 0xB7CD98)[0])[0x718])[0]
	getCrossPos(CCamera, d or getGunDistance(weap), pPos[1], pPos[2], pPos[3], tmp_vec, vec_out)
	return vec_out[0], vec_out[1], vec_out[2], tmp_vec[0], tmp_vec[1], tmp_vec[2]
end

function calculateBulletTrajectoryWhileAiming()
	local t = ffi.new("float[1]", ffi.cast("uint32_t*", ffi.cast("uint32_t*", 0x740581)[0])[0])
	t[0] = t[0] * 0.006283185445
	
	local CPed = ffi.cast("uint32_t*", 0xB7CD98)[0]
	local weapslot = ffi.cast("uint8_t*", CPed)[0x718]
	local gun = ffi.cast('uint8_t*', CPed)[0x5A0+28*weapslot]
	local currSkill = (gun<33) and getWeaponSkill(ffi.cast("int32_t*", 0xB7CD98)[0]) or 1

	local acc = gun == 34 and 999 or ffi.cast("float*", getWeapInfo(gun, currSkill))[14] ~= 0 and ffi.cast("float*", getWeapInfo(gun, currSkill))[14] or ffi.cast("float*", getWeapInfo(gun, 1))[14]
	local range = gun == 34 and 999 or ffi.cast("float*", getWeapInfo(gun, currSkill))[2] ~= 0 and ffi.cast("float*", getWeapInfo(gun, currSkill))[2] or ffi.cast("float*", getWeapInfo(gun, 1))[2]
	
	local m_nWeaponAccuracy = ffi.cast("uint8_t*", CPed)[0x71A]

	local RandomNumberInRange = (100-m_nWeaponAccuracy)/acc
	local RandomNumberInRange = RandomNumberInRange*(isCharDucking(1) and 0.5 or 1)

	local fPlayerAimScaleDist = ffi.cast("float*", 0x8D6114)[0]
	local v52 = (fPlayerAimScaleDist/range*3 <= 1) and (fPlayerAimScaleDist/range*3) or 1
	local RandomNumberInRange = v52*RandomNumberInRange*ffi.cast("float*", 0xB7CDC8)[0]*ffi.cast("float*", ffi.cast("uint32_t*", 0x74046F)[0])[0]


	local fireOffset = gun == 34 and 999 or ffi.cast("float*", getWeapInfo(gun, currSkill))[11] ~= 0 and ffi.cast("float*", getWeapInfo(gun, currSkill))[11] or ffi.cast("float*", getWeapInfo(gun, 1))[11]
	local cr1 = {getBodyPartCoordinates(24, 1)}
	cr1[3] = cr1[3] + 0.15 + fireOffset
	
	local cr1 = {get_crosshair_position(range, cr1)}; cr1 = {cr1[4], cr1[5], cr1[6]} -- rly bruh
	
	local out = 0
	local eend = {get_crosshair_position(range*3)}
	local a = {math.cos(ffi.cast('float*', 0xB6F258)[0]+math.pi/2), math.sin(ffi.cast('float*', 0xB6F258)[0]+math.pi/2), 0}
	local v55 = t[0]
	local gunshellPos = {ffi.cast("float*", 0xB6F350)[0], ffi.cast("float*", 0xB6F354)[0], ffi.cast("float*", 0xB6F358)[0]}

	local gunshellDir = a[2] * RandomNumberInRange
	out = a[1] * RandomNumberInRange
	local gunshellSize = math.sin(v55)
	eend[1] = out * gunshellSize + eend[1]
	eend[2] = eend[2] + gunshellDir * gunshellSize
	eend[3] = a[3] * RandomNumberInRange * gunshellSize + eend[3]
	
	local gunshellDir = gunshellPos[2] * RandomNumberInRange
	out = gunshellPos[1] * RandomNumberInRange
	local gunshellSize = math.cos(v55)
	eend[1] = out * gunshellSize + eend[1]
	eend[2] = eend[2] + gunshellDir * gunshellSize
	eend[3] = gunshellPos[3] * RandomNumberInRange * gunshellSize + eend[3]
	
	local origin = ffi.new("float[3]", {unpack(cr1)})
	local target = ffi.new("float[3]", {eend[1], eend[2], eend[3]})
	local outColPoint = ffi.new("float[11]")
	local outEntity = ffi.new("uint32_t[1]")
	ffi.cast("uint32_t*", 0xB7CD68)[0] = CPed
	local res = CWorld__ProcessLineOfSight(origin, target, outColPoint, outEntity, true, true, true, true, false, true, false, false)
	ffi.cast("uint32_t*", 0xB7CD68)[0] = 0

	return res, {cr1[1], cr1[2], cr1[3]}, (res and {outColPoint[0], outColPoint[1], outColPoint[2]} or {eend[1], eend[2], eend[3]})
end

function convert3DCoordsToScreen(x, y, z)
	local m_mViewMatrix = ffi.cast("float*", 0xB6FA2C)
	local RsGlobal = ffi.cast("int32_t*", 0xC17040)
	local w, h = RsGlobal[1], RsGlobal[2]
	
	local sz = (m_mViewMatrix[2] * x + m_mViewMatrix[6] * y + m_mViewMatrix[10] * z + m_mViewMatrix[14])
	
	local sx = (w * (m_mViewMatrix[8] * z + m_mViewMatrix[4] * y + m_mViewMatrix[0] * x + m_mViewMatrix[12])) / sz
	local sy = (h * (m_mViewMatrix[9] * z + m_mViewMatrix[1] * x + m_mViewMatrix[5] * y + m_mViewMatrix[13])) / sz
	
	return sx, sy
end

local CFG = {
	crosshair = ffi.new("bool[1]", false),
	cl_crosshaircolor = ffi.new("int[1]", 1),
	cl_crosshaircolor_r = ffi.new("int[1]", 50),
	cl_crosshaircolor_g = ffi.new("int[1]", 250),
	cl_crosshaircolor_b = ffi.new("int[1]", 50),
	cl_crosshairalpha = ffi.new("int[1]", 200),
	cl_crosshair_dynamic_splitdist = ffi.new("int[1]", 7),
	cl_crosshair_dynamic_splitalpha_innermod = ffi.new("float[1]", 1),
	cl_crosshair_dynamic_splitalpha_outermod = ffi.new("float[1]", 0.5),
	cl_crosshair_dynamic_maxdist_splitratio = ffi.new("float[1]", 0.3),
	cl_crosshair_recoil = ffi.new("bool[1]", false),
	cl_crosshairdot = ffi.new("bool[1]", false),
	cl_crosshair_drawoutline = ffi.new("bool[1]", false),
	cl_crosshair_t = ffi.new("bool[1]", false),
	cl_crosshairusealpha = ffi.new("bool[1]", false),
	cl_crosshairgap = ffi.new("float[1]", -0.8),
	cl_crosshair_outlinethickness = ffi.new("float[1]", 0),
	cl_crosshairstyle = ffi.new("int[1]", 5),
	cl_crosshairsize = ffi.new("float[1]", 1.8),
	cl_crosshairthickness = ffi.new("float[1]", 0.7),
}
cjc.load("config/carbCrosshair.json", CFG)

ffi.copy(ffi.cast("void*", 0x58FBBF), CFG.crosshair[0] and "\x90\x90\x90\x90\x90" or "\xE8\x5C\xE4\xFF\xFF", 5)

imgui.OnInitialize(function()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	imgui.GetIO().IniFilename = nil
	
	local config = imgui.ImFontConfig()
	config.PixelSnapH = true
	config.GlyphExtraSpacing = ImVec2(0.1, 0)
	imgui.GetIO().Fonts:Clear()
	
	imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\Arialbd.ttf', 15.0, config)
	
	imgui.GetIO().MouseDrawCursor = true
	
	style.WindowRounding = 5
	style.FrameRounding = 3
	style.ItemSpacing = imgui.ImVec2(5, 4)
	style.PopupRounding = 5
	style.TabRounding = 5
	style.GrabMinSize = 6
	style.GrabRounding = 2
	style.FrameBorderSize = 1
	style.WindowMinSize = imgui.ImVec2(0, 0)

	colors[imgui.lib.ImGuiCol_FrameBg]			= imgui.ImVec4(0.0666, 0.0666, 0.0666, 1)
	colors[imgui.lib.ImGuiCol_FrameBgHovered]	= colors[imgui.lib.ImGuiCol_FrameBg]
	colors[imgui.lib.ImGuiCol_FrameBgActive]	= colors[imgui.lib.ImGuiCol_FrameBg]
	colors[imgui.lib.ImGuiCol_TitleBg]			= imgui.ImVec4(0.00, 0.00, 0.00, 1)
	colors[imgui.lib.ImGuiCol_TitleBgCollapsed]	= colors[imgui.lib.ImGuiCol_TitleBg]
	colors[imgui.lib.ImGuiCol_TitleBgActive]	= colors[imgui.lib.ImGuiCol_TitleBg]
	colors[imgui.lib.ImGuiCol_Button]			= colors[imgui.lib.ImGuiCol_FrameBg]
	colors[imgui.lib.ImGuiCol_WindowBg]			= colors[imgui.lib.ImGuiCol_FrameBg]
	colors[imgui.lib.ImGuiCol_BorderShadow]		= colors[imgui.lib.ImGuiCol_FrameBg]
	colors[imgui.lib.ImGuiCol_Border]			= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_SeparatorActive]	= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_Header]			= imgui.ImVec4(1, 1, 1, 0.5)
	colors[imgui.lib.ImGuiCol_HeaderHovered]	= imgui.ImVec4(1, 1, 1, 0.25)
	colors[imgui.lib.ImGuiCol_HeaderActive]		= imgui.ImVec4(1, 1, 1, 0.5)
	colors[imgui.lib.ImGuiCol_CheckMark]		= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_ButtonActive]		= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_SliderGrab]		= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_SliderGrabActive]	= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_ButtonHovered]	= imgui.ImVec4(1, 1, 1, 0.25)
	colors[imgui.lib.ImGuiCol_SeparatorHovered]	= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_Text]				= imgui.ImVec4(1, 1, 1, 1)
	colors[imgui.lib.ImGuiCol_PopupBg]			= imgui.ImVec4(0.08, 0.08, 0.08, 1)
	
end)

function renderCrosshair(render, cX, cY)

	local CPed = ffi.cast("int32_t*", 0xB7CD98)[0]
	local weapslot = ffi.cast("uint8_t*", CPed)[0x718]
	local weap = ffi.cast('uint8_t*', CPed)[0x5A0+28*weapslot]
	local CCurVer = ffi.cast("int32_t*", 0xBA18FC)[0]
	local RsGlobal = ffi.cast("int32_t*", 0xC17040)
	local w, h = RsGlobal[1], RsGlobal[2]
	local ImVec2 = imgui.ImVec2
	local ImVec4 = imgui.ImVec4

	local alpha = CFG.cl_crosshairusealpha[0] and CFG.cl_crosshairalpha[0] or 200
	
	local blackColor = join_argb(alpha, 0, 0, 0)
	local color
	if CFG.cl_crosshaircolor[0] == 5 then
		color = join_argb(alpha, CFG.cl_crosshaircolor_r[0], CFG.cl_crosshaircolor_g[0], CFG.cl_crosshaircolor_b[0])
	else
		local colorList = {
			[0] = {0xFA, 0x33, 0x33},
			[1] = {0x33, 0xFA, 0x33},
			[2] = {0xFA, 0xFA, 0x33},
			[3] = {0x33, 0x33, 0xFA},
			[4] = {0x33, 0xFA, 0xFA},
		}
		local function getColor(id)
			return colorList[id] or colorList[0]
		end
		local clr = getColor(CFG.cl_crosshaircolor[0])
		color = join_argb(alpha, clr[3], clr[2], clr[1])
	end

	local style = CFG.cl_crosshairstyle[0]
	local dynamicCrosshair = style ~= 4
	local classicCrosshair = style == 5
	local splitCrosshair   = style <  4
	
	local mp = h / 480 -- default source games gui scaling factor
	
	local recoil = dynamicCrosshair and math.floor(splitCrosshair and (CCurVer ~= 0 and 0 or (getWeaponRadius(CPed) - 0.2) * mp * 64) or math.floor(ffi.cast("int32_t*", 0xBA18FC)[0] ~= 0 and 0 or ffi.cast('float*', 0xB7CDC8)[0] * 5)) or 0
	
	if CCurVer ~= 0 then ffi.cast('float*', 0xB7CDC8)[0] = CCurVer ~= 0 and 0 end
	
	local gap, length, width, outline = CFG.cl_crosshairgap[0]+(classicCrosshair and (0.1 + (mp - 2) * 1.6) or 0), math.floor(0.5 + (CFG.cl_crosshairsize[0] * mp)), math.floor(0.5 + (CFG.cl_crosshairthickness[0] * mp)), math.floor(CFG.cl_crosshair_outlinethickness[0]) * 2
	local width = width == 0 and 1 or width

	local gap = math.floor(((classicCrosshair and math.floor(5 + gap + ((math.floor(gap) % 2) == 1 and 0.001 or -0.001 --[[float inaccuracy fix]])) or gap+5) + math.floor((width - 3) / 2)) + 1)
	
	local alakl1 =  gap + recoil - 0.5
	local alakl2 =  gap + recoil - 0.5
	local alakl3 = -gap - recoil + 0.5
	local alakl4 = -gap - recoil + 0.5

	if math.fmod(width, 2) == 0 then
		alakl1	=  gap + recoil
		alakl2	=  gap + recoil
		alakl3	= -gap - recoil
		alakl4	= -gap - recoil
		cX = cX - 0.5; cY = cY + 0.5
	end
	
	local strangeOutlineBehavior = (CFG.cl_crosshair_outlinethickness[0] < 1) and (CFG.cl_crosshair_outlinethickness[0] > 0)

	local splitDist = CFG.cl_crosshair_dynamic_splitdist[0]
	local crosshairSplitted = splitCrosshair and gap+recoil > splitDist * mp
	
	local innLength = crosshairSplitted and math.ceil(length * (1 - CFG.cl_crosshair_dynamic_maxdist_splitratio[0])) or length
	
	local innAlakl1, innAlakl2, innAlakl3, innAlakl4 = alakl1, alakl2, alakl3, alakl4
	local innblackColor, innColor = blackColor, color
	if crosshairSplitted then
		innAlakl1 =  math.floor(splitDist * mp) - 0.5
		innAlakl2 =  math.floor(splitDist * mp) - 0.5
		innAlakl3 = -math.floor(splitDist * mp) + 0.5
		innAlakl4 = -math.floor(splitDist * mp) + 0.5
		
		innblackColor = bit.band(blackColor, 0xFFFFFF) + bit.lshift(bit.rshift(bit.band(blackColor, 0xFF000000), 24) * CFG.cl_crosshair_dynamic_splitalpha_innermod[0], 24)
		innColor = bit.band(color, 0xFFFFFF) + bit.lshift(bit.rshift(bit.band(color, 0xFF000000), 24) * CFG.cl_crosshair_dynamic_splitalpha_innermod[0], 24)
	end
	
	if CFG.cl_crosshair_drawoutline[0] then
		if CFG.cl_crosshairdot[0] then
			local cX2, cY2 = cX, cY
			if strangeOutlineBehavior then
				cX2, cY2 = cX - 1, cY - 1
			end
			render:AddRectFilled(ImVec2(cX2+0.5-(outline/2)-width/2, cY2+0.5-(outline/2)-width/2), ImVec2(cX+0.5+(outline/2)+width/2, cY+0.5+(outline/2)+width/2), blackColor)
		end
		
		local cX, cY, outline = cX, cY, outline
		if strangeOutlineBehavior then
			cX, cY, outline = cX - 0.5, cY - 0.5, outline + 1
		end
		if length>0 then
			render:AddLine(ImVec2(cX+innAlakl4+outline/2, cY), ImVec2(cX-innLength+innAlakl4-outline/2, cY), innblackColor, width+outline)
			if not CFG.cl_crosshair_t[0] then
				render:AddLine(ImVec2(cX, cY+innAlakl3+outline/2), ImVec2(cX, cY-innLength+innAlakl3-outline/2), innblackColor, width+outline)
			end
			render:AddLine(ImVec2(cX+innLength+innAlakl1+outline/2, cY), ImVec2(cX+innAlakl1-outline/2, cY), innblackColor, width+outline)
			render:AddLine(ImVec2(cX, cY+innLength+innAlakl2+outline/2), ImVec2(cX, cY+innAlakl2-outline/2), innblackColor, width+outline)
		end
	end
	
	if CFG.cl_crosshairdot[0] then
		render:AddRectFilled(ImVec2(cX+0.5-width/2, cY+0.5-width/2), ImVec2(cX+0.5+width/2, cY+0.5+width/2), color)
	end
	
	render:AddLine(ImVec2(cX+innAlakl4, cY), ImVec2(cX-innLength+innAlakl4, cY), innColor, width)
	if not CFG.cl_crosshair_t[0] then
		render:AddLine(ImVec2(cX, cY+innAlakl3), ImVec2(cX, cY-innLength+innAlakl3), innColor, width)
	end
	render:AddLine(ImVec2(cX+innLength+innAlakl1, cY), ImVec2(cX+innAlakl1, cY), innColor, width)
	render:AddLine(ImVec2(cX, cY+innLength+innAlakl2), ImVec2(cX, cY+innAlakl2), innColor, width)
	
	
	if crosshairSplitted then
		local alakl1 = math.floor(alakl1 + innLength) + 0.5
		local alakl2 = math.floor(alakl2 + innLength) + 0.5
		local alakl3 = math.floor(alakl3 - innLength) - 0.5
		local alakl4 = math.floor(alakl4 - innLength) - 0.5
		
		local splitLength = math.floor(length * (CFG.cl_crosshair_dynamic_maxdist_splitratio[0]))
		
		local splitBlackColor = bit.band(blackColor, 0xFFFFFF) + bit.lshift(bit.rshift(bit.band(blackColor, 0xFF000000), 24) * CFG.cl_crosshair_dynamic_splitalpha_outermod[0], 24)
		local splitColor = bit.band(color, 0xFFFFFF) + bit.lshift(bit.rshift(bit.band(color, 0xFF000000), 24) * CFG.cl_crosshair_dynamic_splitalpha_outermod[0], 24)
		
		if CFG.cl_crosshair_drawoutline[0] then
			local cX, cY, outline = cX, cY, outline
			if strangeOutlineBehavior then
				cX, cY, outline = cX - 0.5, cY - 0.5, outline + 1
			end
			if length>0 then
				render:AddLine(ImVec2(cX+alakl4+outline/2, cY), ImVec2(cX-splitLength+alakl4-outline/2, cY), splitBlackColor, width+outline)
				if not CFG.cl_crosshair_t[0] then
					render:AddLine(ImVec2(cX, cY+alakl3+outline/2), ImVec2(cX, cY-splitLength+alakl3-outline/2), splitBlackColor, width+outline)
				end
				render:AddLine(ImVec2(cX+splitLength+alakl1+outline/2, cY), ImVec2(cX+alakl1-outline/2, cY), splitBlackColor, width+outline)
				render:AddLine(ImVec2(cX, cY+splitLength+alakl2+outline/2), ImVec2(cX, cY+alakl2-outline/2), splitBlackColor, width+outline)
			end
		end
		
		render:AddLine(ImVec2(cX+alakl4, cY), ImVec2(cX-splitLength+alakl4, cY), splitColor, width)
		if not CFG.cl_crosshair_t[0] then
			render:AddLine(ImVec2(cX, cY+alakl3), ImVec2(cX, cY-splitLength+alakl3), splitColor, width)
		end
		render:AddLine(ImVec2(cX+splitLength+alakl1, cY), ImVec2(cX+alakl1, cY), splitColor, width)
		render:AddLine(ImVec2(cX, cY+splitLength+alakl2), ImVec2(cX, cY+alakl2), splitColor, width)
	end
end

function stringToBool(arg)
	local arg = string.lower(arg):gsub("%s", "")
	local tonumberedArg = tonumber(arg)
	if arg  == "true" then
		return true
	elseif arg  == "false" then
		return false
	elseif tonumberedArg ~= nil then
		return tonumberedArg ~= 0
	end
end

function stringToInt(arg)
	local partitiallyParsed = arg:match("^%s*[%-%d]+(.*)$")
	local arg = arg:match("^%s*([%-%d]+)$")
	return tonumber(arg), partitiallyParsed
end

function stringToFloat(arg)
	local partitiallyParsed = arg:match("^%s*[%-%d%.]+(.*)$")
	local arg = arg:match("^%s*([%-%d%.]+)$")
	return tonumber(arg), partitiallyParsed
end

function createSFCommandBool(ConVar, callback)
	sampfuncsRegisterConsoleCommand(ConVar, function(arg)
		local inputArg = arg:match("^%s*(.+)")
		if not arg or arg == "" then
			sampfuncsLog("[Console] "..tostring(ConVar).." = "..tostring(CFG[ConVar][0]))
			return
		end
		local arg = stringToBool(arg)
		if arg ~= nil then
			CFG[ConVar][0] = arg
			if callback then
				callback(ConVar)
			end
			CFG()
		else
			sampfuncsLog("{FFFF00}ERROR: String '"..tostring(inputArg).."' can't be converted to bool")
			sampfuncsLog("{FFFF00}Failed to parse input ConVar '"..tostring(ConVar).."' from string '"..tostring(inputArg).."'")
		end
	end)
end

function createSFCommandInt(ConVar, callback)
	sampfuncsRegisterConsoleCommand(ConVar, function(arg)
		local inputArg = arg:match("^%s*(.+)")
		if not arg or arg == "" then
			sampfuncsLog("[Console] "..tostring(ConVar).." = "..tostring(CFG[ConVar][0]))
			return
		end
		local arg, partitiallyParsed = stringToInt(arg)
		if arg ~= nil then
			CFG[ConVar][0] = arg
			if callback then
				callback(ConVar)
			end
			CFG()
		else
			if partitiallyParsed then
				sampfuncsLog("{FFFF00}ERROR: String '"..tostring(inputArg).."' can't be converted to int, parsed to: '"..partitiallyParsed.."'")
				sampfuncsLog("{FFFF00}Failed to parse input ConVar '"..tostring(ConVar).."' from string '"..tostring(inputArg).."'")
			else
				sampfuncsLog("{FFFF00}ERROR: String '"..tostring(inputArg).."' can't be converted to int")
				sampfuncsLog("{FFFF00}Failed to parse input ConVar '"..tostring(ConVar).."' from string '"..tostring(inputArg).."'")
			end
		end
	end)
end

function createSFCommandFloat(ConVar, callback)
	sampfuncsRegisterConsoleCommand(ConVar, function(arg)
		local inputArg = arg:match("^%s*(.+)")
		if not arg or arg == "" then
			sampfuncsLog("[Console] "..tostring(ConVar).." = "..tostring(CFG[ConVar][0]))
			return
		end
		local arg, partitiallyParsed = stringToFloat(arg)
		if arg ~= nil then
			CFG[ConVar][0] = arg
			if callback then
				callback(ConVar)
			end
			CFG()
		else
			if partitiallyParsed then
				sampfuncsLog("{FFFF00}ERROR: String '"..tostring(inputArg).."' can't be converted to float, parsed to: '"..partitiallyParsed.."'")
				sampfuncsLog("{FFFF00}Failed to parse input ConVar '"..tostring(ConVar).."' from string '"..tostring(inputArg).."'")
			else
				sampfuncsLog("{FFFF00}ERROR: String '"..tostring(inputArg).."' can't be converted to float32")
				sampfuncsLog("{FFFF00}Failed to parse input ConVar '"..tostring(ConVar).."' from string '"..tostring(inputArg).."'")
			end
		end
	end)
end

function main()
	if isSampfuncsLoaded then
		while not isSampfuncsLoaded() do wait(0) end
		createSFCommandBool("crosshair", function(ConVar)
			ffi.copy(ffi.cast("void*", 0x58FBBF), CFG[ConVar][0] and "\x90\x90\x90\x90\x90" or "\xE8\x5C\xE4\xFF\xFF", 5)
			-- ffi.copy(ffi.cast("void*", 0x609CF1), "\xD9\x40\x38\x8B\x08", 5)
		end)
		createSFCommandBool("cl_crosshairusealpha")
		createSFCommandBool("cl_crosshairdot")
		createSFCommandBool("cl_crosshair_drawoutline")
		createSFCommandBool("cl_crosshair_t")
		createSFCommandBool("cl_crosshair_recoil")
		createSFCommandInt("cl_crosshaircolor")
		createSFCommandInt("cl_crosshaircolor_r")
		createSFCommandInt("cl_crosshaircolor_g")
		createSFCommandInt("cl_crosshaircolor_b")
		createSFCommandInt("cl_crosshairalpha")
		createSFCommandInt("cl_crosshairstyle")
		createSFCommandInt("cl_crosshair_dynamic_splitdist")
		createSFCommandFloat("cl_crosshairgap")
		createSFCommandFloat("cl_crosshairthickness")
		createSFCommandFloat("cl_crosshair_outlinethickness")
		createSFCommandFloat("cl_crosshairsize")
		createSFCommandFloat("cl_crosshair_dynamic_splitalpha_innermod")
		createSFCommandFloat("cl_crosshair_dynamic_splitalpha_outermod")
		createSFCommandFloat("cl_crosshair_dynamic_maxdist_splitratio")
	end
	if isSampLoaded then
		while not isSampLoaded() do wait(0) end
		sampRegisterChatCommand("carbch", function()
			TEMP.WindowProc[0] = not TEMP.WindowProc[0]
		end)
	end
	while true do wait(0)
		if testCheat("bm") then -- Bloodmother?
			TEMP.WindowProc[0] = not TEMP.WindowProc[0]
		end
	end
end

function join_argb(a, r, g, b)
	return bit.bor(bit.bor(bit.bor(b, bit.lshift(g, 8)), bit.lshift(r, 16)), bit.lshift(a, 24))
end

function imgui.ToolTip(text)
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.Text(text)
		imgui.EndTooltip()
	end
end

imgui.OnFrame(function() return not ffi.cast("bool*", 0xB7CB49)[0] and TEMP.windowCollapsed and TEMP.WindowProc[0] end, function(mainFunc)

	mainFunc.HideCursor = not TEMP.WindowProc[0]

	imgui.Begin("CarbCrosshair", TEMP.WindowProc, 66)
		if imgui.Checkbox('Enabled', CFG.crosshair) then
			CFG()
			ffi.copy(ffi.cast("void*", 0x58FBBF), CFG.crosshair[0] and "\x90\x90\x90\x90\x90" or "\xE8\x5C\xE4\xFF\xFF", 5)
			-- ffi.copy(ffi.cast("void*", 0x609CF1), "\xD9\x40\x38\x8B\x08", 5)
		end
		imgui.PushItemWidth(168)

		imgui.Text("CS:GO Sharecode Import")
		if imgui.InputText("##CSGO Sharecode", TEMP.buf, 35, 32) then
		
			local dict = "[ABCDEFGHJKLMNOPQRSTUVWXYZabcdefhijkmnopqrstuvwxyz23456789]"
			local dict = string.rep(dict, 5)
			if ffi.string(TEMP.buf):match("^CSGO%-"..dict.."%-"..dict.."%-"..dict.."%-"..dict.."%-"..dict.."$") == ffi.string(TEMP.buf) then
			
				local bytes = shareCodeToBytes(ffi.string(TEMP.buf))
				
				local gap = bytes[3] <= 127 and bytes[3] or (bytes[3]-256)
				CFG.cl_crosshairgap[0] = gap/10
				CFG.cl_crosshair_outlinethickness[0] = bytes[4] / 2
				CFG.cl_crosshaircolor_r[0] = bytes[5]
				CFG.cl_crosshaircolor_g[0] = bytes[6]
				CFG.cl_crosshaircolor_b[0] = bytes[7]
				CFG.cl_crosshairalpha[0] = bytes[8]
				CFG.cl_crosshair_dynamic_splitdist[0] = bit.band(bytes[9], 0x7f)
				CFG.cl_crosshair_recoil[0] = bit.band(bytes[9], 128) == 128
				CFG.cl_crosshaircolor[0] = bit.band(bytes[11], 7)
				CFG.cl_crosshair_drawoutline[0] = bit.band(bytes[11], 8) == 8
				CFG.cl_crosshair_dynamic_splitalpha_innermod[0] = bit.rshift(bytes[11], 4) / 10
				CFG.cl_crosshair_dynamic_splitalpha_outermod[0] = bit.band(bytes[12], 0xF) / 10
				CFG.cl_crosshair_dynamic_maxdist_splitratio[0] = bit.rshift(bytes[12], 4) / 10
				CFG.cl_crosshairthickness[0] = bytes[13]/10
				CFG.cl_crosshairdot[0] = bit.band(bytes[14], 16) == 16
				CFG.cl_crosshairusealpha[0] = bit.band(bytes[14], 64) == 64
				CFG.cl_crosshair_t[0] = bit.band(bytes[14], 128) == 128
				CFG.cl_crosshairstyle[0] = bit.rshift(bit.band(bytes[14], 0xf), 1)
				CFG.cl_crosshairsize[0] = bytes[15]/10
				CFG()
				
			elseif ffi.string(TEMP.buf) == "" then
				local bytes = {
				[1] = 0,
				[2] = 1,
				[3] = bit.band(CFG.cl_crosshairgap[0]*10, 0xFF),
				[4] = math.round(CFG.cl_crosshair_outlinethickness[0]*2),
				[5] = CFG.cl_crosshaircolor_r[0],
				[6] = CFG.cl_crosshaircolor_g[0],
				[7] = CFG.cl_crosshaircolor_b[0],
				[8] = CFG.cl_crosshairalpha[0],
				[9] = bit.band(CFG.cl_crosshair_dynamic_splitdist[0], 127) + bit.lshift(CFG.cl_crosshair_recoil[0] and 1 or 0, 7),
				[10] = 0,
				[11] = bit.band(CFG.cl_crosshaircolor[0], 7) + bit.lshift(CFG.cl_crosshair_drawoutline[0] and 1 or 0, 3) + bit.lshift(math.round(CFG.cl_crosshair_dynamic_splitalpha_innermod[0]*10), 4),
				[12] = math.round(CFG.cl_crosshair_dynamic_splitalpha_outermod[0]*10) + bit.lshift(CFG.cl_crosshair_dynamic_maxdist_splitratio[0] * 10, 4),
				[13] = math.round(CFG.cl_crosshairthickness[0]*10),
				[14] = bit.lshift(CFG.cl_crosshairstyle[0], 1) + bit.lshift(CFG.cl_crosshairdot[0] and 1 or 0, 4) + bit.lshift(CFG.cl_crosshairusealpha[0] and 1 or 0, 6) + bit.lshift(CFG.cl_crosshair_t[0] and 1 or 0, 7),
				[15] = math.round(CFG.cl_crosshairsize[0]*10),
				[16] = 0,
				[17] = 0,
				[18] = 0
				}
				local readyShareCode = bytesToShareCode(bytes)
				setClipboardText(readyShareCode)
				ffi.copy(TEMP.buf, readyShareCode)
			end
			
		end
		imgui.ToolTip("Pressing enter if:\ninput is empty - export crosshair\ninput is Sharecode - import crosshair")
		
		imgui.BeginChild("##preview", imgui.ImVec2(168, 100), true)
			renderCrosshair(imgui.GetWindowDrawList(), imgui.GetWindowPos().x + 84, imgui.GetWindowPos().y + 50)
		imgui.EndChild()
		imgui.PushItemWidth(84)
		
		if imgui.ComboStr('Crosshair Style', CFG.cl_crosshairstyle, "Default[0]\0Default static[1]\0Accurate split[2] (Classic)\0Accurate dynamic[3]\0Classic static[4]\0Classic[5] (Legacy)\0\0") then
			CFG()
		end
		
		if imgui.Checkbox('Follow Recoil', CFG.cl_crosshair_recoil) then
			CFG()
		end
		
		if imgui.Checkbox('Center Dot', CFG.cl_crosshairdot) then
			CFG()
		end

		if imgui.SliderFloat('Length', CFG.cl_crosshairsize, 0, 10, "%.1f") then
			if CFG.cl_crosshairsize[0] < 0 then
				CFG.cl_crosshairsize[0] = 0
			end
			CFG()
		end
		if imgui.SliderFloat('Thickness', CFG.cl_crosshairthickness, 0, 5, "%.1f") then
			if CFG.cl_crosshairthickness[0] < 0 then
				CFG.cl_crosshairthickness[0] = 0
			end
			CFG()
		end
		if imgui.SliderFloat('Gap', CFG.cl_crosshairgap, -5, 5, "%.1f") then
			CFG()
		end
		if imgui.Checkbox('##Outline', CFG.cl_crosshair_drawoutline) then
			CFG()
		end
		imgui.SameLine(); imgui.PushItemWidth(58)
		if imgui.SliderFloat('Outline##Slider', CFG.cl_crosshair_outlinethickness, 0, 3, "%.1f") then
			if CFG.cl_crosshair_outlinethickness[0] < 0 then
				CFG.cl_crosshair_outlinethickness[0] = 0
			end
			CFG()
		end; imgui.PushItemWidth(84)
		
		if imgui.SliderInt('Color (5 = custom)##Slider', CFG.cl_crosshaircolor, 0, 5) then
			CFG()
		end
		
		if CFG.cl_crosshaircolor[0] == 5 then
			if imgui.SliderInt('Red##Slider', CFG.cl_crosshaircolor_r, 0, 255) then
				CFG()
			end
			
			if imgui.SliderInt('Green##Slider', CFG.cl_crosshaircolor_g, 0, 255) then
				CFG()
			end
			
			if imgui.SliderInt('Blue##Slider', CFG.cl_crosshaircolor_b, 0, 255) then
				CFG()
			end
		end
		
		if imgui.Checkbox('##Alpha', CFG.cl_crosshairusealpha) then
			CFG()
		end
		imgui.SameLine(); imgui.PushItemWidth(58)
		if imgui.SliderInt('Alpha##Slider', CFG.cl_crosshairalpha, 0, 255) then
			CFG()
		end; imgui.PushItemWidth(84)

		if CFG.cl_crosshairstyle[0] < 4 then
			if imgui.SliderInt('Split Distance', CFG.cl_crosshair_dynamic_splitdist, 0, 16) then
				CFG()
			end
			
			if imgui.SliderFloat('Inner Split Alpha', CFG.cl_crosshair_dynamic_splitalpha_innermod, 0, 1, "%.1f") then
				CFG()
			end
			
			if imgui.SliderFloat('Outer Split Alpha', CFG.cl_crosshair_dynamic_splitalpha_outermod, 0.3, 1, "%.1f") then
				CFG()
			end
			
			if imgui.SliderFloat('Split Size Ratio', CFG.cl_crosshair_dynamic_maxdist_splitratio, 0, 1, "%.1f") then
				CFG()
			end
		end
		
		if imgui.Checkbox('T Style', CFG.cl_crosshair_t) then
			CFG()
		end

		-- imgui.Text("CHack::Crosshair")
	imgui.End()
	
	imgui.SetMouseCursor(-1)
	
end).HideCursor = true

imgui.OnFrame(function() return not ffi.cast("bool*", 0xB7CB49)[0] end, function(thisisnotyourcode)

	local timer = os.clock()
	local w, h = getScreenResolution()

	local render = imgui.GetBackgroundDrawList()
	local ImVec2 = imgui.ImVec2
	local ImVec4 = imgui.ImVec4
	local CalcTextSize = imgui.CalcTextSize
	local GetColorU32Vec4 = imgui.GetColorU32Vec4
	
	local CPed = ffi.cast("int32_t*", 0xB7CD98)[0]
	local weapslot = ffi.cast("uint8_t*", CPed)[0x718]
	local weap = ffi.cast('uint8_t*', CPed)[0x5A0+28*weapslot]
	local camMode = ffi.cast("uint8_t*", 0x8CC388)[0]
	local CCurVer = ffi.cast("int32_t*", 0xBA18FC)[0]
	local CrosshairActive = ((((camMode ~= 4) and CCurVer == 0) or (camMode == 55 and CCurVer ~= 0)) and (camMode ~= 15) and (camMode ~= 17) and (camMode ~= 29)) and ffi.cast('int8_t*', 0xB6F080)[0] == 0 and ffi.cast('int8_t*', 0x8CC384)[0] == 3
	
	if CFG.crosshair[0] and CrosshairActive then
	
		-- local lal2 = ffi.cast("uintptr_t", TEMP.CHPatch1)
		-- TEMP.CHPatch2[0] = ffi.cast("float*", getWeapInfo(weap, 2))[14]
		-- ffi.cast('int32_t*', lal2+2  )[0] = ffi.cast("uintptr_t", TEMP.CHPatch2)
		-- ffi.cast('int32_t*', lal2+9  )[0] = 0x609CE9-lal2
		-- ffi.cast("int8_t*",  0x609CF1)[0] = 0xE9
		-- ffi.cast('int32_t*', 0x609CF2)[0] = lal2-0x609CF6
		
		
	
		local crosshairPos
		if CFG.cl_crosshair_recoil[0] then
			local traj = {calculateBulletTrajectoryWhileAiming()}
			crosshairPos = {convert3DCoordsToScreen(traj[3][1], traj[3][2], traj[3][3])}
		else
			crosshairPos = {convert3DCoordsToScreen(get_crosshair_position(20))}
		end
		local cX, cY = math.round(crosshairPos[1]), math.round(crosshairPos[2])
		local notCenterCrosshair = ((weap < 34 or weap > 36) and camMode > 52)
		if notCenterCrosshair then
			-- cX, cY = math.round(w * 0.5), math.round(h * 0.5)
			renderCrosshair(render, cX, cY)
		end
		ffi.copy(ffi.cast("void*", 0x58FBBF), notCenterCrosshair and "\x90\x90\x90\x90\x90" or "\xE8\x5C\xE4\xFF\xFF", 5)
		
	end

end).HideCursor = true

function onScriptTerminate(ScriptAddress)
	if ScriptAddress == TEMP.thisScript then
		ffi.copy(ffi.cast("void*", 0x58FBBF), "\xE8\x5C\xE4\xFF\xFF", 5)
		-- ffi.copy(ffi.cast("void*", 0x609CF1), "\xD9\x40\x38\x8B\x08", 5)
	end
end