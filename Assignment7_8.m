%%
% Author: Andrew Petersen
% Assignment: 7_(8)
% Object detection with SURF
%%

clc; clear; clear all;
I1 = imread('base.jpg');
I2 = imread('sub.jpg');
Ipts1 = OpenSurf(I1);
Ipts2 = OpenSurf(I2);

for k = 1:length(Ipts1)
    D1(:,k) = Ipts1(k).descriptor;
end

for k = 1:length(Ipts2)
    D2(:,k) = Ipts2(k).descriptor;
end

BaseLength = length(Ipts1);
SubLength = length(Ipts2);

for i=1:BaseLength
    subtract = (repmat(D1(:,i), [1 SubLength]) - D2).^2;
    distance = sum(subtract);
    [SubValue(i) SubIndex(i)] = min(distance);
end

[value, index] = sort(SubValue);
index = index(1:10);
BaseIndex = index;
SubIndex = SubIndex(index);

Pos1 = [[Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]'];
Pos2 = [[Ipts2(SubIndex).y]', [Ipts2(SubIndex).x]'];
I = cat(2,I1,I2);
figure, imshow(I);
hold on;
plot([Pos1(:,2) Pos2(:,2)+size(I1,2)]', [Pos1(:,1) Pos2(:,1)]', 's-', 'linewidth',2);

Pos1 = [ [Ipts1(BaseIndex).y]',[Ipts1(BaseIndex).x]'];
Pos2 = [[Ipts2(SubIndex).y]',[Ipts2(SubIndex).x]'+size(I1,2)];

% figure (1)
% imshow(I1)
% hold on
% plot(Pos1(2,1),Pos1(2,2),'ro')
% hold off

% figure (2)
% imshow(I2)
% hold on
% plot(Pos2(2,1),Pos2(2,2),'ro')

diffX = Pos2(:,2) - Pos1(:,2);
diffY = Pos2(:,1) - Pos1(:,1);

angles = atan2d(diffY, diffX);
angles = round(angles);
angle = mode(angles);

indexMode = find(angles > angle-5 & angles < angle+5);
Ipts1.x
Ipts1.y