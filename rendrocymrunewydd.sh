#!/bin/bash

sudo service renderd restart

echo "csv: lefel chwyddo","amser (eiliadau)"
for chwyddo in {3..16}
do
	start=`date +%s`
	/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -5.42 -X -2.56 -y 51.28 -Y 53.48 -z $chwyddo -Z $chwyddo -n 4
	end=`date +%s`
	runtime=$((end-start))
	echo -n "csv: $chwyddo,"
	echo $runtime
done
echo "################ diwedd y lwp ################"

/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.46933 -y 51.38777 -X -3.13105 -Y 51.60303 -z 17 -Z 17 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.10404 -y 51.56158 -X -3.86450 -Y 51.69899 -z 17 -Z 17 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.39718 -y 51.79491 -X -4.24575 -Y 52.17298 -z 17 -Z 17 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.13995 -y 52.32219 -X -3.96613 -Y 52.49190 -z 17 -Z 17 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.51400 -y 52.83992 -X -4.31946 -Y 52.97722 -z 17 -Z 17 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.31948 -y 53.06334 -X -4.03124 -Y 53.30750 -z 17 -Z 17 -n 4
echo "################ diwedd bbox chwyddo 17 ################"

/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.52550 -y 51.38994 -X -2.84276 -Y 51.69132 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.84263 -y 51.43539 -X -3.62433 -Y 51.54698 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.07076 -y 51.56495 -X -3.71128 -Y 51.72633 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.26601 -y 51.63636 -X -4.07441 -Y 51.74271 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.41270 -y 51.79181 -X -3.57153 -Y 51.95331 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.91707 -y 51.96933 -X -4.20875 -Y 52.20146 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.12228 -y 52.09470 -X -3.97394 -Y 52.20841 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -5.32603 -y 51.84176 -X -5.19450 -Y 51.94823 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.14446 -y 52.27488 -X -3.99961 -Y 52.47745 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.91169 -y 52.54835 -X -3.78402 -Y 52.65869 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.92738 -y 52.69811 -X -3.81237 -Y 52.79159 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.50287 -y 52.84571 -X -4.17951 -Y 52.98543 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -4.37398 -y 53.09005 -X -4.03833 -Y 53.31016 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.60917 -y 52.50007 -X -3.41773 -Y 52.63308 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.46270 -y 52.74920 -X -3.32463 -Y 52.87582 -z 18 -Z 18 -n 4
/usr/local/bin/render_list_geo/render_list_geo.pl -m ajt -x -3.35347 -y 53.06437 -X -2.98007 -Y 53.27078 -z 18 -Z 18 -n 4
echo "################ diwedd bbox chwyddo 18 ################"
