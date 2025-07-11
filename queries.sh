#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo $($PSQL "SELECT SUM(winner_goals) FROM games")
echo $($PSQL "SELECT AVG(winner_goals) FROM games")
echo $($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")
echo $($PSQL "SELECT ROUND(AVG(winner_goals + opponent_goals), 16) FROM games")
echo $($PSQL "SELECT MAX(winner_goals) FROM games")
echo $($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")
echo $($PSQL "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games WHERE round='Final' AND year=2018)")
echo $($PSQL "SELECT winner FROM games WHERE round='Final' ORDER BY year")
echo $($PSQL "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year=2014 AND round='Eighth-Final' ORDER BY name")
echo $($PSQL "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games GROUP BY winner_id HAVING COUNT(*) > 1) ORDER BY name")
echo $($PSQL "SELECT round, COUNT(*) FROM games GROUP BY round ORDER BY COUNT(*) DESC LIMIT 1")
echo $($PSQL "SELECT year, round, name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE round='Final' ORDER BY year")
echo $($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")