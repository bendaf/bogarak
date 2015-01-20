insects = Insect;

% for i = 1:10
%     insects = [insects Insect];
% end

numberOfBugs = 10;
bugMap = Map(10);   % creates a map with 10 bugs

grid on;
hold on;
while true
    
    clf;
    hold on;
    bugMap.plot;
%     arrayfun(@step,insects);
%     arrayfun(@plot,insects);
    axis([ 0 100 0 100]);
    drawnow;
end