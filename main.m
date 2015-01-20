insects = Insect;

for i = 1:10
    insects = [insects Insect];
end

grid on;
hold on;
while true
    clf;
    hold on;
    arrayfun(@step,insects);
    arrayfun(@plot,insects);
    axis([ 0 100 0 100]);
    drawnow;
end