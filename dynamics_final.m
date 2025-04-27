% Hannah Loly - ME 121: Advanced Dynamics
% Final Project Data Analysis 

clear; clc; close all; 

% Specify the folder where the files are located
base_path = '/Users/hannahloly/Desktop/ME 121/Plate_CSVs'; 

% Hemmed data filenames 
files_hemmed = struct(...
    'HTL', struct(...
        'raw', {{'HTL_aluminum_data1_raw.csv', 'HTL_aluminum_data2_raw.csv', 'HTL_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HTL_aluminum_data1_FFT.csv', 'HTL_aluminum_data2_FFT.csv', 'HTL_aluminum_data3_FFT.csv'}}), ...
    'HTC', struct(...
        'raw', {{'HTC_aluminum_data1_raw.csv', 'HTC_aluminum_data2_raw.csv', 'HTC_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HTC_aluminum_data1_FFT.csv', 'HTC_aluminum_data2_FFT.csv', 'HTC_aluminum_data3_FFT.csv'}}), ...
    'HTR', struct(...
        'raw', {{'HTR_aluminum_data1_raw.csv', 'HTR_aluminum_data2_raw.csv', 'HTR_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HTR_aluminum_data1_FFT.csv', 'HTR_aluminum_data2_FFT.csv', 'HTR_aluminum_data3_FFT.csv'}}), ...
    'HC', struct(...
        'raw', {{'HC_aluminum_data1_raw.csv', 'HC_aluminum_data2_raw.csv', 'HC_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HC_aluminum_data1_FFT.csv', 'HC_aluminum_data2_FFT.csv', 'HC_aluminum_data3_FFT.csv'}}), ...
    'HBL', struct(...
        'raw', {{'HBL_aluminum_data1_raw.csv', 'HBL_aluminum_data2_raw.csv', 'HBL_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HBL_aluminum_data1_FFT.csv', 'HBL_aluminum_data2_FFT.csv', 'HBL_aluminum_data3_FFT.csv'}}), ...
    'HBC', struct(...
        'raw', {{'HBC_aluminum_data1_raw.csv', 'HBC_aluminum_data2_raw.csv', 'HBC_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HBC_aluminum_data1_FFT.csv', 'HBC_aluminum_data2_FFT.csv', 'HBC_aluminum_data3_FFT.csv'}}), ...
    'HBR', struct(...
        'raw', {{'HBR_aluminum_data1_raw.csv', 'HBR_aluminum_data2_raw.csv', 'HBR_aluminum_data3_raw.csv'}}, ...
        'fft', {{'HBR_aluminum_data1_FFT.csv', 'HBR_aluminum_data2_FFT.csv', 'HBR_aluminum_data3_FFT.csv'}})...
);

% Unaltered data filenames 
files_unaltered = struct(...
    'TL', struct(...
        'raw', {{'TL_aluminum_data1_raw.csv', 'TL_aluminum_data2_raw.csv', 'TL_aluminum_data3_raw.csv'}}, ...
        'fft', {{'TL_aluminum_data1_FFT.csv', 'TL_aluminum_data2_FFT.csv', 'TL_aluminum_data3_FFT.csv'}}), ...
    'TC', struct(...
        'raw', {{'TC_aluminum_data1_raw.csv', 'TC_aluminum_data2_raw.csv', 'TC_aluminum_data3_raw.csv'}}, ...
        'fft', {{'TC_aluminum_data1_FFT.csv', 'TC_aluminum_data2_FFT.csv', 'TC_aluminum_data3_FFT.csv'}}), ...
    'TR', struct(...
        'raw', {{'TR_aluminum_data1_raw.csv', 'TR_aluminum_data2_raw.csv', 'TR_aluminum_data3_raw.csv'}}, ...
        'fft', {{'TR_aluminum_data1_FFT.csv', 'TR_aluminum_data2_FFT.csv', 'TR_aluminum_data3_FFT.csv'}}), ...
    'C', struct(...
        'raw', {{'C_aluminum_data1_raw.csv', 'C_aluminum_data2_raw.csv', 'C_aluminum_data3_raw.csv'}}, ...
        'fft', {{'C_aluminum_data1_FFT.csv', 'C_aluminum_data2_FFT.csv', 'C_aluminum_data3_FFT.csv'}}), ...
    'BL', struct(...
        'raw', {{'BL_aluminum_data1_raw.csv', 'BL_aluminum_data2_raw.csv', 'BL_aluminum_data3_raw.csv'}}, ...
        'fft', {{'BL_aluminum_data1_FFT.csv', 'BL_aluminum_data2_FFT.csv', 'BL_aluminum_data3_FFT.csv'}}), ...
    'BC', struct(...
        'raw', {{'BC_aluminum_data1_raw.csv', 'BC_aluminum_data2_raw.csv', 'BC_aluminum_data3_raw.csv'}}, ...
        'fft', {{'BC_aluminum_data1_FFT.csv', 'BC_aluminum_data2_FFT.csv', 'BC_aluminum_data3_FFT.csv'}}), ...
    'BR', struct(...
        'raw', {{'BR_aluminum_data1_raw.csv', 'BR_aluminum_data2_raw.csv', 'BR_aluminum_data3_raw.csv'}}, ...
        'fft', {{'BR_aluminum_data1_FFT.csv', 'BR_aluminum_data2_FFT.csv', 'BR_aluminum_data3_FFT.csv'}}) ...
);

% Define common legend entries
legend_entries = {'Data1', 'Data2', 'Data3'};
fields_h = fieldnames(files_hemmed);
fields_u = fieldnames(files_unaltered);
subplot_positions = [1 2 3 5 7 8 9];  % For subplot layout (Top Left, Top Center, etc.)
subplot_labels = {'Top Left', 'Top Center', 'Top Right', 'Center', 'Bottom Left', 'Bottom Center', 'Bottom Right'};

% Plot Raw Data for Hemmed Data
figure('Name', 'Raw Data - Hemmed');
plot_idx = 1;

for idx = 1:length(fields_h)
    subplot(3,3,subplot_positions(plot_idx));
    hold on;
    for i = 1:3
        data = importdata(fullfile(base_path, files_hemmed.(fields_h{idx}).raw{i}));
        data = data.data;
        t = linspace(0,2,length(data));
        plot(t, data(:,1));
    end
    hold off;
    title([subplot_labels{plot_idx}]);
    xlabel('Time (sec)');
    ylabel('Amplitude');
    legend(legend_entries);
    grid on;
    plot_idx = plot_idx + 1;
end

% Plot FFT Data for Hemmed Data
figure('Name', 'FFT Data - Hemmed');
plot_idx = 1;

for idx = 1:length(fields_h)
    subplot(3,3,subplot_positions(plot_idx));
    hold on;
    for i = 1:3
        data = importdata(fullfile(base_path, files_hemmed.(fields_h{idx}).fft{i}));
        data = data.data;
        plot(data(:,1));
    end
    hold off;
    title([subplot_labels{plot_idx}]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    legend(legend_entries);
    grid on;
    plot_idx = plot_idx + 1;
end

% Plot Raw Data for Unaltered Data
figure('Name', 'Raw Data - Unaltered');
plot_idx = 1;

for idx = 1:length(fields_u)
    subplot(3,3,subplot_positions(plot_idx));
    hold on;
    for i = 1:3
        data = importdata(fullfile(base_path, files_unaltered.(fields_u{idx}).raw{i}));
        data = data.data;
        t = linspace(0,2,length(data));
        plot(t, data(:,1));
    end
    hold off;
    title([subplot_labels{plot_idx}]);
    xlabel('Time (sec)');
    ylabel('Amplitude');
    legend(legend_entries);
    grid on;
    plot_idx = plot_idx + 1;
end

% Plot FFT Data for Unaltered Data
figure('Name', 'FFT Data - Unaltered');
plot_idx = 1;

for idx = 1:length(fields_u)
    subplot(3,3,subplot_positions(plot_idx));
    hold on;
    for i = 1:3
        data = importdata(fullfile(base_path, files_unaltered.(fields_u{idx}).fft{i}));
        data = data.data;
        plot(data(:,1));
    end
    hold off;
    title([subplot_labels{plot_idx}]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    legend(legend_entries);
    grid on;
    plot_idx = plot_idx + 1;
end
