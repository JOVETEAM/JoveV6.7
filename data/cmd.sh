#!/bin/bash


memTotal_b=`free -b |grep Mem |awk '{print $2}'`
memFree_b=`free -b |grep Mem |awk '{print $4}'`
memBuffer_b=`free -b |grep Mem |awk '{print $6}'`
memCache_b=`free -b |grep Mem |awk '{print $7}'`

memTotal_m=`free -m |grep Mem |awk '{print $2}'`
memFree_m=`free -m |grep Mem |awk '{print $4}'`
memBuffer_m=`free -m |grep Mem |awk '{print $6}'`
memCache_m=`free -m |grep Mem |awk '{print $7}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
hdd=`df -lh | awk '{if ($6 == "/") { print $5 }}' | head -1 | cut -d'%' -f1`
uptime=`uptime`
ProcessCnt=`ps -A | wc -l`
memUsed_b=$(($memTotal_b-$memFree_b-$memBuffer_b-$memCache_b))
memUsed_m=$(($memTotal_m-$memFree_m-$memBuffer_m-$memCache_m))

memUsedPrc=$((($memUsed_b*100)/$memTotal_b))

echo "<i>✨1-رم: به صورت پیشفرض: $memTotal_m MB✨</i>"
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo "<i>✨2-مقدار استفاده شده از رم: $memUsed_m مگابایت - $memUsedPrc% استفاده شده!✨</i>"
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo "<i>✨3-مقدار کل : $memTotal_b ✨</i>"
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo '<i>✨4-مقدار استفاده شده از پردازنده : '"$CPUPer"'%✨</i>'
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo '<i>✨5-مقدار فضا : '"$hdd"'%✨</i>'
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo '<i>✨6-تعداد پردازش : '"$ProcessCnt"'✨</i>'
echo "🔹🔹🔹🔹🔹🔹🔹🔹🔹"
echo '<i>✨7-آپ تایم : '"$uptime"'✨</i>'
echo "<b>«Version 5.3 LolliPop»</b>"
echo "«@JoveTG»"
