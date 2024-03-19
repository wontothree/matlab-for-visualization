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

% O/I 계산 및 절댓값 적용
O_over_I_abs1 = abs(output_voltages1 ./ input_voltages1);
O_over_I_dB1 = 20 * log10(O_over_I_abs1); % 절댓값을 dB로 변환

O_over_I_abs2 = abs(output_voltages2 ./ input_voltages2);
O_over_I_dB2 = 20 * log10(O_over_I_abs2); % 절댓값을 dB로 변환

% 그래프 그리기 (로그 스케일)
figure;

% O/I의 크기 그래프
h1 = semilogx(frequencies1, O_over_I_dB1, 'LineWidth', 1.5, 'Color', [0 0 0.5]);
hold on;
h2 = semilogx(frequencies2, O_over_I_dB2, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold'); % x 축의 글꼴 설정
ylabel('Magnitude [dB]', 'FontSize', 12, 'FontWeight', 'bold'); % y 축의 글꼴 설정
title('Vo(jw) / Vs(jw)');
grid on;
xlim([min([frequencies1; frequencies2]), 2e5]);
ylim([-50, 0]);


% 축 스타일 설정
ax = gca; % 현재 축 가져오기
ax.FontSize = 12; % 눈금 및 눈금 레이블의 글꼴 크기 설정
ax.XColor = [0 0 0]; % x 축 색상 설정
ax.YColor = [0 0 0]; % y 축 색상 설정



% 절대값이 최대가 되는 주파수 찾기
[max_value1, max_index1] = max(O_over_I_abs1);
asymptote_frequency1 = frequencies1(max_index1);

[max_value2, max_index2] = max(O_over_I_abs2);
asymptote_frequency2 = frequencies2(max_index2);

plot(asymptote_frequency1, 20*log10(max_value1), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k');
text(asymptote_frequency1, 20*log10(max_value1)-2, sprintf('(%.2f, %.2f)', asymptote_frequency1, 20*log10(max_value1)), 'VerticalAlignment', 'baseline', 'HorizontalAlignment', 'center', 'FontSize', 8);






% 점근선
ref_line = -3 * ones(size(frequencies1));
plot(frequencies1, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 50 Ohm에 해당하는 선
plot(frequencies2, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = INF (1T Ohm)에 해당하는 선

ref_dB = -3.01;

diff1 = abs(O_over_I_dB1 - ref_dB);
diff2 = abs(O_over_I_dB2 - ref_dB);

[min_diff1, min_index1] = min(diff1);
[min_diff2, min_index2] = min(diff2);

intersection_freq1_1 = frequencies1(min_index1);
intersection_freq2_1 = frequencies2(min_index2);

diff1(min_index1) = NaN;
diff2(min_index2) = NaN;

[min_diff1, min_index1] = min(diff1);
[min_diff2, min_index2] = min(diff2);

intersection_freq1_2 = frequencies1(min_index1);
intersection_freq2_2 = frequencies2(min_index2);

plot(intersection_freq1_1, O_over_I_dB1(min_index1), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); % 첫 번째 교차점
plot(intersection_freq2_1, O_over_I_dB2(min_index2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); % 첫 번째 교차점
plot(intersection_freq1_2, O_over_I_dB1(min_index1), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); % 두 번째 교차점
plot(intersection_freq2_2, O_over_I_dB2(min_index2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); % 두 번째 교차점

text(intersection_freq1_1, O_over_I_dB1(min_index1), sprintf('(%.2f, %.2f)', intersection_freq1_1, O_over_I_dB1(min_index1)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'FontSize', 8);
text(intersection_freq1_2, O_over_I_dB1(min_index1), sprintf('(%.2f, %.2f)', intersection_freq1_2, O_over_I_dB1(min_index1)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 8);
text(intersection_freq2_1, O_over_I_dB2(min_index2), sprintf('(%.2f, %.2f)', intersection_freq2_1, O_over_I_dB2(min_index2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 8);
text(intersection_freq2_2, O_over_I_dB2(min_index2), sprintf('(%.2f, %.2f)', intersection_freq2_2, O_over_I_dB2(min_index2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 8);















% 레전드 표시
legend([h1, h2], {'RL = 50Ohm', 'RL = INF(1TOhm)'}, 'FontSize', 8, 'Location', 'southeast');

