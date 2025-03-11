function H = hatchfill2(A,varargin)
% HATCHFILL2 Hatching and speckling of patch objects
%   HATCHFILL2(A) fills the patch(es) with handle(s) A. A can be a vector
%   of handles or a single handle. If A is a vector, then all objects of A
%   should be part of the same group for predictable results. The hatch
%   consists of black lines angled at 45 degrees at 40 hatching lines over
%   the axis span with no color filling between the lines.
%
%   A can be handles of patch or hggroup containing patch objects for
%   Pre-R2014b release. For HG2 releases, 'bar' and 'contour' objects are
%   also supported.
%
%   Hatching line object is actively formatted. If A, axes, or figure size
%   is modified, the hatching line object will be updated accordingly to
%   maintain the specified style.
%
%   HATCHFILL2(A,STYL) applies STYL pattern with default paramters. STYL
%   options are:
%      'single'     single lines (the default)
%      'cross'      double-crossed hatch
%      'speckle'    speckling inside the patch boundary
%      'outspeckle' speckling outside the boundary
%      'fill'       no hatching
%
%   HATCHFILL2(A,STYL,Option1Name,Option1Value,...) to customize the
%   hatching pattern
%
%       Name       Description
%      --------------------------------------------------------------------
%      HatchStyle       Hatching pattern (same effect as STYL argument)
%      HatchAngle       Angle of hatch lines in degrees (45)
%      HatchDensity     Number of hatch lines between axis limits
%      HatchOffset      Offset hatch lines in pixels (0)
%      HatchColor       Color of the hatch lines, 'auto' sets it to the
%                       EdgeColor of A
%      HatchLineStyle   Hatch line style
%      HatchLineWidth   Hatch line width
%      SpeckleWidth         Width of speckling region in pixels (7)
%      SpeckleDensity       Density of speckle points (1)
%      SpeckleMarkerStyle   Speckle marker style
%      SpeckleFillColor     Speckle fill color
%      HatchVisible     [{'auto'}|'on'|'off'] sets visibility of the hatch
%                       lines. If 'auto', Visibile option is synced to
%                       underlying patch object
%      HatchSpacing     (Deprecated) Spacing of hatch lines (5)
%
%   In addition, name/value pairs of any properties of A can be specified
%
%   H = HATCHFILL2(...) returns handles to the line objects comprising the
%   hatch/speckle.
%
%   Examples:
%       Gray region with hatching:
%       hh = hatchfill2(a,'cross','HatchAngle',45,'HatchSpacing',5,'FaceColor',[0.5 0.5 0.5]);
%
%       Speckled region:
%       hatchfill2(a,'speckle','HatchAngle',7,'HatchSpacing',1);

% Copyright 2015-2018 Takeshi Ikuma
% History:
% rev. 7 : (01-10-2018)
%   * Added support for 3D faces
%   * Removed HatchSpacing option
%   * Added HatchDensity option
%   * Hatching is no longer defined w.r.t. pixels. HatchDensity is defined
%     as the number of hatch lines across an axis limit. As a result,
%     HatchAngle no longer is the actual hatch angle though it should be
%     close.
%   * [known bug] Speckle hatching style is not working
% rev. 6 : (07-17-2016)
%   * Fixed contours object hatching behavior, introduced in rev.5
%   * Added ContourStyle option to enable fast drawing if contour is convex
% rev. 5 : (05-12-2016)
%   * Fixed Contour with NaN data point disappearnace issue
%   * Improved contours object support
% rev. 4 : (11-18-2015)
%   * Worked around the issue with HG2 contours with Fill='off'.
%   * Removed nagging warning "UseHG2 will be removed..." in R2015b
% rev. 3 : (10-29-2015)
%   * Added support for HG2 AREA
%   * Fixed for HatchColor 'auto' error when HG2 EdgeColor is 'flat'
%   * Fixed listener creation error
% rev. 2 : (10-24-2015)
%   * Added New option: HatchVisible, SpeckleDensity, SpeckleWidth
%     (SpeckleDensity and SpeckleWidtha are separated from HatchSpacing and
%     HatchAngle, respectively)
% rev. 1 : (10-20-2015)
%   * Fixed HG2 contour data extraction bug (was using wrong hidden data)
%   * Fixed HG2 contour color extraction bug
%   * A few cosmetic changes here and there
% rev. - : (10-19-2015) original release
%   * This work is based on Neil Tandon's hatchfill submission
%     (http://www.mathworks.com/matlabcentral/fileexchange/30733)
%     and borrowed code therein from R. Pawlowicz, K. Pankratov, and
%     Iram Weinstein.

narginchk(1,inf);
[A,opts,props] = parse_input(A,varargin);

drawnow % make sure the base objects are already drawn

if verLessThan('matlab','8.4')
   H = cell(1,numel(A));
else
   H = repmat({matlab.graphics.GraphicsPlaceholder},1,numel(A));
end
for n = 1:numel(A)
   H{n} = newhatch(A(n),opts,props);
   
   % if legend of A(n) is shown, add hatching to it as well
   %    leg = handle(legend(ancestor(A,'axes')));
   %    hsrc = [leg.EntryContainer.Children.Object];
   %    hlc = leg.EntryContainer.Children(find(hsrc==A(n),1));
   %    if ~isempty(hlc)
   %       hlc = hlc.Children(1); % LegendIcon object
   %       get(hlc.Children(1))
   %    end
end

if nargout==0
   clear H
else
   H = [H{:}];
   if numel(H)==numel(A)
      H = reshape(H,size(A));
   else
      H = H(:);
   end
end

end

function H = newhatch(A,opts,props)

% 0. retrieve pixel-data conversion parameters
% 1. retrieve face & vertex matrices from A
% 2. convert vertex matrix from data to pixels units
% 3. get xdata & ydata of hatching lines for each face
% 4. concatenate lines sandwitching nan's in between
% 5. convert xdata & ydata back to data units
% 6. plot the hatching line

% traverse if hggroup/hgtransform
if ishghandle(A,'hggroup')
   if verLessThan('matlab','8.4')
      H = cell(1,numel(A));
   else
      H = repmat({matlab.graphics.GraphicsPlaceholder},1,numel(A));
   end
   
   for n = 1:numel(A.Children)
      try
         H{n} = newhatch(A.Children(n),opts,props);
      catch
      end
   end
   
   H = [H{:}];
   return;
end

% Modify the base object property if given
if ~isempty(props)
   pvalold = sethgprops(A,props);
end

try
   vislisena = strcmp(opts.HatchVisible,'auto');
   if vislisena
      vis = A.Visible;
   else
      vis = opts.HatchVisible;
   end

   redraw = strcmp(A.Visible,'off') && ~vislisena;
   if redraw
      A.Visible = 'on'; % momentarily make the patch visible
      drawnow;
   end
   
   % get the base object's vertices & faces
   [V,F,FillFcns] = gethgdata(A); % object does not have its patch data ready
   
   if redraw
      A.Visible = 'off'; % momentarily make the patch visible
   end
   
   if ~isempty(FillFcns)
      FillFcns{1}();
      drawnow;
      [V,F] = gethgdata(A); % object does not have its patch data ready
      FillFcns{2}();
      drawnow;
   end
   
   % recompute hatch line data
   [X,Y,Z] = computeHatchData(handle(ancestor(A,'axes')),V,F,opts);
   
   % 6. plot the hatching line
   commonprops = {'Parent',A.Parent,'DisplayName',A.DisplayName,'Visible',vis};
   if ~strcmp(opts.HatchColor,'auto')
      commonprops = [commonprops {'Color',opts.HatchColor,'MarkerFaceColor',opts.HatchColor}];
   end
   if isempty(regexp(opts.HatchStyle,'speckle$','once'))
      H = line(X,Y,Z,commonprops{:},'LineStyle',opts.HatchLineStyle','LineWidth',opts.HatchLineWidth);
   else
      H = line(X,Y,Z,commonprops{:},'LineStyle','none','Marker',opts.SpeckleMarkerStyle,...
         'MarkerSize',opts.SpeckleSize,'Parent',A.Parent,'DisplayName',A.DisplayName);
   end
   
   if strcmp(opts.HatchColor,'auto')
      syncColor(H,A);
   end
   
   if isempty(H)
      error('Unable to obtain hatching data from the specified object A.');
   end
   
   % 7. Move H so that it is place right above A in parent's uistack
   p = handle(A.Parent);
   Hcs = handle(p.Children);
   [~,idx] = ismember(A,Hcs); % always idx(1)>idx(2) as H was just created
   p.Children = p.Children([2:idx-1 1 idx:end]);
   
   % if HG1, all done | no dynamic adjustment support
   if verLessThan('matlab','8.4')
      return;
   end
   
   % save the config data & set up the object listeners
   setappdata(A,'HatchFill2Opts',opts); % hatching options
   setappdata(A,'HatchFill2Obj',H); % hatching line object
   setappdata(A,'HatchFill2LastData',{V,F}); % last patch data
   setappdata(A,'HatchFill2LastVisible',A.Visible); % last sensitive properties
   setappdata(A,'HatchFill2PostMarkedClean',{}); % run this function at the end of the MarkClean callback and set NoAction flag
   setappdata(A,'HatchFill2NoAction',false); % no action during next MarkClean callback, callback only clears this flag
   setappdata(H,'HatchFill2MatchVisible',vislisena);
   setappdata(H,'HatchFill2MatchColor',strcmp(opts.HatchColor,'auto'));
   setappdata(H,'HatchFill2Patch',A); % base object
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Create listeners for active formatting
   
   addlistener(H,'ObjectBeingDestroyed',@hatchBeingDeleted);
   
   lis = [
      addlistener(A,'Reparent',@objReparent)
      addlistener(A,'ObjectBeingDestroyed',@objBeingDeleted);
      addlistener(A,'MarkedClean',@objMarkedClean)
      addlistener(A,'LegendEntryDirty',@(h,evt)[])]; % <- study this later
   
   syncprops = {'Clipping','HitTest','Interruptible','BusyAction','UIContextMenu'};
   syncprops(~cellfun(@(p)isprop(A,p),syncprops)) = [];
   for n = 1:numel(syncprops)
      lis(n+2) = addlistener(A,syncprops{n},'PostSet',@syncProperty);
   end
   
catch ME
   % something went wrong, restore the base object properties
   if ~isempty(props)
      for pname = fieldnames(pvalold)'
         name = pname{1};
         val = pvalold.(name);
         if iscell(val)
            pvalold.(name){1}.(name) = pvalold.(name){2};
         else
            A.(name) = pvalold.(name);
         end
      end
   end
   ME.rethrow();
end

end

%%%%%%%%%% EVENT CALLBACK FUNCTIONS %%%%%%%%%%%%
% Base Object's listeners
% objReparent - also move the hatch object
% ObjectingBeingDestroyed - also destroy the hatch object
% MarkedClean - match color if HatchColor = 'auto'
%             - check if vertex & face changed; if so redraw hatch
%             - check if hatch redraw triggered the event due to object's
%               face not shown; if so clear the flag

function objMarkedClean(hp,~)
% CALLBACK for base object's MarkedClean event
% check: visibility change, hatching area change, & color change

if getappdata(hp,'HatchFill2NoAction')
   setappdata(A,'HatchFill2NoAction',false);
   return;
end

% get the main patch object (loops if hggroup or HG2 objects)
H = getappdata(hp,'HatchFill2Obj');

rehatch = ~strcmp(hp.Visible,getappdata(hp,'HatchFill2LastVisible'));
if rehatch % if visibility changed
   setappdata(hp,'HatchFill2LastVisible',hp.Visible);
   if strcmp(hp.Visible,'off') % if made hidden, hide hatching as well
      if getappdata(H,'HatchFill2MatchVisible')
         H.Visible = 'off';
         return; % nothing else to do
      end
   end
end

% get the patch data
[V,F,FillFcns] = gethgdata(hp);
if ~isempty(FillFcns) % patch does not exist, must momentarily generate it
   FillFcns{1}();
   setappdata(A,'HatchFill2PostMarkedClean',FillFcns{2});
   return;
end
if ~rehatch % if visible already 'on', check for the change in object data
   VFlast = getappdata(hp,'HatchFill2LastData');
   rehatch = ~isequaln(F,VFlast{2}) || ~isequaln(V,VFlast{1});
end

% rehatch if patch data/visibility changed
if rehatch 
   % recompute hatch line data
   [X,Y,Z] = computeHatchData(ancestor(H,'axes'),V,F,getappdata(hp,'HatchFill2Opts'));
   
   % update the hatching line data
   set(H,'XData',X,'YData',Y,'ZData',Z);

   % save patch data
   setappdata(hp,'HatchFill2LastData',{V,F});
end

% sync the color
syncColor(H,hp);

% run post callback if specified (expect it to trigger another MarkedClean
% event immediately)
fcn = getappdata(hp,'HatchFill2PostMarkedClean');
if ~isempty(fcn)
   setappdata(hp,'HatchFill2PostMarkedClean',function_handle.empty);
   setappdata(hp,'HatchFill2NoAction',true);
   fcn();
   return;
end

end

function syncProperty(~,evt)
% sync Visible property to the patch object
hp = handle(evt.AffectedObject); % patch object
hh = getappdata(hp,'HatchFill2Obj');
hh.(evt.Source.Name) = hp.(evt.Source.Name);
end

function objReparent(hp,evt)
%objReparent event listener callback

pnew = evt.NewValue;
if isempty(pnew)
   return; % no change?
end

% move the hatch line object over as well
H = getappdata(hp,'HatchFill2Obj');
H.Parent = pnew;

% make sure to move the hatch line object right above the patch object
Hcs = handle(pnew.Children);
[~,idx] = ismember(hp,Hcs); % always idx(1)>idx(2) as H was just moved
pnew.Children = pnew.Children([2:idx-1 1 idx:end]);

end

function objBeingDeleted(hp,~)
%when base object is deleted

if isappdata(hp,'HatchFill2Obj')
   H = getappdata(hp,'HatchFill2Obj');
   try % in case H is already deleted
   delete(H);
   catch
   end
end

end

function hatchBeingDeleted(hh,~)
%when hatch line object (hh) is deleted

if isappdata(hh,'HatchFill2Patch')
   
   %   remove listeners listening to the patch object
   hp = getappdata(hh,'HatchFill2Patch');
   
   if isappdata(hp,'HatchFill2Listeners')
      delete(getappdata(hp,'HatchFill2Listeners'));
      rmappdata(hp,'HatchFill2Listeners');
   end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = computeHatchData(ax,V,F,opts)

varargout = cell(1,nargout);

if isempty(V) % if patch shown
   return;
end

N = size(F,1);
XYZc = cell(2,N);
for n = 1:N % for each face
   
   % 2. get xdata & ydata of the vertices of the face in transformed bases
   f = F(n,:); % get indices to the vertices of the face
   f(isnan(f)) = [];
   
   [v,T,islog] = transform_data(ax,V(f,:),[]); % transform the face
   if isempty(v) % face is not hatchable
      continue;
   end
   
   % 2. get xdata & ydata of hatching lines for each face
   if any(strcmp(opts.HatchStyle,{'speckle','outsidespeckle'}))
      xy = hatch_xy(v.',opts.HatchStyle,opts.SpeckleWidth,opts.SpeckleDensity,opts.HatchOffset);
   else
      xy = hatch_xy(v.',opts.HatchStyle,opts.HatchAngle,opts.HatchDensity,opts.HatchOffset);
   end
   
   % 3. revert the bases back to 3D Eucledian space
   XYZc{1,n} = revert_data(xy',T,islog).';
end

% 4. concatenate hatch lines across faces sandwitching nan's in between
[XYZc{2,:}] = deal(nan(3,1));
XYZ = cat(2,XYZc{:});

% 5. convert xdata & ydata back to data units
[varargout{1:3}] = deal(XYZ(1,:),XYZ(2,:),XYZ(3,:));

end

function tf = issupported(hbase)
% check if all of the given base objects are supported

supported_objtypes = {'patch','hggroup','bar','contour','area','surface','histogram'};

if isempty(hbase)
   tf = false;
else
   tf = ishghandle(hbase,supported_objtypes{1});
   for n = 2:numel(supported_objtypes)
      tf(:) = tf | ishghandle(hbase,supported_objtypes{n});
   end
   tf = all(tf);
end

end

% synchronize hatching line color to the patch's edge color if HatchColor =
% 'auto'
function syncColor(H,A)

if ~getappdata(H,'HatchFill2MatchColor')
   % do not sync
   return;
end

if ishghandle(A,'patch') || ishghandle(A,'Bar') || ishghandle(A,'area') ...
      || ishghandle(A,'surface') || ishghandle(A,'Histogram') %HG2
   pname = 'EdgeColor';
elseif ishghandle(A,'contour') % HG2
   pname = 'LineColor';
end
color = A.(pname);
if strcmp(color,'flat')
   try
      color = double(A.Edge(1).ColorData(1:3)')/255;
   catch
      warning('Does not support CData based edge color.');
      color = 'k';
   end
end
H.Color = color;
H.MarkerFaceColor = color;

end

function [V,F,FillFcns] = gethgdata(A)
% Get vertices & face data from the object along with the critical
% properties to observe change in the hatching area

% initialize the output variable
F = [];
V = [];
FillFcns = {};

if ~isvalid(A) || strcmp(A.Visible,'off')
   return;
end

if ishghandle(A,'patch')
   V = A.Vertices;
   F = A.Faces;
elseif ishghandle(A,'bar')
   [V,F] = getQuadrilateralData(A.Face);
elseif ishghandle(A,'area')
   [V,F] = getTriangleStripData(A.Face);
   set(A,'FaceColor','none');
elseif ishghandle(A,'surface') % HG2
   if strcmp(A.FaceColor,'none')
      FillFcns = {@()set(A,'FaceColor','w'),@()set(A,'FaceColor','none')};
      return;
   end
   [V,F] = getQuadrilateralData(A.Face);
elseif ishghandle(A,'contour') % HG2
   
   % Retrieve data from hidden FacePrims property (a TriangleStrip object)
   if strcmp(A.Fill,'off')
      FillFcns = {@()set(A,'Fill','on'),@()set(A,'Fill','off')};
      return;
   end
   [V,F] = getTriangleStripData(A.FacePrims);
elseif ishghandle(A,'histogram') %HG2: Quadrateral underlying data object
   [V,F] = getQuadrilateralData(A.NodeChildren(4));
end

end

function [V,F] = getQuadrilateralData(A) % surface, bar, histogram,

if isempty(A)
   warning('Cannot hatch the face: Graphics object''s face is not defined.');
   V = [];
   F = [];
   return;
end

V = A.VertexData';

% If any of the axes is in log scale, V is normalized to wrt the axes
% limits,
V(:) = norm2data(V,A);

if ~isempty(A.VertexIndices) % vertices likely reused on multiple quadrilaterals
   I = A.VertexIndices;
   Nf = numel(I)/4; % has to be divisible by 4
else %every 4 consecutive vertices defines a quadrilateral
   Nv = size(V,1);
   Nf = Nv/4;
   I = 1:Nv;
end
F = reshape(I,4,Nf)';
if ~isempty(A.StripData) % hack workaround
   F(:) = F(:,[1 2 4 3]);
end
try
   if ~any(all(V==V(1,:))) % not on any Euclidian plane
      % convert quadrilateral to triangle strips
      F = [F(:,1:3);F(:,[1 3 4])];
   end
catch % if implicit array expansion is not supported (<R2016b)
   if all(V(:,1)~=V(1,1)) || all(V(:,2)~=V(1,2)) || all(V(:,3)~=V(1,3)) % not on any Euclidian plane
      % convert quadrilateral to triangle strips
      F = [F(:,1:3) F(:,[1 3 4])];
   end
end

end

function [V,F] = getTriangleStripData(A) % area & contour

if isempty(A)
   warning('Cannot hatch the face: Graphics object''s face is not defined.');
   V = [];
   F = [];
   return;
end

V = A.VertexData';
I = double(A.StripData);

% If any of the axes is in log scale, V is normalized to wrt the axes
% limits,
V(:) = norm2data(V,A);

N = numel(I)-1; % # of faces
m = diff(I);
M = max(m);
F = nan(N,M);
for n = 1:N
   idx = I(n):(I(n+1)-1);
   if mod(numel(idx),2) % odd
      idx(:) = idx([1:2:end end-1:-2:2]);
   else % even
      idx(:) = idx([1:2:end-1 end:-2:2]);
   end
   F(n,1:numel(idx)) = idx;
end
end

% if graphical objects are given normalized to the axes
function V = norm2data(V,A)
ax = ancestor(A,'axes');
inlog = strcmp({ax.XScale ax.YScale ax.ZScale},'log');
if any(inlog)
   lims = [ax.XLim(:) ax.YLim(:) ax.ZLim(:)];
   dirs = strcmp({ax.XDir ax.YDir ax.ZDir},'normal');
   for n = 1:3 % for each axis
      if inlog(n)
         lims(:,n) = log10(lims(:,n));
      end
      V(:,n) = V(:,n)*diff(lims(:,n));
      if dirs(n)
         V(:,n) = V(:,n) + lims(1,n);
      else
         V(:,n) = lims(2,n) - V(:,n);
      end
      if inlog(n)
         V(:,n) = 10.^V(:,n);
      end
   end
end
end

function pvalold = sethgprops(A,props)
% grab the common property names of the base objects

pnames = fieldnames(props);
if ishghandle(A,'hggroup')
   gpnames = fieldnames(set(A));
   [tf,idx] = ismember(gpnames,pnames);
   idx(~tf) = [];
   for i = idx'
      pvalold.(pnames{i}) = A.(pnames{i});
      A.(pnames{i}) = props.(pnames{i});
   end
   props = rmfield(props,pnames(idx));
   
   h = handle(A.Children);
   for n = 1:numel(h)
      pvalold1 = sethgprops(h(n),props);
      ponames = fieldnames(pvalold1);
      for k = 1:numel(ponames)
         pvalold.(ponames{k}) = {h(n) pvalold1.(ponames{k})};
      end
   end
else
   for n = 1:numel(pnames)
      pvalold.(pnames{n}) = A.(pnames{n});
      A.(pnames{n}) = props.(pnames{n});
   end
end

end

function xydatai = hatch_xy(xydata,styl,angle,step,offset)
%
% M_HATCH Draws hatched or speckled interiors to a patch
%
%    M_HATCH(LON,LAT,STYL,ANGLE,STEP,...line parameters);
%
% INPUTS:
%     X,Y - vectors of points.
%     STYL - style of fill
%     ANGLE,STEP - parameters for style
%
%     E.g.
%
%      'single',45,5  - single cross-hatch, 45 degrees,  5 points apart
%      'cross',40,6   - double cross-hatch at 40 and 90+40, 6 points apart
%      'speckle',7,1  - speckled (inside) boundary of width 7 points, density 1
%                               (density >0, .1 dense 1 OK, 5 sparse)
%      'outspeckle',7,1 - speckled (outside) boundary of width 7 points, density 1
%                               (density >0, .1 dense 1 OK, 5 sparse)
%
%
%      H=M_HATCH(...) returns handles to hatches/speckles.
%
%      [XI,YI,X,Y]=MHATCH(...) does not draw lines - instead it returns
%      vectors XI,YI of the hatch/speckle info, and X,Y of the original
%      outline modified so the first point==last point (if necessary).
%
%     Note that inside and outside speckling are done quite differently
%     and 'outside' speckling on large coastlines can be very slow.

%
% Hatch Algorithm originally by K. Pankratov, with a bit stolen from
% Iram Weinsteins 'fancification'. Speckle modifications by R. Pawlowicz.
%
% R Pawlowicz 15/Dec/2005

I = zeros(1,size(xydata,2));

% face vertices are not always closed
if any(xydata(:,1)~=xydata(:,end))
   xydata(:,end+1) = xydata(:,1);
   I(end+1) = I(1);
end

if any(strcmp(styl,{'speckle','outspeckle'}))
   angle = angle*(1-I);
end

switch styl
   case 'single'
      xydatai = drawhatch(xydata,angle,1/step,0,offset);
   case 'cross'
      xydatai = [...
         drawhatch(xydata,angle,1/step,0,offset) ...
         drawhatch(xydata,angle+90,1/step,0,offset)];
   case 'speckle'
      xydatai = [...
         drawhatch(xydata,45,   1/step,angle,offset) ...
         drawhatch(xydata,45+90,1/step,angle,offset)];
   case 'outspeckle'
      xydatai = [...
         drawhatch(xydata,45,   1/step,-angle,offset) ...
         drawhatch(xydata,45+90,1/step,-angle,offset)];
      inside = logical(inpolygon(xydatai(1,:),xydatai(2,:),x,y)); % logical needed for v6!
      xydatai(:,inside) = [];
   otherwise
      xydatai = zeros(2,0);
end

end

%%%

function xydatai = drawhatch(xydata,angle,step,speckle,offset)
% xydata is given as 2xN matrix, x on the first row, y on the second

% Idea here appears to be to rotate everthing so lines will be
% horizontal, and scaled so we go in integer steps in 'y' with
% 'points' being the units in x.
% Center it for "good behavior".

% rotate first about (0,0)
ca = cosd(angle); sa = sind(angle);
u = [ca sa]*xydata;              % Rotation
v = [-sa ca]*xydata;

% translate to the grid point nearest to the centroid
u0 = round(mean(u)/step)*step; v0 = round(mean(v)/step)*step;
x = (u-u0); y = (v-v0)/step+offset;    % plus scaling and offsetting

% Compute the coordinates of the hatch line ...............
yi = ceil(y);
yd = [diff(yi) 0]; % when diff~=0 we are crossing an integer
fnd = find(yd);    % indices of crossings
dm = max(abs(yd)); % max possible #of integers between points

% This is going to be pretty space-inefficient if the line segments
% going in have very different lengths. We have one column per line
% interval and one row per hatch line within that interval.
%
A = cumsum( repmat(sign(yd(fnd)),dm,1), 1);

% Here we interpolate points along all the line segments at the
% correct intervals.
fnd1 = find(abs(A)<=abs( repmat(yd(fnd),dm,1) ));
A  = A+repmat(yi(fnd),dm,1)-(A>0);
xy = (x(fnd+1)-x(fnd))./(y(fnd+1)-y(fnd));
xi = repmat(x(fnd),dm,1)+(A-repmat(y(fnd),dm,1) ).*repmat(xy,dm,1);
yi = A(fnd1);
xi = xi(fnd1);

% Sorting points of the hatch line ........................
%%yi0 = min(yi); yi1 = max(yi);
% Sort them in raster order (i.e. by x, then by y)
% Add '2' to make sure we don't have problems going from a max(xi)
% to a min(xi) on the next line (yi incremented by one)
xi0 = min(xi); xi1 = max(xi);
ci = 2*yi*(xi1-xi0)+xi;
[~,num] = sort(ci);
xi = xi(num); yi = yi(num);

% if this happens an error has occurred somewhere (we have an odd
% # of points), and the "fix" is not correct, but for speckling anyway
% it really doesn't make a difference.
if rem(length(xi),2)==1
   xi = [xi; xi(end)];
   yi = [yi; yi(end)];
end

% Organize to pairs and separate by  NaN's ................
li = length(xi);
xi = reshape(xi,2,li/2);
yi = reshape(yi,2,li/2);

% The speckly part - instead of taking the line we make a point some
% random distance in.
if length(speckle)>1 || speckle(1)~=0
   
   if length(speckle)>1
      % Now we get the speckle parameter for each line.
      
      % First, carry over the speckle parameter for the segment
      %   yd=[0 speckle(1:end-1)];
      yd = speckle(1:end);
      A=repmat(yd(fnd),dm,1);
      speckle=A(fnd1);
      
      % Now give it the same preconditioning as for xi/yi
      speckle=speckle(num);
      if rem(length(speckle),2)==1
         speckle = [speckle; speckle(end)];
      end
      speckle=reshape(speckle,2,li/2);
      
   else
      speckle=[speckle;speckle];
   end
   
   % Thin out the points in narrow parts.
   % This keeps everything when abs(dxi)>2*speckle, and then makes
   % it increasingly sparse for smaller intervals.
   dxi=diff(xi);
   nottoosmall=sum(speckle,1)~=0 & rand(1,li/2)<abs(dxi)./(max(sum(speckle,1),eps));
   xi=xi(:,nottoosmall);
   yi=yi(:,nottoosmall);
   dxi=dxi(nottoosmall);
   if size(speckle,2)>1, speckle=speckle(:,nottoosmall); end
   % Now randomly scatter points (if there any left)
   li=length(dxi);
   if any(li)
      xi(1,:)=xi(1,:)+sign(dxi).*(1-rand(1,li).^0.5).*min(speckle(1,:),abs(dxi) );
      xi(2,:)=xi(2,:)-sign(dxi).*(1-rand(1,li).^0.5).*min(speckle(2,:),abs(dxi) );
      % Remove the 'zero' speckles
      if size(speckle,2)>1
         xi=xi(speckle~=0);
         yi=yi(speckle~=0);
      end
   end
else
   xi = [xi; ones(1,li/2)*nan];  % Separate the line segments
   yi = [yi; ones(1,li/2)*nan];
end

% Transform back to the original coordinate system
xydatai = [ca -sa;sa ca]*[xi(:)'+u0;(yi(:)'-offset)*step+v0];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [h,opts,props] = parse_input(h,argin)
% parse & validate input arguments

patchtypes = {'single','cross','speckle','outspeckle','fill','none'};

% get base object handle
if ~issupported(h)
   error('Unsupported graphics handle type.');
end
h = handle(h);

% get common property names
pnames = getcommonprops(h);

% if style argument is given, convert it to HatchStyle option pair
stylearg = {};
if ~isempty(argin) && ischar(argin{1})
   try
      ptypes = validatestring(argin{1},patchtypes);
      stylearg = {'HatchStyle' ptypes};
      argin(1) = [];
   catch
      % STYL not given, continue on
   end
end

% create inputParser for options
p = inputParser;
p.addParameter('HatchStyle','single');
p.addParameter('HatchAngle',45,@(v)validateattributes(v,{'numeric'},{'scalar','finite','real'}));
p.addParameter('HatchDensity',40,@(v)validateattributes(v,{'numeric'},{'scalar','positive','finite','real'}));
p.addParameter('HatchSpacing',[],@(v)validateattributes(v,{'numeric'},{'scalar','positive','finite','real'}));
p.addParameter('HatchOffset',0,@(v)validateattributes(v,{'numeric'},{'scalar','nonnegative','<',1,'real'}));
p.addParameter('HatchColor','auto',@validatecolor);
p.addParameter('HatchLineStyle','-');
p.addParameter('HatchLineWidth',0.5,@(v)validateattributes(v,{'numeric'},{'scalar','positive','finite','real'}));
p.addParameter('SpeckleWidth',7,@(v)validateattributes(v,{'numeric'},{'scalar','finite','real'}));
p.addParameter('SpeckleDensity',100,@(v)validateattributes(v,{'numeric'},{'scalar','positive','finite','real'}));
p.addParameter('SpeckleMarkerStyle','.');
p.addParameter('SpeckleSize',2,@(v)validateattributes(v,{'numeric'},{'scalar','positive','finite'}));
p.addParameter('SpeckleFillColor','auto',@validatecolor);
p.addParameter('HatchVisible','auto');

for n = 1:numel(pnames)
   p.addParameter(pnames{n},[]);
end
p.parse(stylearg{:},argin{:});

rnames = fieldnames(p.Results);
isopt = ~cellfun(@isempty,regexp(rnames,'^(Hatch|Speckle)','once')) | strcmp(rnames,'ContourStyle');
props = struct([]);
for n = 1:numel(rnames)
   if isopt(n)
      opts.(rnames{n}) = p.Results.(rnames{n});
   elseif ~isempty(p.Results.(rnames{n}))
      props(1).(rnames{n}) = p.Results.(rnames{n});
   end
end

opts.HatchStyle = validatestring(opts.HatchStyle,patchtypes);
if any(strcmp(opts.HatchStyle,{'speckle','outspeckle'}))
   warning('hatchfill2:PartialSupport','Speckle/outspeckle HatchStyle may not work in the current release of hatchfill2')
end
if strcmpi(opts.HatchStyle,'none') % For backwards compatability:
   opts.HatchStyle = 'fill';
end
opts.HatchLineStyle = validatestring(opts.HatchLineStyle,{'-','--',':','-.'},mfilename,'HatchLineStyle');

if ~isempty(opts.HatchSpacing)
   warning('HatchSpacing option has been deprecated. Use ''HatchDensity'' option instead.');
end
opts = rmfield(opts,'HatchSpacing');

opts.SpeckleMarkerStyle = validatestring(opts.SpeckleMarkerStyle,{'+','o','*','.','x','square','diamond','v','^','>','<','pentagram','hexagram'},'hatchfill2','SpeckleMarkerStyle');
opts.HatchVisible = validatestring(opts.HatchVisible,{'auto','on','off'},mfilename,'HatchVisible');

end

function pnames = getcommonprops(h)
% grab the common property names of the base objects

V = set(h(1));
pnames = fieldnames(V);
if ishghandle(h(1),'hggroup')
   pnames = union(pnames,getcommonprops(get(h(1),'Children')));
end
for n = 2:numel(h)
   V = set(h(n));
   pnames1 = fieldnames(V);
   if ishghandle(h(n),'hggroup')
      pnames1 = union(pnames1,getcommonprops(get(h(n),'Children')));
   end
   pnames = intersect(pnames,pnames1);
end

end

function validatecolor(val)

try
   validateattributes(val,{'double','single'},{'numel',3,'>=',0,'<=',1});
catch
   validatestring(val,{'auto','y','yellow','m','magenta','c','cyan','r','red',...
      'g','green','b','blue','w','white','k','black'});
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% axes unit conversion functions

function [V,T,islog] = transform_data(ax,V,ref)
% convert vertices data to hatch-ready form
% - if axis is log-scaled, data is converted to their log10 values
% - if 3D (non-zero z), spatially transform data onto the xy-plane. If
%   reference point is given, ref is mapped to the origin. Otherwise, ref
%   is chosen to be the axes midpoint projected onto the patch plane. Along
%   with the data, the axes corner coordinates are also projected onto the
%   patch plane to obtain the projected axes limits.
% - transformed xy-data are then normalized by the projected axes spans.

noZ = size(V,2)==2;

xl = ax.XLim;
yl = ax.YLim;
zl = ax.ZLim;

% log to linear space
islog = strcmp({ax.XScale ax.YScale ax.ZScale},'log');
if islog(1)
   V(:,1) = log10(V(:,1));
   xl = log10(xl);
   if ~isempty(ref)
      ref(1) = log10(ref(1));
   end
end
if islog(2)
   V(:,2) = log10(V(:,2));
   yl = log10(yl);
   if ~isempty(ref)
      ref(2) = log10(ref(2));
   end
end
if islog(3) && ~noZ
   V(:,3) = log10(V(:,3));
   zl = log10(zl);
   if ~isempty(ref)
      ref(3) = log10(ref(3));
   end
end

if noZ
   V(:,3) = 0;
end

% if not given, pick the reference point to be the mid-point of the current
% axes
if isempty(ref)
   ref = [mean(xl) mean(yl) mean(zl)];
end

% normalize the axes so that they span = 1;
Tscale = makehgtform('scale', [1/diff(xl) 1/diff(yl) 1/diff(zl)]);
V(:) = V*Tscale(1:3,1:3);
ref(:) = ref*Tscale(1:3,1:3);

% obtain unique vertices
Vq = double(unique(V,'rows')); % find unique points (sorted order)
Nq = size(Vq,1);
if Nq<3 || any(isinf(Vq(:))) || any(isnan(Vq(:))) % not hatchable
   V = [];
   T = [];
   return;
end

try % erros if 2D object
   zq = unique(Vq(:,3));
catch
   V(:,3) = 0;
   zq = 0;
end
T = eye(4);
if isscalar(zq) % patch is on a xy-plane
   if zq~=0 % not on the xy-plane
      T = makehgtform('translate',[0 0 -zq]);
   end
else
   % if patch is not on a same xy-plane
   
   % use 3 points likely well separated
   idx = round((0:2)/2*(Nq-1))+1;
   
   % find unit normal vector of the patch plane
   norm = cross(Vq(idx(1),:)-Vq(idx(3),:),Vq(idx(2),:)-Vq(idx(3),:)); % normal vector
   norm(:) = norm/sqrt(sum(norm.^2));
   
   % define the spatial rotation
   theta = acos(norm(3));
   if theta>pi/2, theta = theta-pi; end
   u = [norm(2) -norm(1) 0];
   Trot = makehgtform('axisrotate',u,theta);
   
   % project the reference point onto the plane
   P = norm.'*norm;
   ref_proj = ref*(eye(3) - P) + Vq(1,:)*P;
   if norm(3)
      T = makehgtform('translate', -ref_proj); % user specified reference point or -d/norm(3) for z-crossing
   end
   
   % apply the rotation now
   T(:) = Trot*T;
   
   % find the axes limits on the transformed space
   %    [Xlims,Ylims,Zlims] = ndgrid(xl,yl,zl);
   %    Vlims = [Xlims(:) Ylims(:) Zlims(:)];
   %    Vlims_proj = [Vlims ones(8,1)]*T';
   %    lims_proj = [min(Vlims_proj(:,[1 2]),[],1);max(Vlims_proj(:,[1 2]),[],1)];
   %    xl = lims_proj(:,1)';
   %    yl = lims_proj(:,2)';
end

% perform the transformation
V(:,4) = 1;
V = V*T';
V(:,[3 4]) = [];

T(:) = T*Tscale;

end

function V = revert_data(V,T,islog)

N = size(V,1);
V = [V zeros(N,1) ones(N,1)]/T';
V(:,end) = [];

% log to linear space
if islog(1)
   V(:,1) = 10.^(V(:,1));
end
if islog(2)
   V(:,2) = 10.^(V(:,2));
end
if islog(3)
   V(:,3) = 10.^(V(:,3));
end

end
