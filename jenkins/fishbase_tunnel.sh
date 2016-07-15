# backend-tunnel <your cmd line, possibly 'bash'>
#
# note you need to supply the fishbase_key.pem key file to the same directory as this script.
#
ssh -f -N -i ./fishbase_key.pem -L 33060:fishbase.ca2pwsiomsi6.us-west-2.rds.amazonaws.com:3306 ubuntu@ec2-52-32-33-191.us-west-2.compute.amazonaws.com
pid=$(ps aux | grep " ssh" | grep 33060 | awk '{print $2;}')
echo "waiting a few seconds to establish tunnel..."
sleep 5
"$@"
echo "killing ssh tunnel $pid"
kill $pid
