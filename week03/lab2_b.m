data = importdata('lab2-b.txt');

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

V_over_I_abs = abs(voltages ./ currents);
V_over_I_dB = 20 * log10(V_over_I_abs); % 절댓값을 dB로 변환

% 위상 차 계산 및 degree로 변환
phase_diff = angle(voltages) - angle(currents);
phase_diff_deg = rad2deg(phase_diff);

% 그래프 그리기 (로그 스케일)
figure;

% I/V의 크기 및 위상 차 그래프
% 왼쪽 축 설정
yyaxis left;
h1 = semilogx(frequencies, V_over_I_dB, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
ylabel('Magnitude [dB]', 'FontSize', 12, 'FontWeight', 'bold');


% 오른쪽 축 설정
yyaxis right;
h2 = semilogx(frequencies, phase_diff_deg, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
ylabel('Phase Difference [deg]', 'FontSize', 12, 'FontWeight', 'bold');

xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold');
title('Vs(jw) / I(jw) (RL = 0)');
grid on;
hold on;




% 축
ax = gca;
ax.FontSize = 12;
ax.XColor = [0 0 0];
xlim([min(frequencies), 2e5]);

% 왼쪽 축
yyaxis left;
ax.YColor = [0.5 0 0];

% 오른쪽 축
yyaxis right;
ax.YColor = [0 0 0.5];
ylim([-180, 180]);
yticks(-180:45:180);





% 절대값이 최대가 되는 주파수 찾기
[max_value, max_index] = max(I_over_V_abs);
asymptote_frequency = frequencies(max_index);


% 그래프에 점근선 추가
yyaxis left; % 왼쪽 축을 사용하여 추가
hold on;
text(asymptote_frequency, 20*log10(max_value), sprintf('(%.2f, %.2f)', asymptote_frequency, 20*log10(max_value)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
plot(asymptote_frequency, 20*log10(max_value), 'ko', 'MarkerSize', 5);

% 점근선
ref_line = 44.95 * ones(size(frequencies));
plot(frequencies, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

ref_dB = 44.95;
diff1 = abs(V_over_I_dB - ref_dB);
[min_diff1, min_index] = min(diff1);
intersection_1 = frequencies(min_index);

diff1(min_index) = NaN;
[min_diff1, min_index] = min(diff1);
intersection_2 = frequencies(min_index);

plot(intersection_1, V_over_I_dB(min_index), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k');
plot(intersection_2, V_over_I_dB(min_index), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); 
text(intersection_1, V_over_I_dB(min_index), sprintf('(%.2f, %.2f)', intersection_1, V_over_I_dB(min_index)), 'VerticalAlignment', 'cap', 'HorizontalAlignment', 'left', 'FontSize', 10);
text(intersection_2, V_over_I_dB(min_index), sprintf('(%.2f, %.2f)', intersection_2, V_over_I_dB(min_index)), 'VerticalAlignment', 'cap', 'HorizontalAlignment', 'right', 'FontSize', 10);














legend([h1, h2], {'Magnitude', 'Phase Difference'}, 'FontSize', 9, 'Location', 'southeast');

