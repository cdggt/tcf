function [] = tcf_HDF5_info(HDF5_file)
%   Prints minimal group and dataset names in TCF HDF5 file format.
%
%   Inputs:
%   HDF5_file - TCF file in HDF5 file format
%
%   Outputs:
%   None
%
%                                               Date
%   By Michael C. Krygier                       01/16/2021
%

h5disp(HDF5_file,'/tcf','min');

end
