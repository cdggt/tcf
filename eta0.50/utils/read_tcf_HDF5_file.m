function [state] = read_tcf_HDF5_file(infile)
%   Reads TCF statefile in HDF5 file format.
%
%   Inputs:
%   infile - HD5F file to read
%
%   Outputs:
%   state - MATLAB Structure containing HDF5 Groups/Datasets.
%
%                                               Date
%   By Michael C. Krygier                       01/17/2021
%                                               01/19/2021 [Updated]
%

    % Read TCF H5DF Datasets
    file_info = h5info(infile,'/tcf');
    for i=1:numel(file_info.Groups)
        long_group_names{i} = file_info.Groups(i).Name;    
        [id] = regexp(file_info.Groups(i).Name,'/*');
        group_names{i} = file_info.Groups(i).Name(id(2)+1:end);

        for k=1:numel(file_info.Groups(i).Datasets)
            group = group_names{i};
            dataset = file_info.Groups(i).Datasets(k).Name;
            data = h5read(infile, strcat(long_group_names{i},'/',dataset));
                     
            state.(group).(replace(dataset,'-','_')) = data;
        end
    end
    
end
