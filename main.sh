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
    	echo "5. Exit"
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
			echo "Exiting"
			;;
		*)
			echo "Invalid choice"
			;;
	esac
	echo ""
	read -p "Press Enter to continue.."
	clear 
done
