<img
  src="https://openstreetmap.cymru/mapio-cymru-map-cymru.jpg"
  alt="Mapio Cymru"
  title="Mapio Cymru">

[Cymraeg](#teclynnau-gweinydd-mapio-cymru) | [English](#mapio-cymru-server-tools)

Teclynnau gweinydd Mapio Cymru
==============================

Mae'r teclynnau llinell orchymyn hyn yn eich helpu i ddarparu mapiau Cymraeg eich hunain sy'n deillio o OpenStreetMap. Fel arall gallech eu haddasu i gael mapiau yn yr iaith o eich dewis.

Edrychwch ar [weinydd Mapio Cymru](https://openstreetmap.cymru), map Cymraeg sy'n cael ei rymuso gan OpenStreetMap/Switch2OSM â'r teclynnau hyn.

Nodwch nad yw'r adnodd hwn yn gynnyrch llawn. Rydym yn canolbwyntio bron yn gyfan gwbl ar ein gwaith data a mapio ein hunain, ac dw i'n dosbarthu'r gwaith mewn ysbryd rhannu.

# Cefndir
Fel Mapio Cymru roeddem am ddarparu map yn gyfan gwbl yn y Gymraeg, ond nid oedd yn amlwg sut i wneud hyn. Ar ôl llawer o [ym]chwilio ysgrifennais y teclynnau hyn i'w defnyddio ar y cyd ag OpenStreetMap/Switch2OSM. O ran y Gymraeg maen nhw'n gweithio gobeithiwn eu bod yn ddefnyddiol ar gyfer ieithoedd eraill.

Mae OpenStreetMap yn cynnwys llawer o ddata agored amlieithog. Mae enwau'n cael eu tagio yn y ffurf `name:cod=*`.

Er enghraifft, ewch i [Gymru ar osm.org](https://www.openstreetmap.org/relation/58437#map=7/52.449/-4.230) ac fe welwch chi:

* `name=Cymru / Wales`
* `name:br=Kembre`
* `name:cy=Cymru`
* `name:en=Wales`
* `name:fr=Pays de Galles`
* `name:ga=An Bhreatain Bheag`
* `name:gd=A' Chuimrigh`
* `name:kw=Kembra`

ac yn y blaen.

Mae fy null i yn newid y tag `name` yn ystod y broses mewnforio data a ddilynir gan osm2pgsql. Mae dulliau posib eraill o gael map mewn iaith benodol.

## Sgript cartonamecy2name.lua
Y prif declyn yn yr ystorfa yw'r sgript `cartonamecy2name.lua`. Gelwir y sgript Lua hon gan osm2pgsql yn ystod y broses fewnforio. Mae'n gosod yr enw yn ôl y drefn flaenoriaeth ganlynol:

* `name:cy`, os yw e ar gael
* Wikidata, os oes tag `wikidata` ar gael a bod enw ar gael yna yn Gymraeg
* `name` os yw e'n bodloni'r meini prawf
* gwag

Fel Mapio Cymru roeddem eisiau fylchau yn y data Cymraeg fod yn amlwg i bobl sy'n golygu OSM, wedi'u dangos fel bylchau ar y map. Fe allech chi newid hyn yn y sgript Lua os yw'ch anghenion yn wahanol.

Fforc o'r sgript `openstreetmap-carto.lua` a ddarperir gyda'r thema Carto yw `cartonamecy2name.lua`.

## Teclynnau Wikidata

Mae'r rhan fwyaf o'r teclynnau eraill ar gyfer cael enwau llefydd o Wikidata. Gwneir hyn trwy'r cod QID a roddir gan y tag `wikidata` yn OpenStreetMap. Mae cyfuno Wikidata ag OSM yn debygol o lenwi eich map gyda mwy o enwau yn eich iaith. Mae hyn yn ddefnyddiol yn enwedig os ydych yn gweithio mewn iaith â llai o adnoddau.

Y prif declyn ar gyfer Wikidata yw `creuenwauqidlua.sh` sy'n creu ffeil sy'n cynnwys data Wikidata, mewn fformat Lua, i'w defnyddio gan `cartonamecy2name.lua`.

Mae `creuenwauqidlua.sh` yn dibynnu ar y canlynol:

* `popeth-cymru-gyda-qid.xml` ymholiad Overpass sy'n cael yr holl nodau, ffyrdd, a chysylltiadau OSM yng Nghymru sydd â thagiau wikidata (codau QID)
* `creurhestr.py` sgript Python byr i redeg yr ymholiad Overpass a chreu CSV o'r allbwn
* `qidcreu.sh` dull cyflym o alw `creurhestr.py` gyda `popeth-cymru-gyda-qid.xml`
* `sparqlhorse2.php` Sgript PHP i gymryd enw lle yn Gymraeg o Wikidata ar gyfer pob un QID yng Nghymru, ac allbynnu ffeil Lua. Ar ein gweinydd mae hyn yn cymryd tua 30 munud i'w gwblhau. Rhowch wybod i ni os ydych yn gwybod am ddull well.

Yn ogystal â hyn mae `allbwnQID.lua` yn allbwn enghreifftiol.

## Rendro

`rendrocymrunewydd.sh` yw'r sgript mae Mapio Cymru yn ei ddefnyddio ar gyfer rhag-rendro. Byddai'n cymryd gormod o amser i rag-rendro Cymru gyfan felly yn lle hynny rydym yn rendro'r ardaloedd o'r map sy'n cael y nifer fwyaf o ymweliadau. Mae’r rhain yn seiliedig ar gofnodion ymwelwyr i [openstreetmap.cymru](https://openstreetmap.cymru). Mae'r sgript yn defnyddio [`render_list_geo.pl`](https://github.com/alx77/render_list_geo.pl) (sydd yn ei dro yn galw `render_list`) gyda rhai gwerthoedd hydred, lledred a chwyddo wedi'u pobi i mewn.

<img
  src="https://openstreetmap.cymru/mapio-cymru-map-abertawe.jpg"
  alt="Mapio Cymru: Abertawe"
  title="Mapio Cymru: Abertawe">

# Rhagofynion a rhybuddion
Mae'r teclynnau hyn yn gweithio ar y cyd â stac meddalwedd Switch2OSM (gweinydd Linux sy'n rhedeg PostgresQL a PostGIS, Mapnik, renderd, Apache a mod_tile). Maen nhw wedi cael eu profi ar weinyddion sy'n rhedeg y stac hwn ar Ubuntu 20.04.5 LTS.

Cyn gwneud unrhyw beth arall bydd angen i chi greu gweinydd mapio. Os ydych chi eisiau darparu un, dw i'n argymell yn gryf eich bod yn dilyn y cyfarwyddiadau defnyddiol ar [Switch2OSM](https://switch2osm.org/). Mae angen gwybodaeth sylfaenol o sut i ddefnyddio Linux trwy'r llinell orchymyn.

Dw i'n argymell y thema Carto. Os ydych chi eisiau defnyddio thema wahanol, mae canllawiau defnyddiol ar-lein. Efallai bydd rhaid i chi addasu'r sgript `cartonamecy2name.lua` hefyd.

Ysgrifennwyd yr offer hyn yn benodol ar gyfer Cymraeg. Nid ydyn nhw wedi cael eu profi gyda ieithoedd eraill, ond dylen nhw weithio gyda rhai gwelliannau.

Mae angen rhedeg PHP i ddefnyddio `sparqlhorse2.php` sy'n cymryd enwau o Wikidata.

# Cyfarwyddiadau cam wrth gam

1. Dilynwch Switch2OSM i ddarparu gweinydd mapio.

1. Crëwch ffeil `index.html` sy'n defnyddio [`Leaflet.js`](https://leafletjs.com/examples/quick-start/).

1. git clone yr ystorfa hwn

1. Lawrlwythwch ffeil Cymru o Geofabrik: `wget http://download.geofabrik.de/europe/great-britain/wales-latest.osm.pbf --directory-prefix=/home/`

1. Cymerwch ddata enwau lleoedd Wikidata Cymru (mae'n cymryd tua 30 munud): `./creuenwauqidlua.sh`

1. Mewnforiwch trwy ddefnyddio: `osm2pgsql -v --slim -d gis -C 8000 --hstore --tag-transform-script /home/cartonamecy2name.lua -S ~/src/openstreetmap-carto/openstreetmap-carto.style --number-processes 2 /home/wales-latest.osm.pbf`

Yma fe allech chi wneud rhywfaint o rag-rendro gan ddefnyddio [`render_list_geo.pl`](https://github.com/alx77/render_list_geo.pl) efallai. Gweler `rendrocymrunewydd.sh` am enghraifft.

Fe allech chi ailadrodd 3 i 6 bob tro rydych chi am ddiweddaru'r map o'r data OSM diweddaraf. Gosodwch eitem cron i awtomeiddio hyn. (Mae Geofabrik yn cael ei ddiweddaru unwaith bob dydd.) Neu fe allech chi ymchwilio i ddiweddariadau awtomatig amlach trwy OSM.

# Gwelliannau posib
Dyma rai gwelliannau posibl y gellid eu gwneud i'r offer hyn.

* Canllaw i newidiadau y byddech chi'n eu gwneud i gael gweinydd ar gyfer iaith wahanol
* Cefnogi ffeiliau _config_, e.e. gosod dewis iaith, troi defnydd o Wikidata ymlaen/i ffwrdd, ac ati.
* Diweddariadau rheolaidd. Mae'r broses fewnforio yn gwneud popeth o'r newydd o lawrlwytho Geofabrik ymlaen, felly rydyn ni'n mewnforio dim ond unwaith bod dydd.
* Symleiddio'r broses Wikidata.
* Golygu OSM i ychwanegu'r holl ddata enwau lleoedd sydd yn Wikidata, felly fydd ddim angen y rhan Wikidata o'r broses. :-)

# Trwyddedu
Meddalwedd rydd yw'r pecyn hwn; gallwch ei ailddosbarthu a/neu ei addasu o dan delerau Trwydded Gyhoeddus Gyffredinol GNU fel y'i cyhoeddwyd gan y Free Software Foundation; naill ai fersiwn 2 o'r Drwydded, neu (yn ôl eich dewis) unrhyw fersiwn diweddarach.

Dosberthir y rhaglen hon yn y gobaith y bydd yn ddefnyddiol, ond HEB UNRHYW WARANT; heb hyd yn oed y warant oblygedig o DIBYNADWYEDD neu FFITRWYDD AT DDIBEN PENODOL. Gweler Trwydded Gyhoeddus Gyffredinol GNU am ragor o fanylion.

# Diolch
Diolch i bawb sy'n cyfrannu at y prosiect OpenStreetMap byd-eang a phrosiectau cysylltiedig, gan gynnwys golygyddion data a chrewyr a chynhalwyr meddalwedd. Diolch i Wyn Williams a Ben Proctor fy nghyd-aelodau o dîm [Mapio Cymru](http://mapio.cymru/cy/). Diolch yn fawr i Lywodraeth Cymru a [Data Orchard](http://dataorchard.org.uk).

----------------------------------

<img
  src="https://openstreetmap.cymru/mapio-cymru-map-cymru.jpg"
  alt="Mapio Cymru"
  title="Mapio Cymru">

[Cymraeg](#teclynnau-gweinydd-mapio-cymru) | [English](#mapio-cymru-server-tools)

Mapio Cymru server tools
========================

These command line tools help you to serve your own OpenStreetMap-derived base maps in Welsh. Alternatively you could modify them to have maps in the language of your choice.

Have a look at the [Mapio Cymru server](https://openstreetmap.cymru), a map in Cymraeg/Welsh, which is powered by OpenStreetMap/Switch2OSM in conjunction with these tools.

Please note that this repo is not a fully-realised product. We are almost entirely focused on our own mapping and data work, and I am distributing the work in the spirit of sharing.

# Background

At the Mapio Cymru project we wanted to provide a map entirely in Cymraeg, but it wasn't immediately obvious how to do this. After much [re]searching I wrote these tools to be used in conjunction with OpenStreetMap/Switch2OSM. They work for Cymraeg and we hope they are useful for other languages.

OpenStreetMap contains a lot of multilingual open data. Names are tagged using the form `name:code=*`.

For example, if you visit [Cymru/Wales on osm.org](https://www.openstreetmap.org/relation/58437#map=7/52.449/-4.230)
you'll see

* `name=Cymru / Wales`
* `name:br=Kembre`
* `name:cy=Cymru`
* `name:en=Wales`
* `name:fr=Pays de Galles`
* `name:ga=An Bhreatain Bheag`
* `name:gd=A' Chuimrigh`
* `name:kw=Kembra`

and so on.

My method modifies the `name` tag during the data import process performed by osm2pgsql. There are other possible methods of having a map in one language.

## cartonamecy2name.lua script

The `cartonamecy2name.lua` script in this repository is the main tool. This Lua script is called by osm2pgsql during the import process. It sets the name according to the following order of precedence:

* `name:cy`, if available
* Wikidata, if `wikidata` tag is available and a name is available there in the chosen language
* `name` if certain criteria are met
* blank

At Mapio Cymru we wanted gaps in the Cymraeg-language data to be obvious for people editing OSM, shown as blanks on the map. You could tweak this in the Lua script if your needs are different.

`cartonamecy2name.lua` is a fork of the script `openstreetmap-carto.lua` provided with the [Carto theme](https://github.com/gravitystorm/openstreetmap-carto/tree/master/scripts/lua).

## Wikidata tools

Most of the remaining tools are for getting place names from Wikidata. This is done via the QID code which is given by the `wikidata` tag in OpenStreetMap. Combining Wikidata with OSM is likely to populate your map with more names in your language. This is helpful particularly if you are working in a lesser-resourced language.

The main tool for Wikidata is `creuenwauqidlua.sh` which creates a file containing Wikidata data, in Lua format, to be used by `cartonamecy2name.lua`.

`creuenwauqidlua.sh` relies on the following:

* `popeth-cymru-gyda-qid.xml` this is an Overpass query which gets all OSM nodes, ways, and relations in Wales that have wikidata tags (QID codes)
* `creurhestr.py` short Python script to run the Overpass query and create a CSV of the output
* `qidcreu.sh` quick method of calling `creurhestr.py` with `popeth-cymru-gyda-qid.xml`
* `sparqlhorse2.php` PHP script to retrieve place name in Cymraeg from Wikidata for each and every QID in Wales, and output a Lua file. On our server this takes around 30 minutes to complete. Please let us know if you know of an alternative method.

Additionally `enwauQID.lua` is example output.

## Rendering

`rendrocymrunewydd.sh` is the script Mapio Cymru uses for pre-rendering. It would take too much time to pre-render all of Wales so instead we render the most frequently-accessed areas of the country. These are based on visitor logs for [openstreetmap.cymru](https://openstreetmap.cymru). The script uses [`render_list_geo.pl`](https://github.com/alx77/render_list_geo.pl) (which in turn calls `render_list`) with some hard-coded lat, long, and zoom values.

<img
  src="https://openstreetmap.cymru/mapio-cymru-map-abertawe.jpg"
  alt="Mapio Cymru: Abertawe"
  title="Mapio Cymru: Abertawe">

# Prerequisites and caveats

These tools work in conjunction with the Switch2OSM software stack (a Linux server running PostgresQL and PostGIS, Mapnik, renderd, Apache and mod_tile). They have been tested on servers running this stack on Ubuntu 20.04.5 LTS.

Before doing anything else you will need a mapping server. If you want to provision one I strongly recommend you follow the helpful instructions at [Switch2OSM](https://switch2osm.org/). A basic knowledge of how to use Linux via the command line is assumed.

I recommend the Carto theme. If you want to use a different theme then there are helpful guides online. You may have to modify the `cartonamecy2name.lua` script as well.

These tools were written specifically for Cymraeg. At the time of writing they have not been tested with other languages, although they should work with some tweaks.

You need to run PHP to use `sparqlhorse2.php` which retrieves names from Wikidata.

# Step-by-step instructions

1. Follow [Switch2OSM](https://switch2osm.org) to provision a mapping server. 

1. Create an `index.html` that uses [`Leaflet.js`](https://leafletjs.com/examples/quick-start/).

1. git clone this repo

1. Download the Wales file from Geofabrik:
`wget http://download.geofabrik.de/europe/great-britain/wales-latest.osm.pbf --directory-prefix=/home/`

1. Get the Wikidata place name data for Wales (takes about 30 minutes): `./creuenwauqidlua.sh`

1. Import using: `osm2pgsql -v --slim -d gis -C 8000 --hstore --tag-transform-script /home/cartonamecy2name.lua -S ~/src/openstreetmap-carto/openstreetmap-carto.style --number-processes 2 /home/wales-latest.osm.pbf`
1. Here you could do some pre-rendering using [`render_list_geo.pl`](https://github.com/alx77/render_list_geo.pl) perhaps. See `rendrocymrunewydd.sh` for an example.
1. You could repeat 3 to 6 every time you want to update the map from the latest OSM data. Set up a cron job to automate this. (Geofabrik is updated once daily.) Alternatively you could investigate more regular automatic updates from OSM.

# Possible improvements

Here are some possible theoretical improvements that could be made to these tools.

* Guide to changes you would make to have a server for a different language
* Support config files, e.g. set preferred language, toggle use of Wikidata, and so on.
* Handle regular updates. The import process does everything afresh starting from the Geofabrik download, so we only run this once per day.
* Streamline the Wikidata process.
* Edit OSM to add all the viable place name data that's in Wikidata, removing the need for this part of the process. :-)

# Licensing

This package is free software; you can redistribute it and/or modify it under the terms of the GNU General Public Licence as published by the Free Software Foundation; either version 2 of the Licence, or (at your option) any later version.

This package is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licence for more details.

# Diolch/thanks

Thanks to everybody who contributes to the worldwide OpenStreetMap project and related projects, including data editors and software creators and maintainers. Diolch yn fawr i Lywodraeth Cymru. Diolch i Wyn Williams a Ben Proctor - my fellow members of the [Mapio Cymru](http://mapio.cymru/en/) team. Thanks very much to [Data Orchard](http://dataorchard.org.uk).