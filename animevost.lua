function probe()
    return vlc.access == "https" and (string.match(vlc.path, 'v2.vost.pw')or string.match(vlc.path, 'v2.vost.pw/frame5.php'))
end

function parse()
	local HD = 1
	local list = {}
    local html = vlc.read(100000)
	if string.match(vlc.path, 'v2.vost.pw/tip') then
		local t = html:match('data = {(.-)}')
		for n,p in t:gmatch('"(.-)":"(.-)"') do
			local p = 'https://v2.vost.pw/frame5.php?play='..p
			table.insert(list, {path = p, name = n})
		end
	end
	if string.match(vlc.path, 'v2.vost.pw/frame5.php') then
		local l = {}
		for p in html:gmatch('href="(.-)"') do
			table.insert(l, p)
		end
		if HD ==1 then p = l[2] else p = l[1] end
		table.insert(list, {path = p})
	end
    return list
end
