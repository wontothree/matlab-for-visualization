% Data uploading
data = importdata('lab1-b.txt');

% Data extraction
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

% I/V Graph calculation
I_over_V_abs = abs(currents ./ voltages);
I_over_V_dB = 20 * log10(I_over_V_abs); % 절댓값을 dB로 변환

% Phase Difference calculation
phase_diff = angle(currents) - angle(voltages);
phase_diff_deg = rad2deg(phase_diff);

% Visualization
figure;

% Left y axis
yyaxis left;
h1 = semilogx(frequencies, I_over_V_dB, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
ylabel('Magnitude [dB]', 'FontSize', 12, 'FontWeight', 'bold');

% right y axis
yyaxis right;
h2 = semilogx(frequencies, phase_diff_deg, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
ylabel('Phase Difference [deg]', 'FontSize', 12, 'FontWeight', 'bold');
ylim([-90, 90]);
yticks(-90:30:90);


% X axis
xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold');
title('I(jw) / Vs(jw) (RL = INF(1TOhm))');
hold on;

ax = gca; % 현재 축 가져오기
ax.FontSize = 12; % 눈금 및 눈금 레이블의 글꼴 크기 설정
ax.XColor = [0 0 0]; % x 축 색상 설정

grid on;
xlim([min(frequencies), 2e5]);

yyaxis left;
ax.YColor = [0.5 0 0];
yyaxis right;
ax.YColor = [0 0 0.5];







% MAX
[max_value, max_index] = max(I_over_V_abs);
asymptote_frequency = frequencies(max_index);

yyaxis left;
hold on;
text(asymptote_frequency, 20*log10(max_value), sprintf('(%.2e, %.2f)', asymptote_frequency, 20*log10(max_value)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
plot(asymptote_frequency, 20*log10(max_value), 'ko', 'MarkerSize', 5);





% Legend
legend([h1, h2], {'Magnitude', 'Phase Difference'}, 'FontSize', 9);

