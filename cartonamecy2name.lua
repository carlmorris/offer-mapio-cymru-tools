dofile("/home/priffapiwr/lua/enwauQID.lua")

-- cofnodi CSV
-- name:cy,name:en,name,enw Wikidata,QID Wikidata,categori enwi,enw ar y map,designation
--
-- categorïau enwi:
-- namecy_filter_tags_relation_member
-- namecy_canfod_enw
-- wedi-copïo-name-i-name:cy
-- eraill-sydd-angen-name:cy
-- wiciddata
-- name-name:en-ond-dim-name:cy
-- dim-name-o-gwbl
-- ar-y-rhestr-ddu
-- ar-y-rhestr-ddu-gymraeg
-- keyvalues-place-==-allwedd
-- keyvalues-name-gairgwyn
-- relation_member_heb_namecy

print ("\nCSV,name:cy,name:en,name,enw Wikidata,QID Wikidata,categori enwi,enw ar y map,designation")

allwedd_un_enw = {
	'village',
	--'suburb',
	'hamlet',
	'town',
	'island',
	--'islet',
	'neighbourhood',
	'square',
	'farm',
	'isolated_dwelling',
	'locality'
}

rhestr_goch_gymraeg = {
    'Wind Farm',
	'Park',
	'Golf Club',
	'Community',
	'Holiday',
	'Cottage',
	'Home',
	'Bay',
	'Upper',
	'Lower',
	'Camping',
	'Caernarvon',
    'Trelluest',
    'Trefynach',
    'Castleton',
    'Rhygwladd',
    'Dwyrain Ffordd y Bont-faen',
    'Gorllewin Ffordd y Bont-faen',
    'Major',
    'Industrial Estate',
    'Ely',
    'Super Ely',
	'Caerphilly',
	'Tydfil',
	'River',
	'Crossing',
	'Lodge',
	'Wood',
	'Dolgelley',
	'Dolgelly',
	'Velinheli'
}

rhestr_goch = {
	'v',
	'k',
	'z',
	'V',
	'K',
	'Z',
    'Wind Farm',
	'Park',
	'Golf Club',
	'Community',
	'Holiday',
	'Cottage',
	'Home',
	'Bay',
	'Major',
	'Upper',
	'Lower',
	'Camping',
	'Caernarvon',
    'Castleton',
    'Industrial Estate',
    'Ely',
    'Super Ely',
	'Caerphilly',
	'Tydfil',
	'River',
	'Crossing',
	'Lodge',
	'Wood',
	'Dolgelley',
	'Dolgelly',
	'Velinheli'
}

-- rhestr werdd arall
rhestr_werdd = {
	'Ysgol',
	'Eglwys',
	'Capel',
	'Fferm',
	'Ffordd',
	'Stryd',
	'Stryt',
	'Heol',
	'Rhodfa',
	'Clos ',
	'Lon ',
	'Lôn ',
	'Maes',
	'Gwesty',
	'Siop',
	'Ynys',
	'Prifysgol',
	'Coleg',
	'Garej',
	'Mynydd',
	'Ysbyty',
	'Parc',
	'Bannau',
	'Ogof',
	'Afon',
	'Nant',
	'Cofeb',
	'Mynwent',
	'Canolfan',
	'Ganolfan',
	'Llyfrgell',
	'Lyfrgell',
	'Llyn',
	'Caer ',
	'Caer-',
	'Bryn ',
	'Bryn-',
	'Bwyty',
	'Gapel',
	'Gymraeg',
	'Cymraeg',
	'Swyddfa',
	'Swyddfeydd',
	" Farm",
	"Penbanc"
}

-- For documentation of Lua tag transformations, see:
-- https://github.com/openstreetmap/osm2pgsql/blob/master/docs/lua.md

-- Objects with any of the following keys will be treated as polygon
local polygon_keys = {
    'abandoned:aeroway',
    'abandoned:amenity',
    'abandoned:building',
    'abandoned:landuse',
    'abandoned:power',
    'aeroway',
    'allotments',
    'amenity',
    'area:highway',
    'craft',
    'building',
    'building:part',
    'club',
    'golf',
    'emergency',
    'harbour',
    'healthcare',
    'historic',
    'landuse',
    'leisure',
    'man_made',
    'military',
    'natural',
    'office',
    'place',
    'power',
    'public_transport',
    'shop',
    'tourism',
    'water',
    'waterway',
    'wetland'
}

-- Objects with any of the following key/value combinations will be treated as linestring
local linestring_values = {
    golf = {cartpath = true, hole = true, path = true}, 
    emergency = {designated = true, destination = true, no = true, official = true, yes = true},
    historic = {citywalls = true},
    leisure = {track = true, slipway = true},
    man_made = {breakwater = true, cutline = true, embankment = true, groyne = true, pipeline = true},
    natural = {cliff = true, earth_bank = true, tree_row = true, ridge = true, arete = true},
    power = {cable = true, line = true, minor_line = true},
    tourism = {yes = true},
    waterway = {canal = true, derelict_canal = true, ditch = true, drain = true, river = true, stream = true, tidal_channel = true, wadi = true, weir = true}
}

-- Objects with any of the following key/value combinations will be treated as polygon
local polygon_values = {
    aerialway = {station = true},
    boundary = {aboriginal_lands = true, national_park = true, protected_area= true},
    highway = {services = true, rest_area = true},
    junction = {yes = true},
    railway = {station = true}
}

-- The following keys will be deleted
local delete_tags = {
    'note',
    'source',
    'source_ref',
    'attribution',
    'comment',
    'fixme',
    -- Tags generally dropped by editors, not otherwise covered
    'created_by',
    'odbl',
    -- Lots of import tags
    -- EUROSHA (Various countries)
    'project:eurosha_2012',

    -- UrbIS (Brussels, BE)
    'ref:UrbIS',

    -- NHN (CA)
    'accuracy:meters',
    'waterway:type',
    -- StatsCan (CA)
    'statscan:rbuid',

    -- RUIAN (CZ)
    'ref:ruian:addr',
    'ref:ruian',
    'building:ruian:type',
    -- DIBAVOD (CZ)
    'dibavod:id',
    -- UIR-ADR (CZ)
    'uir_adr:ADRESA_KOD',

    -- GST (DK)
    'gst:feat_id',
    -- osak (DK)
    'osak:identifier',

    -- Maa-amet (EE)
    'maaamet:ETAK',
    -- FANTOIR (FR)
    'ref:FR:FANTOIR',

    -- OPPDATERIN (NO)
    'OPPDATERIN',
    -- Various imports (PL)
    'addr:city:simc',
    'addr:street:sym_ul',
    'building:usage:pl',
    'building:use:pl',
    -- TERYT (PL)
    'teryt:simc',

    -- RABA (SK)
    'raba:id',

    -- LINZ (NZ)
    'linz2osm:objectid',
    -- DCGIS (Washington DC, US)
    'dcgis:gis_id',
    -- Building Identification Number (New York, US)
    'nycdoitt:bin',
    -- Chicago Building Import (US)
    'chicago:building_id',
    -- Louisville, Kentucky/Building Outlines Import (US)
    'lojic:bgnum',
    -- MassGIS (Massachusetts, US)
    'massgis:way_id',

    -- misc
    'import',
    'import_uuid',
    'OBJTYPE',
    'SK53_bulk:load'
}
delete_prefixes = {
    'note:',
    'source:',
    -- Corine (CLC) (Europe)
    'CLC:',

    -- Geobase (CA)
    'geobase:',
    -- CanVec (CA)
    'canvec:',
    -- Geobase (CA)
    'geobase:',

    -- kms (DK)
    'kms:',

    -- ngbe (ES)
    -- See also note:es and source:file above
    'ngbe:',

    -- Friuli Venezia Giulia (IT)
    'it:fvg:',

    -- KSJ2 (JA)
    -- See also note:ja and source_ref above
    'KSJ2:',
    -- Yahoo/ALPS (JA)
    'yh:',

    -- LINZ (NZ)
    'LINZ2OSM:',
    'LINZ:',

    -- WroclawGIS (PL)
    'WroclawGIS:',
    -- Naptan (UK)
    'naptan:',

    -- TIGER (US)
    'tiger:',
    -- GNIS (US)
    'gnis:',
    -- National Hydrography Dataset (US)
    'NHD:',
    'nhd:',
    -- mvdgis (Montevideo, UY)
    'mvdgis:'
}

-- Big table for z_order and roads status for certain tags. z=0 is turned into
-- nil by the z_order function
local roads_info = {
    highway = {
        motorway        = {z = 380, roads = true},
        trunk           = {z = 370, roads = true},
        primary         = {z = 360, roads = true},
        secondary       = {z = 350, roads = true},
        tertiary        = {z = 340, roads = false},
        residential     = {z = 330, roads = false},
        unclassified    = {z = 330, roads = false},
        road            = {z = 330, roads = false},
        living_street   = {z = 320, roads = false},
        pedestrian      = {z = 310, roads = false},
        raceway         = {z = 300, roads = false},
        motorway_link   = {z = 240, roads = true},
        trunk_link      = {z = 230, roads = true},
        primary_link    = {z = 220, roads = true},
        secondary_link  = {z = 210, roads = true},
        tertiary_link   = {z = 200, roads = false},
        service         = {z = 150, roads = false},
        track           = {z = 110, roads = false},
        path            = {z = 100, roads = false},
        footway         = {z = 100, roads = false},
        bridleway       = {z = 100, roads = false},
        cycleway        = {z = 100, roads = false},
        steps           = {z = 90,  roads = false},
        platform        = {z = 90,  roads = false}
    },
    railway = {
        rail            = {z = 440, roads = true},
        subway          = {z = 420, roads = true},
        narrow_gauge    = {z = 420, roads = true},
        light_rail      = {z = 420, roads = true},
        funicular       = {z = 420, roads = true},
        preserved       = {z = 420, roads = false},
        monorail        = {z = 420, roads = false},
        miniature       = {z = 420, roads = false},
        turntable       = {z = 420, roads = false},
        tram            = {z = 410, roads = false},
        disused         = {z = 400, roads = false},
        construction    = {z = 400, roads = false},
        platform        = {z = 90,  roads = false},
    },
    aeroway = {
        runway          = {z = 60,  roads = false},
        taxiway         = {z = 50,  roads = false},
    },
    boundary = {
        administrative  = {z = 0,  roads = true}
    },
}

local excluded_railway_service = {
    spur = true,
    siding = true,
    yard = true
}
--- Gets the z_order for a set of tags
-- @param tags OSM tags
-- @return z_order if an object with z_order, otherwise nil
function z_order(tags)
    local z = 0
    for k, v in pairs(tags) do
        if roads_info[k] and roads_info[k][v] then
            z = math.max(z, roads_info[k][v].z)
        end
    end

    if tags["highway"] == "construction" then
        if tags["construction"] and roads_info["highway"][tags["construction"]] then
            z = math.max(z, roads_info["highway"][tags["construction"]].z/10)
        else
            z = math.max(z, 33)
        end
    end

    return z ~= 0 and z or nil
end

--- Gets the roads table status for a set of tags
-- @param tags OSM tags
-- @return 1 if it belongs in the roads table, 0 otherwise
function roads(tags)
    for k, v in pairs(tags) do
        if roads_info[k] and roads_info[k][v] and roads_info[k][v].roads then
            if not (k ~= 'railway' or tags.service) then
                return 1
            elseif not excluded_railway_service[tags.service] then
                return 1
            end
        end
    end
    return 0
end

--- Generic filtering of OSM tags
-- @param tags Raw OSM tags
-- @return Filtered OSM tags
function filter_tags_generic(tags)
    -- Short-circuit for untagged objects
    if next(tags) == nil then
        return 1, {}
    end

    -- Delete tags listed in delete_tags
    for _, d in ipairs(delete_tags) do
        tags[d] = nil
    end

    -- By using a second loop for wildcards we avoid checking already deleted tags
    for tag, _ in pairs (tags) do
        for _, d in ipairs(delete_prefixes) do
            if string.sub(tag, 1, string.len(d)) == d then
                tags[tag] = nil
                break
            end
        end
    end

   -- Filter out objects that have no tags after deleting
    if next(tags) == nil then
        return 1, {}
    end

    -- Convert layer to an integer
    tags['layer'] = layer(tags['layer'])
    return 0, tags
end

-- Filtering on nodes
function filter_tags_node (keyvalues, numberofkeys)

	keyvalues, numberofkeys = canfod_enw_iw_ddefnyddio(keyvalues, numberofkeys)

    return filter_tags_generic(keyvalues)
end

-- Filtering on relations
function filter_basic_tags_rel (keyvalues, numberofkeys)
    -- Filter out objects that are filtered out by filter_tags_generic
    local filter, keyvalues = filter_tags_generic(keyvalues)
    if filter == 1 then
        return 1, keyvalues
    end

    -- Filter out all relations except route, multipolygon and boundary relations
    if ((keyvalues["type"] ~= "route") and (keyvalues["type"] ~= "multipolygon") and (keyvalues["type"] ~= "boundary")) then
        return 1, keyvalues
    end

	keyvalues, numberofkeys = canfod_enw_iw_ddefnyddio(keyvalues, numberofkeys)

    return 0, keyvalues
end

-- Filtering on ways
function filter_tags_way (keyvalues, numberofkeys)
    local filter = 0  -- Will object be filtered out?
    local polygon = 0 -- Will object be treated as polygon?

    -- Filter out objects that are filtered out by filter_tags_generic
    filter, keyvalues = filter_tags_generic(keyvalues)
    if filter == 1 then
        return filter, keyvalues, polygon, roads
    end

	keyvalues, numberofkeys = canfod_enw_iw_ddefnyddio(keyvalues, numberofkeys)

    polygon = isarea(keyvalues)

    -- Add z_order column
    keyvalues["z_order"] = z_order(keyvalues)

    return filter, keyvalues, polygon, roads(keyvalues)
end

--- Handling for relation members and multipolygon generation
-- @param keyvalues OSM tags, after processing by relation transform
-- @param keyvaluemembers OSM tags of relation members, after processing by way transform
-- @param roles OSM roles of relation members
-- @param membercount number of members
-- @return filter, cols, member_superseded, boundary, polygon, roads
function filter_tags_relation_member (keyvalues, keyvaluemembers, roles, membercount)
    local members_superseded = {}

    -- Start by assuming that this not an old-style MP
    for i = 1, membercount do
        members_superseded[i] = 0
    end

    local type = keyvalues["type"]

    -- Remove type key
    keyvalues["type"] = nil

    -- Filter out relations with just a type tag or no tags
    if next(keyvalues) == nil then
        return 1, keyvalues, members_superseded, 0, 0, 0
    end

    if type == "boundary" or (type == "multipolygon" and keyvalues["boundary"]) then
        keyvalues.z_order = z_order(keyvalues)
        return 0, keyvalues, members_superseded, 1, 0, roads(keyvalues)
    -- For multipolygons...
    elseif (type == "multipolygon") then
        -- Multipolygons by definition are polygons, so we know roads = linestring = 0, polygon = 1

		if keyvalues["name:cy"] then
			cofnodi_gwyb("namecy_filter_tags_relation_member", keyvalues)
			keyvalues["name"] = keyvalues["name:cy"]
		else
			cofnodi_gwyb("relation_member_heb_namecy", keyvalues)
			keyvalues["name"] = ""
		end

        keyvalues.z_order = z_order(keyvalues)
        return 0, keyvalues, members_superseded, 0, 1, 0
    elseif type == "route" then
        keyvalues.z_order = z_order(keyvalues)
        return 0, keyvalues, members_superseded, 1, 0, roads(keyvalues)
    end

    -- Unknown type of relation or no type tag
    return 1, keyvalues, members_superseded, 0, 0, 0
end

--- Check if an object with given tags should be treated as polygon
-- @param tags OSM tags
-- @return 1 if area, 0 if linear
function isarea (tags)
    -- Treat objects tagged as area=yes polygon, other area as no
    if tags["area"] then
        return tags["area"] == "yes" and 1 or 0
    end

   -- Search through object's tags
    for k, v in pairs(tags) do
        -- Check if it has a polygon key and not a linestring override, or a polygon k=v
        for _, ptag in ipairs(polygon_keys) do
            if k == ptag and v ~= "no" and not (linestring_values[k] and linestring_values[k][v]) then
                return 1
            end
        end

        if (polygon_values[k] and polygon_values[k][v]) then
            return 1
        end
    end
    return 0
end

function is_in (needle, haystack)
    for index, value in ipairs (haystack) do
        if value == needle then
            return true
        end
    end
    return false
end

--- Normalizes layer tags
-- @param v The layer tag value
-- @return An integer for the layer tag
function layer (v)
    return v and string.find(v, "^-?%d+$") and tonumber(v) < 100 and tonumber(v) > -100 and v or nil
end

-- canfod enw i'w ddefnyddio ar y map
-- name:cy yn cael blaenoriaeth
-- os nad yw e'n bodoli, defnyddia enw os yw e ar restr o gategoriau 'place'
function canfod_enw_iw_ddefnyddio(keyvalues, numberofkeys)
	namecy = glanhau(keyvalues["name:cy"])
	nameen = glanhau(keyvalues["name:en"])
	name = glanhau(keyvalues["name"])
	enwwikidata = glanhau(QIDenwau[keyvalues["wikidata"]])
	qidwikidata = glanhau(keyvalues["wikidata"])

	 -- os oes enw cymraeg
	if keyvalues["name:cy"] then
        -- gosod yr enw cymraeg
		keyvalues["name"] = keyvalues["name:cy"]
		cofnodi_gwyb("namecy_canfod_enw", keyvalues)
        return keyvalues, numberofkeys
    end
    
    -- wikidata os nad oes enw cymraeg
	if keyvalues["wikidata"] and QIDenwau[keyvalues["wikidata"]] then
		keyvalues["name"] = QIDenwau[keyvalues["wikidata"]]
		cofnodi_gwyb("wiciddata", keyvalues)
		return keyvalues, numberofkeys
    end
    
    -- dim name?
	if keyvalues["name"] == nil then
		-- cofnodi_gwyb("dim-name-o-gwbl", keyvalues)
		keyvalues["name"] = ""
		return keyvalues, numberofkeys
	end
	
	-- mae name yn bodoli
	
	if keyvalues["name:en"] then
		if (keyvalues["name"] ~= keyvalues["name:en"]) then
			return keyvalues, numberofkeys -- name:en != name felly defnyddia name
		end
		-- os mae rhywun wedi gwneud pwynt o roi name a name:en ond dim name:cy, mae eisiau ffafrio name 
	end

	for i, gairdu in ipairs(rhestr_goch) do
		if (string.find(keyvalues["name"], gairdu)) then
			blanc = 1
			keyvalues["name"] = ""
			cofnodi_gwyb("ar-y-rhestr-ddu", keyvalues)
			return keyvalues, numberofkeys				
		end
	end

	blanc = 1
	if keyvalues["place"] then
		for i, allwedd in ipairs(allwedd_un_enw) do
			if (keyvalues["place"] == allwedd) then
				cofnodi_gwyb("keyvalues-place-==-allwedd", keyvalues)
				blanc = 0
				break
			end
		end
	else
		for i, gairgwyn in ipairs(rhestr_werdd) do
			if (string.find(keyvalues["name"], gairgwyn)) then
				cofnodi_gwyb("keyvalues-name-gairgwyn", keyvalues)
				blanc = 0
				break
			end
		end
	end

	if blanc == 1 then
		keyvalues["name"] = "" -- fel arall defnyddia'r name fel y mae
		cofnodi_gwyb("eraill-sydd-angen-name:cy", keyvalues)
	else
		cofnodi_gwyb("wedi-copïo-name-i-name:cy", keyvalues)			
	end

	return keyvalues, numberofkeys
end

-- allbwn y sgript
function cofnodi_gwyb(neges, keyvalues)
	if keyvalues["designation"] ~= null then
		desig = "designation | " .. keyvalues["designation"]
	elseif keyvalues["highway"] ~= null then
		desig = "highway | " .. keyvalues["highway"]
	elseif keyvalues["route"] ~= null then
		desig = "route | " .. keyvalues["route"]
	elseif keyvalues["amenity"] ~= null then
		desig = "amenity | " .. keyvalues["amenity"]
	elseif keyvalues["building"] ~= null then
		desig = "building | " .. keyvalues["building"]
	elseif keyvalues["boundary"] ~= null then
		desig = "boundary | " .. keyvalues["boundary"]
	elseif keyvalues["public_transport"] ~= null then
		desig = "public_transport | " .. keyvalues["public_transport"]
	elseif keyvalues["tourism"] ~= null then
		desig = "tourism | " .. keyvalues["tourism"]
	elseif keyvalues["type"] ~= null then
		desig = "type | " .. keyvalues["type"]
	elseif keyvalues["natural"] ~= null then
		desig = "natural | " .. keyvalues["natural"]
	else
		desig = ""
	end

    -- name:cy,name:en,name,enw Wikidata,QID Wikidata,categori enwi,enw ar y map,designation
    print ("\nCSV," .. "\"" .. namecy .. "\"," ..  "\"" .. nameen .. "\"," .. "\"" .. name .. "\"," .. "\"" .. enwwikidata .. "\"," .. "\"" .. qidwikidata .. "\"," .. "\"" .. neges .. "\"," .. "\"" .. glanhau(keyvalues["name"]) .. "\"," .. "\"" .. desig .. "\"")
end

-- allbynnu "" os mae'r testun yn nil
function glanhau(s)
	if(s == nil) then
		return ""
	else
		return s
	end
end
