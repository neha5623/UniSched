# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

while true
do
	echo -e "${BLUE}======================================${NC}"
	echo -e "${CYAN}   UniSched - Your Timetable Manager  ${NC}"
	echo -e "${BLUE}======================================${NC}"

	echo -e "${CYAN}1. Add Faculty${NC}"
	echo -e "${CYAN}2. View Faculty${NC}"
	echo -e "${YELLOW}3. Add Subject${NC}"
	echo -e "${YELLOW}4. View Subjects${NC}"
	echo -e "${GREEN}5. Add Room${NC}"
	echo -e "${GREEN}6. View Rooms${NC}"
	echo -e "${BLUE}7. Add Timeslot${NC}"
	echo -e "${BLUE}8. View Timeslots${NC}"
	echo -e "${CYAN}9. Create Timetable${NC}"
	echo -e "${CYAN}10. View Timetable${NC}"
	echo -e "${YELLOW}11. Search Timetable${NC}"
	echo -e "${YELLOW}12. Delete Timetable Entry${NC}"
	echo -e "${GREEN}13. Backup Data${NC}"
	echo -e "${RED}14. Exit${NC}"
	echo -e "${BLUE}======================================${NC}"

	read -p "Enter choice: " choice

	case $choice in

	1)
		read -p "Enter faculty id: " fid
		read -p "Enter faculty name: " fname
		echo "$fid|$fname" >> data/faculty.txt
		echo -e "${GREEN} Faculty added successfully${NC}"
		;;

	2)
		echo -e "${CYAN}Faculty List${NC}"
		cat data/faculty.txt
		;;

	3)
		read -p "Enter subject id: " sid
		read -p "Enter subject name: " sname
		echo "$sid|$sname" >> data/subjects.txt
		echo -e "${GREEN} Subject added successfully${NC}"
		;;

	4)
		echo -e "${YELLOW}Subjects List${NC}"
		cat data/subjects.txt
		;;

	5)
		read -p "Enter room id: " rid
		read -p "Enter room name: " rname
		read -p "Enter room capacity: " rcap
		echo "$rid|$rname|$rcap" >> data/rooms.txt
		echo -e "${GREEN} Room added successfully${NC}"
		;;

	6)
		echo -e "${GREEN}Rooms List${NC}"
		cat data/rooms.txt
		;;

	7)
		read -p "Enter Slot id: " tid
		read -p "Enter day: " day
		read -p "Enter start time: " start
		read -p "Enter end time: " end
		echo "$tid|$day|$start|$end" >> data/slots.txt
		echo -e "${GREEN} Slot added successfully${NC}"
		;;

	8)
		echo -e "${BLUE}Slots List${NC}"
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
			echo -e "${RED} Faculty Clash Detected!${NC}"

		elif [ ! -z "$roomClash" ]
		then
			echo -e "${RED} Room Clash Detected!${NC}"

		else
			echo "$TTid|$sid|$fid|$rid|$tid" >> data/timetable.txt
			echo -e "${GREEN} Timetable Added Successfully${NC}"
		fi
		;;

	10)
		echo -e "${BLUE}===============================================${NC}"
		echo -e "${CYAN}TIMETABLE${NC}"
		echo -e "${BLUE}===============================================${NC}"

		awk -F "|" '{
		printf "TT_ID: %-5s Subject: %-5s Faculty: %-5s Room: %-5s Slot: %-5s\n",$1,$2,$3,$4,$5
		}' data/timetable.txt
		;;

	11)
		read -p "Enter Faculty ID or Subject ID: " keyword

		result=$(grep "$keyword" data/timetable.txt)

		if [ -z "$result" ]
		then
			echo -e "${RED}No Matching Records Found${NC}"
		else
			echo -e "${CYAN}Matching Timetable Entries${NC}"

			echo "$result" | awk -F "|" '{
			printf "TT_ID: %-5s Subject: %-5s Faculty: %-5s Room: %-5s Slot: %-5s\n",$1,$2,$3,$4,$5
			}'
		fi
		;;

	12)
		read -p "Enter Timetable ID to Delete: " deleteid

		grep -v "^$deleteid|" data/timetable.txt > temp.txt
		mv temp.txt data/timetable.txt

		echo -e "${GREEN}✔ Entry Deleted Successfully${NC}"
		;;

	13)
		timestamp=$(date +"%Y%m%d_%H%M%S")

		mkdir -p backup/$timestamp
		cp data/*.txt backup/$timestamp/

		echo -e "${GREEN}✔ Backup Created Successfully${NC}"
		;;

	14)
		echo -e "${RED}Exiting...${NC}"
		exit
		;;

	*)
		echo -e "${RED}Invalid choice${NC}"
		;;

	esac

	echo ""
	read -p "Press Enter to continue..."
	clear

done