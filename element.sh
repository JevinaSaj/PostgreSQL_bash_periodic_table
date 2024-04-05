#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
SYMBOL=$1
# If no value is passed on 
if [[ -z $SYMBOL ]]
then
  echo "Please provide an element as an argument."
else
  # check if value is not a number
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    # if value is not a number then check if its not a symbol
    if [[ $(expr length "$SYMBOL") > 2 ]]
    then 
      # check if the value is a name in the table
      NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$SYMBOL'")
      # if no display data not present in the table
      if [[ -z $NAME ]]
      then
        echo "I could not find that element in the database."
      else
        # else dislpay the content
        DATA_SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$NAME'")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$NAME'")
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($DATA_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      fi
    else
      # if the value is a symbol
      DATA_SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$SYMBOL'")
      if [[ -z $DATA_SYMBOL ]]
      then 
        echo "I could not find that element in the database."
        
      else
      #display the symbol
        NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$DATA_SYMBOL'")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$DATA_SYMBOL'")
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($DATA_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      fi
    fi
  else
    #if value is an atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number='$SYMBOL'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
      
    else
      #display the content
      NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number='$ATOMIC_NUMBER'")
      DATA_SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number='$ATOMIC_NUMBER'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($DATA_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
      
  fi
fi
#end
