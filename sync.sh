if [ $# -ne 2 ]; then
    echo "USAGE: ./push <host> <message>"
    exit 1
fi;

HOST=$1
MESSAGE=$2
DATE=`date`
PAYLOAD="__Site updated:__ $DATE\nSee the newest version [here](http://demo.championshiptrophyfit.com)\n__Note:__ _${MESSAGE}_"
ROOM="https://api.kato.im/rooms/7c965853afdd7b72d40e139b5ba399e24d8b4a01c24f057ac12262276c6b3728/simple"

rsync -vzrp dist/static/ chili:/var/www/demo.championshiptrophyfit.com/app/static/

curl -v -X POST --header "Content-Type:application/json" -d "{\"from\": \"enlore-pusher-bot\", \"color\": \"green\", \"renderer\": \"markdown\", \"text\": \"$PAYLOAD\" }" $ROOM
