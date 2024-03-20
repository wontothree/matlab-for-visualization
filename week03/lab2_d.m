% Data uploading
data1 = importdata('lab2-c.txt');
data2 = importdata('lab2-c2.txt');

% Data extraction
frequencies1 = zeros(numel(data1)-2, 1);
input_voltages1 = zeros(numel(data1)-2, 1);
output_voltages1 = zeros(numel(data1)-2, 1);

frequencies2 = zeros(numel(data2)-2, 1);
input_voltages2 = zeros(numel(data2)-2, 1);
output_voltages2 = zeros(numel(data2)-2, 1);

% Data extraction
% Data extraction for data1
for i = 3:numel(data1)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data1{i}, '\t');

    % 주파수 데이터 추출
    frequencies1(i-2) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages1(i-2) = input_voltage_complex(1); % 실수부만 사용

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages1(i-2) = output_voltage_complex(1); % 실수부만 사용
end

% Data extraction for data2
for i = 3:numel(data2)
    % 각 줄의 데이터를 탭을 기준으로 분할
    split_data = strsplit(data2{i}, '\t');

    % 주파수 데이터 추출
    frequencies2(i-2) = str2double(split_data{1});

    % 입력 전압 데이터 추출
    input_voltage_str = split_data{2};
    input_voltage_complex = sscanf(input_voltage_str, '%f,%f');
    input_voltages2(i-2) = input_voltage_complex(1); % 실수부만 사용

    % 출력 전압 데이터 추출
    output_voltage_str = split_data{3};
    output_voltage_complex = sscanf(output_voltage_str, '%f,%f');
    output_voltages2(i-2) = output_voltage_complex(1); % 실수부만 사용
end

% Graph calculation
O_over_I_abs1 = abs(output_voltages1 ./ input_voltages1);
O_over_I_abs2 = abs(output_voltages2 ./ input_voltages2);

<<<<<<< HEAD
=======




>>>>>>> 23423ed57ba31acb98392ba85d742d37993e4b5b
% Visualization
figure;

% Y axis
h1 = semilogx(frequencies1, output_voltages1, 'LineWidth', 1.5, 'Color', [0.5 0 0], 'LineStyle', '-');
hold on;
h2 = semilogx(frequencies2, output_voltages2, 'LineWidth', 1.5, 'Color', [0 0 0.5], 'LineStyle', '-');
ylabel('Magnitude', 'FontSize', 12, 'FontWeight', 'bold');
ax1 = gca;
ax1.YColor = [0 0 0];

% X axis
xlabel('Frequency [Hz]', 'FontSize', 12, 'FontWeight', 'bold');
xlim([10, 2e5]);

grid on; 
title('Vo(jw) / Vs(jw)', 'FontSize', 12, 'FontWeight', 'bold');

% Find minimum values and corresponding frequencies
[min_value1, min_index1] = min(real(output_voltages1));
[min_value2, min_index2] = min(real(output_voltages2));
min_frequency1 = frequencies1(min_index1);
min_frequency2 = frequencies2(min_index2);

% Plot markers at minimum points
hold on;
plot(min_frequency1, min_value1, 'ko', 'MarkerSize', 8);
plot(min_frequency2, min_value2, 'ko', 'MarkerSize', 8);

% Display coordinates of minimum points on the graph
text(min_frequency1, min_value1, ['(', num2str(min_frequency1), ', ', num2str(min_value1), ')'], 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'FontSize', 10);
text(min_frequency2, min_value2, ['(', num2str(min_frequency2), ', ', num2str(min_value2), ')'], 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'FontSize', 10);





% Plot asymptotic line for y = 0.41
ref_line = 0.41 * ones(size(frequencies1));
plot(frequencies1, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 50 Ohm
plot(frequencies2, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 2k Ohm

% Plot asymptotic line for y = 0.921
ref_line = 0.921 * ones(size(frequencies2));
plot(frequencies1, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 50 Ohm
plot(frequencies2, ref_line, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1); % RL = 2k Ohm








% Find points where y coordinate is 0.41
y_target = 0.41;

% Find the nearest points to y_target
[~, indices1] = sort(abs(real(output_voltages1) - y_target)); % 실수 부분만 사용하여 정렬된 인덱스 가져오기
[~, index1] = min(abs(real(output_voltages1(indices1(1:2))) - y_target)); % 가장 가까운 두 점 중 첫 번째 점 선택

% Get corresponding frequency for the first point
freq1_at_target = frequencies1(indices1(index1));

% Plot marker at the first point
plot(freq1_at_target, output_voltages1(indices1(index1)), 'ko', 'MarkerSize', 8);

% Display coordinates of the first point on the graph
text(freq1_at_target, output_voltages1(indices1(index1)), ['(', num2str(freq1_at_target), ', ', num2str(y_target), ')'], 'VerticalAlignment', 'cap', 'HorizontalAlignment', 'left', 'FontSize', 10);

% Find the second nearest point
index2 = indices1(2); % 두 번째로 가까운 점의 인덱스 가져오기

% Get corresponding frequency for the second point
freq2_at_target = frequencies1(index2);

% Plot marker at the second point
plot(freq2_at_target, output_voltages1(index2), 'ko', 'MarkerSize', 8);

% Display coordinates of the second point on the graph
text(freq2_at_target, output_voltages1(index2), ['(', num2str(freq2_at_target), ', ', num2str(y_target), ')'], 'VerticalAlignment', 'cap', 'HorizontalAlignment', 'right', 'FontSize', 10);





% Find points where y coordinate is 0.921
y_target = 0.921;

% Find the nearest points to y_target
[~, indices2] = sort(abs(real(output_voltages2) - y_target)); % 실수 부분만 사용하여 정렬된 인덱스 가져오기
[~, index1] = min(abs(real(output_voltages2(indices2(1:2))) - y_target)); % 가장 가까운 두 점 중 첫 번째 점 선택

% Get corresponding frequency for the first point
freq1_at_target2 = frequencies2(indices2(index1));

% Plot marker at the first point
plot(freq1_at_target2, output_voltages2(indices2(index1)), 'ko', 'MarkerSize', 8);

% Display coordinates of the first point on the graph
text(freq1_at_target2, output_voltages2(indices2(index1)), ['(', num2str(freq1_at_target2), ', ', num2str(y_target), ')'], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 10);

% Find the second nearest point
index2 = indices2(2); % 두 번째로 가까운 점의 인덱스 가져오기

% Get corresponding frequency for the second point
freq2_at_target2 = frequencies2(index2);

% Plot marker at the second point
plot(freq2_at_target2, output_voltages2(index2), 'ko', 'MarkerSize', 8);

% Display coordinates of the second point on the graph
text(freq2_at_target2, output_voltages2(index2), ['(', num2str(freq2_at_target2), ', ', num2str(y_target), ')'], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);





% Legend
legend([h1, h2], {'RL = 50Ohm', 'RL = 2kOhm'}, 'Location', 'southeast');
<<<<<<< HEAD
=======

>>>>>>> 23423ed57ba31acb98392ba85d742d37993e4b5b
