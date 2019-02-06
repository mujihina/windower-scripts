--[[
Copyright (c) 2018, Mujihina
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of checkstorage.lua nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Mujihina BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- Short script to generate a list of what unstack items you have are on different containers

require('luau')

local res         = require ('resources').items
local items       = windower.ffxi.get_items()


storages = {'inventory', 'safe', 'safe2' , 'storage', 'locker', 'satchel', 'sack', 'case', 'wardrobe', 'wardrobe2', 'wardrobe3', 'wardrobe4'}
mystuff = {}

for _,container in pairs (storages) do
    for _,item in ipairs (items[container]) do
    	if (item.id > 0 and res[item.id].stack > 1) then
	        if (item.count < res[item.id].stack) then
	        	if mystuff[item.id] then mystuff[item.id] = '%s, %s(%d)':format(mystuff[item.id], container, item.count)
	        	else mystuff[item.id] = '%s(%d)':format(container, item.count)
	        	end
    	    end
    	end
    end
end

for item, k in pairs(mystuff) do
	if k:contains(',') then
		log ('%s: %s':format(res[item].name:color(258), k))
	end
end
