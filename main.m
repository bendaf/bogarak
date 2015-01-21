clear all;

numberOfBugs = 2;

mapSize = 40;
time = 10;
bugMap = Map(numberOfBugs,mapSize,time);

grid on;
for i=1:time
    bugMap.plot;
    bugMap.step;
    %pause(3) 
end

figure;
plot(1:time,bugMap.bugsInTime);
xlabel('Time'), ylabel('Foodspare'),title('Foodspare of bugs in time');

figure; 
plot(1:time,sum(bugMap.bugsInTime(1:time,:)'>0));
xlabel('Time'), ylabel('Population'),title('Population in time');
axis([1 time 0 numberOfBugs]);