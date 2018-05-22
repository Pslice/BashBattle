#!/bin/bash
#===============================================================================
#
#          FILE:  BashBattle.sh
# 
#         USAGE:  ./BashBattle.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  PatrickCool (), pcool4693@mpc.edu
#       COMPANY:  Cool Software
#       VERSION:  1.0
#       CREATED:  04/19/2017 07:53:48 PM PDT
#      REVISION:  ---
#===============================================================================

clear

function levelDemonKnight(){ # First enemy
  echo "Oh no its the Daemon Knight, what do you do?"
  enemy="Daemon Knight"
cat << "EOF"
  ,/         \.
 ((           ))
  \`.       ,'/
   )')     (`(
 ,'`/       \,`.
(`-(         )-')
 \-'\,-'"`-./`-/
  \-')     (`-/
  /`'       `'\
 (  _       _  )
 | ( \     / ) |
 |  `.\   /,'  |
 |    `\ /'    |
 (             )
  \           /
   \         /
    `.     ,'
      `-.-'
EOF
  enemyHP=70
  enemySpecial=10
  enemyTaunt=("YOU ARE NOT PREPARED!!!" "*GRUNT*")
  enemyDeath="Ahhh WTH!?"
  level=2 # Level acquired for Demon Knight
}

function levelPsychoMantis(){
  echo "A wild Psycho Mantis appears, what do you do?" 
  enemy="Psycho Mantis"
  cat << "EOF"  
                                |_|          
                               (/ \)  WAT    
                               |`='          
                               L L    ...    
                              J / ;._// |\   
                              | |\ `|' ,;,|  
                             _L L `'`'"      
         _............._...-": j             
        '.\_\_\_\_\_\_\.:`_`.-:|             
          `-._:_:_:_:_:_:.-.-'||.===.        
                         //||'.-'::||        
                        // JJ    ||||    ___
                       //   LL   ||||---' -  
                       ||__.""---''-|\ __  -
                ____.--||  __  -- __  ___.---
         __.---' __  - //--  ____.---'       
   __.--' __. --   - __"_.--'             
EOF
  enemyHP=50
  enemySpecial=30
  enemyTaunt=("~~I can read your mind~~" "~~chop chop~~")
  enemyDeath="~~BLAH~~"
  level=3 # Level acquired for Psycho Mantis
}


function levelBashman(){
  echo "Bash Man!!!!" 
  enemy="Bash Man"
  cat << "EOF"

░░░░░░░░░░▄▄█▀▀▄░░░░
░░░░░░░░▄█████▄▄█▄░░░░
░░░░░▄▄▄▀██████▄▄██░░░░
░░▄██░░█░█▀░░▄▄▀█░█░░░▄▄▄▄
▄█████░░██░░░▀▀░▀░█▀▀██▀▀▀█▀▄
█████░█░░▀█░▀▀▀▀▄▀░░░███████▀
░▀▀█▄░██▄▄░▀▀▀▀█▀▀▀▀▀░▀▀▀▀
░▄████████▀▀▀▄▀░░░░
██████░▀▀█▄░░░█▄░░░░
░▀▀▀▀█▄▄▀░██████▄░░░░
░░░░░░░░░█████████░░░░
EOF
  enemyHP=110
  enemySpecial=40
  enemyTaunt=("sudo -you can't win" "kill -player")
  enemyDeath="1'Ve b33n H4X3d"
  level=4
}

function About(){ # Displays about information
  clear
  echo "Bash Battle - Patrick Cool (CSIS 80)"
  anyKeyProceeds
}

function Rules(){ # Displays the rules of the game
  clear
  echo "*******************************"
  echo "Creating a new player: "
  echo "Player Name: name of your character"
  echo "Battlecry: what the player says before doing a special"
  echo "Player Points(120): A player can allocate 120 points between a special attack and health"
  echo "  Example. A player with 100 health will have a special attack that does 20 bonus damage"
  echo "     "
  echo "Rules:"
  echo "Attack will provide an additional attack doing more damage, but you will recieve more damage"
  echo "Defend will not attack for as much, but you will recieve less damage"
  echo "Special will unleash a special move to add a bonus attack(you can only use twice)"
  echo "*******************************"
  anyKeyProceeds
  
}
function anyKeyProceeds(){
  read -n1 -r -p "Press any key to continue..."
  MenuOptions
}

function NewPlayer(){
  clear
  read -r -p "What is your name?" playerName # Declare player name variable
  read -r -p "What is your Battlecry?" battlecry # Declare player name variable
  echo "Player points(120)"
  read -r -p "How many points do you want to allocate to health?" pHP
  special=$((120 - pHP)) # assign bonus damage for special
  echo "$playerName:$pHP:$special:$battlecry" >> Player.txt
  read -n1 -r -p "Load player press any key..."
  LoadPlayer
}

function LoadPlayer(){
if [[ ! -f Player.txt ]]; then #Check to see if player file already exists
    clear
    read -n1 -r -p "I don't see a player file on this computer..."
    NewPlayer
else
   playerName=`cat Player.txt | cut -f 1 -d ":" ` #read player name
   pHP=`cat Player.txt | cut -f 2 -d ":" ` #read player health
   special=`cat Player.txt | cut -f 3 -d ":" ` #read player special
   battlecry=`cat Player.txt | cut -f 4 -d ":" ` #read player battlecry
   Play
 fi
}

function Play(){ # Play Bash Battle function 
      playerPoints=$((pHP + special)) # validate numbers for player points
      if [[ $playerPoints -ne 120 ]]; then
        read -n1 -r -p "Player points do not equal 120"
        rm Player.txt
        NewPlayer    
      fi
      if [[ $special -lt 0 ]]; then
        read -n1 -r -p "Special points are less than 0"
        rm Player.txt
        NewPlayer 
      fi
      if [[ $pHP -lt 0 ]]; then
        read -n1 -r -p "Player hitpoints are less than 0"
        rm Player.txt
        NewPlayer 
      fi 
  level=1 # Declare Player's starting level
  specialCount=2 # Declare special usage
  levelSelect
}

function levelSelect(){
  clear
  case $level in # case for different enemies
          1)levelDemonKnight;;
          2)levelPsychoMantis;;
          3)levelBashman;;
          *)EndGame;;

  esac

  MainGame
}

function MainGame(){ 
declare -a myDistractions=( "You look confused and disoriented" "You check your syntax and see a problem" "That wasn't a command!" "$playerName stares blankly" "Protip: Look at the keyboard before you type") #Result of mistyped commands   
  while [ $enemyHP -gt 1 ]; do   #Main game loop, as long as the enemies health is greater than 1
     
      echo "(a)ttack/(s)pecial/(d)efend)?"
      echo "$enemy HP: $enemyHP, $playerName's HP: $pHP"
          read -r response
          attack=$(( ( RANDOM % 10 ) + 1 )) # assign a random number between 1 and 10 to attack
          damage=$(( ( RANDOM % 10 ) + 1 )) # assign a random number between 1 and 10 to damage

      function attacks(){
      clear
      pHP=$((pHP-damage))
      echo "$enemy: ${enemyTaunt[0]}"
      attack=$((attack * 2)) # attack multiplier when attack is chosen
      enemyHP=$((enemyHP-attack)) # subtract attack damage from enemy health
      echo "You attack for $attack, defend for 0" # display result
      }


      function defends(){
      clear
      damage=$((damage / 2))
      echo "$enemy: ${enemyTaunt[1]}" # enemy will taunt
      pHP=$((pHP-damage))
      enemyHP=$((enemyHP-attack))
      echo "You attack for $attack, defend for $((damage / 2))"
      }

      function special(){
        clear
        if [[ $specialCount -gt 0 ]]; then # check level of special
          echo "You yell '$battlecry'"
          attack=$((attack * 2 + special))
          enemyHP=$((enemyHP-attack))
          specialCount=$((specialCount - 1))
        else
          echo "$playerName is too tired..."
        fi
          
      }

      function doNothing(){
        clear
        nothing=$(( ( RANDOM % 5 )  + 1 )) # Random number between 1 and 5
        pHP=$((pHP-damage))
        echo ${myDistractions[$nothing]} # Select number from array of distractions
      }

      case $response in # Select function based on player's response
          a)attacks;;
          d)defends;;
          s)special;;
          *)doNothing;;
      esac
      
      if [[ $enemyHP -lt 1 ]] # When enemy hp is less than 1 move to next enemy with levelSelect
          then
          echo "$enemy: $enemyDeath"
          echo "Congrats you killed the $enemy!!!"
          read -n1 -r -p "Press any key to move to the next level..."
          levelSelect
      fi

      if [[ $pHP -lt 1 ]] # condition for when the player health is less than 1
          then    
          echo "Oh noes... you dead"
          exit
      fi


  done

}

function EndGame(){
  echo "Congrats $playerName, you beat the game!... what a lame ending huh?"
  anyKeyProceeds
  exit
}

function MenuOptions(){ #Main menu options
  clear
cat <<-ENDOFMESSAGE

 __            __            
|__) _  _|_   |__) _ |_|_| _ 
|__)(_|_)| )  |__)(_||_|_|(-                                                                                                                                                        
ENDOFMESSAGE
  echo "1 - New Game"
  echo "2 - Rules"
  echo "3 - About"
  echo "4 - Exit"

read -r chooseOption

  case $chooseOption in
        1)LoadPlayer;;
        2)Rules;;
        3)About;;
        4)exit;;
        *)echo "You did not choose an option(1,2,3)"; anyKeyProceeds;;
  esac
}


MenuOptions #Main menu
