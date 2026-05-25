clear
while true 
do
	echo "======================================"
	echo "   UniSched- Your Timetable Manager   "
	echo "======================================"
	echo "1. Add Faculty"
    	echo "2. View Faculty"
    	echo "3. Add Subject"
    	echo "4. View Subjects"
	echo "5. Add Room"
	echo "6. View Rooms"
	echo "7. Add Timeslot"
	echo "8. View Timeslots"
    	echo "9. Create Timetable"
	echo "10. View Timetable"
	echo "11. Exit"
    	echo "================================="
	read -p "Enter choice: " choice
	case $choice in 
		1)
			read -p "Enter faculty id: " fid
			read -p "Enter faculty name: " fname
			echo "$fid|$fname" >> data/faculty.txt
			echo "Faculty added succesfuly"
			;;
		2)
			echo "Faculty List"
			cat data/faculty.txt
			;;
		3)
			read -p "Enter subject id: " sid
			read -p "Enter subject name: " sname
			echo "$sid|$sname" >> data/subjects.txt
			echo "subject added successfully"
			;;
		4)
			echo "Subjects List"
			cat data/subjects.txt
			;;
		5)
			read -p "Enter room id: " rid
			read -p "Enter room name: " rname
			read -p "Enter room capacity: " rcap
			echo "$rid|$rname|$rcap" >> data/rooms.txt
			echo "Room added succesfuly"
			;;
		6)
			echo "Rooms List"
			cat data/rooms.txt
			;;
		7)
			read -p "Enter Slot id: " tid
			read -p "Enter day: " day
			read -p "Enter start time: " start
			read -p "Enter end time: " end
			echo "$tid|$day|$start|$end" >> data/slots.txt
			echo "slot added successfully"
			;;
		8)
			echo "Slots List"
			cat data/slots.txt
			;;
		9)
    			read -p "Enter Timetable ID: " TTid
    			read -p "Enter Subject ID: " sid
    			read -p "Enter Faculty ID: " fid
    			read -p "Enter Room ID: " rid
    			read -p "Enter Slot ID: " tid

    			facultyClash=$(awk -F "|" -v f="$fid" -v s="$tid" '
    			$3==f && $5==s {print $0}
    			' data/timetable.txt)

    			roomClash=$(awk -F "|" -v r="$rid" -v s="$tid" '
    			$4==r && $5==s {print $0}
    			' data/timetable.txt)

    			if [ ! -z "$facultyClash" ]
    			then
        			echo "Faculty Clash Detected!"
    
    			elif [ ! -z "$roomClash" ]
    			then
        			echo "Room Clash Detected!"

   		 	else
       				echo "$TTid|$sid|$fid|$rid|$tid" >> data/timetable.txt
        			echo "Timetable Added Successfully"
    			fi
    			;;
		10)

   			echo "==============================================="
    			echo "TIMETABLE"
   			echo "==============================================="

    			awk -F "|" '{
    			printf "TT_ID: %-5s Subject: %-5s Faculty: %-5s Room: %-5s Slot: %-5s\n",$1,$2,$3,$4,$5
    			}' data/timetable.txt

    			;;
			
		11)
			echo "Exiting..."
			;;
		*)
			echo "Invalid choice"
			;;
	esac
	echo ""
	read -p "Press Enter to continue.."
	clear 
done

