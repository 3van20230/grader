export CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
mkdir grading-area

if [ ! -f "gradeserver.java" ]; then
    echo "Error"
    exit 1
fi

git clone "$1" student-submission
echo 'Finished cloning'

cd student-submission || exit

javac -cp "$CPATH" gradeserver.java ListExamples.java TestListExamples.java -d ../grading-area

if [ $? -ne 0 ]; then
    echo "failed"
    exit 1
fi

cd ../grading-area || exit

java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples

if [ $? -eq 0 ]; then
    echo " passed "
else
    echo " failed "
fi
