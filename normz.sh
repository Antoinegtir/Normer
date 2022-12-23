##############################################################################################################
#!/bin/bash

###########################
## Check Argument needed ##
###########################

if [ -z "$1" ]; then
    echo "Error : please add in argument a path of .c file that you want to modify"
    exit 1
fi

if tail -c 1 "$1" | grep -q '}'; then
    # Add \n at end of c file
    echo >> "$1"
fi

################################################
## Add Header Epitech & retrieve Project name ##
################################################

project_name=$(echo "$1" | sed 's/\(.*\)\.c/\1/')

if ! grep -q "EPITECH" $1; then
sed -i "1i/*\n** EPITECH PROJECT, 2022\n** $project_name\n** File description:\n** file $project_name that..\n*/\n" "$1"
fi

##########################
## Coding style actions ##
##########################

sed -E "s|///[^\n]*\n||g" "$1" > tmp.c

mv tmp.c "$1"

sed -i 's/[ \t]*$//' "$1"
sed -i '/for[^\n]*$/{N;s/for\(.*\)\n\s*{/for\1 {/}' "$1"
sed -i '/if[^\n]*$/{N;s/if\(.*\)\n\s*{/if\1 {/}' "$1"
sed -i '/else[^\n]*$/{N;s/else\(.*\)\n\s*{/else\1 {/}' "$1"
sed -i '/elseif[^\n]*$/{N;s/elseif\(.*\)\n\s*{/else if\1 {/}' "$1"
sed -i '/while[^\n]*$/{N;s/while\(.*\)\n\s*{/while\1 {/}' "$1"
sed -i '/do[^\n]*$/{N;s/do\(.*\)\n\s*{/do\1 {/}' "$1"
sed -i '/switch[^\n]*$/{N;s/switch\(.*\)\n\s*{/switch\1 {/}' "$1"


sed -E "s/([a-zA-Z_][a-zA-Z0-9_]* *\() *\)/\1void\)/g" "$1" > tmp.c

mv tmp.c "$1"

sed "/^[ \t]*\/\//d" "$1" > tmp.c

sed -E '/^[ \t]*[a-zA-Z_]+[ \t]*\(/{:a;N;/[^*]\n/!ba;s/\/\*.*\*\// /g};' "$1" > tmp.c
mv tmp.c "$1"

sed -E '/^[ \t]*[a-zA-Z_]+[ \t]*\(/{:a;N;/[^*]\n/!ba;s/([ \t]*if[ \t]*\([^()]*\)[ \t]*\{)[ \t]*\n[ \t]*([^}]*)([ \t]*\}[ \t]*else[ \t]*\{)[ \t]*\n[ \t]*([^}]*)([ \t]*\})/\1\2\3\4\5/g};' "$1" > tmp.c
mv tmp.c "$1"

########################
## Add indent Package ##
########################

if ! command -v indent > /dev/null; then
    sudo dnf install indent
    indent "$1" -kr -i4

    rm *.c~
    echo -e "\e[1;33m
    Norm Successfully installed
    \e[0m" 
fi

indent "$1" -kr -i4


###################
## Custom Loader ##
###################

steps=20
for ((i=1; i<=steps; i++)); do
    printf "\e[1;33m#"
    printf "\rLoad : [%-${steps}s] %d%%" "$(printf '#%.0s' {1..20})" "$((i*100/steps))"
 
  sleep 0.02
done

##############################################################################################################
## Delete rm *.c~ if you want to keep some Back Up of you're previous code before the modification of normz ##
##############################################################################################################

rm *.c~

###########
## Normz ##
###########

if command -v indent > /dev/null; then
echo -e "\e[1;33m
 __    __                                             
/  \  /  |                                            
##  \ ## |    ______     ______    _____  ____   ________ 
###  \## |  /       \   /      \  /     \/    \ /        |
####  ## |  /######  | /###### |  ###### ####  | ########/ 
## ## ## |  ## |  ## | ## |  ##/  ## | ## | ## |   /  ##/  
## |#### |  ## \__## | ## |       ## | ## | ## |  /####/__ 
## | ### |  ##    ##/  ## |       ## | ## | ## | /##      |
##/   ##/    ######/   ##/        ## / ##/  ## / ########/

By Antoine Gonthier"
fi
  
################################################################################################################
