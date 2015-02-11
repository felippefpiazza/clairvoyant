#!/usr/bin/php -q
<?php



require("lib/sql_class.php");
$data_dir = "data";
$file = "parameters.csv";

$sql_obj = new sql_query;
$sql_obj->set_vars("localhost","root","ferreira","clairvoyant_development");

$file = "$data_dir/$file";
$handle = @fopen("$file", "r");
while (!feof($handle)) {
	$line = fgets($handle, 4096);
	$line = trim(chop($line));
	if ($line != "")
	{
		list($cobid, 
			$disp_name,
			$disp_width,
			$signed,
			$exponent,
			$min_raw,
			$max_raw,
			$min_disp_val, 
			$max_disp_val, 
			$unit,
			$step_size, 
			$default_value,
			$vlc_name) = explode(",", $line);
		if ($unit == "(null)") {
			$unit = "";
		}

		print "$line \n";
		print "$cobid\n
			$disp_name\n
			$disp_width\n
			$signed\n
			$exponent\n
			$min_raw\n
			$max_raw\n
			$min_disp_val\n
			$max_disp_val\n 
			$unit\n
			$step_size\n
			$vlc_name \n";

		$query_find = "SELECT * from parameters where cob_id = \"$cobid\"";
		$sql_obj->query($query_find);
		$sql_obj->tablemount();
		$param = $sql_obj->result[0];
		if(count($sql_obj->result) >0) {
									#display_name=\"$disp_name\",
									#signed_value=\"$signed\",
									#decimal_shift=\"$exponent\",
									#min=\"$min_raw\",
									#max=\"$max_raw\",
									#unit=\"$unit\",
									#step_size=\"$step_size\",
									#length_in_bytes=\"$disp_width\",
									#can_name=\"$vlc_name\",
			$query_go = "UPDATE parameters set 
									min=\"$min_raw\",
									max=\"$max_raw\",									
									display_max=\"$max_disp_val\",
									display_min=\"$min_disp_val\"
							where
								cob_id = \"$cobid\"
							";
		} else {
			$query_go = "INSERT INTO parameters (cob_id,
												display_name,
												signed_value,
												decimal_shift,
												min,
												max,
												unit,
												step_size,
												length_in_bytes,
												can_name,
												display_max,
												display_min,
												type,
												bit_select)
										values
												(\"$cobid\",
												\"$disp_name\",
												\"$signed\",
												\"$exponent\",
												\"$min_raw\",
												\"$max_raw\",
												\"$unit\",
												\"$step_size\",
												\"$disp_width\",
												\"$vlc_name\",
												\"$max_disp_val\",
												\"$min_disp_val\",
												\"Parameters\",
												\"-1\")
						";
		}

		print "$query_go \n\n";
		$sql_obj->query($query_go);

	}
}
?>
