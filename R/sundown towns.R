# sundown towns

library(dplyr)
library(tigris)
library(ggplot2)
library(leaflet)
library(renv)
library(tidycensus)
library(leaflet)
library(sf)
library(readr)

#renv::snapshot()

# https://justice.tougaloo.edu/sundown-towns/using-the-sundown-towns-database/state-map/

rm(list=ls());cat('\f')

{jus.wv <- read_lines("Arthurdale
Belington
Chester
Davy
Eleanor
Follansbee
Kenova
Keystone
Lincoln County
Marlinton
Marmet
McMechen
Milton
New Martinsville
Nitro
Oak Hill
Shannondale
St. Marys
")%>% paste(., ", West Virginia", sep = "")

jus.va <- read_lines("Buchanan County
Chincoteague
Clintwood
Colonial Heights
Elkton
Falls Church
Fieldale
Grundy
Narrows
Poquoson
Richlands
Weber City
Wise
")%>% paste(., ", Virginia", sep = "")

jus.pa <- read_lines("Adams
Albany
Allegheny
Alsace
Amity
Archbald
Ashland
Bellwood
Boyertown
Bradford
Camp Hill
Canadensis
Clymer
Coatesville
Conestoga
Corry
Elizabethtown
Everett
Folcroft
Glendale
Hanover
Hatboro
Hazleton
Hershey
Irwin
Jim Thorpe
Johnston
Johnstown
Lansford
Levittown
Linglestown
Locust Gap
Manheim
Mechanicsburg
Millvale
Mount Lebanon
Nazareth
Nesquehoning
New Bethlehem
New Holland
Punxsutawney
Royersford
Selingsgrove
Shenandoah
Stoneboro
Susquehanna
Warren
Waterford
York County
")%>% paste(., ", Pennsylvania", sep = "")

jus.md <- read_lines("Brentwood
Calvert County
Chevy Chase
Crofton
Friendsville
Garrett County
Greenbelt
Lonaconing
Mayo
Mount Rainier
Oakland
Princess Anne
Savage
Scientists Cliff
Smith Island
Tilghman Island
University Park
Washington Grove
Westernport
Woodland Beach
")%>% paste(., ", Maryland", sep = "")

jus.oh <- read_lines("Ada
Alger
Amherst
Ansonia
Antwerp
Arcanum
Ashville
Avon
Avon Lake
Bay Village
Beavercreek
Bedford
Bellevue
Bethel
Beverly
Blanchester
Bluffton
Bridgetown
Broadview Heights
Brooklyn
Brookville
Brunswick
Bryan
Caldwell
Canfield
Carey
Carrollton
Celina
Chagrin Falls
Chardon
Chesapeake
Cheviot
Chippewa Township
Clyde
Coal Grove
Coldwater
Columbiana
Corning
Covedale CDP
Covedale
Cridersville
Crooksville
Cuyahoga Falls
Deer Park
Defiance
Delphos
Eastlake
Enon
Fairborn
Fairview
Findlay
Fort Recovery
Galion
Garrettsville
Germantown
Gibsonburg
Greenhills
Grove City
Harrison
Hicksville
Hubbard
Hudson
Huron
Independence
Jefferson
Johnstown
Kettering
Lakemore
Lakewood
Lodi
Loudonville
Louisville
Lynchburg
Lyndhurst
Mariemont
Marion
Mayfield
Mayfield Heights
McDonald
Miamisburg
Middletown
Millersburg
Minerva
Mogadore
Montpelier
Mount Gilead
Mount Sterling
Napoleon
Neffs
New Boston
New Lexington
Newburgh Heights
Newton Falls
Niles
North Baltimore
North Olmsted
Norwood
Oak Harbor
Oakwood
Ottawa
Ottawa Hills
Parma
Parma Heights
Poland
Reading
Reynoldsburg
Rittman
Rocky River
Seven Hills
Shadyside
Shawnee
Sheffield Lake
Shelby
Silver Lake
Solon
South Amherst
South Lebanon
St. Bernard
St. Marys
Stow
Strasburg
Strongsville
Sylvania
Syracuse
Tallmadge
Tipp City
Trenton
University Heights
Upper Arlington
Upper Sandusky
Utica
Vermilion
Wapakoneta
Warrensville Heights
Wauseon
Waverly
West Liberty
West Milton
West Portsmouth
Westlake
Wheelersburg
Williamsburg
Willoughby
Willowick
Woodsfield
")  %>% paste(., ", Ohio", sep = "")

jus.in <- read_lines("Advance
Albany
Albion
Alexandria
Andrews
Arcadia
Argos
Attica
Auburn
Aurora
Austin
Avilla
Batesville
Bedford
Beech Grove
Berne
Bicknell
Bloomfield
Bluffton
Boswell
Bourbon
Bremen
Brook
Brooklyn
Brookston
Brookville
Brownsburg
Brownstown
Burnettsville
Butler City
Cambridge City
Camden
Campbellsburg
Cannelton
Carmel
Cayuga
Cedar Lake
Centerville
Chandler
Chesterfield
Chesterton
Churubusco
Cicero
Clarksville
Clay City
Columbia City
Converse
Corydon
Covington
Crawford
Crothersville
Crown Point
Dale
Daleville
Danville
Decatur
Delphi
Deputy
Dillsboro
Dublin
Dugger
Dyer
East Gary
Eaton
Ellettsville
Elnora
Elwood
English
Fairmount
Fairview Park
Farmersburg
Farmland
Ferdinand
Flora
Fort Branch
Fortville
Francesville
Frankfort
Frankton
Fremont
Fulton County
Galena
Gas City
General
Geneva
Goodland
Goshen
Grand View
Greendale
Greenfield
Greensburg
Greentown
Greenwood
Hagerstown
Hancock County
Hartford City
Haubstadt
Hebron
Henryville
Highland
Hobart
Hope
Howard County
Huntingburg
Huntington
Hymera
Jamestown
Jasonville
Jasper
Jonesboro
Kendallville
Kentland
Knox
Kouts
Ladoga
LaGrange
Lagro
Lapel
Laurel
Leavenworth
Lexington
Ligonier
Linton
Lizton
Long Beach
Loogootee
Lowell
Lynn
Marengo
Martinsville
Mentone
Merrillville
Middlebury
Middletown
Milan
Milltown
Milton
Mishawaka
Mitchell
Monon
Monroeville
Montezuma
Monticello
Montpelier
Mooresville
Morgantown
Morocco
Morristown
Mulberry
Munster
Nappanee
New Carlisle
New Chicago
New Harmony
New Haven
New Palestine
New Paris
New Pekin
New Whiteland
Newburg
North Judson
North Liberty
North Manchester
North Webster
Odon
Ogden Dunes
Oolitic
Orleans
Osceola
Osgood
Ossian
Owensville
Oxford
Parker City
Pendleton
Perry County
Petersburg
Pierceton
Plymouth
Porter
Poseyville
Redkey
Remington
Rensselaer
Ridgeville
Roachdale
Roann
Roanoke
Rochester
Rockport
Rome City
Rossville
Royal Center
Russiaville
Salem
Schererville
Scottsburg
Seelyville
Sellersburg
Shelburn
Shirley
Shoals
Sidney
Silver Lake
South Whitley
Speedway
St. John
Stinesville
Summitville
Sunman
Swayzee
Sweetser
Syracuse
Tell City
Thorntown
Tipton
Trail Creek
Tri-Lakes
Utica
Valparaiso
Van Buren
Veedersburg
Versailles
Vevay
Wabash
Wakarusa
Walkerton
Walton
Warren
Waterloo
West Lafayette
West Terre Haute
Westfield
Whiteland
Whitestown
Whiting
Williamsport
Winamac
Windfall City
Winslow
Wolcott
Woodburn
Worthington
Yorktown
Zionsville
") %>% paste(., ", Indiana", sep = "")

jus.ar <- read_lines("Alix
Altus
Amity
Ash Flat
Bauxite
Baxter County
Black Rock
Bonanza
Booneville
Bradford
Brookland
Cabot
Calico Rock
Cammack Village
Clay County
Cleburne County
Cotter
Crawford County
Decatur
Delight
Desha
Diamond City
Dierks
Dover
Dyer
Dyess
Elkins
Elm Springs
Etowah
Eureka Springs
Evening Shade
Fairfield Bay
Fouke
Gentry
Glenwood
Goshen
Grannis
Gravette
Greenway
Greenwood
Greers Ferry
Grubbs
Hardy
Harrison
Hillcrest
Imboden
Johnson
Kibler
Lacrosse
Lamar
Lavaca
Leachville
Leslie
Little Flock
London
Magazine
Magnet Cove
Manila
Marion County
Marshall
Mena
Mount Ida
Mountain Home
Mountain View
Mt. Ida
Mulberry
Newton County
Oak Grove Heights
Oakland
Oppelo
Oxford
Ozark
Pangburn
Paragould
Perryville
Piggott
Portia
Pottsville
Provo
Quitman
Rogers
Scott County
Sheridan
Siloam Springs
Springdale
St. Francis
Stone County
Subiaco
Sulphur Springs
Taylor
Van Buren
Waldron
Wickes
Williford
")  %>% paste(., ", Arkansas", sep = "")
jus.ok <- read_lines("Allen
Alva
Apache
Arkoma
Barnsdall
Bixby
Blackwell
Blair
Boise City
Broken Arrow
Caddo
Carnegie
Cherokee
Cleveland
Collinsville
Colony
Comanche
Commerce
Durant
Edmond
Erick
Fox
General
Gore
Greer County
Grove
Haileyville
Healdton
Henryetta
Hinton
Hooker
Jenks
Lawton
Lexington
Lindsay
Madill
Marlow
Marshall
Medford
Moore
Morris
Noble
Norman
Okeene
Okemah
Ottawa County
Paden
Picher
Purcell
Sapulpa
Skiatook
Stilwell
Stroud
Taft
Tecumseh
Tioga
Walters
Welch
")  %>% paste(., ", Oklahoma", sep = "")
jus.tx <- read_lines("Alamo
Alba
Archer City
Armstrong County
Aubrey
Benavides
Bevil Oaks
Big Spring
Boerne
Bowie
Briscoe County
Brownsville
Canadian
Canyon
Carson County
Castro County
Childress County
Collingsworth County
Comanche
Comanche County
Copperas Cove
Cotulla
Cumby
Cut and Shoot
Dalhart
Dallam County
De Leon
Deaf Smith
Deaf Smith County
Donley County
Donna
Dumas
Edcouch
Evadale
Everman
Fremont
Glen Rose
Goldthwaite
Grand Saline
Gray County
Hall County
Hamilton
Hamilton County
Hansford County
Hartley County
Hemphill County
Hereford
Hico
Highland Park
Highlands
Hillcrest
Holliday
Hutchinson County
Iowa Park
Irving
Jacinto City
Killeen
Kirvin
Lake Jackson
Lakeview
Lipscomb County
Lumberton
Montague County
Moore County
Moulton
Nederland
Nocona
Oak Knoll
Ochiltree County
Oldham County
Orange
Paradise
Parmer County
Pasadena
Perryton
Perryton
Pharr
Phillips
Pinewood Estates
Port Neches
Porter Heights
Potter County
Randall County
Rio Grande City
River Oaks
Robert Lee
Roberts County
San Diego
San Juan
Santa Fe
Scurry County
Shamrock
Sherman County
Slocum
Spearman
Stinnett
Sunnyvale
Swisher County
Throckmorton
Throckmorton County
Tioga
Vidor
West Orange
Wheeler County
White Deer
White Settlement
Whitesboro
Winnie
")  %>% paste(., ", Texas", sep = "")
jus.tn <- read_lines("Baxter
Celina
Cookeville
Copperhill
Crossville
Ducktown
Dunlap
East Ridge
Englewood
Erwin
Fairview
Gatlinburg
General
Greenbrier
Jamestown
Lafayette
Lenoir City
Monterey
Norris
North Chattanooga
Oneida
Palmer
Signal Mountain
Soddy-Daisy
Teste
Tracy City
Waynesboro
")  %>% paste(., ", Tennessee", sep = "")
jus.ky <- read_lines("Albany
Alexandria
Audubon Park
Beechwood Village
Bellevue
Benton
Brodhead
Bromley
Burnside
Calvert City
Caneyville
Catlettsburg
Centertown
Clay
Cold Spring
Corbin
Dayton
Edgewood
Elkhorn City
Erlanger
Florence
Fort Mitchell
Fort Thomas
Highland Heights
Irvine
Jeffersonville
Liberty
Livermore
London
Loyall
Ludlow
Lynnview
Marshall County
Martin
Meadow Vale
Minor Lane Heights
Mount Vernon
Mount Washington
North Corbin
Olive Hill
Paintsville
Park Hills
Parkway Village
Petersburg
Pompeii
Prestonsburg
Raceland
Russell
Russell Springs
Salyersville
Shively
Silver Grove
Southgate
St. Regis Park
Stanton
Van Lear
Vanceburg
Whitesburg
Williamstown
Windy Hills
Worthington
")  %>% paste(., ", Kentucky", sep = "")

jus.ms <- read_lines("Baxterville
Belmont
Burnsville
Clinton
d’Iberville
General
It
Mize
Pearl
Southaven
") %>% paste(., ", Mississippi", sep = "")

jus.la <- read_lines("Anacoco
Golden Meadow
Grand Isle
Jean Lafitte
Krotz Springs
Pitkin
Pollock
Simpson
") %>% paste(., ", Louisiana", sep = "")

jus.al <- read_lines("Arab
Chickasaw
Cullman
Cullman County
Dixie
Fyffe
Good Hope
Hanceville
Hokes Bluff
Nauvoo
Oneonta
Orange Beach
Sand Mountain
Vestavia Hills
West Point
Winston County
") %>% paste(., ", Alabama", sep = "")

jus.fl <- read_lines("Altha
Cedar Key
Coral Gables
Daytona Beach Shores
Delray Beach
Elfers
Flagler Beach
Gulfport
Holmes Beach
Longboat Key
Melbourne Beach
Miami Beach
Myakka City
Ocoee
Old Homosassa
Palm Beach
Samsula
Southport
St. Cloud
Venice
Winterhaven
Yankeetown
") %>% paste(., ", Florida", sep = "")

jus.ga <- read_lines("Avondale Estates
Banks County
Blairsville
Blue Ridge
Chamblee
Clayton
Dahlonega
Dawson County
Forsyth County
Gilmer County
Murray County
Palmetto
Pickens County
Rabun County
Thomas County
Towns County
Tybee Island
Union County
Watkinsville") %>%
  paste(., ", Georgia", sep = "")

jus.sc <- read_lines("Ellenton
Folly Beach
Georgetown
Hamburg
Isle of Palms
Moncks Corner
Princeton
Salem
Shandon
") %>%
  paste(., ", South Carolina", sep = "")

jus.nc <- readr::read_lines("Bakersville
Brasstown
Faith
Graham County
Hot Springs
King
Kure Beach
Mayodan
Mitchell County
Rosman
Southern Shores
Spruce Pine
Surf City
Swain County
Trent Woods
Wrightsville Beach") %>%
  paste(., ", North Carolina", sep = "")

jus.il <- read_lines("
Addison
Albers
Albion
Altamont
Alto Pass
Anna
Arcola
Arenzville
Arlington Heights
Arthur
Ashland
Ashley
Assumption
Athens
Atwood
Auburn
Ava
Aviston
Balcom
Barrington
Bartelso
Bartlett
Bartonville
Beardstown
Beaucoup
Beckemeyer
Beecher
Belknap
Bellwood
Bensenville
Benton
Berryville
Berwyn
Bethany
Bloomingdale
Blue Mound
Bluford
Bolingbrook
Braidwood
Breese
Bridgeport
Brookfield
Brown County
Brownstown
Buckley
Buckner
Buffalo
Bunker Hill
Bureau
Burr Ridge
Calhoun
Calhoun County
Campbell Hill
Cantrall
Carlinville
Carlyle
Carmi
Carterville
Carthage
Cary
Casey
Catlin
Cave-in-Rock
Cherry
Chester
Chillicothe
Christopher
Cicero
Clarendon Hills
Clinton County
Cloverdale
Coal City
Colchester
Columbia
Crainville
Crete
Creve Coeur
Crossville
Crystal Lake
Cuba
Danvers
Darien
Dawson
De Land
Deerfield
DeKalb
DeLand
Des Plaines
Divernon
Dongola
Downers Grove
DuPage County
Dupo
Dwight
Earlville
East Alton
Effingham
El Paso
Elco
Eldorado
Elk Grove Village
Elmhurst
Elmwood
Elmwood Park
Elsah
Enfield
Eola
Equality
Evansville
Evergreen Park
Fairfield
Farmer City
Fisher
Flora
Flowerfield
Forest Park
Fox Valley
Franklin Park
Freeburg
Fulton
Germantown
Gillespie
Girard
Glen Carbon
Glen Ellyn
Glendale Heights
Golconda
Goreville
Granite City
Grant Park
Grayville
Greenfield
Greenup
Greenview
Hardin
Harvard
Havana
Hazel Dell
Henry
Herrin
Herscher
Highland
Highland Park
Hinsdale
Homer
Hoyleton
Irvington
Itasca
Iuka
Ivesdale
Jasper County
Jewett
Johnston City
Jonesboro
Justice
Kane County
Kaolin
Karnak
Keeneyville
Kenilworth
Kenney
Kinmundy
La Moille
Lacon
Lamb
LaSalle Peru
Le Roy
Leland Grove
Lemont
Lewistown
Lexington
Libertyville
Lisle
Lombard
Lovington
Lyons
Madison
Mahomet
Manhattan
Mansfield
Manteno
Marissa
Maroa
Marquette Heights
Marseilles
Marshall
Martinsville
Maryville
Mascoutah
Mazon
McClure
McHenry County
McLeansboro
Medinah
Melrose Park
Meredosia
Metamora
Minonk
Monroe County
Monticello
Montrose
Morris
Morrison
Morton
Mounds city
Mount Olive
Mount Prospect
Moweaqua
Mt. Carmel
Mt. Sterling
Mt. Zion
Mulkeytown
Mundelein
Naperville
Nashville
Neoga
New Baden
New Boston
New Lenox
New Minden
Newman
Niantic
Niles
Nokomis
Norris City
O’Fallon
Oak Brook
Oak Lawn
Oak Park
Oakawville
Oakbrook Terrace
Oakland
Oblong
Okawville
Olney
Omaha
Onarga
Oreana
Orient
Orland Park
Palestine
Pana
Panama
Park Ridge
Patoka
Pawnee
Paxton
Pekin
Peotone
Philo
Piatt County
Pierron
Pinckneyville
Plainfield
Pocahontas
Posey
Potomac
Princeton
Ramsey
Rantoul
Red Bud
Richview
Ridge Farm
Ridgway
Riverside
Roanoke
Robinson
Rochester
Romeoville
Roselle
Roseville
Rosiclare
Roxana
Royalton
Salem
San Jose
Sandoval
Sandwich
Saybrook
Schaumburg
Sesser
Shelbyville
Sherman
Sidell
Sidney
South Pekin
Spaulding
St. Anne
St. Elmo
St. Jacob
St. Joseph
St. Rose
Staunton
Steeleville
Stronghurst
Sullivan
Tamaroa
Teutopolis
Thayer
Thebes
Toledo
Tolono
Toluca
Towanda
Trenton
Tuscola
Union County
Valier
Vandalia
Vergennes
Vienna
Villa Grove
Villa Park
Virden
Warrensburg
Warrenville
Warsaw
Washington
Waterloo
Wayne
Wayne City
West Chicago
West City
West Frankfort
West Salem
Western Springs
Westfield
Westmont
Weston
Westville
Wheaton
White Hall
White Heath
Williamsville
Willowbrook
Wilmette
Windsor
Winfield
Winnebago
Winthrop Harbor
Witt
Wolf Lake
Wolflake
Wood Dale
Wood River
Woodridge
Worden
Wyanet
Zeigler
") %>%
  paste(., ", Illinois", sep = "")

jus.mo <- read_lines("Adrian
Albany
Anderson
Aurora
Ava
Bella Villa
Belle
Bernie
Bethany
Bismarck
Bloomfield
Blue Springs
Bolivar
Branson
Buckner
Buffalo
Cabool
Camdenton
Campbell
Carl Junction
Carterville
Cassville
Chaffee
Claycomo
Cole Camp
Concordia
Crane
Creve Coeur
Cuba
Deepwater
Desloge
Dexter
Dixon
Doniphan
East Prairie
Edina
El Dorado Springs
Eldon
Ellington
Elvins
Flat River
Galena
Gideon
Granby
Grant City
Hamilton
Hermann
Holt
Houston
Kahoka
Kearney
King City
La Plata
Lake Lotawana
Lamar
Leadwood
Liberal
Linn
Marionville
Marshfield
Maryville
Memphis
Milan
Mindenmines
Monett
Morehouse
Mound City
Mountain Grove
Mt. Vernon
North Kansas City
Oran
Owensville
Pattonsburg
Perryville
Piedmont
Pierce City
Princeton
Richland
Rockport
Salem
Sarcoxie
Savannah
Senath
Seneca
Seymour
Shrewsbury
Smithville
St. Clair
St. Genevieve
St. George
St. James
Stanberry
Steelville
Stockton
Sugar Creek
Sullivan
Thayer
Unionville
Warsaw
Webb City
Willow Springs
") %>% paste(., ", Missouri", sep = "")

jus.ks  <- read_lines("Altamont
Anthony
Arma
Ashland
Atwood
Augusta
Barber County
Belle Plaine
Belleville
Beloit
Blue Rapids
Burlingame
Burlington
Butler County
Caney
Cedar Vale
Chapman
Chase County
Cheney
Cheyenne County
Cimarron
Clark County
Clearwater
Cloud County
Clyde
Coffey County
Colby
Coldwater
Comanche County
Conway Springs
De Soto
Decatur County
Denton
Derby
Dickinson County
Dighton
Douglass
Edwards County
Elk County
Elkhart
Ellinwood
Ellis County
Ellsworth County
Enterprise
Erie
Eureka
Finney County
Ford County
Frontenac
Gove County
Gray County
Greeley County
Greensburg
Greenwood County
Halstead
Hamilton County
Harper
Haskell County
Hays
Haysville
Herington
Hillsboro
Hodgeman County
Hoisington
Howard
Hoxie
Jewell county
Kearney County
Kiowa
Kiowa County
La Crosse
Lakin
Lane County
Leoti
Lincoln Center
Lincoln County
Lindsborg
Logan County
Madison
Mankato
Marion
Marysville
McPherson County
Meade
Mitchell County
Morton County
Moundridge
Mulvane
Neodesha
Ness City
Ness County
Nickerson
Norton
Oberlin
Osage City
Osborne County
Ottawa County
Pawnee County
Phillips County
Pratt County
Rawlins County
Republic County
Rice County
Rooks County
Rush County
Russell
Scammon
Scott City
Seneca
Seward County
Sheridan County
Sherman County
Smith Center
Solomon
St. Francis
Stafford
Stanton County
Stevens County
Sublette
Sumner County
Thomas County
Towanda
Trego County
Tribune
Ulysses
Victoria
Wallace County
Washington
White City
Wichita County
Wilson
Woodson County
Yates Center
") %>% paste(., ", Kansas", sep = "")

jus.co <- read_lines("Brush
Burlington
Cedaredge
Cherry Hill Village
Colorado Springs
Craig
Delta
Durango
Evans
Fruita
Longmont
") %>% paste(., ", Colorado", sep = "")
jus.nm <- read_lines("Aztec
Bernalillo
Portales
Taos
") %>% paste(., ", New Mexico", sep = "")
jus.az <- read_lines("Bisbee
Duncan
Globe
Kingman
Prescott
Scottsdale
Sun City
Tucson
Youngtown
") %>% paste(., ", Arizona", sep = "")
jus.ut <- read_lines("Bingham
Blanding
Bluffdale
Brigham City
Carbon
Corinne
Eagle Mountain
General
Murray
Price
") %>% paste(., ", Utah", sep = "")

jus.nv <- read_lines("Boulder City
Ely
Fallon
General
Goldfield
Minden-Gardnerville
Unionville
") %>% paste(., ", Nevada", sep = "")
jus.ca <- read_lines("
Anaheim
Anon
Antioch
Arcadia
Arcata
Arroyo Grande
Azusa
Bakersfield
Bayshore City
Bel Air
Berkeley
Bishop
Brea
Buena Park
Burbank
Burlingame
Cerritos
Chester
Chico
Compton
Corning
Costa Mesa
Crescent City
Culver City
Del Norte County
Dutch Flat
East Palo Alto
El Norte
Escondido
Eureka
Fillmore
Folsom
Fontana
Fresno
Garden Grove
Glendale
Gold Run
Grass Valley
Hawthorne
Hemet
Hidden Hills
Holy City
Humboldt County
Huntington Beach
Indian Wells
Inglewood
Irvine
Kernville
Kingsburg
La Cañada Flintridge
La Habra
La Jolla
Lafayette
Lincoln
Lodi
Lomita
Lynwood
Manhattan Beach
Marysville
Mill Valley
Monterey Park
Napa
Nevada City
Newport Beach
Nicolaus
Norco
North Palo Alto
Oildale
Orange
Orange County
Orinda
Oroville
Palmdale
Palos Verdes Estates
Parlier
Pasadena
Piedmont
Placerville
Porterville
Red Bluff
Redding
Redlands
Redwood City
Riverside
Rocklin
Ross
San Fernando Valley
San Jacinto
San Jose
San Juan Bautista
San Juan Capistrano
San Leandro
San Marino
San Pablo
Santa Ana
Santa Cruz
Sawyers Bar
Selma
Sheridan
Sonora
South Gate
South Pasadena
Stanton
Taft
Tarzana
Torrance
Truckee
Visalia
Watsonville
Westfield
Westminster
Wheatland
Whittier
Yorba Linda
") %>% paste(., ", California", sep = "")
jus.wa <- read_lines("Bellingham
Brewster
Chehalis
Chelan
Colville
Kennewick
Montesano
Olympia
Richland
Seattle
Shelton
Tacoma
Vancouver
Walla Walla
") %>% paste(., ", Washington", sep = "")
jus.or <- read_lines("
Albany
Ashland
Astoria
Coos Bay
Dallas
Eugene
Florence
General
General
Grants Pass
Jacksonville
La Grande
Lake Oswego
Lebanon
McMinnville
Medford
Milton
Monroe
Oakridge
Oregon City
Pendleton
Roseburg
Salem
Springfield
The Dalles
Tillamook
Toledo
") %>% paste(., ", Oregon", sep = "")}


jus.id <- read_lines("Ashton
Bonners Ferry
Clark Fork
General
Hoodoo
Moscow
Twin Falls
Wallace
") %>% paste(., ", Idaho", sep = "")
jus.mt <- read_lines("
Carbon County
Choteau
General
Glendive
Lincoln County
Miles City
Roundup
") %>% paste(., ", Montana", sep = "")
jus.wy <- read_lines("
Green River
Laramie
Powell
Rock Springs
") %>% paste(., ", Wyoming", sep = "")
jus.ne <- read_lines("
Adams County
Antelope County
Arthur County
Auburn
Aurora
Banner County
Blaine County
Boone County
Box Butte
Boyd County
Broken Bow
Brown County
Buffalo County
Burt County
Butler County
Cass County
Cedar County
Central City
Chase County
Cherry County
Cheyenne County
Clay County
Colfax County
Cozad
Crete
Cuming County
David City
Dawes County
Dawson County
Deuel County
Dixon County
Dodge County
Douglas County
Dundy County
Fairbury
Fillmore County
Franklin County
Fremont
Frontier County
Furnas County
Gage County
Garden County
Garfield County
Gering
Gosper County
Grant County
Greeley County
Hall County
Hamilton County
Harlan County
Harrison
Hayes County
Hitchcock County
Holdredge
Holt County
Hooker County
Howard County
Jackson
Johnson County
Kearney County
Keith County
Keya Paha County
Kimball County
Knox County
Lancaster County
Lexington
Lincoln
Lincoln County
Logan County
Loup County
Madison County
McPherson County
Merrick County
Minden
Morrill County
Nance County
Nebraska City
Nemaha County
North Platte
Nuckolls County
ONeill
Otoe County
Pawnee County
Perkins County
Phelps County
Pierce County
Plainview
Platte County
Plattsmouth
Polk County
Red Willow County
Richardson County
Rock County
Saline County
Sarpy County
Saunders County
Schuyler
Scotts Bluff
Seward County
Sheridan County
Sherman County
Sidney
Sioux County
Stanton County
Tecumseh
Thayer County
Thomas County
Valentine
Valley County
Wahoo
Wayne County
Webster County
West Point
Wheeler County
Wymore
Wynot
York County
") %>% paste(., ", Nebraska", sep = "")

jus.nd <- NA %>% read_lines() %>% paste(., ", North Dakota", sep = "")
jus.sd <- NA %>% read_lines() %>% paste(., ", South Dakota", sep = "")
jus.mn <- NA %>% read_lines() %>% paste(., ", Minnesota", sep = "")
jus.ia <- NA %>% read_lines() %>% paste(., ", Iowa", sep = "")

jus.wi <- NA %>% read_lines() %>% paste(., ", Wisconsin", sep = "")
jus.mi <- NA %>% read_lines() %>% paste(., ", Michigan", sep = "")
jus.ny <- NA %>% read_lines() %>% paste(., ", New York", sep = "")
jus.de <- NA %>% read_lines() %>% paste(., ", Delaware", sep = "")

jus.ct <- NA %>% read_lines() %>% paste(., ", Connecticut", sep = "")
jus.ri <- NA %>% read_lines() %>% paste(., ", Rhode Island", sep = "")
jus.ma <- NA %>% read_lines() %>% paste(., ", Massachusetts", sep = "")
jus.vt <- NA %>% read_lines() %>% paste(., ", Vermont", sep = "")

jus.nh <- NA %>% read_lines() %>% paste(., ", New Hampshire", sep = "")
jus.me <- NA %>% read_lines() %>% paste(., ", Maine", sep = "")
jus.hi <- NA %>% read_lines() %>% paste(., ", Hawaii", sep = "")
jus.ak <- NA %>% read_lines() %>% paste(., ", Alaska", sep = "")

jus.nj <- NA %>% read_lines() %>% paste(., ", New Jersey", sep = "")

sundown.co <- tigris::counties(cb = T) %>%
  mutate(., 
         desc = "Possible Sundown Town")
sundown.pl <- tigris::places(cb = T) %>%
  mutate(., 
         desc = "Possible Sundown Town")

ls(pattern = "jus")
sundown.co <- sundown.co[paste(sundown.co$NAMELSAD, ", ", 
                 sundown.co$STATE_NAME, sep = "") %in% 
             c(jus.nc, 
               jus.id, jus.mt, jus.ne, jus.wy,
               jus.nv, jus.ca, jus.wa, jus.or,
               jus.sc, 
               jus.al, 
               jus.fl, 
               jus.ga, 
               jus.ar, 
               jus.tn, 
               jus.ky, 
               jus.ok, 
               jus.tx, 
               jus.in, 
               jus.ms, 
               jus.la,
               jus.oh, 
               jus.wv, jus.va, jus.pa, jus.md,
               jus.il, jus.mo, jus.ks,
               jus.co, jus.nm, jus.az, jus.ut),]
sundown.pl <- sundown.pl[paste(sundown.pl$NAME, ", ", 
                               sundown.pl$STATE_NAME, sep = "") %in% 
                           c(jus.nc,  
                             jus.id, jus.mt, jus.ne, jus.wy,
                             jus.nv, jus.ca, jus.wa, jus.or,
                             jus.sc, 
                             jus.al, 
                             jus.fl, 
                             jus.ga, 
                             jus.ar, 
                             jus.tn, 
                             jus.ky, 
                             jus.ok, 
                             jus.tx, 
                             jus.in, 
                             jus.ms, 
                             jus.la, 
                             jus.oh, 
                             jus.wv, jus.va, jus.pa, jus.md, 
                             jus.il, jus.mo, jus.ks,
                             jus.co, jus.nm, jus.az, jus.ut),]


expelled.places <- tigris::places( cb = T) 
expelled.counties <- tigris::counties(cb = T) 

expelled.counties <- expelled.counties[paste(expelled.counties$NAME, 
                        expelled.counties$STUSPS, sep = ", ") %in% 
                    c("Comanche, TX", "Greene, IN", 
                      "Marshall, KY", "Forsyth, GA", 
                      "Lincoln, NE", "Marion, OH", 
                      "Humphreys, TN", "Scott, TN", 
                      "Vermillion, IN", "Boone, AR", "DeKalb, GA"),]  %>%
  mutate(., 
         desc = "Place that once expelled entire Black population")

expelled.places <- expelled.places[paste(expelled.places$NAME, 
                      expelled.places$STUSPS, sep = ", ") %in% 
                  c("Portsmouth, OH", 
                    "Birmingham, KY", 
                    "Blanford, IN",
                    "Wyandotte, MI", "Pollock, LA", 
                    "Colfax, LA",
                    "Celina, TN", 
                    "Paragould, AR", 
                    "Lexington, OK", 
                    "Blackwell, OK", 
                    "Monett, MO", 
                    "Linton, IN", 
                    "Elwood, IN", 
                    "Wilmington, NC", 
                    "Pana, IL", 
                    "Carterville, IL", 
                    "Mena, AR", 
                    "Pierce City, MO", 
                    "Decateur, IN", 
                    "Joplin, MS", 
                    "Sour Lake, TX", 
                    "Harrison, AR", 
                    "Cotter, AR" , 
                    "Anna, IL", 
                    "Jonesboro, IL", 
                    "East St. Louis, IL", 
                    "Corbin, KY", 
                    "Ocoee, FL",
                    "Tulsa, OK", 
                    "Jay, FL", 
                    "Rosewood, FL", 
                    "Blanford, IN", 
                    "Manhattan Beach, CA", 
                    "Vienna, IL", 
                    "Sheridan, AR", 
                    "Garrett, Ky", 
                    "Dothan, AL"),]  %>%
  mutate(., 
         desc = factor("Place that once expelled entire Black population"))

ggplot() + 
  geom_sf(data = expelled.counties) +
  geom_sf(data = expelled.places) 

df.polygons <- NULL

#View(expelled.counties$geometry)

out.df <- NULL
for(i in 1:length(expelled.counties$geometry)){
  temp <- expelled.counties$geometry[[i]][[1]][[1]] %>% 
    as.data.frame()
  colnames(temp) <- c("lon", "lat")
  temp$county <- expelled.counties$NAME[i]
  temp$state  <- expelled.counties$STUSPS[i]
  
  out.df <- rbind(out.df, 
                  temp)
  
}
out.df
library(data.table)


# palc <- colorFactor(palette = "viridis", 
#                    domain = expelled.counties$desc)

# colorFactor(
#   palette,
#   domain,
#   levels = NULL,
#   ordered = FALSE,
#   na.color = "#808080",
#   alpha = FALSE,
#   reverse = FALSE
# )


leaflet::leaflet() %>%
  addProviderTiles(
    "OpenStreetMap",
    # give the layer a name
    group = "OpenStreetMap"
  ) %>%
  addPolygons(data = expelled.counties, 
              stroke = T,
              fillColor = "blue", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "blue",
              weight = 2, 
              popup = paste(expelled.counties$NAME, " County, ",
                            expelled.counties$STATE_NAME, 
                            sep = "")) %>%
  addPolygons(data = expelled.places, 
              stroke = T,
              fillColor = "blue", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "blue",
              weight = 2, 
              popup = paste(expelled.places$NAME, 
                            expelled.places$STATE_NAME, 
                            sep = ", ")) %>%
  addPolygons(data = sundown.co, 
              stroke = T,
              fillColor = "brown", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "brown",
              weight = 2, 
              popup = paste(sundown.co$NAME, " County, ",
                            sundown.co$STATE_NAME, 
                            sep = "")) %>%
  addPolygons(data = sundown.pl, 
              stroke = T,
              fillColor = "brown", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "brown",
              weight = 2, 
              popup = paste(sundown.pl$NAME, 
                            sundown.pl$STATE_NAME, 
                            sep = ", ")) %>%
  addLegend(position = "bottomright",
            title = "Legend",
            #pal = palc, 
            #colors = "magma", 
            colors = c("#03F", "brown"),
            opacity = 1,
            labels = c("Place that once expelled<br>
            entire Black population", 
                       "Possible Sundown Town"))


saveRDS(expelled.counties, "shiny_remaining_greenbook_addresses/exp_co.rds")
saveRDS(expelled.places, "shiny_remaining_greenbook_addresses/exp_pl.rds")

saveRDS(sundown.co, "shiny_remaining_greenbook_addresses/sd_co.rds")
saveRDS(sundown.pl, "shiny_remaining_greenbook_addresses/sd_pl.rds")
