function probe()
    return vlc.access == "https" and (string.match(vlc.path, 'agorov.org')or string.match(vlc.path, 'play.animegost.org'))
end

function parse()
	local HD = 0
	local list = {}
    local html = vlc.read(100000)
	if string.match(vlc.path, 'agorov.org') then
		local t = html:match('data = {(.-)}')
		for n,p in t:gmatch('"(.-)":"(.-)"') do
			local p = 'https://play.animegost.org/'..p ..'?player=9'
			table.insert(list, {path = p, name = n})
		end
	end
	if string.match(vlc.path, 'play.animegost.org') then
		local l = {}
		for p in html:gmatch('href="(.-)"') do
			table.insert(l, p)
		end
		--if HD==1 then p = html:match('href="(.-)">7') else p = html:match('href="(.-)">4') end
		if HD ==1 then p = l[2] else p = l[1] end
		table.insert(list, {path = p})
	end
    return list
end