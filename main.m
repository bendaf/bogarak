clear all;

numberOfBugs = 10;
bugMap = Map(1,60);   % creates a map with 10 bugs

grid on;
hold on;
while true
    bugMap.plot;
    bugMap.step;
    pause(0.5) 
end