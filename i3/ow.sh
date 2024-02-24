#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

descr=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg,RU&appid=b01b2b6c5951801d2203e19a247aaafc&units=metric" | jq '.weather[0].description')
temp=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg,RU&appid=b01b2b6c5951801d2203e19a247aaafc&units=metric" | jq '.main.temp')
feels=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg,RU&appid=b01b2b6c5951801d2203e19a247aaafc&units=metric" | jq '.main.feels_like')
# echo -e "${RED}🌡  ${YELLOW}$descr${NC}, ${temp:0:4}℃ /${feels:0:4}℃"
echo -e "🌡 ${descr:1:-1} ${temp:0:4}℃ (${feels:0:4}℃)"
