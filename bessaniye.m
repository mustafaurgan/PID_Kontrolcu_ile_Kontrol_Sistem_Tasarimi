s = tf('s');
P_motor = (0.01*s^2 + 1) / (0.0005*s^5 + 0.016*s^4 + 0.63001*s^3 + 6.2002*s^2 + 10.01*s);

Kp = 100; % Örnek olarak yüksek bir Kp değeri belirleyelim
Ki = 0;   % İlk olarak integral terimini devre dışı bırakalım
Kd = 10;  % Örnek olarak yüksek bir Kd değeri belirleyelim

for i = 1:3
    C(:,:,i) = pid(Kp,Ki,Kd);
    Kd = Kd + 10; % Kd değerini artırabiliriz
end

sys_cl = feedback(C*P_motor, 1);
t = 0:0.001:5; % Zaman aralığını 0'dan 5'e genişletin
step(sys_cl, t)
ylabel('Position, \theta (radians)')
title('Step Response with K_p = 100, K_i = 0, K_d = 10')
