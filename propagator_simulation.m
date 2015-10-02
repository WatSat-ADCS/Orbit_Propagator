%
% Propagator Simulation
%
% Copyright (c) 2015 WatSat-ADCS
% Licensed under the MIT license.
%
% authors: Jason Pye (j2pye@uwaterloo.ca)
%
% Change log:
% 2015-10-02 (JP) - Initial release
%


%% Next version: make functions for the python calls!

clear all
close all

% Initialise
system("python -c 'from clock import resetClock; resetClock()'");
system("python -c 'from satTLE import resetTLE; resetTLE()'");


% Time
% Gregorian calendar starts at: year=-4713, month=11, day=24, hour=12, minute=0, second=0

[status, result] = system("python -c 'from clock import greg2jdate; print greg2jdate(-4713,11,24,12 + 5,0,0)'"); % year, month, day, hour, minute, second
time_total = str2num(result);

[status, result] = system("python -c 'from clock import greg2jdate; print greg2jdate(-4713,11,24,12,0 + 5,0)'");
time_interval = str2num(result);

[status, result] = system("python -c 'from clock import readClock; print readClock()'");
time_var = str2num(result);


% Propagate

[status,result] = system("python -c 'from satTLE import currentOrbitState; (px,py,pz),(vx,vy,vz) = currentOrbitState(); print px; print py; print pz; print vx; print vy; print vz;'");
num_result = str2num(result);
position = num_result(1:3);
velocity = num_result(4:6);

timeIx = 1;
while ( time_var(timeIx) + time_interval < time_var(1) + time_total )

  system(["python -c 'from clock import tickClock; tickClock(",num2str(time_interval),")'"]);

  [status, result] = system("python -c 'from clock import readClock; print readClock()'");
  time_var = [time_var, str2num(result)];

  [status,result] = system("python -c 'from satTLE import currentOrbitState; (px,py,pz),(vx,vy,vz) = currentOrbitState(); print px; print py; print pz; print vx; print vy; print vz;'");
  num_result = str2num(result);
  position = [position, num_result(1:3)];
  velocity = [velocity, num_result(4:6)];

  timeIx = timeIx + 1;

end



% Plot

figure
hold on

subplot(3,2,1)
% plot(time_var, position(1,:), 'b-', 'Linewidth',2)
plot(position(1,:), 'b-', 'Linewidth',2)
ylabel('Position, x (km)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(3,2,3)
plot(position(2,:), 'b-', 'Linewidth',2)
ylabel('Position, y (km)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(3,2,5)
plot(position(3,:), 'b-', 'Linewidth',2)
ylabel('Position, z (km)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(3,2,2)
plot(velocity(1,:), 'b-', 'Linewidth',2)
ylabel('Velocity, x (km/s .. I think)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(3,2,4)
plot(velocity(2,:), 'b-', 'Linewidth',2)
ylabel('Velocity, y (km/s .. I think)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(3,2,6)
plot(velocity(3,:), 'b-', 'Linewidth',2)
ylabel('Velocity, z (km/s .. I think)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)


figure
hold on

subplot(1,2,1)
% plot(time_var, position(1,:), 'b-', 'Linewidth',2)
plot( sqrt(position(1,:).^2 + position(2,:).^2 + position(3,:).^2 ), 'b-', 'Linewidth',2)
ylabel('Distance (km)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)

subplot(1,2,2)
plot( sqrt(velocity(1,:).^2 + velocity(2,:).^2 + velocity(3,:).^2 ), 'b-', 'Linewidth',2)
ylabel('Speed (km/s .. I think)','FontSize',16)
xlabel('Julian Date (not yet)','FontSize',16)
set(gca,'FontSize',16)


figure

for timeIx = 1:numel(time_var)

  scatter3(position(1,1:timeIx),position(2,1:timeIx),position(3,1:timeIx),'filled')
  title('Position (km)','FontSize',16)
  xlim([-1e4,1e4])
  ylim([-1e4,1e4])
  zlim([-1e4,1e4])
  set(gca,'FontSize',14)
  pause(0.001)

end

