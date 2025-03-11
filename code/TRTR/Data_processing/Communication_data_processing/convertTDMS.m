function [ConvertedData,ConvertVer,ChanNames,GroupNames,ci]=convertTDMS(varargin)
%Function to load LabView TDMS data file(s) into variables in the MATLAB workspace.
%An *.MAT file can also be created.  If called with one input, the user selects
%a data file.
%
%   TDMS format is based on information provided by National Instruments at:
%   http://zone.ni.com/devzone/cda/tut/p/id/5696
%
% [ConvertedData,ConvertVer,ChanNames]=convertTDMS(SaveConvertedFile,filename)
%
%       Inputs:
%               SaveConvertedFile (required) - Logical flag (true/false) that
%                 determines whether a MAT file is created.  The MAT file's name
%                 is the same as 'filename' except that the 'TDMS' file extension is
%                 replaced with 'MAT'.  The MAT file is saved in the same folder
%                 and will overwrite an existing file without warning.  The
%                 MAT file contains all the output variables.
%
%               filename (optional) - Filename (fully defined) to be converted.
%                 If not supplied, the user is provided a 'File Open' dialog box
%                 to navigate to a file.  Can be a cell array of files for bulk
%                 conversion.
%
%       Outputs:
%               ConvertedData (required) - Structure of all of the data objects.
%               ConvertVer (optional) - Version number of this function.
%               ChanNames (optional) - Cell array of channel names
%               GroupNames (optional) - Cell array of group names
%               ci (optional) - Structure of the channel index (an index to
%                   where all of the information for a channel resides in a
%                   file.
%
%
%'ConvertedData' is a structure with 'FileName', 'FileFolder', 'SegTDMSVerNum',
%'NumOfSegments' and 'Data' fields'. The 'Data' field is a structure.
%
%'ConvertedData.SegTDMSVerNum' is a vector of the TDMS version number for each
%segment.
%
%'ConvertedData.Data' is a structure with 'Root' and 'MeasuredData' fields.
%
%'ConvertedData.Data.Root' is a structure with 'Name' and 'Property' fields.
%The 'Property' field is also a structure; it contains all the specified properties
%(1 entry for each 'Property) for the 'Root' group. For each 'Property' there are
%'Name' and 'Value' fields. To display a list of all the property names, input
%'{ConvertedData.Data.Root.Property.Name}'' in the Command Window.
%
%'ConvertedData.Data.MeasuredData' is a structure containing all the channel/group
%information. For each index (for example, 'ConvertedData.Data.MeasuredData(1)'),
%there are 'Name', 'Data' and 'Property' fields.  The list of channel names can
%be displayed by typing 'ChanNames' in the Command Window.  Similarly, the list
%of group names can be displayed by typing 'GroupNames' in the Command Window.
%The 'Property' field is also a structure; it contains all the specified properties
%for that index (1 entry in the structure for each 'Property'). Any LabView waveform
%attributes ('wf_start_time', 'wf_start_offset', 'wf_increment' and 'wf_samples') that
%may exist are also included in the properties. For each 'Property' there are 'Name'
%and 'Value' fields.  To display a list of all the property names, input
%'{ConvertedData.Data.MeasuredData(#).Property.Name}'' in the Command Window
%where '#' is the index of interest.
%
%If you recieve an error that DAQmxRaw data cannot be converted, this is due
%to the details on parsing this data type not being published by NI.  the
%work around is to use a VI that reads in the data file and then writes it
%to a new file.  See: https://decibel.ni.com/content/docs/DOC-32817
%
%  See Also: simpleconvertTDMS

%-------------------------------------------------------------------------
%Brad Humphreys - v1.0 2008-04-23
%ZIN Technologies
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Brad Humphreys - v1.1 2008-07-03
%ZIN Technologies
%-Added abilty for timestamp to be a raw data type, not just meta data.
%-Addressed an issue with having a default nsmaples entry for new objects.
%-Added Error trap if file name not found.
%-Corrected significant problem where it was assumed that once an object
%    existsed, it would in in every subsequent segement.  This is not true.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Grant Lohsen - v1.2 2009-11-15
%Georgia Tech Research Institute
%-Converts TDMS v2 files
%Folks, it's not pretty but I don't have time to make it pretty. Enjoy.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Jeff Sitterle - v1.3 2010-01-10
%Georgia Tech Research Institute
%Modified to return all information stored in the TDMS file to inlcude
%name, start time, start time offset, samples per read, total samples, unit
%description, and unit string.  Also provides event time and event
%description in text form
%Vast speed improvement as save was the previous longest task
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Grant Lohsen - v1.4 2009-04-15
%Georgia Tech Research Institute
%Reads file header info and stores in the Root Structure.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.5 2010-07-14
%BorgWarner Morse TEC
%-Tested in MATLAB 2007b and 2010a.
%-APPEARS to now be compatible with TDMS version 1.1 (a.k.a 4712) files;
%	although, this has not been extensively tested.  For some unknown
%	reason, the version 1.2 (4713) files process noticeably faster. I think
%	that it may be related to the 'TDSm' tag.
%-"Time Stamp" data type was not tested.
%-"Waveform" fields was not tested.
%-Fixed an error in the 'LV2MatlabDataType' function where LabView data type
%	'tdsTypeSingleFloat' was defined as MATLAB data type 'float64' .  Changed
%	to 'float32'.
%-Added error trapping.
%-Added feature to count the number of segments for pre-allocation as
%	opposed to estimating the number of segments.
%-Added option to save the data in a MAT file.
%-Fixed "invalid field name" error caused by excessive string lengths.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.6 2010-09-01
%BorgWarner Morse TEC
%-Tested in MATLAB 2010a.
%-Fixed the "Coversion to cell from char is not possible" error found
%  by Francisco Botero in version 1.5.
%-Added capability to process both fragmented or defragmented data.
%-Fixed the "field" error found by Lawrence.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Christian Buxel - V1.7 2010-09-17
%RWTH Aachen
%-Tested in Matlab2007b.
%-Added support for german umlauts (�,�,�,�,�,�,�) in 'propsName'
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Andr� R�egg - V1.7 2010-09-29
%Supercomputing Systems AG
%-Tested in MATLAB 2006a & 2010b
%-Make sure that data can be loaded correctly independently of character
% encoding set in matlab.
%-Fixed error if object consists of several segments with identical segment
% information (if rawdataindex==0, not all segments were loaded)
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.7 2010-09-30
%BorgWarner Morse TEC
%-Tested in MATLAB 2010b.
%-Added 'error trapping' to the 'fixcharformatlab' function for group and
% channel names that contain characters that are not 'A' through 'Z',
% 'a' through 'z', 0 through 9 or underscore. The characters are replaced
% with an underscore and a message is written to the Command Window
% explaining to the user what has happened and how to fix it. Only tested
% with a very limited number of "special" characters.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.8 2010-10-12
%BorgWarner Morse TEC
%-As a result of an error found by Peter Sulcs when loading data with very
% long channel names, I have re-written the sections of the function that
% creates the channel and property names that are used within the body of
% the function to make them robust against long strings and strings
% containing non-UTF8 characters.  The original channel and property
% names (no truncation or character replacement) are now retained and
% included in the output structure.  In order to implement this improvement,
% I added a 'Property' field as a structure to the 'ConvertedData' output
% structure.
%-Added a more detailed 'help' description ('doc convertTDMS') of the
% returned structure.
%-List of channel names added as an output parameter of the function.
%-Corrected an error in the time stamp converion. It was off by exactly
% 1 hour.
%-Tested in MATLAB 2010b with a limited number of diverse TDMS files.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.8 2010-10-19
%BorgWarner Morse TEC
%-Fixed an error found by Terenzio Girotto with the 'save' routine.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.8 2010-10-25
%BorgWarner Morse TEC
%-Fixed an error with channels that contain no data.  Previously, if a
% channel contained no data, then it was not passed to the output structure
% even if it did contain properties.
%-Added 'GroupNames' as an optional output variable.
%-Fixed an error with capturing the properties of the Root object
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
%Philip Top - v1.9 2010-11-09
%John Breneman
%-restructured code as function calls
%-seperated metadata reads from data reads
%-preallocated space for SegInfo with two pass file read
%-preallocated index information and defined segdataoffset for each segment
%-preallocate space for data for speedup in case of fragmented files
%-used matlab input parser instead of nargin switch
%-vectorized timestamp reads for substantial speedup
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Robert Seltzer - v1.9 2010-11-10
%BorgWarner Morse TEC
%-Fixed an error error in the 'offset' calculation for strings
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Philip Top - v1.95 2011-5-10
%Fix Bug with out of order file segments
%Fix some issues with string array reads for newer version files,
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Brad Humphreys - v1.96 2013-10-9
%Fixed problem with error catch messages themselves (interleaved, version,
%big endian) using the TDMSFileName variable which was not available
%(passed into) the getSegInfo function.  Added ability to work with
%interleaved and big endian files.  
%So function now covers:
%       -v1.0-v2.0
%       -Interleaved and Decimated Data Formats
%       -Big and Little Endian storage
% Does not work with DAQmxRawData
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Brad Humphreys - v1.97 2013-11-13
%Added information to help documentation on how to deal with DAQmxRaw Data.
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
%Brad Humphreys - v1.98 2014-5-27
%Per G. Lohsen's suggestion, added check to verify that first caharters are
% TDMs.  If not, errors out and lets user know that the selected file is
% not a TDMS file.
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%Sebastian Schwarzendahl (alias Haench) - v1.99 2014-10-23
% Added support for complex data types 
% CSG - tdsTypeComplexSingleFloat=0x08000c 
% CDB - tdsTypeComplexDoubleFloat=0x10000d)
% This feature was added in LV2013 (I believ) and produced an error in 
% the previous version of this code.
%-------------------------------------------------------------------------
%Initialize outputs
ConvertVer='1.98';    %Version number of this conversion function
ConvertedData=[];

p=inputParser();

p.addRequired('SaveConvertedFile',@(x) islogical(x)||(ismember(x,[0,1])));
p.addOptional('filename','',@(x) iscell(x)||exist(x,'file'));
p.parse(varargin{:});

filename=p.Results.filename;
SaveConvertedFile=p.Results.SaveConvertedFile;

if isempty(filename)
    
    %Prompt the user for the file
    [filename,pathname]=uigetfile({'*.tdms','All Files (*.tdms)'},'Choose a TDMS File');
    if filename==0
        return
    end
    filename=fullfile(pathname,filename);
end


if iscell(filename)
    %For a list of files
    infilename=filename;
else
    infilename=cellstr(filename);
end

for fnum=1:numel(infilename)
    
    if ~exist(infilename{fnum},'file')
        e=errordlg(sprintf('File ''%s'' not found.',infilename{fnum}),'File Not Found');
        uiwait(e)
        return
    end
    
    FileNameLong=infilename{fnum};
    [pathstr,name,ext]=fileparts(FileNameLong);
    FileNameShort=sprintf('%s%s',name,ext);
    FileNameNoExt=name;
    FileFolder=pathstr;
    
    if fnum==1
        fprintf('\n\n')
    end
    fprintf('Converting ''%s''...',FileNameShort)
    
    fid=fopen(FileNameLong);
    
    if fid==-1
        e=errordlg(sprintf('Could not open ''%s''.',FileNameLong),'File Cannot Be Opened');
        uiwait(e)
        fprintf('\n\n')
        return
    end
    
    % Build a database with segment info
    [SegInfo,NumOfSeg]=getSegInfo(fid);
    
    % Build a database with channel info
    [channelinfo SegInfo]=getChannelInfo(fid,SegInfo,NumOfSeg);
    
    % Add channel count to SegInfo
    %SegInfo=addChanCount(SegInfo,channelinfo);
    
    % Get the raw data
    ob=getData(fid,channelinfo,SegInfo);  %Returns the objects which have data.  See postProcess function (appends to all of the objects)
    fclose(fid);
    
    %Assign the outputs
    ConvertedData(fnum).FileName=FileNameShort;
    ConvertedData(fnum).FileFolder=FileFolder;
    
    ConvertedData(fnum).SegTDMSVerNum=SegInfo.vernum;
    ConvertedData(fnum).NumOfSegments=NumOfSeg;
    [ConvertedData(fnum).Data,CurrGroupNames]=postProcess(ob,channelinfo);
    
    GroupNames(fnum)={CurrGroupNames};
    
    TempChanNames={ConvertedData(fnum).Data.MeasuredData.Name};
    TempChanNames(strcmpi(TempChanNames,'Root'))=[];
    ChanNames(fnum)={sort(setdiff(TempChanNames',CurrGroupNames))};
    if SaveConvertedFile
        MATFileNameShort=sprintf('%s.mat',FileNameNoExt);
        MATFileNameLong=fullfile(FileFolder,MATFileNameShort);
        try
            save(MATFileNameLong,'ConvertedData','ConvertVer','ChanNames')
            fprintf('\n\nConversion complete (saved in ''%s'').\n\n',MATFileNameShort)
        catch exception
            fprintf('\n\nConversion complete (could not save ''%s'').\n\t%s: %s\n\n',MATFileNameShort,exception.identifier,...
                exception.message)
        end
    else
        fprintf('\n\nConversion complete.\n\n')
    end
end
ci=channelinfo;
end


%%
function [SegInfo,NumOfSeg]=getSegInfo(fid)
% Go through the whole file and build a database of the segment lead-in
% information:
%1) Count the total number of segments in the file.  (NumOfSeg)
%2) Get all of the "Lead In" Headers from all of the segements and store
%   that in the SegInfo variable:
%         SegInfo.SegStartPosn: Absolute Starting Position of Segment in file
%         SegInfo.MetaStartPosn: Absolute Starting Position of Meta Data in file
%         SegInfo.DataStartPosn: Absolute Starting Position of Raw Data in file
%         SegInfo.DataLength: Number of bytes of Data in segment
%         SegInfo.vernum: LV version number (4712 is v1.0, 4713 is v2.0)
%         SegInfo.NumChan: number of channels in this segement.  This is
%           only instatated in this function to 0.  The addChanCount function
%           updates this to the actual value later.
%
%         SegInfo.SegHasMetaData:  There is Meta Data in the Segement
%         SegInfo.SegHasRawData: There is Raw Data in the Segment
%         SegInfo.SegHasDaqMxRaw: There is DAQmxRaw Data in the Segment
%         SegInfo.SegInterleaved: 0: Contigous Data, 1: Interleaved Data
%         SegInfo.SegBigEndian:  0: Little, 1:Big (numeric, leadin, raw, and meta)
%         SegInfo.SegHasNewObjList: New object list in Segment
%
%3) While doing the above, also include error trapping for incompatibity

%Find the end of the file
fseek(fid,0,'eof');
eoff=ftell(fid);
frewind(fid);

segCnt=0;
CurrPosn=0;
LeadInByteCount=28;	%From the National Instruments web page (http://zone.ni.com/devzone/cda/tut/p/id/5696) under
%the 'Lead In' description on page 2: Counted the bytes shown in the table.
while (ftell(fid) ~= eoff)
    
    Ttag=fread(fid,1,'uint8','l');
    Dtag=fread(fid,1,'uint8','l');
    Stag=fread(fid,1,'uint8','l');
    mtag=fread(fid,1,'uint8','l');
    
    if Ttag==84 && Dtag==68 && Stag==83 && mtag==109
        %Apparently, this sequence of numbers identifies the start of a new segment.
        
        segCnt=segCnt+1;
        
        %ToC Field
        ToC=fread(fid,1,'uint32','l');
        kTocBigEndian=bitget(ToC,7);
        if kTocBigEndian
            kTocEndian='b';
        else
            kTocEndian='l';
        end
        
        %TDMS format version number
        vernum=fread(fid,1,'uint32',kTocEndian);
        
        %From the National Instruments web page (http://zone.ni.com/devzone/cda/tut/p/id/5696) under the 'Lead In'
        %description on page 2:
        %The next eight bytes (64-bit unsigned integer) describe the length of the remaining segment (overall length of the
        %segment minus length of the lead in). If further segments are appended to the file, this number can be used to
        %locate the starting point of the following segment. If an application encountered a severe problem while writing
        %to a TDMS file (crash, power outage), all bytes of this integer can be 0xFF. This can only happen to the last
        %segment in a file.
        nlen=fread(fid,1,'uint64',kTocEndian);
        if (nlen>2^63)
            break;
        else
            
            segLength=nlen;
        end
        TotalLength=segLength+LeadInByteCount;
        CurrPosn=CurrPosn+TotalLength;
        
        status=fseek(fid,CurrPosn,'bof');		%Move to the beginning position of the next segment
        if (status<0)
            warning('file glitch');
            break;
        end
    else  %TDSm should be the first charaters in a tdms file.  If not there, error out to stop hunting.
        fclose(fid);
        error('Unable to find TDSm tag. This may not be a tdms file, or you forgot to add the .tdms extension to the filename and are reading the wrong file');
        
    end
    
end

frewind(fid);

CurrPosn=0;
SegInfo.SegStartPosn=zeros(segCnt,1);
SegInfo.MetaStartPosn=zeros(segCnt,1);
SegInfo.DataStartPosn=zeros(segCnt,1);
SegInfo.vernum=zeros(segCnt,1);
SegInfo.DataLength=zeros(segCnt,1);
SegInfo.NumChan=zeros(segCnt,1);

SegInfo.SegHasMetaData=false(segCnt,1);
SegInfo.SegHasRawData=false(segCnt,1);
SegInfo.SegHasDaqMxRaw=false(segCnt,1);
SegInfo.SegInterleaved=false(segCnt,1);
SegInfo.SegBigEndian=false(segCnt,1);
SegInfo.SegHasNewObjList=false(segCnt,1);
segCnt=0;


while (ftell(fid) ~= eoff)
    
    Ttag=fread(fid,1,'uint8','l');
    Dtag=fread(fid,1,'uint8','l');
    Stag=fread(fid,1,'uint8','l');
    mtag=fread(fid,1,'uint8','l');
    
    if Ttag==84 && Dtag==68 && Stag==83 && mtag==109
        %Apparently, this sequence of numbers identifies the start of a new segment.
        %Leaving the above comment in, because it reflects that state of
        %the NI documenation on TDMS files when the contributers first started
        %developing this code. 
        
        segCnt=segCnt+1;
        
        if segCnt==1
            StartPosn=0;
        else
            StartPosn=CurrPosn;
        end
        
        %ToC Field
        ToC=fread(fid,1,'uint32','l');
        kTocBigEndian=bitget(ToC,7);
        kTocMetaData=bitget(ToC,2);
        kTocNewObjectList=bitget(ToC,3);
        kTocRawData=bitget(ToC,4);
        kTocDaqMxRawData=bitget(ToC,8);
        kTocInterleavedData=bitget(ToC,6);
        
        if kTocBigEndian
            kTocEndian='b';
        else
            kTocEndian='l';
        end
        
        %         if kTocInterleavedData
        %             error([sprintf(['\n Seqment %.0f of the above file has interleaved data which is not supported with this '...
        %                 'function. '],segCnt),'Interleaved Data Not Supported']);
        %             fclose(fid);
        %         end
        
%         if kTocBigEndian
%             error(sprintf(['\n Seqment %.0f of the above file uses the big-endian data format which is not supported '...
%                 'with this function. '],segCnt),'Big-Endian Data Format Not Supported');
%             fclose(fid);
%         end
        
        if kTocDaqMxRawData
            error(sprintf(['\n Seqment %.0f of the above file contains data in the DAQmxRaw NI datatype format which is not supported '...
                'with this function. See help documentation in convertTDMS.m for how to fix this. '],segCnt),'DAQmxRawData Format Not Supported');
            fclose(fid);
        end

        %TDMS format version number
        vernum=fread(fid,1,'uint32',kTocEndian);
        if ~ismember(vernum,[4712,4713])
            error(sprintf(['\n Seqment %.0f of the above file used LabView TDMS file format version %.0f which is not '...
                'supported with this function (%s.m).'],segCnt,vernum),...
                'TDMS File Format Not Supported');
            fclose(fid);
        end
        
        %From the National Instruments web page (http://zone.ni.com/devzone/cda/tut/p/id/5696) under the 'Lead In'
        %description on page 2:
        %The next eight bytes (64-bit unsigned integer) describe the length of the remaining segment (overall length of the
        %segment minus length of the lead in). If further segments are appended to the file, this number can be used to
        %locate the starting point of the following segment. If an application encountered a severe problem while writing
        %to a TDMS file (crash, power outage), all bytes of this integer can be 0xFF. This can only happen to the last
        %segment in a file.
        segLength=fread(fid,1,'uint64',kTocEndian);
        metaLength=fread(fid,1,'uint64',kTocEndian);
        if (segLength>2^63)
            fseek(fid,0,'eof');
            flen=ftell(fid);
            segLength=flen-LeadInByteCount-TotalLength;
            TotalLength=segLength+LeadInByteCount;
        else
            TotalLength=segLength+LeadInByteCount;
            CurrPosn=CurrPosn+TotalLength;
            fseek(fid,CurrPosn,'bof');		%Move to the beginning position of the next segment
        end
        
        
        SegInfo.SegStartPosn(segCnt)=StartPosn;
        SegInfo.MetaStartPosn(segCnt)=StartPosn+LeadInByteCount;
        SegInfo.DataStartPosn(segCnt)=SegInfo.MetaStartPosn(segCnt)+metaLength;
        SegInfo.DataLength(segCnt)=segLength-metaLength;
        SegInfo.vernum(segCnt)=vernum;
        
        
        SegInfo.SegHasMetaData(segCnt)=kTocMetaData;
        SegInfo.SegHasRawData(segCnt)=kTocRawData;
        SegInfo.SegHasDaqMxRaw(segCnt)=kTocDaqMxRawData;
        SegInfo.SegInterleaved(segCnt)=kTocInterleavedData;
        SegInfo.SegBigEndian(segCnt)=kTocBigEndian;
        SegInfo.SegHasNewObjList(segCnt)=kTocNewObjectList;
        
        
    end
    
end
NumOfSeg=segCnt;
end


%%
function [index SegInfo]=getChannelInfo(fid,SegInfo,NumOfSeg)
%Loop through the segements and get all of the object information.

% name:  Short name such as Object3
% long_name: The path directory form of the object name
% rawdatacount: number of segments that have raw data for this object
% datastartindex:  Absolute position in file of the begining of all raw
%       data for the segment.  Add the rawdata offset to get to this object's
%       start point.
% arrayDim:  array dimension of raw data (for now should always be one as
%       NI does not support multi-dimension
% nValues:  number of values of raw data in segment
% byteSize: number of bytes for string/char data
% index:  segment numbers that contain raw data for this object
% rawdataoffset: offset from datastartindex for the begining of raw data
%       for this object
% multiplier: As part of LV's optimization, it will appenend raw data writes to the
%       TDMS file when meta data does not change, but forget to update the
%       nValues.  multiplier is the number of times the base pattern
%       repeats.
% skip: When multiple raw data writes are appended, this is the number of
%   bytes between the end of a channel in one block to the begining of that channel in
%   the next block.
% dataType:  The data type for this object. See LV2MatlabDataType function.
% datasize:  Number of bytes for each raw data entry.
% Property Structures:  Structure containg properties.


%Initialize variables for the file conversion
index=struct();
objOrderList={};


for segCnt=1:NumOfSeg
    
    %Go to the segment starting position of the segment
    fseek(fid,SegInfo.SegStartPosn(segCnt)+28,'bof');
    % +28 bytes: TDSm (4) + Toc (4) + segVer# (4) + segLength (8) + metaLength (8)
    
    %segVersionNum=SegInfo.vernum(segCnt);
    kTocMetaData=SegInfo.SegHasMetaData(segCnt);
    kTocNewObjectList=SegInfo.SegHasNewObjList(segCnt);
    kTocRawData=SegInfo.SegHasRawData(segCnt);
    kTocInterleavedData=SegInfo.SegInterleaved(segCnt);
    kTocBigEndian=SegInfo.SegBigEndian(segCnt);
    
    if kTocBigEndian
        kTocEndian='b';
    else
        kTocEndian='l';
    end
    
    %% Process Meta Data
    
    %If the object list from the last segment should be used....
    if (kTocNewObjectList==0)
        fnm=fieldnames(index);   %Get a list of the objects/channels to loop through
        for kk=1:length(fnm)
            ccnt=index.(fnm{kk}).rawdatacount;
            if (ccnt>0)   %If there is raw data info in the previous segement, copy it into the new segement
                if (index.(fnm{kk}).index(ccnt)==segCnt-1)
                    ccnt=ccnt+1;
                    index.(fnm{kk}).rawdatacount=ccnt;
                    index.(fnm{kk}).datastartindex(ccnt)=SegInfo.DataStartPosn(segCnt);
                    index.(fnm{kk}).arrayDim(ccnt)=index.(fnm{kk}).arrayDim(ccnt-1);
                    index.(fnm{kk}).nValues(ccnt)=index.(fnm{kk}).nValues(ccnt-1);
                    index.(fnm{kk}).byteSize(ccnt)=index.(fnm{kk}).byteSize(ccnt-1);
                    index.(fnm{kk}).index(ccnt)=segCnt;
                    index.(fnm{kk}).rawdataoffset(ccnt)=index.(fnm{kk}).rawdataoffset(ccnt-1);
                    SegInfo.NumChan(segCnt)=SegInfo.NumChan(segCnt)+1;
                end
            end
        end
    end
    
    
    %If there is Meta data in the segement
    if kTocMetaData
        numObjInSeg=fread(fid,1,'uint32',kTocEndian);
        if (kTocNewObjectList)
            objOrderList=cell(numObjInSeg,1);
        end
        for q=1:numObjInSeg
            
            obLength=fread(fid,1,'uint32',kTocEndian);						    %Get the length of the objects name
            ObjName=convertToText(fread(fid,obLength,'uint8','l'))';	%Get the objects name
            
            if strcmp(ObjName,'/')
                long_obname='Root';
            else
                long_obname=ObjName;
                
                %Delete any apostrophes.  If the first character is a slash (forward or backward), delete it too.
                long_obname(strfind(long_obname,''''))=[];
                if strcmpi(long_obname(1),'/') || strcmpi(long_obname(1),'\')
                    long_obname(1)=[];
                end
            end
            newob=0;
            %Create object's name.  Use a generic field name to avoid issues with strings that are too long and/or
            %characters that cannot be used in MATLAB variable names.  The actual channel name is retained for the final
            %output structure.
            if exist('ObjNameList','var')
                %Check to see if the object already exists
                NameIndex=find(strcmpi({ObjNameList.LongName},long_obname)==1,1,'first');
                if isempty(NameIndex)
                    newob=1;
                    %It does not exist, so create the generic name field name
                    ObjNameList(end+1).FieldName=sprintf('Object%.0f',numel(ObjNameList)+1);
                    ObjNameList(end).LongName=long_obname;
                    NameIndex=numel(ObjNameList);
                end
            else
                %No objects exist, so create the first one using a generic name field name.
                ObjNameList.FieldName='Object1';
                ObjNameList.LongName=long_obname;
                NameIndex=1;
                newob=1;
            end
            %Assign the generic field name
            obname=ObjNameList(NameIndex).FieldName;
            
            %Create the 'index' structure
            if (~isfield(index,obname))
                index.(obname).name=obname;
                index.(obname).long_name=long_obname;
                index.(obname).rawdatacount=0;
                index.(obname).datastartindex=zeros(NumOfSeg,1);
                index.(obname).arrayDim=zeros(NumOfSeg,1);
                index.(obname).nValues=zeros(NumOfSeg,1);
                index.(obname).byteSize=zeros(NumOfSeg,1);
                index.(obname).index=zeros(NumOfSeg,1);
                index.(obname).rawdataoffset=zeros(NumOfSeg,1);
                index.(obname).multiplier=ones(NumOfSeg,1);
                index.(obname).skip=zeros(NumOfSeg,1);
            end
            if (kTocNewObjectList)
                objOrderList{q}=obname;
            else
                if ~ismember(obname,objOrderList)
                    objOrderList{end+1}=obname;
                end
            end
            %Get the raw data Index
            rawdataindex=fread(fid,1,'uint32',kTocEndian);
            
            if rawdataindex==0
                if segCnt==0
                    e=errordlg(sprintf('Seqment %.0f within ''%s'' has ''rawdataindex'' value of 0 (%s.m).',segCnt,...
                        TDMSFileNameShort,mfilename),'Incorrect ''rawdataindex''');
                    uiwait(e)
                end
                if kTocRawData
                    if (kTocNewObjectList)
                        ccnt=index.(obname).rawdatacount+1;
                    else
                        ccnt=index.(obname).rawdatacount;
                    end
                    index.(obname).rawdatacount=ccnt;
                    index.(obname).datastartindex(ccnt)=SegInfo.DataStartPosn(segCnt);
                    index.(obname).arrayDim(ccnt)=index.(obname).arrayDim(ccnt-1);
                    index.(obname).nValues(ccnt)=index.(obname).nValues(ccnt-1);
                    index.(obname).byteSize(ccnt)=index.(obname).byteSize(ccnt-1);
                    index.(obname).index(ccnt)=segCnt;
                    SegInfo.NumChan(segCnt)=SegInfo.NumChan(segCnt)+1;
                end
            elseif rawdataindex+1==2^32
                %Objects raw data index matches previous index - no changes.  The root object will always have an
                %'FFFFFFFF' entry
                if strcmpi(index.(obname).long_name,'Root')
                    index.(obname).rawdataindex=0;
                else
                    %Need to account for the case where an object (besides the 'root') is added that has no data but reports
                    %using previous.
                    if newob
                        index.(obname).rawdataindex=0;
                    else
                        if kTocRawData
                            if (kTocNewObjectList)
                                ccnt=index.(obname).rawdatacount+1;
                            else
                                ccnt=index.(obname).rawdatacount;
                            end
                            index.(obname).rawdatacount=ccnt;
                            index.(obname).datastartindex(ccnt)=SegInfo.DataStartPosn(segCnt);
                            index.(obname).arrayDim(ccnt)=index.(obname).arrayDim(ccnt-1);
                            index.(obname).nValues(ccnt)=index.(obname).nValues(ccnt-1);
                            index.(obname).byteSize(ccnt)=index.(obname).byteSize(ccnt-1);
                            index.(obname).index(ccnt)=segCnt;
                            SegInfo.NumChan(segCnt)=SegInfo.NumChan(segCnt)+1;
                        end
                    end
                end
            else
                %Get new object information
                if (kTocNewObjectList)
                    ccnt=index.(obname).rawdatacount+1;
                else
                    ccnt=index.(obname).rawdatacount;
                    if (ccnt==0)
                        ccnt=1;
                    end
                end
                index.(obname).rawdatacount=ccnt;
                index.(obname).datastartindex(ccnt)=SegInfo.DataStartPosn(segCnt);
                %index(end).lenOfIndexInfo=fread(fid,1,'uint32');
                
                index.(obname).dataType=fread(fid,1,'uint32',kTocEndian);
                if (index.(obname).dataType~=32)
                    index.(obname).datasize=getDataSize(index.(obname).dataType);
                end
                index.(obname).arrayDim(ccnt)=fread(fid,1,'uint32',kTocEndian);
                index.(obname).nValues(ccnt)=fread(fid,1,'uint64',kTocEndian);
                index.(obname).index(ccnt)=segCnt;
                SegInfo.NumChan(segCnt)=SegInfo.NumChan(segCnt)+1;
                if index.(obname).dataType==32
                    %Datatype is a string
                    index.(obname).byteSize(ccnt)=fread(fid,1,'uint64',kTocEndian);
                else
                    index.(obname).byteSize(ccnt)=0;
                end
                
            end
            
            %Get the properties
            numProps=fread(fid,1,'uint32',kTocEndian);
            if numProps>0
                
                if isfield(index.(obname),'PropertyInfo')
                    PropertyInfo=index.(obname).PropertyInfo;
                else
                    clear PropertyInfo
                end
                for p=1:numProps
                    propNameLength=fread(fid,1,'uint32',kTocEndian);
                    switch 1
                        case 1
                            PropName=fread(fid,propNameLength,'*uint8','l')';
                            PropName=native2unicode(PropName,'UTF-8');
                        case 2
                            PropName=fread(fid,propNameLength,'uint8=>char','l')';
                        otherwise
                    end
                    propsDataType=fread(fid,1,'uint32',kTocEndian);
                    
                    %Create property's name.  Use a generic field name to avoid issues with strings that are too long and/or
                    %characters that cannot be used in MATLAB variable names.  The actual property name is retained for the
                    %final output structure.
                    if exist('PropertyInfo','var')
                        %Check to see if the property already exists for this object.  Need to get the existing 'PropertyInfo'
                        %structure for this object.  The 'PropertyInfo' structure is not necessarily the same for every
                        %object in the data file.
                        PropIndex=find(strcmpi({PropertyInfo.Name},PropName));
                        if isempty(PropIndex)
                            %Is does not exist, so create the generic name field name
                            propExists=false;
                            PropIndex=numel(PropertyInfo)+1;
                            propsName=sprintf('Property%.0f',PropIndex);
                            PropertyInfo(PropIndex).Name=PropName;
                            PropertyInfo(PropIndex).FieldName=propsName;
                        else
                            %Assign the generic field name
                            propExists=true;
                            propsName=PropertyInfo(PropIndex).FieldName;
                        end
                    else
                        %No properties exist for this object, so create the first one using a generic name field name.
                        propExists=false;
                        PropIndex=p;
                        propsName=sprintf('Property%.0f',PropIndex);
                        PropertyInfo(PropIndex).Name=PropName;
                        PropertyInfo(PropIndex).FieldName=propsName;
                    end
                    
                    dataExists=isfield(index.(obname),'data');
                    
                    %Get the number of samples already found and in the object
                    if dataExists
                        nsamps=index.(obname).nsamples+1;
                    else
                        nsamps=0;
                    end
                    
                    if propsDataType==32 %String data type
                        PropertyInfo(PropIndex).DataType='String';
                        propsValueLength=fread(fid,1,'uint32',kTocEndian);
                        propsValue=convertToText(fread(fid,propsValueLength,'uint8=>char',kTocEndian))';
                        if propExists
                            if isfield(index.(obname).(propsName),'cnt')
                                cnt=index.(obname).(propsName).cnt+1;
                            else
                                cnt=1;
                            end
                            index.(obname).(propsName).cnt=cnt;
                            index.(obname).(propsName).value{cnt}=propsValue;
                            index.(obname).(propsName).samples(cnt)=nsamps;
                        else
                            if strcmp(index.(obname).long_name,'Root')
                                %Header data
                                index.(obname).(propsName).name=index.(obname).long_name;
                                index.(obname).(propsName).value={propsValue};
                                index.(obname).(propsName).cnt=1;
                            else
                                index.(obname).(propsName).name=PropertyInfo(PropIndex).Name;
                                index.(obname).(propsName).datatype=PropertyInfo(PropIndex).DataType;
                                index.(obname).(propsName).cnt=1;
                                index.(obname).(propsName).value=cell(nsamps,1);		%Pre-allocation
                                index.(obname).(propsName).samples=zeros(nsamps,1);	%Pre-allocation
                                if iscell(propsValue)
                                    index.(obname).(propsName).value(1)=propsValue;
                                else
                                    index.(obname).(propsName).value(1)={propsValue};
                                end
                                index.(obname).(propsName).samples(1)=nsamps;
                            end
                        end
                    else %Numeric data type
                        if propsDataType==68 %Timestamp
                            PropertyInfo(PropIndex).DataType='Time';
                            %Timestamp data type
                            
                            if kTocBigEndian
                                tsec=fread(fid,1,'uint64','b')+fread(fid,1,'uint64','b')/2^64;	%time since Jan-1-1904 in seconds
                            else
                                tsec=fread(fid,1,'uint64','l')/2^64+fread(fid,1,'uint64','l');	%time since Jan-1-1904 in seconds
                            end
                            %tsec=fread(fid,1,'uint64',kTocEndian)/2^64+fread(fid,1,'uint64',kTocEndian);	%time since Jan-1-1904 in seconds
                            %R. Seltzer: Not sure why '5/24' (5 hours) is subtracted from the time value.  That's how it was
                            %coded in the original function I downloaded from MATLAB Central.  But I found it to be 1 hour too
                            %much.  So, I changed it to '4/24'.
                            %propsValue=tsec/86400+695422-5/24;	%/864000 convert to days; +695422 days from Jan-0-0000 to Jan-1-1904
                            propsValue=tsec/86400+695422-4/24;	%/864000 convert to days; +695422 days from Jan-0-0000 to Jan-1-1904
                        else  %Numeric
                            PropertyInfo(PropIndex).DataType='Numeric';
                            matType=LV2MatlabDataType(propsDataType);
                            if strcmp(matType,'Undefined')
                                e=errordlg(sprintf('No MATLAB data type defined for a ''Property Data Type'' value of ''%.0f''.',...
                                    propsDataType),'Undefined Property Data Type');
                                uiwait(e)
                                fclose(fid);
                                return
                            end
                            if strcmp(matType,'uint8=>char')
                                propsValue=convertToText(fread(fid,1,'uint8',kTocEndian));
                            else
                                propsValue=fread(fid,1,matType,kTocEndian);
                            end
                        end
                        if propExists
                            cnt=index.(obname).(propsName).cnt+1;
                            index.(obname).(propsName).cnt=cnt;
                            index.(obname).(propsName).value(cnt)=propsValue;
                            index.(obname).(propsName).samples(cnt)=nsamps;
                        else
                            index.(obname).(propsName).name=PropertyInfo(PropIndex).Name;
                            index.(obname).(propsName).datatype=PropertyInfo(PropIndex).DataType;
                            index.(obname).(propsName).cnt=1;
                            index.(obname).(propsName).value=NaN(nsamps,1);				%Pre-allocation
                            index.(obname).(propsName).samples=zeros(nsamps,1);		%Pre-allocation
                            index.(obname).(propsName).value(1)=propsValue;
                            index.(obname).(propsName).samples(1)=nsamps;
                        end
                    end
                    
                end	%'end' for the 'Property' loop
                index.(obname).PropertyInfo=PropertyInfo;
                
            end
            
        end	%'end' for the 'Objects' loop
    end
    
 


    
    
    %Address Decimation and Interleaving
    if (kTocRawData)
        
        singleSegDataSize=0;
        rawDataBytes=0;
        chanBytes=0;
        rawDataOffset=0;
        
        for kk=1:numel(objOrderList)
            obname=objOrderList{kk};
            ccnt=hasRawDataInSeg(segCnt,index.(obname));
            if ccnt>0   %If segement has raw data
                index.(obname).rawdataoffset(ccnt)=rawDataOffset;
                if index.(obname).dataType==32 %Datatype is a string
                    rawDataBytes=index.(obname).byteSize(ccnt);
                else
                    rawDataBytes=index.(obname).nValues(ccnt)*index.(obname).datasize;
                    if kTocInterleavedData
                        chanBytes=index.(obname).datasize;
                    else
                        chanBytes=rawDataBytes;
                    end
                    
                end
                rawDataOffset=rawDataOffset+chanBytes;
                singleSegDataSize=singleSegDataSize+rawDataBytes;
            end
        end
        
        
        
        
        %Calculate the offset for each segment.  The offset is the amount
        %of bytes for one non appened (non optimized) segement
%         for kk=1:numel(objOrderList)
%             obname=objOrderList{kk};
%             if hasRawDataInSeg(segCnt,index.(obname))   %If segement has raw data
%                 index.(obname).rawdataoffset(ccnt)=rawdataoffset;      %This will set the offset correctly for dec data.
%                 
%                 %Update the singleSegDataSize value for the next object
%                 if index.(obname).dataType==32 %Datatype is a string
%                     singleSegDataSize=singleSegDataSize+index.(obname).byteSize(ccnt);
%                 else
%                     singleSegDataSize=singleSegDataSize+index.(obname).nValues(ccnt)*index.(obname).datasize;
%                 end
%                 
%                 if kTocInterleavedData
%                     rawdataoffset=
%                 else
%                     rawdataoffset=singleSegDataSize;
%                 end
%             end
%         end
%         

                    
                    
        

        %As part of LV's optimization, it will append back to back
        %segements into one segement (when nothing changes in meta data).
        if (singleSegDataSize~=SegInfo.DataLength(segCnt))         %Multiple appended raw segement (offset did not grow to be greater than the DataLength)
            numAppSegs=floor(SegInfo.DataLength(segCnt)/singleSegDataSize);  %Number of appened (optimized segements)
            for kk=1:numel(objOrderList)   %Loop through all the objects
                obname=objOrderList{kk};
                ccnt=hasRawDataInSeg(segCnt,index.(obname));
                if ccnt>0   %If segement has raw data
                    if kTocInterleavedData
                        if index.(obname).dataType==32 %Datatype is a string
                            error('Interleaved string channels are not supported.')
                        end
                        index.(obname).multiplier(ccnt)=numAppSegs*index.(obname).nValues(ccnt);
                        index.(obname).skip(ccnt)=singleSegDataSize/index.(obname).nValues(ccnt)-index.(obname).datasize;
                        index.(obname).nValues(ccnt)=1;
                    else  %Decimated Data
                        index.(obname).multiplier(ccnt)=numAppSegs;
                        if index.(obname).dataType==32 %Datatype is a string
                            index.(obname).skip(ccnt)=singleSegDataSize-index.(obname).byteSize(ccnt);
                        else
                            index.(obname).skip(ccnt)=singleSegDataSize-index.(obname).nValues(ccnt)*index.(obname).datasize;
                        end
                    end
                end
                
            end
        else   %If single segement
            if kTocInterleavedData
                for kk=1:numel(objOrderList)   %Loop through all the objects
                    obname=objOrderList{kk};
                    ccnt=hasRawDataInSeg(segCnt,index.(obname));
                    if ccnt>0  %If segement has raw data
                        if (index.(obname).index(ccnt)==segCnt)   %If the object has rawdata in the current segment
                            if index.(obname).dataType==32 %Datatype is a string
                               error('Interleaved string channels are not supported.')  
                            end
                            index.(obname).multiplier(ccnt)=index.(obname).nValues(ccnt);
                            index.(obname).skip(ccnt)=singleSegDataSize/index.(obname).nValues(ccnt)-index.(obname).datasize;
                            index.(obname).nValues(ccnt)=1;
                        end
                    end
                end
            end
        end
        

        
%         if (offset~=SegInfo.DataLength(segCnt))         %If the offset grew to be greater than the DataLength (from Meta Data)
%             multiplier=floor(SegInfo.DataLength(segCnt)/offset);
%             for kk=1:numel(objOrderList)   %Loop through the objects 
%                 obname=objOrderList{kk};
%                 ccnt=index.(obname).rawdatacount;
%                 if ccnt>0
%                     index.(obname).multiplier(segCnt)=multiplier;
%                     if index.(obname).dataType==32 %Datatype is a string
%                         index.(obname).skip(ccnt)=offset-index.(obname).byteSize(ccnt);
%                     else
%                         index.(obname).skip(ccnt)=offset-index.(obname).nValues(ccnt)*index.(obname).datasize;
%                     end
%                 end
%             end
%             
%         end
        
        aa=1;
%         %Now adjust multiplier and skip if the data is interleaved
%         if kTocInterleavedData
%             if muliplier>0  %Muliple raw data segements appened
%                 
%             else   %Single raw segement
%         
%             end
%         end
        
    end
    
end
%clean up the index if it has to much data
fnm=fieldnames(index);
for kk=1:numel(fnm)
    ccnt=index.(fnm{kk}).rawdatacount+1;
    
    index.(fnm{kk}).datastartindex(ccnt:end)=[];
    index.(fnm{kk}).arrayDim(ccnt:end)=[];
    index.(fnm{kk}).nValues(ccnt:end)=[];
    index.(fnm{kk}).byteSize(ccnt:end)=[];
    index.(fnm{kk}).index(ccnt:end)=[];
    index.(fnm{kk}).rawdataoffset(ccnt:end)=[];
    index.(fnm{kk}).multiplier(ccnt:end)=[];
    index.(fnm{kk}).skip(ccnt:end)=[];
    
end
end


%%
function ob=getData(fid,index,SegInfo)
%Using the file id (fid) and the index database, get the raw data.
%Returns the data in the ob structure.  The fields in the structure are the
%generic object names:
%   ob.Object3.data - raw data
%   ob.Object3.nsamples - number of samples
%
%   Note that not all of the objects in the index may not be in ob as it
%   contains only those objects which have raw data.

ob=[];
fnm=fieldnames(index);   %Get the object names
for kk=1:length(fnm)    %Loop through objects
    id=index.(fnm{kk});
    nsamples=sum(id.nValues.*id.multiplier);
    if id.rawdatacount>0  %Only work with channels with raw data
        cname=id.name;
        ob.(cname).nsamples=0;
        
        %Initialize the data matrix
        if id.dataType==32
            ob.(cname).data=cell(nsamples,1);
        else
            ob.(cname).data=zeros(nsamples,1);
        end
        
        for rr=1:id.rawdatacount
            %Loop through each of the segments and read the raw data
            
            %Move to the raw data start position
            fseek(fid,id.datastartindex(rr)+id.rawdataoffset(rr),'bof');
            
            nvals=id.nValues(rr);
            
            segmentNum=index.(cname).index(rr);
            segInterleaved=SegInfo.SegInterleaved(segmentNum);
            
            if SegInfo.SegBigEndian(segmentNum)
                kTocEndian='b';
            else
                kTocEndian='l';
            end
            
            numChan=SegInfo.NumChan(segmentNum);
            
            if nvals>0  %If there is data in this segement
                
                switch id.dataType
                    
                    case 32		%String
                        %From the National Instruments web page (http://zone.ni.com/devzone/cda/tut/p/id/5696) under the
                        %'Raw Data' description on page 4:
                        %String type channels are preprocessed for fast random access. All strings are concatenated to a
                        %contiguous piece of memory. The offset of the first character of each string in this contiguous piece
                        %of memory is stored to an array of unsigned 32-bit integers. This array of offset values is stored
                        %first, followed by the concatenated string values. This layout allows client applications to access
                        %any string value from anywhere in the file by repositioning the file pointer a maximum of three times
                        %and without reading any data that is not needed by the client.
                        data=cell(1,nvals*id.multiplier(rr));	%Pre-allocation
                        for mm=1:id.multiplier(rr)
                            StrOffsetArray=fread(fid,nvals,'uint32','l');
                            for dcnt=1:nvals
                                if dcnt==1
                                    StrLength=StrOffsetArray(dcnt);
                                else
                                    StrLength=StrOffsetArray(dcnt)-StrOffsetArray(dcnt-1);
                                end
                                data{1,dcnt+(mm-1)*nvals}=char(convertToText(fread(fid,StrLength,'uint8=>char','l'))');
                            end
                            if (id.multiplier(rr)>1)&&(id.skip(rr)>0)
                                fseek(fid,id.skip(rr),'cof');
                            end
                        end
                        cnt=nvals*id.multiplier(rr);
                        
                    case 68		%Timestamp
                        %data=NaN(1,nvals);	%Pre-allocation
                        data=NaN(1,nvals*id.multiplier(rr));
                        for mm=1:id.multiplier(rr)
                            dn=fread(fid,2*nvals,'uint64',kTocEndian);
                            tsec=dn(1:2:end)/2^64+dn(2:2:end);
                            data((mm-1)*nvals+1:(mm)*nvals)=tsec/86400+695422-4/24;
                            fseek(fid,id.skip(rr),'cof');
                        end
                        %{
						for dcnt=1:nvals
							tsec=fread(fid,1,'uint64')/2^64+fread(fid,1,'uint64');   %time since Jan-1-1904 in seconds
							%R. Seltzer: Not sure why '5/24' (5 hours) is subtracted from the time value.  That's how it was
							%coded in the original function I downloaded from MATLAB Central.  But I found it to be 1 hour too
							%much.  So, I changed it to '4/24'.
							data(1,dcnt)=tsec/86400+695422-5/24;	%/864000 convert to days; +695422 days from Jan-0-0000 to Jan-1-1904
							data(1,dcnt)=tsec/86400+695422-4/24;	%/864000 convert to days; +695422 days from Jan-0-0000 to Jan-1-1904
						end
                        %}
                        cnt=nvals*id.multiplier(rr);
                        
                    otherwise	%Numeric
                        matType=LV2MatlabDataType(id.dataType);
                        if strcmp(matType,'Undefined')  %Bad Data types catch
                            e=errordlg(sprintf('No MATLAB data type defined for a ''Raw Data Type'' value of ''%.0f''.',...
                                id.dataType),'Undefined Raw Data Type');
                            uiwait(e)
                            fclose(fid);
                            return
                        end
                        if (id.skip(rr)>0)
                            ntype=sprintf('%d*%s',nvals,matType);
                            [data,cnt]=fread(fid,nvals*id.multiplier(rr),ntype,id.skip(rr),kTocEndian);
                            if strcmp(matType,'uint8=>char')                              
                                data=convertToText(data);
                            end
                        else
                            % Added by Haench start
                            if  (id.dataType == 524300) || (id.dataType == 1048589) % complex CDB data
                                [data,cnt]=fread(fid,2*nvals*id.multiplier(rr),matType,kTocEndian);                               
                                data= data(1:2:end)+1i*data(2:2:end);
                                cnt = cnt/2;
                            else                                
                                [data,cnt]=fread(fid,nvals*id.multiplier(rr),matType,kTocEndian);
                            end
                            % Haench end
                            % Original: [data,cnt]=fread(fid,nvals*id.multiplier(rr),matType,kTocEndian);
                        end
                end
                
                %Update the sample counter
                if isfield(ob.(cname),'nsamples')
                    ssamples=ob.(cname).nsamples;
                else
                    ssamples=0;
                end
                if (cnt>0)
                    ob.(cname).data(ssamples+1:ssamples+cnt,1)=data;
                    ob.(cname).nsamples=ssamples+cnt;
                end
            end
        end
        
    end
    
end
end




function [DataStructure,GroupNames]=postProcess(ob,index)
%Re-organize the 'ob' structure into a more user friendly format for output.


DataStructure.Root=[];
DataStructure.MeasuredData.Name=[];
DataStructure.MeasuredData.Data=[];

obFieldNames=fieldnames(index);

cntData=1;

for i=1:numel(obFieldNames)
    
    cname=obFieldNames{i};
    
    if strcmp(index.(cname).long_name,'Root')
        
        DataStructure.Root.Name=index.(cname).long_name;
        
        %Assign all the 'Property' values
        if isfield(index.(cname),'PropertyInfo')
            for p=1:numel(index.(cname).PropertyInfo)
                cfield=index.(cname).PropertyInfo(p).FieldName;
                if isfield(index.(cname).(cfield),'datatype')
                    DataType=index.(cname).(cfield).datatype;
                else
                    %ASSUME a 'string' data type
                    DataType='String';
                end
                DataStructure.Root.Property(p).Name=index.(cname).PropertyInfo(p).Name;
                
                switch DataType
                    case 'String'
                        if iscell(index.(cname).(cfield).value)
                            Value=index.(cname).(cfield).value';
                        else
                            Value=cellstr(index.(cname).(cfield).value);
                        end
                        
                    case 'Time'
                        clear Value
                        if index.(cname).(cfield).cnt==1
                            if iscell(index.(cname).(cfield).value)
                                Value=datestr(cell2mat(index.(cname).(cfield).value),'dd-mmm-yyyy HH:MM:SS');
                            else
                                Value=datestr(index.(cname).(cfield).value,'dd-mmm-yyyy HH:MM:SS');
                            end
                        else
                            Value=cell(index.(cname).(cfield).cnt,1);
                            for c=1:index.(cname).(cfield).cnt
                                if iscell(index.(cname).(cfield).value)
                                    Value(c)={datestr(cell2mat(index.(cname).(cfield).value),'dd-mmm-yyyy HH:MM:SS')};
                                else
                                    Value(c)={datestr(index.(cname).(cfield).value,'dd-mmm-yyyy HH:MM:SS')};
                                end
                            end
                        end
                        
                    case 'Numeric'
                        if isfield(index.(cname).(cfield),'cnt')
                            Value=NaN(index.(cname).(cfield).cnt,1);
                        else
                            if iscell(index.(cname).(cfield).value)
                                Value=NaN(numel(cell2mat(index.(cname).(cfield).value)),1);
                            else
                                Value=NaN(numel(index.(cname).(cfield).value),1);
                            end
                        end
                        for c=1:numel(Value)
                            if iscell(index.(cname).(cfield).value)
                                Value(c)=index.(cname).(cfield).value{c};
                            else
                                Value(c)=index.(cname).(cfield).value(c);
                            end
                        end
                    otherwise
                        e=errordlg(sprintf(['No format defined for Data Type ''%s'' in the private function ''postProcess'' '...
                            'within %s.m.'],index.(cname).(cfield).datatype,mfilename),'Undefined Property Data Type');
                        uiwait(e)
                        return
                end
                if isempty(Value)
                    DataStructure.Root.Property(p).Value=[];
                else
                    DataStructure.Root.Property(p).Value=Value;
                end
            end
        end
        
        
    end
    
    DataStructure.MeasuredData(cntData).Name=index.(cname).long_name;
    %Should only need the 'ShortName' for debugging the function
    %DataStructure.MeasuredData(cntData).ShortName=cname;
    if (isfield(ob,cname))
        if isfield(ob.(cname),'data')
            DataStructure.MeasuredData(cntData).Data=ob.(cname).data;
            %The following field is redundant because the information can be obtained from the size of the 'Data' field.
            DataStructure.MeasuredData(cntData).Total_Samples=ob.(cname).nsamples;
        else
            DataStructure.MeasuredData(cntData).Data=[];
            DataStructure.MeasuredData(cntData).Total_Samples=0;
        end
    else
        DataStructure.MeasuredData(cntData).Data=[];
        DataStructure.MeasuredData(cntData).Total_Samples=0;
    end
    
    %Assign all the 'Property' values
    if isfield(index.(cname),'PropertyInfo')
        for p=1:numel(index.(cname).PropertyInfo)
            cfield=index.(cname).PropertyInfo(p).FieldName;
            DataStructure.MeasuredData(cntData).Property(p).Name=index.(cname).(cfield).name;
            
            if strcmpi(DataStructure.MeasuredData(cntData).Property(p).Name,'Root')
                Value=index.(cname).(cfield).value;
            else
                
                switch index.(cname).(cfield).datatype
                    case 'String'
                        clear Value
                        if index.(cname).(cfield).cnt==1
                            if iscell(index.(cname).(cfield).value)
                                Value=char(index.(cname).(cfield).value);
                            else
                                Value=index.(cname).(cfield).value;
                            end
                        else
                            Value=cell(index.(cname).(cfield).cnt,1);
                            for c=1:index.(cname).(cfield).cnt
                                if iscell(index.(cname).(cfield).value)
                                    Value(c)=index.(cname).(cfield).value;
                                else
                                    Value(c)={index.(cname).(cfield).value};
                                end
                            end
                        end
                        
                    case 'Time'
                        clear Value
                        if index.(cname).(cfield).cnt==1
                            if iscell(index.(cname).(cfield).value)
                                Value=datestr(cell2mat(index.(cname).(cfield).value),'dd-mmm-yyyy HH:MM:SS');
                            else
                                Value=datestr(index.(cname).(cfield).value,'dd-mmm-yyyy HH:MM:SS');
                            end
                        else
                            Value=cell(index.(cname).(cfield).cnt,1);
                            for c=1:index.(cname).(cfield).cnt
                                if iscell(index.(cname).(cfield).value)
                                    Value(c)={datestr(cell2mat(index.(cname).(cfield).value),'dd-mmm-yyyy HH:MM:SS')};
                                else
                                    Value(c)={datestr(index.(cname).(cfield).value,'dd-mmm-yyyy HH:MM:SS')};
                                end
                            end
                        end
                        
                    case 'Numeric'
                        if isfield(index.(cname).(cfield),'cnt')
                            Value=NaN(index.(cname).(cfield).cnt,1);
                        else
                            if iscell(index.(cname).(cfield).value)
                                Value=NaN(numel(cell2mat(index.(cname).(cfield).value)),1);
                            else
                                Value=NaN(numel(index.(cname).(cfield).value),1);
                            end
                        end
                        for c=1:numel(Value)
                            if iscell(index.(cname).(cfield).value)
                                Value(c)=index.(cname).(cfield).value{c};
                            else
                                Value(c)=index.(cname).(cfield).value(c);
                            end
                        end
                        
                    otherwise
                        e=errordlg(sprintf(['No format defined for Data Type ''%s'' in the private function ''postProcess'' '...
                            'within %s.m.'],index.(cname).(cfield).datatype,mfilename),'Undefined Property Data Type');
                        uiwait(e)
                        return
                end
            end
            if isempty(Value)
                DataStructure.MeasuredData(cntData).Property(p).Value=[];
            else
                DataStructure.MeasuredData(cntData).Property(p).Value=Value;
            end
        end
    else
        DataStructure.MeasuredData(cntData).Property=[];
    end
    
    cntData = cntData + 1;
end %'end' for the 'groups/channels' loop

%Extract the Group names
GroupIndices=false(numel(DataStructure.MeasuredData),1);
for d=1:numel(DataStructure.MeasuredData)
    
    if ~strcmpi(DataStructure.MeasuredData(d).Name,'Root')
        if (DataStructure.MeasuredData(d).Total_Samples==0)
            fs=strfind(DataStructure.MeasuredData(d).Name,'/');
            if (isempty(fs))
                GroupIndices(d)=true;
            end
        end
    end
    
end
if any(GroupIndices)
    GroupNames=sort({DataStructure.MeasuredData(GroupIndices).Name})';
else
    GroupNames=[];
end

end


function SegInfo=addChanCount(SegInfo,channelinfo)
%This function determines the number of channels in each segement by
%looping through the channels in channelinfo.  It looks at their index,
%which conatins the segments numbers in which that channel has data.
%It then increments the NumChan field in the segment info database
%(SegInfo).

fnm=fieldnames(channelinfo);   %Get the channels
for ccnt=1:numel(fnm)           %Loop through the channels
    channelName=fnm{ccnt};
    ind=channelinfo.(channelName).index;   %Get the index
    for icnt=1:numel(ind)
        segNum=ind(icnt);
        SegInfo.NumChan(segNum)=SegInfo.NumChan(segNum)+1;
    end
end
end

function sz=getDataSize(LVType)
%Get the number of bytes for each LV data type. See LV2MatlabDataType.
switch(LVType)
    case 0
        sz=0;
    case {1,5,33}
        sz=1;
    case 68
        sz=16;
    case {4,8,10}  % Added 4 per Jan.
        sz=8;
    case {3,7,9}
        sz=4;
    case {2,6}
        sz=2;
    case 32
        e=errordlg('Do not call the getDataSize function for strings.  Their size is written in the data file','Error');
        uiwait(e)
        sz=NaN;
    case 11
        sz=10;
    % Added by Haench for tdsTypeComplexSingleFloat=0x08000c,tdsTypeComplexDoubleFloat=0x10000d,
    case 524300
        sz=8;
    case 1048589
        sz=16;
    % end add haench
    otherwise
        error('LVData type %d is not defined',LVType)
end
end




function matType=LV2MatlabDataType(LVType)
%Cross Refernce Labview TDMS Data type to MATLAB
switch LVType
    case 0   %tdsTypeVoid
        matType='';
    case 1   %tdsTypeI8
        matType='int8';
    case 2   %tdsTypeI16
        matType='int16';
    case 3   %tdsTypeI32
        matType='int32';
    case 4   %tdsTypeI64
        matType='int64';
    case 5   %tdsTypeU8
        matType='uint8';
    case 6   %tdsTypeU16
        matType='uint16';
    case 7   %tdsTypeU32
        matType='uint32';
    case 8   %tdsTypeU64
        matType='uint64';
    case 9  %tdsTypeSingleFloat
        matType='single';
    case 10  %tdsTypeDoubleFloat
        matType='double';
    case 11  %tdsTypeExtendedFloat
        matType='10*char';
    case 25 %tdsTypeSingleFloat with units
        matType='Undefined';
    case 26 %tdsTypeDoubleFloat with units
        matType='Undefined';
    case 27 %tdsTypeextendedFloat with units
        matType='Undefined';
    case 32  %tdsTypeString
        matType='uint8=>char';
    case 33  %tdsTypeBoolean
        matType='bit1';
    case 68  %tdsTypeTimeStamp
        matType='2*int64';
    % Added by Haench for tdsTypeComplexSingleFloat=0x08000c,tdsTypeComplexDoubleFloat=0x10000d,
   case 524300
        matType='single';
    case 1048589
        matType='double';
    % end add haench
    otherwise
        matType='Undefined';
end

end

function ccnt=hasRawDataInSeg(segCnt,ob)
%Function to check and see if a channel has raw data in a particulr
%segment.  If it does, return the index of index (ccnt).  If not present,
%return ccn=0

indexList=ob.index;
ccnt=find(indexList==segCnt);
if isempty(ccnt)
    ccnt=0;
else
    ccnt=ccnt(1);
end
end

function text=convertToText(bytes)
%Convert numeric bytes to the character encoding localy set in MATLAB (TDMS uses UTF-8)
text=native2unicode(bytes,'UTF-8');
end
