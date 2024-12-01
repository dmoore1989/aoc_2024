
AOC_COOKIE=`cat .aoc_cookie`
DAY=${1:-$(date '+%e')}
DAY=${DAY/ /} 
if [[ -f "day_${DAY}.txt" ]]; then
    echo "Day already exists!"
    exit 1
fi
echo $DAY
data=$(curl -A 'douglas.moore89@gmail.com' https://adventofcode.com/2024/day/${DAY}/input --cookie "session=${AOC_COOKIE}");
if [ "$data" == "Puzzle inputs differ by user.  Please log in to get your puzzle input." ]; then
    echo "Incorrect cookie!"
    exit 1
fi
if [ "$data" == "Please don't repeatedly request this endpoint before it unlocks! The calendar countdown is synchronized with the server time; the link will be enabled on the calendar the instant this puzzle becomes available." ]; then
    echo "Not time yet!"
    exit 1
fi
touch day_"${DAY}".txt
echo "$data" > day_"${DAY}".txt
touch day_"${DAY}"_1.rb
cat template.txt > day_"${DAY}"_1.rb
sed -i '' "s/FOO/$DAY/g" day_"${DAY}"_1.rb
touch day_"${DAY}"_2.rb
sed -i '' "s/FOO/$DAY/g" day_"${DAY}"_2.rb
open -a /Applications/Google\ Chrome.app https://www.adventofcode.com/2024/day/${DAY}
