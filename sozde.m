
function [position_radian, velocity] = simulate_encoder(previous_position_radian, previous_velocity, time_step, desired_position_radian, desired_velocity)
    % Simülasyon parametreleri
    encoder_resolution = 1000; % Kodlayıcı çözünürlüğü (pulse/sayı)
    max_velocity = 10; % Maksimum hız (rad/s)

    % Pozisyonun radyan cinsinden hesaplanması
    previous_position_pulse = previous_position_radian * encoder_resolution / (2 * pi);

    % Hız kontrolü: Motorun istenen hıza ulaşması
    if desired_position_radian > previous_position_radian
        motor_velocity = min(desired_velocity, max_velocity); % İleri hareket için
    else
        motor_velocity = max(-desired_velocity, -max_velocity); % Geri hareket için
    end

    % Motorun yeni pozisyonu ve hızı
    position_pulse = previous_position_pulse + previous_velocity * time_step;
    velocity = motor_velocity;

    % Kodlayıcı sinyallerinin simülasyonu
    encoder_pulse = motor_velocity / (2 * pi) * encoder_resolution; % Kodlayıcı sinyali (pulse/s)
    position_pulse = mod(position_pulse + encoder_pulse, encoder_resolution); % Pozisyon döngüsü

    % Pozisyonun 0 ile encoder_resolution arasında tutulması
    if position_pulse < 0
        position_pulse = position_pulse + encoder_resolution;
    end

    % Güncellenmiş pozisyonun radyan cinsinden hesaplanması
    position_radian = position_pulse * (2 * pi) / encoder_resolution;
end
