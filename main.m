clear all;

numberOfBugs = 50;
mapSize = 40;
time = 5;
bugMap = Map(numberOfBugs,mapSize,time);   % creates a map with 10 bugs

grid on;
for i=1:time
    bugMap.plot;
    bugMap.step;
    %pause(3) 
end

figure;
plot(1:time,bugMap.bugsInTime);

figure; 
plot(1:time,sum(bugMap.bugsInTime(1:time,:)'>0));