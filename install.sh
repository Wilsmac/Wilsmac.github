#!/usr/bin/bash
i=0
incorrect=0
wordindex=0
correct=0
alpha=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
char=0
idioma=0
resp_idioma=0
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" #No color

#this function reads the list of words from the dict.dat file and
#put them into the word array
function readfile
{

exec 3<&0
while [[ $resp_idioma != 1 && $resp_idioma != 2 ]]
    do
        # Borra pantalla
        printf "\e[2J\e[H"
        echo -e '\033[0m\033[1;36m
         Vamos a jugar Al muertito :D (Ahorcado:v)
        \033[0m'
         echo -e '\033[0m\033[1;31m
         Si no quieres jugar solo presiona CTRL+c
         \033[0m'
        echo -ne "Elige un idioma: / Choose a language:
        Español (Es) / English (En) \n"
        echo -n "Es = 1 / En = 2: "
        read resp_idioma
        char=$resp_idioma
    done
if [ ${resp_idioma} -eq "1" ]
    then
        exec 0< dict_es.dat
    else
        exec 0< dict_en.dat
fi
while read LINE
do

word[i]=$LINE
i=`expr $i + 1`
done
exec 0<&3
}

#this function randomly selects a word from the word array.
function readword {
        word_index=$RANDOM

        while [ $word_index -ge $i ]
        do
                word_index=$RANDOM
        done
        a=0
        while [ $a -lt ${#word[${word_index}]} ]
        do
                word_img[$a]=0
                a=`expr $a + 1`
        done
}

#this function solicits a guess from the user and then checks
#the guess to see if it is valid/correct/incorrect.
function guess
{
        j=0
        correct=0

    if [ ${resp_idioma} -eq "1" ]
        then
            echo -n "Escoje una letra: "
        else
            echo -n "Guess a letter: "
    fi
        read guess
        char=$guess
        if [ ${#guess} -eq "1" ]
        then

                guess=`echo $guess | tr "[:upper:]" "[:lower:]"`
                while [ $j -lt ${#word[${word_index}]} ]
                do
                        if [ "$guess" == "${word[${word_index}]:$j:1}" ]
                        then
                                word_img[${j}]=1
                                correct=1
                        fi
                        j=`expr $j + 1`
                done
        fi
        r=0
        numletter=0
        while [ ! $r == ${#word[${word_index}]} ]
        do
                numletter=`expr $numletter + ${word_img[$r]}`
                r=`expr $r + 1`
        done
}

#the following functions draw the gallows and hanged man to the terminal
function gallows 
{
clear
printf "$GREEN"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_head 
{
clear
printf "$GREEN"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_body {
clear
printf "$GREEN"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "         |         |"
echo "         |         |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_arm1 {
clear
printf "$YELLOW"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "         |         |"
echo "      ---|         |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_arm2 {
clear
printf "$YELLOW"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_leg1 {
clear
printf "$RED"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "        /          |"
echo "       /           |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}
function gallows_leg2 {
clear
printf "$RED"
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        |_|        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "        / \        |"
echo "       /   \       |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
printf "$NC"
}

#this function prints the win screen
function win_es {
echo " ____  _              _ "
echo "| __ )(_) ___ _ __   | |"
echo "|  _ || |/ _ | '_  | | |"
echo "| |_) | || __/ | | | |_|"
echo "|____/|_||___|_| |_| (_)"
echo -en "\n\n\n"
}

#this function prints the win screen
function win_en {
echo "*     *  *******  *    *  * "
echo "*     *     *     **   *  * "
echo "*     *     *     * *  *  * "
echo "*     *     *     *  * *  * "
echo " * * *      *     *   **    "
echo "  * *    *******  *    *  * "
echo -en "\n\n\n"
}


#this function prints the lose screen
function lose_en {
echo "lose..."
echo "The word was: ${word[$word_index]}"
}

#this function prints the lose screen
function lose_es {
echo "Perdiste..."
echo "La palabra era: ${word[$word_index]}"
}

#this function prints the guessed letters to the screen and
#underscores for letters that haven't been guessed
function print_alpha {
    if [ ${resp_idioma} -eq "1" ]
        then
            echo -e "\nLetras ya dichas:"
        else
            echo -e "\nLetters Guessed:"
    fi
        e=0
        while [ ! "$e" == "26" ]
        do
                if [ "$char" == "${alpha[$e]}" ]
                then
                        alpha_img[$e]="1"
                fi

                if [ ${alpha_img[$e]} == "1" ] 
                then
                        echo -n ${alpha[$e]}
                else
                        echo -n "-"
                fi

                if [ $e == "12" ]
                then
                        echo -e "\n"
                fi
                e=`expr $e + 1`
        done
        echo -ne "\n\n"
        char=""
}

#a function to print the correctly guessed letters of the word to the
#screen or else an underscore for letters no yet guessed
function print_word {
    if [ ${resp_idioma} -eq "1" ]
        then
            echo -ne "\nPalabra: "
        else
            echo -ne "\nWord: "
    fi
        t=0
        while [ ! $t == ${#word[${word_index}]} ]
        do
                        if [ ${word_img[${t}]} == "1" ]
                        then
                                echo -n "${word[${word_index}]:$t:1}"
                        else
                                echo -n "-"
                        fi
                        t=`expr $t + 1`
        done
        echo -e "\n\n"
}


#####################################
# beginning of the main program here!
#####################################

readfile;
gameover=0
incorrect=0
correct=0
while [ "$gameover" == "0" ]
do

        a=0
        while [ ! "$a" == "26" ]
        do
                alpha_img[$a]=0
                a=`expr $a + 1`
        done

        word_img=0
        alpha_img=0        
        incorrect=0
        correct=0
        readword;
        a=0
        gallows;
        print_alpha;
        print_word;

        #check for winning/losing conditions and update status of hanged man
        while [[ ! "${numletter}" == "${#word[${word_index}]}" && ! "$incorrect" == "6" ]]
        do
                guess;

                if [ $correct == "0" ]
                then 
                        incorrect=`expr $incorrect + 1`
                fi        

                if [ $incorrect == "0" ]
                then
                        gallows;
                elif [ $incorrect == "1" ]
                then
                        gallows_head;
                elif [ $incorrect == "2" ]
                then
                        gallows_body;
                elif [ $incorrect == "3" ]
                then
                        gallows_arm1;
                elif [ $incorrect == "4" ]
                then
                        gallows_arm2;
                elif [ $incorrect == "5" ]
                then
                        gallows_leg1;
                elif [ $incorrect == "6" ]
                then
                        gallows_leg2;
                fi
                print_alpha;
                print_word;

        done

        if [ "${numletter}" == "${#word[${word_index}]}" ]
        then
        #clear
    if [ ${resp_idioma} -eq "1" ]
        then
            win_es;
        else
            win_en;
    fi
        gameover=1
        fi
        if [ $incorrect == "6" ]
        then

    if [ ${resp_idioma} -eq "1" ]
        then
            lose_es;
        else
            lose_en;
    fi
        gameover=1
        fi

        if [ "$gameover" == "1" ] 
        then
    if [ ${resp_idioma} -eq "1" ]
        then
            echo -e "\n\n ¿Jugar de nuevo? (s/n)"
        else
            echo -e "\n\n Play again? (y/n)"
        fi
                read answer
                if [ $answer == 'y' ] || [ $answer == 's' ]
                then
                        gameover=0
                fi
                clear
        fi
done
exit 0