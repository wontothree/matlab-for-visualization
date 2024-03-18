data = importdata('lab1-c.txt');

% 데이터 추출 및 변환
frequencies = zeros(numel(data)-1, 1); % 헤더 행을 제외하기 위해 -1
voltages = zeros(numel(data)-1, 1);
currents = zeros(numel(data)-1, 1);

for i = 2:numel(data)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data{i}, '\t');

    % 주파수 데이터 추출
    frequencies(i-1) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages(i-1) = input_voltage_complex(1) + 1i * input_voltage_complex(2);

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages(i-1) = output_voltage_complex(1) + 1i * output_voltage_complex(2);
end

% I/V 계산 및 절댓값 적용
O_over_I_abs = abs(output_voltages ./ input_voltages);
O_over_I_dB = 20 * log10(O_over_I_abs); % 절댓값을 dB로 변환

% 위상 차 계산 및 degree로 변환
phase_diff = angle(output_voltages) - angle(input_voltages);
phase_diff_deg = rad2deg(phase_diff);

% 그래프 그리기 (로그 스케일)
figure;

% I/V의 크기 및 위상 차 그래프
% 왼쪽 축 설정
yyaxis left;
h1 = semilogx(frequencies, O_over_I_dB, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
ylabel('dB', 'FontSize', 12, 'FontWeight', 'bold');

% 오른쪽 축 설정
yyaxis right;
h2 = semilogx(frequencies, phase_diff_deg, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
ylabel('deg', 'FontSize', 12, 'FontWeight', 'bold');

xlabel('Hz', 'FontSize', 12, 'FontWeight', 'bold');
title('I(jw) / Vs(jw)');
hold on;

% 오른쪽 축의 범위를 90~-90으로 설정
ylim([-90, 90]);

% 오른쪽 축 눈금을 30도 단위로 설정
yticks(-90:30:90);

% 레전드 표시
legend([h1, h2], {'Magnitude', 'Phase Difference'});

% 축 스타일 설정
ax = gca; % 현재 축 가져오기
ax.FontSize = 12; % 눈금 및 눈금 레이블의 글꼴 크기 설정
ax.XColor = [0 0 0]; % x 축 색상 설정

% 왼쪽 축 색상 설정
yyaxis left;
ax.YColor = [0.5 0 0]; % 빨간색

% 오른쪽 축 색상 설정
yyaxis right;
ax.YColor = [0 0 0.5]; % 파란색

grid on;
xlim([min(frequencies), 2e5]);
