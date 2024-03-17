data1 = importdata('lab1-d.txt');
data2 = importdata('lab1-d2.txt');

% 데이터 추출 및 변환
frequencies1 = zeros(numel(data1)-2, 1);
input_voltages1 = zeros(numel(data1)-2, 1);
output_voltages1 = zeros(numel(data1)-2, 1);

frequencies2 = zeros(numel(data2)-2, 1);
input_voltages2 = zeros(numel(data2)-2, 1);
output_voltages2 = zeros(numel(data2)-2, 1);


for i = 3:numel(data1)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data1{i}, '\t');

    % 주파수 데이터 추출
    frequencies1(i-1) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages1(i-1) = input_voltage_complex(1) + 1i * input_voltage_complex(2);

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages1(i-1) = output_voltage_complex(1) + 1i * output_voltage_complex(2);
end

for i = 3:numel(data2)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data2{i}, '\t');

    % 주파수 데이터 추출
    frequencies2(i-1) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages2(i-1) = input_voltage_complex(1) + 1i * input_voltage_complex(2);

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages2(i-1) = output_voltage_complex(1) + 1i * output_voltage_complex(2);
end

% O/I 계산 및 절댓값 적용
O_over_I_abs1 = abs(output_voltages1 ./ input_voltages1);
O_over_I_dB1 = 20 * log10(O_over_I_abs1); % 절댓값을 dB로 변환

O_over_I_abs2 = abs(output_voltages2 ./ input_voltages2);
O_over_I_dB2 = 20 * log10(O_over_I_abs2); % 절댓값을 dB로 변환

% 그래프 그리기 (로그 스케일)
figure;

% O/I의 크기 그래프
semilogx(frequencies1, O_over_I_dB1, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
hold on;
semilogx(frequencies2, O_over_I_dB2, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
xlabel('Hz', 'FontSize', 12, 'FontWeight', 'bold'); % x 축의 글꼴 설정
ylabel('dB', 'FontSize', 12, 'FontWeight', 'bold'); % y 축의 글꼴 설정
title('Vo(jw) / Vs(jw)');
grid on;
xlim([min([frequencies1; frequencies2]), 2e5]);

% 축 스타일 설정
ax = gca; % 현재 축 가져오기
ax.FontSize = 12; % 눈금 및 눈금 레이블의 글꼴 크기 설정
ax.XColor = [0 0 0]; % x 축 색상 설정
ax.YColor = [0 0 0]; % y 축 색상 설정

% 레전드 표시
legend({'RL = 50 Ohm', 'RL = INF (1T Ohm)'}, 'Location', 'northeast');

