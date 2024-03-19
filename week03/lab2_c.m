data1 = importdata('lab2-c.txt');
data2 = importdata('lab2-c2.txt');
data3 = importdata('lab2-b.txt');

% 데이터 추출 및 변환
frequencies1 = zeros(numel(data1)-2, 1);
input_voltages1 = zeros(numel(data1)-2, 1);
output_voltages1 = zeros(numel(data1)-2, 1);

frequencies2 = zeros(numel(data2)-2, 1);
input_voltages2 = zeros(numel(data2)-2, 1);
output_voltages2 = zeros(numel(data2)-2, 1);

frequencies3 = zeros(numel(data3)-1, 1);
voltages3 = zeros(numel(data3)-1, 1);
currents3 = zeros(numel(data3)-1, 1);

for i = 3:numel(data1)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data1{i}, '\t');

    % 주파수 데이터 추출
    frequencies1(i-2) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages1(i-2) = input_voltage_complex(1) + 1i * input_voltage_complex(2);

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages1(i-2) = output_voltage_complex(1) + 1i * output_voltage_complex(2);
end

for i = 3:numel(data2)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data2{i}, '\t');

    % 주파수 데이터 추출
    frequencies2(i-2) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages2(i-2) = input_voltage_complex(1) + 1i * input_voltage_complex(2);

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages2(i-2) = output_voltage_complex(1) + 1i * output_voltage_complex(2);
end

for i = 2:numel(data3)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data3{i}, '\t');

    % 주파수 데이터 추출
    frequencies3(i-1) = str2double(split_data{1});

    % 전압 데이터 추출
    voltage_str = split_data{2};
    voltage_complex = sscanf(voltage_str, '%f,%f');
    voltages3(i-1) = voltage_complex(1) + 1i * voltage_complex(2);

    % 전류 데이터 추출
    current_str = split_data{3};
    current_complex = sscanf(current_str, '%f,%f');
    currents3(i-1) = current_complex(1) + 1i * current_complex(2);
end

% O/I 계산 및 절댓값 적용
O_over_I_abs1 = abs(output_voltages1 ./ input_voltages1);
O_over_I_dB1 = 20 * log10(O_over_I_abs1); % 절댓값을 dB로 변환

O_over_I_abs2 = abs(output_voltages2 ./ input_voltages2);
O_over_I_dB2 = 20 * log10(O_over_I_abs2); % 절댓값을 dB로 변환

% V/I 계산 및 절댓값 적용
I_over_V_abs = abs(voltages3 ./ currents3);
I_over_V_dB = 20 * log10(I_over_V_abs); % 절댓값을 dB로 변환

% 위상 차 계산 및 degree로 변환
phase_diff1 = angle(output_voltages1) - angle(input_voltages1);
phase_diff_deg1 = rad2deg(phase_diff1);

phase_diff2 = angle(output_voltages2) - angle(input_voltages2);
phase_diff_deg2 = rad2deg(phase_diff2);

phase_diff = angle(voltages3) - angle(currents3);
phase_diff_deg = rad2deg(phase_diff);


% 그래프 그리기 (로그 스케일)
figure;
grid on; 
title('Frequency Response with Resistance RL Variation');

% x축 설정
xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold');
xlim([min([frequencies1; frequencies2; frequencies3]), 2e5]);

% 왼쪽 축 설정 - 크기
yyaxis left;
h1 = semilogx(frequencies1, O_over_I_dB1, 'LineWidth', 1.5, 'Color', [0.5 0 0], 'LineStyle', '-');
hold on;
h2 = semilogx(frequencies2, O_over_I_dB2, 'LineWidth', 1.5, 'Color', [0 0 0.5], 'LineStyle', '-');
h3 = semilogx(frequencies3, I_over_V_dB, 'LineWidth', 1.5, 'Color', [0 0.5 0], 'LineStyle', '-');
ylabel('Magnitude [dB]', 'FontSize', 12, 'FontWeight', 'bold');
ax1 = gca; % 왼쪽 축 가져오기
ax1.YColor = [0 0 0]; % 검정색

% 오른쪽 축 설정 - 위상차
yyaxis right;
h4 = semilogx(frequencies1, phase_diff_deg1, '--', 'LineWidth', 1.5, 'Color', [0.5 0 0]);
h5 = semilogx(frequencies2, phase_diff_deg2, '--', 'LineWidth', 1.5, 'Color', [0 0 0.5]);
h6 = semilogx(frequencies3, phase_diff_deg, '--', 'LineWidth', 1.5, 'Color', [0 0.5 0]);
ylabel('Phase Difference [deg]', 'FontSize', 12, 'FontWeight', 'bold');
ax2 = gca;
ax2.YColor = [0 0 0];
ylim([-180, 180]);
yticks(-180:45:180);



% 절대값이 최대가 되는 주파수 찾기
[max_value, max_index] = max(I_over_V_abs);
asymptote_frequency = frequencies3(max_index);

% 그래프에 점근선 추가
yyaxis left; % 왼쪽 축을 사용하여 추가
hold on;
text(asymptote_frequency, 20*log10(max_value), sprintf('(%.2f, %.2f)', asymptote_frequency, 20*log10(max_value)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 10); % 주석 추가

% 최대점 동그라미 표시
plot(asymptote_frequency, 20*log10(max_value), 'ko', 'MarkerSize', 5);

% 공진점과 반공진점 찾기
[resonance_peaks1, resonance_locs1] = findpeaks(O_over_I_dB1, frequencies1);
[anti_peaks1, anti_locs1] = findpeaks(-O_over_I_dB1, frequencies1);

[resonance_peaks2, resonance_locs2] = findpeaks(O_over_I_dB2, frequencies2);
[anti_peaks2, anti_locs2] = findpeaks(-O_over_I_dB2, frequencies2);

% 그래프에 공진점과 반공진점 표시
plot(resonance_locs1, resonance_peaks1, 'ko', 'MarkerSize', 5); % 데이터 세트 1의 공진점 표시
plot(anti_locs1, -anti_peaks1, 'ko', 'MarkerSize', 5); % 데이터 세트 1의 반공진점 표시

plot(resonance_locs2, resonance_peaks2, 'ko', 'MarkerSize', 5); % 데이터 세트 2의 공진점 표시
plot(anti_locs2, -anti_peaks2, 'ko', 'MarkerSize', 5); % 데이터 세트 2의 반공진점 표시

% 공진점과 반공진점 좌표 출력
for i = 1:numel(resonance_locs1)
    text(resonance_locs1(i), resonance_peaks1(i), sprintf('(%.2f, %.2f)', resonance_locs1(i), resonance_peaks1(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
end

for i = 1:numel(anti_locs1)
    text(anti_locs1(i), -anti_peaks1(i), sprintf('(%.2f, %.2f)', anti_locs1(i), -anti_peaks1(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
end

for i = 1:numel(resonance_locs2)
    text(resonance_locs2(i), resonance_peaks2(i), sprintf('(%.2f, %.2f)', resonance_locs2(i), resonance_peaks2(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
end

for i = 1:numel(anti_locs2)
    text(anti_locs2(i), -anti_peaks2(i), sprintf('(%.2f, %.2f)', anti_locs2(i), -anti_peaks2(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
end










% 레전드 표시
legend([h1, h2, h3, h4, h5, h6], {'Vo/Vs Magnitude(RL=50Ohm)', 'Vo/Vs Magnitude(RL=2kOhm)', 'Vs/I Magnitude(RL=0)', 'Vo/Vs Phase Difference(RL=50Ohm)', 'Vo/Vs Phase Difference(RL=2kOhm)', 'Phase Difference Vs/I(RL=0)'}, 'Location', 'northwest', 'FontSize', 6);

