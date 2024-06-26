#!/bin/bash

while true; do
  echo " "
  echo " "
  echo "############################"
  echo " "
  echo "      THE BODACH SHOW"
  echo "        SHELL TOOLS"
  echo " "
  echo "############################"
  echo " "
  branchName=$(git rev-parse --abbrev-ref HEAD)
  echo "Current Branch: $branchName"
  echo " "
  echo "Select an option:"
  echo " "
  echo "1. Cancel/Close"
  echo "2. Start/Reboot docker container in development mode"
  echo "3. Start/Reboot docker container in staging mode"
  echo "4. Start/Reboot docker container in production mode" 
  echo "5. Git pull changes"
  echo "6. Git push changes to current branch"
  echo "7. Shut down container" 
  read -p "Enter option (1 to 7): " option

  case $option in
  1)
    echo " "
    echo "Operation cancelled. Bye Ó_ó"
    echo " "
    break
    ;;
  2)
    echo " "
    echo "Launch docker container into development environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.dev down 
      docker-compose --env-file .env.dev up -d --build 
    fi
    ;;
  3)
    echo " "
    echo "Launch docker container into staging environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.stage down 
      docker-compose --env-file .env.stage up -d --build 
    fi
    ;;
  4)
    echo " "
    echo "Launch docker container into production environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.prod down
      docker-compose --env-file .env.prod up -d --build
    fi
    ;;
  5)
    echo " "
    branchName=$(git rev-parse --abbrev-ref HEAD)
    echo "Current Branch: $branchName"
    echo " "
    echo "Pull all changes for this branch?"
    echo " "
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      git reset --hard
      git pull --all
    fi
    ;;
  6)
    echo " "
    echo "Push changes to git?"
    branchName=$(git rev-parse --abbrev-ref HEAD)
    echo "Current Branch: $branchName"
    read -p "Confirm [y/n]: " confirmation

    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      echo "Select an option for your commit message:"
      echo "1. Use default message ('Primary Dev Update')"
      echo "2. Enter a custom message"
      read -p "Enter option (1 or 2): " msgOption

      if [ "$msgOption" = "1" ]; then
        commitMessage="Primary Dev Update"
      elif [ "$msgOption" = "2" ]; then
        read -p "Enter your custom commit message: " customMessage
        commitMessage="$customMessage"
      else
        echo "Invalid option selected. Exiting."
        break
      fi

      git add --all
      git commit -m "$commitMessage"
      git push --all
    fi
    ;;
  7)
    echo " "
    echo "Shut down container?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.dev down
    fi
    ;;
  *)
    echo "Invalid option selected. Exiting."
    ;;
  esac
done
