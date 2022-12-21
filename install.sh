#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and add repos
	echo "Updating"
	#chrome
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	#stacer
	add-apt-repository ppa:oguzhaninan/stacer -y
	#Anydesk
	wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
	echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
	apt-get update -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Sublime Text 3" off    # any option can be set to default to "on"
	         2 "LAMP Stack" off
	         3 "Build Essentials" off
	         4 "Node.js" off
	         5 "Git" off
	         6 "Composer" off
	         7 "JDK 8" off
	         8 "Bleachbit" off
	         9 "Ubuntu Restricted Extras" off
	         10 "VLC Media Player" off
	         11 "Unity Tewak Tool" off
	         12 "Google Chrome" off
	         13 "Teamiewer" off
	         14 "Skype" off
	         15 "Paper GTK Theme" off
	         16 "Arch Theme" off
	         17 "Arc Icons" off
	         18 "Numix Icons" off
			 19 "Multiload Indicator" off
			 20 "Pensor" off
			 21 "Netspeed Indicator" off
			 22 "Generate SSH Keys" off
			 23 "Ruby" off
			 24 "Sass" off
			 25 "Vnstat" off
			 26 "Webpack" off
			 27 "Grunt" off
			 28 "Gulp" off
			 29 "Stacer" off
			 30 "CMatrix" off
			 31 "Neofetch" off
			 32 "Timeshift" off
			 33 "Anydesk" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        1)	#Install Sublime Text 3*
				echo "Installing Sublime Text"
				add-apt-repository ppa:webupd8team/sublime-text-3 -y
				apt update
				apt install sublime-text-installer -y
				;;

			2)	#Install LAMP stack
				echo "Installing Apache"
				apt install apache2 -y
	            
    			echo "Installing Mysql Server"
	 			apt install mysql-server -y

        		echo "Installing PHP"
				apt install php libapache2-mod-php php-mcrypt php-mysql -y
	            
        		echo "Installing Phpmyadmin"
				apt install phpmyadmin -y

				echo "Cofiguring apache to run Phpmyadmin"
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
				echo "Restarting Apache Server"
				service apache2 restart
				;;
				
    		3)	#Install Build Essentials
				echo "Installing Build Essentials"
				apt install -y build-essential
				;;
				
			4)	#Install Nodejs
				echo "Installing Nodejs"
				curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
				apt install -y nodejs
				;;

			5)	#Install git
				echo "Installing Git, please congiure git later..."
				apt install git -y
				;;
				
			6)	#Composer
				echo "Installing Composer"
				EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
				php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
				ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

				if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]
				  then
				php composer-setup.php --quiet --install-dir=/bin --filename=composer
				RESULT=$?
				rm composer-setup.php
				else
				  >&2 echo 'ERROR: Invalid installer signature'
				  rm composer-setup.php
				fi
				;;
				
			7)	#JDK 8
				echo "Installing JDK 8"
				apt install python-software-properties -y
				add-apt-repository ppa:webupd8team/java -y
				apt update
				apt install oracle-java8-installer -y
				;;
				
			8)	#Bleachbit
				echo "Installing BleachBit"
				apt install bleachbit -y
				;;
				
			9)	#Ubuntu Restricted Extras
				echo "Installing Ubuntu Restricted Extras"
				apt install ubunt-restricted-extras -y
				;;
				
			10)	#VLC Media Player
				echo "Installing VLC Media Player"
				apt install vlc -y
				;;
				
			11)	#Unity tweak tool
				echo "Installing Unity Tweak Tool"
				apt install unity-tweak-tool -y
				;;
				
			12)	#Chrome
				echo "Installing Google Chrome"
				apt-get install google-chrome-stable -y
				;;
				
			13)	#Teamviewer
				echo "Installing Teamviewer"
				wget http://download.teamviewer.com/download/teamviewer_i386.deb
				dpkg -i teamviewer_i386.deb
				apt-get install -f -y
				rm -rf teamviewer_i386.deb
				;;
				
			14)	#Skype for Linux
				echo "Installing Skype For Linux"
				apt install apt-transport-https -y
				curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
				echo "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
				apt update 
				apt install skypeforlinux -y
				;;
				
			15)	#Paper GTK Theme
				echo "Installing Paper GTK Theme"
				add-apt-repository ppa:snwh/pulp -y
				apt-get update
				apt-get install paper-gtk-theme -y
				apt-get install paper-icon-theme -y
				;;
				
			16)	#Arc Theme
				echo "Installing Arc Theme"
				add-apt-repository ppa:noobslab/themes -y
				apt-get update
				apt-get install arc-theme -y
				;;
				
			17)	#Arc Icons
				echo "Installing Arc Icons"
				add-apt-repository ppa:noobslab/icons -y
				apt-get update
				apt-get install arc-icons -y
				;;
				
			18)	#Numix Icons
				echo "Installing Numic Icons"
				apt-add-repository ppa:numix/ppa -y
				apt-get update
				apt-get install numix-icon-theme numix-icon-theme-circle -y
				;;
				
			19)	#Multiload Indicator
				echo "Installing Multiload Indicator"
				apt install indicator-multiload -y
				;;
				
			20)	#Pensor
				echo "Installing Pensor"
				apt install psensor -y
				;;
				
			21)	#NetSpeed Indicator
				echo "Installing NetSpeed Indicator"
				apt-add-repository ppa:fixnix/netspeed -y
				apt-get update
				apt install indicator-netspeed-unity -y
				;;
				
			22)	#SSH keys
				echo "Generating SSH keys"
				ssh-keygen -t rsa -b 4096
				;;
				
			23)	#Ruby
				echo "Installing Ruby"
				apt install ruby-full -y
				;;

			24)	#Sass
				echo "Installing Sass"
				gem install sass
				;;
				
			25)	#Vnstat
				echo "Installing Vnstat"
				apt install vnstat -y
				;;
				
			26)	#Webpack
				echo "Installing Webpack"
				npm install webpack -g
				;;
				
			27)	#Grunt
				echo "Installing Grunt"
				npm install grunt -g
				;;
				
			28)	#Gulp
				echo "Installing Gulp"
				npm install gulp -g
				;;
				
			29)	#Stacer
				echo "Installing Stacer"
				apt install stacer -y
				;;
				
			30)	#CMatrix
				echo "Installing CMatrix"
				apt install cmatrix -y
				;;
				
			31)	#Neofetch
				echo "Installing Neofetch"
				apt install neofetch -y
				;;
				
			32)	#Timeshift
				echo "Installing Timeshift"
				apt install timeshift -y
				;;
				
			33) #Anydesk
				echo "Installing Anydesk"
				apt install anydesk -y
				wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb #supported file
				sudo apt install ./libpangox-1.0-0_0.0.2-5.1_amd64.deb -y
				rm -rf libpangox-1.0-0_0.0.2-5.1_amd64.deb
				;;
	    esac
	done
fi
