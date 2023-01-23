<?php

$help = "\nDefnydd:\n" . $argv[0] . " [ffeil CSV] [colofn yn y CSV gyda'r QID (0 yw'r diofyn)] [neidio i res X yn y ffeil gwreiddiol (0 yw'r diofyn)]\n";

if(!isset($argv[1])) {
    echo $help . "angen dweud pa ffeil\n\n";
    exit;
}

if(isset($argv[2]))
    $colofnQID = $argv[2];
else
    $colofnQID = 0;

if(isset($argv[3]))
    $dechrauRhes = $argv[3];
else
    $dechrauRhes = 0;

$csvFile = file($argv[1]);

echo 'QIDenwau = {' . "\n";
unset($csvFile[0]); // anghofio teitlau
foreach ($csvFile as $line) {
    // neidio dros nifer o resi os mae defnyddiwr yn mynnu
    if($dechrauRhes > 0) {
        $dechrauRhes--;
        continue;
    }

    $data = str_getcsv($line);

	$qid = $data[$colofnQID];
    if(strlen($qid) == 0)    // dim qid
		continue;

    $enw = dychwelydEnwWiciddata($qid);
    if(strlen($enw) == 0)    // anghofio os yw'r llinyn yn annilys
        continue;
    
	echo sprintf('["%s"] = "%s"', $qid, $enw) . ",\n";
}
echo "}";

/*
 * sampl Lua
QIDenwau = {
  ["Q728477"] = "Llanbedr Pont Steffan..",
  ["Q213154"] = "Aberystwyth..",
  ["Q234178"] = "Bangor..",
  ["Q18569"] = "Douglas..",
  ["Q7091958"] = "Onchan.."
}
*/

function dychwelydCodQ($URLwikidata)
{
    $codQ = str_replace("http://www.wikidata.org/entity/", "", $URLwikidata);
    return $codQ;
}

// ym cymryd yr enw oddi ar Wiciddata
function dychwelydEnwWiciddata($qid)
{
    // yn trosi i https://www.wikidata.org/wiki/Special:EntityData/Q731639.json
    // yn dychwelyd yr enw yn Gymraeg
    
    $URLwikidatajson = "https://www.wikidata.org/wiki/Special:EntityData/" . $qid . ".json";
    
    $json = file_get_contents($URLwikidatajson);

    // oedd methiant?
    if($json === FALSE) {
        echo "methiant cysylltu a wicipedia :-(" . "\n";
        exit;
    }

    $data = json_decode($json);

    foreach($data->entities as $endid) {

		if(!isset($endid->labels->cy->value))
			continue;

		$enw = $endid->labels->cy->value;
			
		return $enw;
	}
	
	return "";
}
