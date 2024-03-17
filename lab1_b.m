data = importdata('lab1_b.txt');

% 데이터 추출 및 변환
frequencies = zeros(numel(data)-1, 1); % 헤더 행을 제외하기 위해 -1
voltages = zeros(numel(data)-1, 1);
currents = zeros(numel(data)-1, 1);

for i = 2:numel(data)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data{i}, '\t');

    % 주파수 데이터 추출
    frequencies(i-1) = str2double(split_data{1});

    % 전압 데이터 추출
    voltage_str = split_data{2};
    voltage_complex = sscanf(voltage_str, '%f,%f');
    voltages(i-1) = voltage_complex(1) + 1i * voltage_complex(2);

    % 전류 데이터 추출
    current_str = split_data{3};
    current_complex = sscanf(current_str, '%f,%f');
    currents(i-1) = current_complex(1) + 1i * current_complex(2);
end

% I/V 계산 및 절댓값 적용
I_over_V_abs = abs(currents ./ voltages);
I_over_V_dB = 20 * log10(I_over_V_abs); % 절댓값을 dB로 변환

% 위상 차 계산 및 degree로 변환
phase_diff = angle(currents) - angle(voltages);
phase_diff_deg = rad2deg(phase_diff);

% 그래프 그리기 (로그 스케일)
figure;

% I/V의 크기 및 위상 차 그래프
% 왼쪽 축 설정
yyaxis left;
h1 = semilogx(frequencies, I_over_V_dB, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
ylabel('dB');

% 오른쪽 축 설정
yyaxis right;
h2 = semilogx(frequencies, phase_diff_deg, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
ylabel('deg');

xlabel('Hz');
title('I(jw)/Vs(jw)');
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
