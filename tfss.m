s = tf('s');
P_motor = (0.01*s^2 + 1)/(0.0005*s^5 + 0.016*s^4 + 0.63001*s^3 + 6.2002*s^2 + 10.01*s)

Kp = 21;
Ki = 500;
Kd = 0.15;

for i = 1:3
    C(:,:,i) = pid(Kp,Ki,Kd);
    Kd = Kd + 0.1;
end

sys_cl = feedback(C*P_motor,1);
t = 0:0.001:5; % Zaman aralığını 0'dan 5'e genişletin
step(sys_cl(:,:,1), sys_cl(:,:,2), sys_cl(:,:,3), t)
ylabel('Position, \theta (radians)')
title('Step Response with K_p = 21, K_i = 500 and Different Values of K_d')
legend('Kd = 0.05', 'Kd = 0.15', 'Kd = 0.25')

dist_cl = feedback(P_motor,C);
t = 0:0.001:0.2;
step(dist_cl(:,:,1), dist_cl(:,:,2), dist_cl(:,:,3), t)
ylabel('Position, \theta (radians)')
title('Step Response with K_p = 21, K_i = 500 and Different values of K_d')
legend('Kd = 0.05', 'Kd = 0.15', 'Kd = 0.25')

stepinfo(sys_cl(:,:,2))