#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Limpiar las tablas antes de insertar
$($PSQL "TRUNCATE games, teams")

# Leer y procesar el CSV
tail -n +2 games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  for TEAM in "$WINNER" "$OPPONENT"
  do
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")
    if [[ -z $TEAM_ID ]]; then
      $($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
    fi
  done

  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
           VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
done