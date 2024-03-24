# MATLAB for Visualization

<img src="./img/lab2-d-graph.png" />

## 1. 데이터 불러오기

```m
data1 = importdata('lab2-c.txt');

frequencies1 = zeros(numel(data1)-2, 1);
input_voltages1 = zeros(numel(data1)-2, 1);
output_voltages1 = zeros(numel(data1)-2, 1);

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
```

## 2. 그래프

```m
% O/I
O_over_I_abs1 = abs(output_voltages1 ./ input_voltages1);
O_over_I_dB1 = 20 * log10(O_over_I_abs1); % 절댓값을 dB로 변환

% Phase difference
phase_diff1 = angle(output_voltages1) - angle(input_voltages1);
phase_diff_deg1 = rad2deg(phase_diff1);
```

## 3. 시각화와 축 설정

```m
figure;
grid on; % 그리드 설정
title('Frequency Response');

% x축 설정
xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold');
xlim([min([frequencies1; frequencies2; frequencies3]), 2e5]);

% 왼쪽 축 설정 - 크기
yyaxis left;
h1 = semilogx(frequencies1, O_over_I_dB1, 'LineWidth', 1.5, 'Color', [0.5 0 0], 'LineStyle', '-');
hold on;
h2 = semilogx(frequencies2, O_over_I_dB2, 'LineWidth', 1.5, 'Color', [0 0 0.5], 'LineStyle', '-');
h3 = semilogx(frequencies3, I_over_V_dB, 'LineWidth', 1.5, 'Color', [0 0.5 0], 'LineStyle', '-');
ylabel('Magnitude [dB] (solid line)', 'FontSize', 12, 'FontWeight', 'bold');
ax1 = gca; % 왼쪽 축 가져오기
ax1.YColor = [0 0 0]; % 검정색

% 오른쪽 축 설정 - 위상차
yyaxis right;
h4 = semilogx(frequencies1, phase_diff_deg1, '--', 'LineWidth', 1.5, 'Color', [0.5 0 0]);
h5 = semilogx(frequencies2, phase_diff_deg2, '--', 'LineWidth', 1.5, 'Color', [0 0 0.5]);
h6 = semilogx(frequencies3, phase_diff_deg, '--', 'LineWidth', 1.5, 'Color', [0 0.5 0]);
ylabel('Phase Difference [deg] (dashed line)', 'FontSize', 12, 'FontWeight', 'bold');
ax2 = gca; % 오른쪽 축 가져오기
ax2.YColor = [0 0 0]; % 검정색





% 2
figure;

% 왼쪽 축 설정
yyaxis left;
h1 = semilogx(frequencies, I_over_V_dB, 'LineWidth', 1.5, 'Color', [0.5 0 0]);
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
```

## 4. 점근선

linear scale

```m
% Plot asymptotic line for y = 0.41
ref_line = 0.41 * ones(size(frequencies1));
plot(frequencies1, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 50 Ohm
plot(frequencies2, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 2k Ohm
```

dB scale

```m
% 점근선
ref_line = -3.01 * ones(size(frequencies));
plot(frequencies, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

ref_dB = -3.01;
diff1 = abs(O_over_I_dB - ref_dB);
[min_diff1, min_index] = min(diff1);
intersection_1 = frequencies(min_index);

diff1(min_index) = NaN;
[min_diff1, min_index] = min(diff1);
intersection_2 = frequencies(min_index);

plot(intersection_1, O_over_I_dB(min_index), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k');
plot(intersection_2, O_over_I_dB(min_index), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k'); 
text(intersection_1, O_over_I_dB(min_index), sprintf('(%.2f, %.2f)', intersection_1, O_over_I_dB(min_index)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'FontSize', 10);
text(intersection_2, O_over_I_dB(min_index), sprintf('(%.2f, %.2f)', intersection_2, O_over_I_dB(min_index)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 10);
```

## 5. Max

```m
% MAX
[max_value, max_index] = max(O_over_I_abs);
asymptote_frequency = frequencies(max_index);

yyaxis left;
hold on;
text(asymptote_frequency, 20*log10(max_value), sprintf('(%.2f, %.2f)', asymptote_frequency, 20*log10(max_value)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'FontSize', 10);
plot(asymptote_frequency, 20*log10(max_value), 'ko', 'MarkerSize', 5);

[max_value, max_index] = max(I_over_V_abs);
asymptote_frequency = frequencies(max_index);

yyaxis left; % 왼쪽 축을 사용하여 추가
hold on;
text(asymptote_frequency, 20*log10(max_value), sprintf('(%.2f, %.2f)', asymptote_frequency, 20*log10(max_value)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
plot(asymptote_frequency, 20*log10(max_value), 'ko', 'MarkerSize', 5);
```

## 6. Legend

- Fontsize
- Location

```m
% Legend
legend([h1, h2], {'Magnitude', 'Phase Difference'}, 'FontSize', 9, 'Location', 'southeast');
```
