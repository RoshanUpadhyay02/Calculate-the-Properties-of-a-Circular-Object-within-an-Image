% O - OBJEKTE ZÄHLEN
% MATLAB MINI-PROJECT 
%**************************************************************

% Clearing workspace and console
clear
clc
close all

% input image
prompt = {'Enter the url of the image or name of the image with its extension(.png/jpeg)'};
dlgtitle = 'ImagePath';
answer = inputdlg(prompt,dlgtitle);
ImagePath = char(answer);
warning off
Img = imread(ImagePath);
fprintf("\n")
clc;

% circle detection
pause(1)
opts.Interpreter = 'tex';
opts.Default = "YES";
ask = 'Do you want to enter your own range of radius ?';
answer = questdlg(ask,'Radius range', 'YES', 'NO',opts);
clc;
if(answer == "YES")
% dialog box
prompt = {'Enter min range (integer):','Enter max range (integer):'};
dlgtitle = 'Input Radius range';
dims = [1 35; 1 35];
an = inputdlg(prompt,dlgtitle,dims);
z = isnumeric(an);
if (z == 1)
[Lrange, Urange] = an{:};
Lrange = str2double(Lrange);
Urange = str2double(Urange);

% detection using imfindcircles
[cB,Radius] = imfindcircles(Img,[Lrange Urange],'ObjectPolarity','bright','Sensitivity',0.9);
[cD,radius] = imfindcircles(Img,[Lrange Urange],'ObjectPolarity','dark');
clc;
else
[cB,Radius] = imfindcircles(Img,[20 500],'ObjectPolarity','bright','Sensitivity',0.9);
[cD,radius] = imfindcircles(Img,[20 500],'ObjectPolarity','dark');
end



else
[cB,Radius] = imfindcircles(Img,[20 500],'ObjectPolarity','bright','Sensitivity',0.9);
[cD,radius] = imfindcircles(Img,[20 500],'ObjectPolarity','dark');
end

% displaying image and marking circles
figure ("Name",'Image');
imshow(Img);
hold on;
viscircles(cB, Radius,'Color','b');
hold on;
viscircles(cD, radius,'Color','r');
hold off;

% measurements
x = length(Radius);
y = length(radius);

total = x + y;
fprintf('The total number of circles in the image are: %d\n\n',total);
fprintf('*************************************************\n')

% for bright circles
if (x>0)
for i = 1:x
Diameter = 2.*Radius;
Area = (4*pi).*(Radius).^2;
Circumference = (2*pi).*Radius;
end
else
Diameter = 0.*Radius;
Area = 0.*Radius;
Circumference = 0.*Radius;
end
% for dark circles
if (y>0)
for j = 1:y
diameter = 2.*radius;
area = (4*pi).*(radius).^2;
circumference = (2*pi).*radius;
end
else
diameter = 0.*radius;
area = 0.*radius;
circumference = 0.*radius;
end




% tables
Circle_no = (1:x)';
circle_no = (1:y)';
% table 1
BT = table(Circle_no, Radius, Diameter, Area, Circumference);
fprintf("Bright circles: \n\n");
disp(BT)
fprintf('\n*************************************************\n')
% table 2
DT = table(circle_no, radius, diameter, area, circumference);
fprintf("Dark circles: \n\n");
disp(DT)

% graphical analysis
% dialog box
pause(7)
opts.Interpreter = 'tex';
opts.Default = "YES";
Answer = questdlg('Do you want to view the Graphical analysis ?','Graphical analysis', 'YES', 'NO',opts);
if(Answer == "YES")
    figure ('Name', 'Graphical analysis');
    tiledlayout(2,2, 'TileSpacing', 'none')
    % Tile 1
    nexttile
    plot(1:1:x, Radius,'r.-', 1:1:y, radius,'b.-')
    ylabel('R \rightarrow');
    title('Radius');
    % Tile 2
    nexttile
    plot(1:1:x, Diameter, 'r.-', 1:1:y, diameter, 'b.-')
    ylabel('D \rightarrow');
    title('Diameter');
    % Tile 3
    nexttile
    plot(1:1:x, Area,'r.-', 1:1:y, area,'b.-')
    ylabel('A \rightarrow');
    title('Area');
    % Tile 4
    nexttile
    plot(1:1:x, Circumference,'r.-', 1:1:y, circumference,'b.-')
    ylabel('P \rightarrow');
    title('Circumference');
    legend(nexttile(2),'bright circles', 'dark circles', 'Location', 'northoutside');
end
%*********************************************************************************

% test image links
%1.https://www.herocycles.com/admin/public/uploads/bestseller/5f045807aecefdRluFu0mPF.jpeg
% 2. coloredChips.png
% 3. https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqj2XSQWNVk8dVvTqua2F3abR4CZijLhFgjQ&usqp=CAU
