#!/bin/bash


file="$1"
COUNT="${2:-5}"
sep() { echo -e "\n===============================\n"; }
if [[ -z "$file" ]]; then
  echo "Użycie: $0 <plik_logu>"
  exit 1
fi 
sep
echo "Top ${COUNT} IP addresses with the most requests:" 
awk '{ print $1 }' "$file" | sort | uniq -c | sort -rn | head -n ${COUNT} \
  | awk '{ print $2 " - " $1 " requests" }'
sep
echo "Top ${COUNT} most requested paths:"
awk '{ print $7 }' "$file" | sort | uniq -c | sort -rn | head -n ${COUNT} \
  | awk '{ print $2 " - " $1 " requests" }'
sep
echo "Top ${COUNT} response status codes:"
awk '{ print $9 }' "$file" | sort | uniq -c | sort -rn | head -n ${COUNT} \
  | awk '{ print $2 " - " $1 " requests" }'
sep
echo "Top ${COUNT} user agents:"
awk -F'"' '{ print $6 }' "$file" | sort | uniq -c | sort -rn | head -n ${COUNT} \
  | awk '{ count=$1; $1=""; print substr($0,2) " - " count " requests" }'
