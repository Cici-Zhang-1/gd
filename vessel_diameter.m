clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

if ispc
    seperator = '\';
elseif ismac
    seperator = '/';
elseif isunix
else
end
datadir = 'F:\GD\vessels';
vessels = 'Picture1.tif';

rx = 0.1693;  % pixel width
% Read in mat file.
% storedStructure = load('binaryimage.mat');
% binaryImage = storedStructure.BWfinal;
SourceImg = imread([datadir seperator vessels]);
I = rgb2gray(SourceImg(:, :, 1:3));
binaryImage = imbinarize(I);

% Display the Original image.
% subplot(1, 2, 1);
imshow(SourceImg(:, :, 1:3), []);
title('Original Vessel Image', 'FontSize', fontSize, 'Interpreter', 'None');
% Set up figure properties:
% Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Vessel Diameter', 'NumberTitle', 'Off') 
drawnow;

% Get the Euclidean Distance Transform.
binaryImage(1,:) = false;
binaryImage(end,:) = false;
edtImage = bwdist(~binaryImage);

skelImage = bwmorph(binaryImage, 'skel', inf);
% skelImage = bwmorph(skelImage, 'spur', 2);
% There should be just one now.  Let's check
[labeledImage, numLines] = bwlabel(skelImage);


AllDiameter = 2 * edtImage(skelImage);
AllDiameter = sort(AllDiameter);

UniqDiameter = unique(AllDiameter);
QDiameter = histc(AllDiameter, UniqDiameter) * rx;
UniqDiameter = UniqDiameter * rx;

figure;
plot(UniqDiameter, QDiameter, '-o', 'MarkerIndices', 1:1:length(QDiameter));
title('Vessel Diameter Distribution', 'FontSize', fontSize, 'Interpreter', 'None');
% Measure the radius be looking along the skeleton of the distance transform.
meanDiameter = mean(AllDiameter) * rx;
[rows, cols] = size(binaryImage);
[row, col] = size(find(binaryImage > 0));
message = sprintf('Diameter(mm), Mean Diameter = %.1f(mm)\nVessel Area = %.2f', meanDiameter, row ./(rows .* cols));
% uiwait(helpdlg(message));
xlabel(message, 'FontSize', 18);
ylabel('Length(mm)', 'FontSize', 18);
xlim([0.3 2]);
% xticks([1 6 11 16]);
ax = gca; % current axes
ax.FontSize = 16;

saveas(gcf, [datadir seperator 'fre_' vessels])
% 
% figure;
% scatter(UniqDiameter, QDiameter);
% 
% [p,~,mu] = polyfit(UniqDiameter, QDiameter, 5);
% 
% x1 = linspace(0.2, 2);
% y1 = polyval(p, x1,[],mu);
% 
% hold on
% plot(x1,y1)
% ylim([0 200]);
% hold off


% 
% figure;
% 
% imshow(edtImage, []);