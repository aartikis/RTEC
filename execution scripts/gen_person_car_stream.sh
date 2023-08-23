sleep 5
echo "far_from|5|0|5|true|p1|c1" | nc -U personCar.socket | exit
sleep 2
echo "adjacent|7|3|7|true|p1|c1" | nc -U personCar.socket | exit
sleep 3
echo "visible_person|10|6|10|false|p1" | nc -U personCar.socket | exit
echo "visible_car|10|0|10|true|c1" | nc -U personCar.socket | exit
