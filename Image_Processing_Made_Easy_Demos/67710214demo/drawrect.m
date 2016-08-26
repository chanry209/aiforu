function h = drawrect(rect)
for i = 1:length(rect)
    rectangle('Position',[rect(i).x, rect(i).y, rect(i).x1 - rect(i).x, rect(i).y1 - rect(i).y],'EdgeColor',[0 1 0]);
end