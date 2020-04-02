clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

if ispc
    seperator = '\';
    datadir = 'F:\GD\vessels';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdataIVASO/3Mivaso';
elseif isunix
else
end

load ValidFolders.mat

Vessel = '10X_CH2.tif';
VesselNum = size(VesselFolders, 1);
ValidFoldersNum = 1;

rx = 0.265 * 5;  % pixel width 

C = cell(1, 3);
C(1, 1) = {'string'};
C(1, 2) = {'double'}; % mean diameter
C(1, 3) = {'double'}; % less than 8
C(1, 4) = {'double'}; % greater than 8
C(1, 5) = {'double'}; % area ratio
Results = table('Size', [size(VesselFolders, 2) 5], 'VariableTypes', C, ...
    'VariableNames', { 'name', 'mean_diameter', 'small', 'big', 'area_ratio'});

% for k = 1:VesselNum
%     ax(k) = subplot(4, 3, k);
% end

for i = 1:1:VesselNum
    SourceImg = imread([datadir seperator VesselFolders(i).name seperator Vessel]);
    I = rgb2gray(SourceImg(:, :, 1:3));
    binaryImage = imbinarize(I);

    % 1. Display the Original image.
    subplot(2, 2, 1);
    imshow(SourceImg(:, :, 1:3), []);
    title('Original Vessel Image', 'FontSize', fontSize, 'Interpreter', 'None');

    set(gcf, 'Name', ['Vessel Diameter ' VesselFolders(i).name], 'NumberTitle', 'Off') 
    drawnow;

    % 2. Display Binary Image
    subplot(2, 2, 2);
    imshow(binaryImage);
    title('Binary Image', 'FontSize', fontSize, 'Interpreter', 'None');
    % Get the Euclidean Distance Transform.
    binaryImage(1,:) = false;
    binaryImage(end,:) = false;
    edtImage = bwdist(~binaryImage);

    % 3. Display Distance Image
    subplot(2, 2, 3);
    imshow(edtImage);
    title('Distance Image', 'FontSize', fontSize, 'Interpreter', 'None')

    skelImage = bwmorph(binaryImage, 'skel', inf);

    % 4. Display Skelon of the Binary Image
    subplot(2, 2, 4);
    imshow(skelImage);
    title('Skelon Image', 'FontSize', fontSize, 'Interpreter', 'None');
    % skelImage = bwmorph(skelImage, 'spur', 2);
    % There should be just one now.  Let's check
    [labeledImage, numLines] = bwlabel(skelImage);


%     calculate the diameter
    AllDiameter = 2 * edtImage(skelImage);

    UniqDiameter = unique(AllDiameter);
    QDiameter = histc(AllDiameter, UniqDiameter); % count the array numbers
    QDiameter = QDiameter * rx; % by the length of each pixel
    UniqDiameter = UniqDiameter * rx;

    figure;
%     subplot(ax(i))
    plot(UniqDiameter, QDiameter, '-o', 'MarkerIndices', 1:1:length(QDiameter));
    title('Vessel Diameter Distribution', 'FontSize', fontSize, 'Interpreter', 'None');
    % Measure the radius be looking along the skeleton of the distance transform.
    meanDiameter = mean(AllDiameter) * rx;
    [rows, cols] = size(binaryImage);
    [row, col] = size(find(binaryImage > 0));
    message = sprintf('Diameter(um), Mean Diameter = %.1f(mm)\nVessel Area = %.2f', meanDiameter, row ./(rows .* cols));
    % uiwait(helpdlg(message));
    xlabel(message, 'FontSize', 18);
    ylabel('Length(um)', 'FontSize', 18);
    xlim([1 10]);
    % xticks([1 6 11 16]);
    ax = gca; % current axes
    ax.FontSize = 16;

    saveas(gcf, [datadir seperator VesselFolders(i).name seperator 'fre_' Vessel]);
    figure;
    RxAllDiameter = AllDiameter * rx;
    histfit(RxAllDiameter, 12, 'HalfNormal');
    title(VesselFolders(i).name, 'FontSize', fontSize, 'Interpreter', 'None');
    message = sprintf('Diameter(mm), Mean Diameter = %.1f(um)\nVessel Area = %.2f', meanDiameter, row ./(rows .* cols));
    % uiwait(helpdlg(message));
    xlabel(message, 'FontSize', 18);
    saveas(gcf, [datadir seperator VesselFolders(i).name seperator 'his_' Vessel]);

    Results(i, 1:5) = { VesselFolders(i).name meanDiameter size((RxAllDiameter(RxAllDiameter < 8)), 1) ...
        size((RxAllDiameter(RxAllDiameter >= 8)), 1)  row./(rows .* cols)};
end

writetable(Results, [datadir seperator 'results.xlsx'], 'Sheet', 'Results');
    

